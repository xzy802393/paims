package com.cz.yingpu.system.pc.realnamecertificationhandler;

import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserIntegralHistory;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import java.util.Date;
import java.util.Map;

public class GetIntegralHandler extends CommonHandler {

	@Override
	public void handle(AppUser au, IBaseSpringrainService service) {
		try {
			Finder finder = new Finder("SELECT value FROM t_sys_sysparam WHERE code = :code")
					.setParam("code", "realNameCertificationIntegral");
			Map<String, Object> result = service.queryForObject(finder);
			double realNameIntegral = Double.parseDouble(result.get("value").toString());

			AppUser appUser = new AppUser();
			appUser.setId(au.getId());
			au = service.queryForObject(appUser);
			au.setIntegral(realNameIntegral + (au.getIntegral() == null ? 0 : au.getIntegral()));
			service.updateValidValue(au);

			UserIntegralHistory uis = new UserIntegralHistory();
			uis.setUserId(au.getId());
			uis.setIntegral(realNameIntegral);
			uis.setTotalIntegral(au.getIntegral());
			uis.setOperationTime(new Date());
			uis.setOperationType(1);
			service.save(uis);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
