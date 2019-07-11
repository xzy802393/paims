package com.cz.yingpu.system.pc.listener;

import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.Order;
import com.cz.yingpu.system.fuyoudata.P2p500405RspData;
import com.cz.yingpu.system.service.IBaseSpringrainService;

import java.util.Map;


/** 通用的用于监听用户注册事件监听器 */
public interface RechargeBalanceEventListener {

	public void onRechargeSuccess(Order order, P2p500405RspData response);

	public void onRechargeFailure(Order order, P2p500405RspData response);

	interface EventHandler {
		void hanldeSuccess(Order order, P2p500405RspData response);

		void hanldeFailure(Order order, P2p500405RspData response);
	}
}