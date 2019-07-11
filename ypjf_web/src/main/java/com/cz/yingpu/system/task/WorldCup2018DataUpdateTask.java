package com.cz.yingpu.system.task;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.conn.HttpHostConnectException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.cz.yingpu.frame.common.BaseLogger;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.Log;
import com.cz.yingpu.system.entity.WorldCupInexistenceU;
import com.cz.yingpu.system.entity.WorldCupMatch;
import com.cz.yingpu.system.entity.WorldCupScoreInfo;
import com.cz.yingpu.system.lib.WorldCup2018DataCreeper;
import com.cz.yingpu.system.pc.WorldCup2018DataUpdate;
import com.cz.yingpu.system.pc.pohneNumber;
import com.cz.yingpu.system.service.IBaseSpringrainService;


/**
 * 2018世界杯赛事数据更新
 */
@Component
public class WorldCup2018DataUpdateTask extends BaseLogger {

	@Resource
	private IBaseSpringrainService baseSpringrainService;

	@Resource
	private HttpServletRequest request;

	int MAX_RETRY_TIMES = 3;

	int retryTimes = 0;

	/**
	 * 更新2018世界杯竞猜活动竞猜数据
	 */
	//@Scheduled(cron = "0 0 6 * * ?")
	public void updateWorldCup2018Score() {
		int TOTAL_BONUS = 1000,
			VIRTUAL_BONUS_USER_NUMBER = 0,
			MAX_TOTAL_BONUS = 0;
		double TODAY_BONUS = 0;

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Log log = new Log("/webdata/logs", "world_cup_2018_task_" + dateFormat.format(new Date()) + ".log");
		log.writeLog("开始执行2018世界杯数据更新任务...");

		try {
			WorldCup2018DataCreeper creeper = new WorldCup2018DataCreeper();
			String yesterdayDateStr = dateFormat.format(new Date(new Date().getTime() - 86400 * 1000));
			List<WorldCupScoreInfo> scoreInfos = null;
			Finder sysFinder = new Finder(
					"SELECT value FROM t_sys_sysparam WHERE code IN('worldCup2018TodayBonus','worldCup2018MaxBonus') ORDER BY id");
			
			sysFinder.setEscapeSql(false);
			List<Map<String, Object>> sysParams = baseSpringrainService.queryForList(sysFinder);
			TODAY_BONUS = Double.parseDouble(sysParams.get(0).get("value").toString());
			MAX_TOTAL_BONUS = Integer.parseInt(sysParams.get(1).get("value").toString());
			VIRTUAL_BONUS_USER_NUMBER = (int) (TOTAL_BONUS / TODAY_BONUS);

			log.writeLog("开始爬取世界杯比赛数据...");
			List<Map> datum = creeper.fetchMatches(
					creeper.fetchPage(WorldCup2018DataCreeper.DATA_SOURCE_URL));
			log.writeLog("更新淘汰赛数据...");
			updateKnockoutMatches(datum, log, baseSpringrainService);
			List<WorldCupMatch> yesterdayMatches = baseSpringrainService.queryForList(
					new Finder("SELECT * FROM t_world_cup_2018_match")
							.append(" WHERE startDate = :date")
							.setParam("date", yesterdayDateStr),
					WorldCupMatch.class);
			if (yesterdayMatches.isEmpty()) {
				log.writeLog(yesterdayDateStr + "没有比赛，程序结束。");
				return;
			}
			
			log.writeLog("爬取数据完成，开始更新今日竞猜结果...");
			for (Map<String, List<?>> data : datum) {
				List<WorldCupMatch> everydayMatches = (List<WorldCupMatch>) data.get("matches");
				for (WorldCupMatch singleMatch : everydayMatches) {
					for (WorldCupMatch yesterdayMatch : yesterdayMatches) {
						if (singleMatch.getId().equals(yesterdayMatch.getId())) {
							scoreInfos = (List<WorldCupScoreInfo>) data.get("scoreInfos");
							if (scoreInfos != null) {
								for (WorldCupScoreInfo info : scoreInfos) {
									if (!singleMatch.getId().equals(info.getMatchId()) || info.getScore() == null) {
										continue;
									}

									log.writeLog(info);
									baseSpringrainService.update(new Finder("UPDATE t_world_cup_2018_score_info")
											.append(" SET score = :score, isWinner = :isWinner")
											.append(" WHERE matchId = :matchId AND teamId = :teamId")
											.setParam("score", info.getScore())
											.setParam("matchId", info.getMatchId())
											.setParam("teamId", info.getTeamId())
											.setParam("isWinner", info.getIsWinner()));
								}
							}
						}
					}
				}
			}

			Finder finder = new Finder("SELECT wcm.*, wcsi.teamId, wcsi.isWinner, wcsi.matchId")
					.append(" FROM t_world_cup_2018_match wcm LEFT JOIN t_world_cup_2018_score_info wcsi")
					.append(" ON wcsi.isWinner = 1 AND wcsi.matchId = wcm.id")
					.append(" WHERE wcm.startDate = :matchDate")
					.setParam("matchDate", yesterdayDateStr);
			Finder updateFinder;
			int guessSuccessUserNum = 0;

			for (Map<String, Object> data : baseSpringrainService.queryForList(finder)) {
				updateFinder = new Finder("UPDATE t_world_cup_2018_user_guess_info ugi, t_world_cup_2018_score_info si")
						.append(" SET ugi.getMoney = 1 WHERE ugi.matchId = :matchId AND 1 = :isWinner AND si.teamId = :teamId")
						.append(" AND ugi.scoreInfoId = si.id")
						.setParam("teamId", data.get("teamId"))
						.setParam("isWinner", data.get("isWinner"))
						.setParam("matchId", data.get("matchId"));
				guessSuccessUserNum += baseSpringrainService.update(updateFinder);

				updateFinder = new Finder("UPDATE t_world_cup_2018_user_guess_info ugi SET ugi.getMoney = 1")
						.append(" WHERE ugi.matchId = :matchId AND ugi.draw = 1 AND 0 = :isWinner")
						.setParam("isWinner", data.get("isWinner") == null ? 0 : data.get("isWinner"))
						.setParam("matchId", data.get("id"));
				guessSuccessUserNum += baseSpringrainService.update(updateFinder);
			}

			VIRTUAL_BONUS_USER_NUMBER = VIRTUAL_BONUS_USER_NUMBER - guessSuccessUserNum;
			if (guessSuccessUserNum * TODAY_BONUS > MAX_TOTAL_BONUS) {
				TODAY_BONUS = MAX_TOTAL_BONUS / guessSuccessUserNum;
				VIRTUAL_BONUS_USER_NUMBER = ((int) (TOTAL_BONUS / TODAY_BONUS)) - guessSuccessUserNum;
			}
			if (VIRTUAL_BONUS_USER_NUMBER > 0) {
				Finder truncateFinder = new Finder("TRUNCATE TABLE t_world_cup_inexistence_user");
				truncateFinder.setEscapeSql(false);
				baseSpringrainService.update(truncateFinder);
				getAllTeam(VIRTUAL_BONUS_USER_NUMBER, TODAY_BONUS);
			}

			baseSpringrainService.update(new Finder("UPDATE t_world_cup_2018_user_guess_info ugi,")
					.append(" t_world_cup_2018_match m SET ugi.getMoney = :money WHERE ugi.matchId = m.id")
					.append(" AND m.startDate = :startDate AND ugi.getMoney = 1")
					.setParam("startDate", yesterdayDateStr)
					.setParam("money", TODAY_BONUS));

			retryTimes = 0;
			log.writeLog(String.format("昨日比赛数：%d，竞猜正确数量：%d，分配奖金：%f。",
					yesterdayMatches.size(), guessSuccessUserNum, TODAY_BONUS));
			log.writeLog("更新竞猜结果完毕");
			log.writeLog("程序已结束。\r\n");
		}
		catch(HttpHostConnectException e) {
			e.printStackTrace();
			if (retryTimes++ < MAX_RETRY_TIMES) {
				log.writeLog("出现连接问题，重新执行程序。剩余重试次数：" + (MAX_RETRY_TIMES - retryTimes));
				updateWorldCup2018Score();
			}
			else {
				log.writeLog(String.format("重试次数超过最大限制%d，停止程序执行。", MAX_RETRY_TIMES));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			log.writeLog(String.format("出现异常：%n%s", Log.getStackTrace(e)));
		}
		finally {
			log.close();
		}
	}
	
	private void updateKnockoutMatches(
			List<Map> dataum , Log log, IBaseSpringrainService service) {
		List<WorldCupScoreInfo> scoreInfos = new ArrayList<>();
		for (Map<String, List<?>> data : dataum) {
			List<WorldCupMatch> matches = (List<WorldCupMatch>) data.get("matches");
			INNER: for (WorldCupMatch match : matches) {
				if ("knockoutphase".equals(match.getStage())) {
					scoreInfos.addAll((List<WorldCupScoreInfo>) data.get("scoreInfos"));
					break INNER;
				}
			}
		}
		
		for (WorldCupScoreInfo info : scoreInfos) {
			try {
				if (info.getTeamId() == 0) {
					continue;
				}
				
				if (null == baseSpringrainService.queryForObject(
						new Finder("SELECT * FROM t_world_cup_2018_score_info")
								.append(" WHERE matchId = :matchId AND teamId = :teamId")
								.setParam("matchId", info.getMatchId())
								.setParam("teamId", info.getTeamId()))) {
					
					baseSpringrainService.save(info);
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

	private void specialScore(List<WorldCupScoreInfo> infos, int[] scores) {
		List<WorldCupScoreInfo> temp;
		for (int i = 0; i < infos.size(); i+=2) {
			temp = infos.subList(i, i + 2);
			for (int j = 0; j < temp.size(); j++) {
				temp.get(j).setScore(scores[j]);
				temp.get(j).setIsWinner(scores[j] > scores[temp.size() - (j + 1)] ? 1 : 0);
			}
		}
	}

	private void getAllTeam(int num, double money) throws Exception {
		WorldCupInexistenceU jiaUser =new WorldCupInexistenceU();
		Finder finder=new Finder("select tm.startTime,tm.startDate,tt.chineseName,tc.score,tc.isWinner,tc.id scoreInfoId,tm.id tmId,tt.name ")
				.append("from t_world_cup_2018_match tm,t_world_cup_2018_score_info tc,t_world_cup_2018_team tt ")
				.append("WHERE tt.id=tc.teamId AND tm.id=tc.matchId order by tm.startTime asc,tc.teamId DESC");

			Map map=new HashMap();
			SimpleDateFormat dateFormat =new SimpleDateFormat("yyyy-MM-dd");
			Date today=new Date();
			Date yesterday=new Date(today.getTime()-1000*60*60*24);
			String nowTime=dateFormat.format(yesterday);
			Finder f=new Finder("SELECT tm.id,tm.`startDate` FROM  t_world_cup_2018_match tm WHERE tm.`startDate` =:startDate").setParam("startDate",nowTime);
			List<WorldCupMatch> match= baseSpringrainService.queryForList(f,WorldCupMatch.class);
			for (int i = 0; i < num; i++) { // 动态生成200条数据
				Random rand = new Random();
				int size=match.size();
				if (size == 0) {
					break;
				}
				
				int a=rand.nextInt(size);
				WorldCupInexistenceU worldCupInexistenceU= pohneNumber.getAddress(money);
				worldCupInexistenceU.setMatchId(match.get(a).getId());
				baseSpringrainService.save(worldCupInexistenceU);
			}
	}

	public static void main(String[] args) {
		new WorldCup2018DataUpdate().updateWorldCup2018Score();
	}

}
