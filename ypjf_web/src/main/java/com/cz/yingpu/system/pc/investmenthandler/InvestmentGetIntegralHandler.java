package com.cz.yingpu.system.pc.investmenthandler;

import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserIntegralHistory;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.pc.listener.CommonInvestEventListener;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import org.apache.commons.lang3.ObjectUtils;

import java.util.Date;


public class InvestmentGetIntegralHandler implements CommonInvestEventListener.InvestmentHanlder {

	/**
	 * 用户注册成功后奖励积分
	 */
	@Override
	public void handle(AppUser au, UserProject up, IBaseSpringrainService service) throws Exception {
		if (up.getPath() == null) {
			return;
		}

		try {
			au = service.queryForObject(au);
			if (au == null) {
				return;
			}

			au.setIntegral(ObjectUtils.defaultIfNull(au.getIntegral(), 0D) + up.getTotolInterest());
			service.updateValidValue(au);

			UserIntegralHistory uis = new UserIntegralHistory();
			uis.setUserId(au.getId());
			uis.setIntegral(up.getTotolInterest());
			uis.setTotalIntegral(au.getIntegral());
			uis.setOperationTime(new Date());
			uis.setOperationType(2);
			uis.setProjectId(up.getProjectId());
			service.save(uis);
		}
		catch(Exception e) {
			e.printStackTrace();
		}

	}
}
