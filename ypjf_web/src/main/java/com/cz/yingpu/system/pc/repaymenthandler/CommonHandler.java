package com.cz.yingpu.system.pc.repaymenthandler;

import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import java.util.ArrayList;
import java.util.List;

public class CommonHandler {

	static List<CommonHandler> handlers = new ArrayList<>();

	static {
		handlers.add(new DispenseIntegralHandler());
	}

	public CommonHandler() {
	}

	public void handle(AppUser au, UserProject up, Double interest, IBaseSpringrainService service) {
		for (CommonHandler handler : handlers) {
			try {
				handler.handle(au, up, interest, service);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}
