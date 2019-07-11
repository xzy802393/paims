package com.cz.yingpu.system.pc.registerhandler;

import com.cz.yingpu.frame.util.CalculationUtil;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.Activity;
import com.cz.yingpu.system.entity.ActivityUser;
import com.cz.yingpu.system.entity.ActivityUserQualification;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.service.IBaseSpringrainService;
import com.cz.yingpu.system.pc.listener.CommonRegisterEventListener;

import org.apache.commons.lang.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.management.RuntimeErrorException;

public class Activity201806DragonBoatRegisterSuccessHandler implements CommonRegisterEventListener.SuccessHandler {

	String ACTIVITY_ID = "39";

	@Override
	public void handleSuccess(AppUser au, Map<String, String> param, IBaseSpringrainService service) {
		try {
			String type = param.get("type"),
				   method = param.get("method"),
				   inviter = param.get("inviteCode"),
				   activityId = param.get("activityId");

			if ("invite".equals(method) && "activity".equals(type) && StringUtils.isNotBlank(inviter)
					&& ACTIVITY_ID.equals(activityId)) {
				AppUser queryUser = new AppUser();
				queryUser.setPhone(inviter);

				queryUser = service.queryForObject(queryUser);
				if (queryUser == null) {
					throw new RuntimeErrorException(null, "邀请人不存在！");
				}

				String qualificationName = "dragonBoatForwardTimes";
				ActivityUserQualification qualification = new ActivityUserQualification();
				ActivityUserQualification dbQlf = new ActivityUserQualification();
				qualification.setQualificationName(qualificationName);
				qualification.setActivityId(Integer.parseInt(ACTIVITY_ID));
				qualification.setUserId(au.getId());

				dbQlf = service.queryForObject(qualification);
				qualification.setQualificationValue("1");
				if (dbQlf == null) {
					service.save(qualification);
				}
				else {
					service.updateValidValue(qualification);
				}

				ActivityUser actInviter = new ActivityUser();
				ActivityUser actUser = new ActivityUser();
				actInviter.setUserId(queryUser.getId());
				actInviter.setActivityId(Integer.parseInt(ACTIVITY_ID));
				actInviter = service.queryForObject(actInviter);
				if (actInviter == null) {
					throw new RuntimeErrorException(null, "邀请人未参加此活动！");
				}

				actUser.setUserId(au.getId());
				actUser.setGroupId(actInviter.getGroupId());
				actUser.setJoinTime(new Date());
				actUser.setActivityId(Integer.parseInt(ACTIVITY_ID));
				service.save(actUser);

				Finder upFinder = new Finder("UPDATE t_activity_user_group SET userNum = IFNULL(userNum, 0) + 1")
						.append(" WHERE id = :groupId")
						.setParam("groupId", actInviter.getGroupId());
				service.update(upFinder);

				updateGroupInvestAnnualized_20180501(au, service);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	Activity getActivity(Integer actId, IBaseSpringrainService baseSpringrainService) throws Exception {
		String msg = "";
		Date now = new Date();
		Activity activity = new Activity();

		activity.setId(actId);
		activity = baseSpringrainService.queryForObject(activity);
		if (activity != null) {
			if (now.before(activity.getStarttime())) {
				msg = "活动暂未开始！";
			} else if (now.after(activity.getEndtime())) {
				msg = "活动已经结束！";
			}
			if (org.apache.commons.lang3.StringUtils.isNotBlank(msg)) {
				activity = null;
				System.out.println(msg);
			}
		}

		return activity;
	}

	public void updateGroupInvestAnnualized_20180501(AppUser au, IBaseSpringrainService baseSpringrainService) {
		int activityId = 39;

		try {
			Activity activity = getActivity(activityId, baseSpringrainService);
			if (activity == null) {
				System.out.println("找不到ID为" + activityId + "的活动");
				return;
			}

			ActivityUser actUser = new ActivityUser();
			actUser.setUserId(au.getId());
			actUser.setActivityId(activityId);
			actUser = baseSpringrainService.queryForObject(actUser);
			if (actUser == null) {
				System.out.println("ID为" + au.getId() + "的用户暂未参加此活动!");
				return;
			}

			Finder finder = new Finder("SELECT * FROM t_user_project WHERE userId = :uid")
					.append(" AND status = 2 AND createTime BETWEEN :start AND :end")
					.setParam("start", activity.getStarttime())
					.setParam("end", activity.getEndtime())
					.setParam("uid", au.getId());

			List<UserProject> userProjectList = baseSpringrainService.queryForList(finder, UserProject.class);

			ActivityUser user = new ActivityUser();
			if (userProjectList.isEmpty()) {
				return;
			}

			double totalInvestMoney = 0, annualizedInvestment = 0;
			int drawTimes = 0;
			for (UserProject _up : userProjectList) {
				Double cardPrize = _up.getCardPrice() == null ? 0 : _up.getCardPrice();
				totalInvestMoney = CalculationUtil.addition(totalInvestMoney, _up.getMoney() + cardPrize);
				annualizedInvestment = CalculationUtil.addition(
						annualizedInvestment, CalculationUtil.multiply(
								CalculationUtil.divide(_up.getMoney() + cardPrize, 12D),
								(double) _up.getDeadLine()));
			}

			user.setUserId(au.getId());
			actUser.setInvestAmount(totalInvestMoney);
			actUser.setAnnualized(annualizedInvestment);
			baseSpringrainService.updateValidValue(actUser);

			Finder uf = new Finder("UPDATE t_activity_user_group SET totalAnnualized = ")
					.append(" (SELECT SUM(IF(annualized IS NULL, 0, annualized))")
					.append(" FROM t_activity_user WHERE groupId = :gId)")
					.append(" WHERE id = :gId")
					.setParam("gId", actUser.getGroupId());

			baseSpringrainService.update(uf);
		}
		catch(Exception e) {
			if (e instanceof RuntimeErrorException) {
				System.err.println(e.getMessage());
				return;
			}
			e.printStackTrace();
		}
	}
}
