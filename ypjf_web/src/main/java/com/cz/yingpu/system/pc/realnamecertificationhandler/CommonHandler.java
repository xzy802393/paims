package com.cz.yingpu.system.pc.realnamecertificationhandler;

import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.pc.repaymenthandler.DispenseIntegralHandler;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import java.util.ArrayList;
import java.util.List;

public class CommonHandler {

	static List<CommonHandler> handlers = new ArrayList<>();

	static {
		handlers.add(new GetIntegralHandler());
	}

	public CommonHandler() {
	}

	public void handle(AppUser au, IBaseSpringrainService service) {
		for (CommonHandler handler : handlers) {
			try {
				handler.handle(au, service);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}
