package com.cz.yingpu.system.pc.activityhandler;

import com.cz.yingpu.frame.util.CalculationUtil;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.Activity201806DragonBoatInfo;
import com.cz.yingpu.system.entity.ActivityInvestHistory;
import com.cz.yingpu.system.entity.ActivityUser;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import javax.management.RuntimeErrorException;


/**
 * 2018年6月龙舟PK活动
 */
public class $201806DragonBoatActivityInvestmentHandler extends AbstractActivityInvestmentHanlder{

	public $201806DragonBoatActivityInvestmentHandler(int actId) {
		super(actId);
	}

	@Override
	public void handle(AppUser au, UserProject up, IBaseSpringrainService service) {
		try {
			super.handle(au, up, service);
			ActivityUser actUser = new ActivityUser();
			actUser.setUserId(au.getId());
			actUser.setActivityId(activityId);
			actUser = service.queryForObject(actUser);
			if (actUser == null || !activity.getId().equals(actUser.getActivityId())) {
				System.err.println("ID为" + au.getId() + "的用户暂未参加此活动!");
				return;
			}

			int MOVE_BASE_ANNUALIZED = 800, MOVE_DISTANCE_BASE_NUMBER = 80;
			Finder finder = new Finder("SELECT * FROM t_user_project WHERE id = :id")
					.append(" AND status = 2 AND createTime BETWEEN :start AND :end")
					.setParam("start", activity.getStarttime())
					.setParam("end", activity.getEndtime())
					.setParam("id", up.getId());
			ActivityInvestHistory history = new ActivityInvestHistory();
			double investMoney = up.getMoney() == null ? 0 : up.getMoney(),
				   cardMoney = up.getCardPrice() == null ? 0 : up.getCardPrice(),
				   annualizedInvestment = CalculationUtil.multiply(
							CalculationUtil.divide(investMoney + cardMoney, 12D), (double) up.getDeadLine()),
				   userInvsetMoney = actUser.getInvestAmount() == null ? 0 : actUser.getInvestAmount(),
				   userAnnualized = actUser.getAnnualized() == null ? 0 : actUser.getAnnualized();

			actUser.setUserId(au.getId());
			actUser.setInvestAmount(userInvsetMoney + investMoney);
			actUser.setAnnualized(userAnnualized + annualizedInvestment);
			service.updateValidValue(actUser);

			Finder uf = new Finder("UPDATE t_activity_user_group SET totalAnnualized = ")
					.append(" IFNULL(totalAnnualized, 0) + :thisAnnualized WHERE id = :gId")
					.setParam("gId", actUser.getGroupId())
					.setParam("thisAnnualized", annualizedInvestment);
			service.update(uf);

			Activity201806DragonBoatInfo dragonBoatInfo = new Activity201806DragonBoatInfo();
			dragonBoatInfo.setGroupId(actUser.getGroupId());
			Activity201806DragonBoatInfo dbDragonBoatInfo = service.queryForObject(dragonBoatInfo);
			if (dbDragonBoatInfo == null) {
				service.save(dragonBoatInfo);
			}

			uf = new Finder("UPDATE t_activity_201806_dragon_boat_info augdbi, t_activity_user_group aug")
					.append(" SET augdbi.moveDistance = FLOOR(ROUND(aug.totalAnnualized / "
								+ MOVE_BASE_ANNUALIZED + ", 2) * " + MOVE_DISTANCE_BASE_NUMBER + ")")
					.append(" WHERE aug.id = augdbi.groupId AND augdbi.groupId = :gId")
					.setParam("gId", actUser.getGroupId());
			service.update(uf);

			history.setUserProjectId(up.getId());
			history.setThisAnnualized(annualizedInvestment);
			history.setAnnualized(userAnnualized + annualizedInvestment);
			history.setUserId(au.getId());
			service.save(history);
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
