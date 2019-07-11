package com.cz.yingpu.system.pc.listener;

import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.pc.registerhandler.RegisterGetIntegralSuccessHandler;
import com.cz.yingpu.system.service.IBaseSpringrainService;
import com.cz.yingpu.system.pc.registerhandler.Activity201806DragonBoatRegisterSuccessHandler;

import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Component
public class CommonRegisterEventListener implements RegisterEventListener {

	private List<SuccessHandler> successHandlers = new ArrayList<>();

	public CommonRegisterEventListener() {
		//successHandlers.add(new Activity201806DragonBoatRegisterSuccessHandler());
		successHandlers.add(new RegisterGetIntegralSuccessHandler());
	}

	@Override
	public void onRegisterSuccess(AppUser au, Map<String, String> param, IBaseSpringrainService service) {
		for (SuccessHandler handler : successHandlers) {
			handler.handleSuccess(au, param, service);
		}
	}

	@Override
	public void onRegisterException(AppUser au, Map<String, String> param, Throwable e) {

	}

	public interface SuccessHandler {
		void handleSuccess(AppUser au, Map<String, String> param, IBaseSpringrainService service);
	}
}


