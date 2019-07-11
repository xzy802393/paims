package com.cz.yingpu.system.pc;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.WorldCupInexistenceU;
import com.cz.yingpu.system.entity.WorldCupUserGuessInfo;
import com.cz.yingpu.system.service.IBaseSpringrainService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/pc/worldCup")
public class WorldCupController extends BaseController {

    @Resource
    IBaseSpringrainService baseSpringrainService;
    @Resource HttpServletRequest request;

    //战队及当日比赛展示
    @RequestMapping("/list/json")
    @ResponseBody
    public ReturnDatas getAllTeam(){
        ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
       WorldCupInexistenceU jiaUser =new WorldCupInexistenceU();
       AppUser user=(AppUser) request.getSession().getAttribute("pcuser");
       //查询所有赛事信息
        Finder finder=new Finder("select tm.startTime,tm.startDate,tt.chineseName,tc.score,tc.isWinner,tc.id scoreInfoId,tm.id tmId,tt.name ")
                .append("from t_world_cup_2018_match tm,t_world_cup_2018_score_info tc,t_world_cup_2018_team tt ")
                .append("WHERE tt.id=tc.teamId AND tm.id=tc.matchId order by tm.startTime asc,tm.id DESC");

        try{
            Map map=new HashMap();
            List<Map<String,Object>> teamInfo= baseSpringrainService.queryForList(finder);
            map.put("teamInfo",teamInfo);
            SimpleDateFormat dateFormat =new SimpleDateFormat("yyyy-MM-dd");
            Date now =new Date();
            String nowTime =dateFormat.format(now);
            map.put("nowTime",nowTime);
            Date yesterday=new Date(now.getTime()-1000*60*60*24);
            String yest=dateFormat.format(yesterday);//昨天

            Finder f3=new Finder("SELECT tm.startTime,tt.chineseName,tc.score,tt.name ")
                    .append(" FROM t_world_cup_2018_match tm,t_world_cup_2018_score_info tc,t_world_cup_2018_team tt ")
                    .append("WHERE tt.id=tc.teamId AND tm.id=tc.matchId AND tm.startDate<'"+nowTime+"' ORDER BY tm.startTime DESC,tm.id DESC");
            f3.setEscapeSql(false);
            List<Map<String,Object>> u= baseSpringrainService.queryForList(f3);
            map.put("u",u);
            //查询用户中奖的记录
            Finder f1=new Finder("SELECT tu.`phone`,tt.matchTeams, ugi.getMoney FROM(  SELECT GROUP_CONCAT(t.chineseName SEPARATOR ' vs ') matchTeams,  si.matchId FROM ")
                    .append(" (t_world_cup_2018_team t, t_world_cup_2018_match m, t_world_cup_2018_score_info si ) WHERE si.matchId = m.id AND t.id = si.teamId AND m.startDate=:startDate GROUP BY m.id) tt ")
                    .append(" INNER JOIN t_world_cup_2018_user_guess_info ugi ON ugi.matchId = tt.matchId INNER JOIN t_app_user tu ON tu.`id`=ugi.userId WHERE ugi.getMoney>0 ORDER BY ugi.guessTime DESC ")
                   .setParam("startDate",yest);
                f1.setEscapeSql(false);
             List<Map<String,Object>> guessInfo= baseSpringrainService.queryForList(f1);
                 List phoneList=new ArrayList();
             for(int i=0;i<guessInfo.size();i++){
                 String str=(String)guessInfo.get(i).get("phone");
                 String phoneNumber = str.substring(0, 3) + "****" + str.substring(7, str.length());
                 guessInfo.get(i).put("phone",phoneNumber);
             }
            Finder f2=new Finder("SELECT tt.matchTeams, ti.phone,ti.getMoney FROM(  SELECT GROUP_CONCAT(t.chineseName SEPARATOR ' vs ') matchTeams,  si.matchId FROM ")
                   .append(" (t_world_cup_2018_team t, t_world_cup_2018_match m, t_world_cup_2018_score_info si) ")
                    .append( " WHERE si.matchId = m.id AND t.id = si.teamId  GROUP BY m.id) tt ")
                    .append(" INNER JOIN t_world_cup_inexistence_user ti ON ti.matchId = tt.matchId ");
            f2.setEscapeSql(false);
            List<Map<String,Object>> bianInfo= baseSpringrainService.queryForList(f2);
            guessInfo.addAll(bianInfo);
            //map.put("bianInfo",bianInfo);
            map.put("guessInfo",guessInfo);
          if(user!=null){
              //查询用户已经投票的列表
              Finder finder1=(new Finder("SELECT * FROM t_world_cup_2018_user_guess_info WHERE userId = :userId ").setParam("userId", user.getId()));
              List<WorldCupUserGuessInfo> userInfo= baseSpringrainService.queryForList(finder1,WorldCupUserGuessInfo.class);
              map.put("userInfo",userInfo);
          }
            rt.setData(map);
        }
       catch (Exception e){
           e.printStackTrace();
       }
        return rt;
    }
    //用户竞猜
    @RequestMapping("/guess/json")
    @ResponseBody
    public ReturnDatas guess(String userId,Integer teamId,String matchId,long startTime){

        ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
        WorldCupUserGuessInfo userInfo=new WorldCupUserGuessInfo();
        Integer id=Integer.parseInt(userId);
        Date guessTime=new Date();

        try{
            userInfo = baseSpringrainService.queryForObject(new Finder("SELECT * FROM t_world_cup_2018_user_guess_info WHERE userId = :userId  AND matchId=:matchId")
                    .setParam("userId", id).setParam("matchId",matchId), WorldCupUserGuessInfo.class);
            if(guessTime.getTime()>startTime){
                rt.setData("投票时间已过");
                return rt;
            }
            if(userInfo==null) {
                WorldCupUserGuessInfo userInfo1=new WorldCupUserGuessInfo();
                userInfo1.setUserId(Integer.parseInt(userId));
                if(teamId==0){//id==1表示投了平局
                    userInfo1.setDraw(1);
                    userInfo1.setScoreInfoId(null);
                }else{
                    userInfo1.setDraw(0);
                    userInfo1.setScoreInfoId(teamId);
                }
                userInfo1.setMatchId(matchId);
                userInfo1.setGuessTime(guessTime);
                baseSpringrainService.save(userInfo1);
                rt.setData("投票成功");
                return rt;
            }
            else{
                rt.setData("请勿重复竞猜");
                return  rt;
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return rt;
    }

}
