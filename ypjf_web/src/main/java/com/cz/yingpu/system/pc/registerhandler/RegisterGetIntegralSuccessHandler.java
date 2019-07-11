package com.cz.yingpu.system.pc.registerhandler;

import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserIntegralHistory;
import com.cz.yingpu.system.pc.listener.CommonRegisterEventListener;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import java.util.Date;
import java.util.Map;

public class RegisterGetIntegralSuccessHandler implements CommonRegisterEventListener.SuccessHandler {

	@Override
	public void handleSuccess(AppUser au, Map<String, String> param, IBaseSpringrainService service)  {
		try {
			Finder finder = new Finder("SELECT value FROM t_sys_sysparam WHERE code = :code")
					.setParam("code", "registerIntegral");
			Map<String, Object> result = service.queryForObject(finder);
			double registerIntegral = Double.parseDouble(result.get("value").toString());

			au.setIntegral(registerIntegral + (au.getIntegral() == null ? 0 : au.getIntegral()));
			service.updateValidValue(au);

			UserIntegralHistory uis = new UserIntegralHistory();
			uis.setUserId(au.getId());
			uis.setIntegral(registerIntegral);
			uis.setTotalIntegral(au.getIntegral());
			uis.setOperationTime(new Date());
			uis.setOperationType(0);
			service.save(uis);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
