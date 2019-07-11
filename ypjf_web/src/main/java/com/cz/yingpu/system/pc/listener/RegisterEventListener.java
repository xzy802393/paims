package com.cz.yingpu.system.pc.listener;

import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import java.util.Map;


/** 通用的用于监听用户注册事件监听器 */
public interface RegisterEventListener {

	void onRegisterSuccess(AppUser au, Map<String, String> param, IBaseSpringrainService service);

	void onRegisterException(AppUser au, Map<String, String> param, Throwable e);

}