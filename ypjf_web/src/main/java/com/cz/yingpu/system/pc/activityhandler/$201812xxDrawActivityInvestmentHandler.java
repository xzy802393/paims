package com.cz.yingpu.system.pc.activityhandler;

import com.cz.yingpu.frame.util.CalculationUtil;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.ActivityUserQualification;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import javax.management.RuntimeErrorException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 18年12月投资抽奖活动
 */
public class $201812xxDrawActivityInvestmentHandler extends AbstractActivityInvestmentHanlder {
	public $201812xxDrawActivityInvestmentHandler(int actId) {
		super(actId);
	}

	public void handle(AppUser au, UserProject up, IBaseSpringrainService service) {

		try {
			super.handle(au, up, service);
			int activityId = activity.getId(),
				annualizedBaseNumber = 500;
			double investMoney = up.getMoney() == null ? 0 : up.getMoney(),
				   cardMoney = up.getCardPrice() == null ? 0 : up.getCardPrice(),
				   annualizedInvestment = CalculationUtil.multiply(
				   			CalculationUtil.divide(investMoney + cardMoney, 12D), (double) up.getDeadLine());
			Map<String, String> qualificationMap = null;
			String[] qualificationKeyValues = {
					"annualizedInvestment", annualizedInvestment + "",
					"totalDrawTimes", "0"
			};

			ActivityUserQualification queryQlf = new ActivityUserQualification();
			queryQlf.setActivityId(activityId);
			queryQlf.setUserId(au.getId());
			List<ActivityUserQualification> dbQlfList = service.queryForListByEntity(queryQlf, null);
			qualificationMap = getQualificationMap(dbQlfList);
			boolean isUpdate = !qualificationMap.isEmpty();

			for (int i = 0; i < qualificationKeyValues.length; i += 2) {
				String key = qualificationKeyValues[i];
				String dbValue = qualificationMap.get(key) == null ? "0" : qualificationMap.get(key);
				String value = new BigDecimal(dbValue).add(new BigDecimal(qualificationKeyValues[i + 1]))
										.setScale(2, BigDecimal.ROUND_HALF_UP).toString();

				qualificationMap.put(key, value);
				ActivityUserQualification qualification = new ActivityUserQualification();
				qualification.setQualificationValue(value);
				if (isUpdate) {
					int id = 0;
					for (ActivityUserQualification qlf : dbQlfList) {
						if (qlf.getQualificationName().equals(key)) {
							id = qlf.getId();
							break;
						}
					}
					qualification.setId(id);
					service.updateValidValue(qualification);
				} else {
					qualification.setUserId(au.getId());
					qualification.setActivityId(activityId);
					qualification.setQualificationName(key);
					service.save(qualification);
				}
			}

			Finder finder = new Finder("UPDATE t_activity_user_qualification SET qualificationValue = :value")
					.append(" WHERE qualificationName = :name AND userId = :userId AND activityId = :actId")
					.setParam("value", new BigDecimal(qualificationMap.get("annualizedInvestment"))
							.divide(new BigDecimal(annualizedBaseNumber)).intValue())
					.setParam("name", "totalDrawTimes")
					.setParam("userId", au.getId())
					.setParam("actId", activityId);
			service.update(finder);
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
