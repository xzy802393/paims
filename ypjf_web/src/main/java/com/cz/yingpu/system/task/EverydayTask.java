package com.cz.yingpu.system.task;


import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserIntegralHistory;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.lang.reflect.Member;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 每日任务
 */
@Component
public class EverydayTask {

	@Resource
	private IBaseSpringrainService baseSpringrainService;

	@Resource
	private HttpServletRequest request;

	/**
	 * 用户生日奖励银子
	 */
	@Scheduled(cron = "59 59 23 * * ?")
	public void bonusIntegralForUserBirthday() {
		try {
			Finder finder = new Finder("SELECT value FROM t_sys_sysparam WHERE code = :code")
					.setParam("code", "userBirthdayIntegral");
			Finder usersFinder = new Finder("SELECT * FROM t_app_user WHERE DATE_FORMAT(NOW(), '%m%d') = SUBSTR(idcard, 11, 4) AND isIdCard = '是'");
			usersFinder.setEscapeSql(false);
			Map<String, Object> result = baseSpringrainService.queryForObject(finder);
			double userBirthdayIntegral = Double.parseDouble(result.get("value").toString());
			List<AppUser> birthdayUsers = baseSpringrainService.queryForList(usersFinder, AppUser.class);

			for (AppUser au : birthdayUsers) {
				au.setIntegral(userBirthdayIntegral + (au.getIntegral() == null ? 0 : au.getIntegral()));
				baseSpringrainService.updateValidValue(au);

				UserIntegralHistory uis = new UserIntegralHistory();
				uis.setUserId(au.getId());
				uis.setIntegral(userBirthdayIntegral);
				uis.setTotalIntegral(au.getIntegral());
				uis.setOperationTime(new Date());
				uis.setOperationType(3);
				baseSpringrainService.save(uis);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

    /**
     * 每月定时清空用户消息
     */
    @Scheduled(cron = "0 0 0 1 * ?")
    public void emptyUserMessageEveryMonth() {
        Finder emptyUserFinder = new Finder("TRUNCATE TABLE t_message");

        try {
            System.out.println(" @@ 开始清空消息... ");
            baseSpringrainService.update(emptyUserFinder);
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }

	/**
	 * 会员阶段性重置
	 */
//	@Scheduled(cron = "00 00 00 * * ?")
//	public void Member(){
//		try {
//			System.out.println("******************会员重置实施*************************");
//			Finder member  = new Finder("SELECT * FROM t_app_user WHERE isIdCard=:isIdCard ");
//			member.setParam("isIdCard","是");
//			List<AppUser> members = baseSpringrainService.queryForList(member,AppUser.class);
//			for(AppUser au: members){
//				if(au.getResetDate()==null){
//					Finder time = new Finder("SELECT DATEDIFF(NOW(),cardTime) timeDifference FROM t_app_user WHERE id=:id");
//					time.setParam("id",au.getId());
//					Map<String,Object> appuser = baseSpringrainService.queryForObject(time);
//					if(Integer.parseInt(String.valueOf(appuser.get("timeDifference")))>180){
//						au.setResetDate(new Date());
//						au.setMember("新手转享");
//					}
//				}else{
//					Finder time = new Finder("SELECT DATEDIFF(NOW(),:resetDate) timeDifference FROM t_app_user WHERE id=:id");
//					time.setParam("resetDate",au.getResetDate());
//					time.setParam("id",au.getId());
//					Map<String,Object>  appuser = baseSpringrainService.queryForObject(time);
//					if(Integer.parseInt(String.valueOf(appuser.get("timeDifference")))>180){
//						au.setResetDate(new Date());
//						au.setMember("新手专享");
//					}
//				}
//				baseSpringrainService.updateValidValue(au);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}
