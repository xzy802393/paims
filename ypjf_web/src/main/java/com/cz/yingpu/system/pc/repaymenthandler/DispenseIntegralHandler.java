package com.cz.yingpu.system.pc.repaymenthandler;

import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserIntegralHistory;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import java.util.Date;

public class DispenseIntegralHandler extends CommonHandler {

	/**
	 * 项目换款时给投资人发放积分
	 */
	@Override
	public void handle(AppUser au, UserProject up, Double interest, IBaseSpringrainService service) {
		try {
			au.setIntegral(interest + (au.getIntegral() == null ? 0 : au.getIntegral()));
			service.updateValidValue(au);

			UserIntegralHistory uis = new UserIntegralHistory();
			uis.setUserId(au.getId());
			uis.setProjectId(up.getProjectId());
			uis.setIntegral(interest);
			uis.setTotalIntegral(au.getIntegral());
			uis.setOperationTime(new Date());
			uis.setOperationType(2);
			service.save(uis);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
