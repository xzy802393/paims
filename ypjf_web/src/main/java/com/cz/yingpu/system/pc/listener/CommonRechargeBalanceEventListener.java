package com.cz.yingpu.system.pc.listener;

import com.cz.yingpu.system.entity.Order;
import com.cz.yingpu.system.fuyoudata.P2p500405RspData;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 充值事件监听器
 */
@Component
public class CommonRechargeBalanceEventListener implements RechargeBalanceEventListener{
	private static List<RechargeBalanceEventListener.EventHandler> handlers = new ArrayList<>();

	public static void addHandler(EventHandler handler) {
		if (handler != null) {
			synchronized (handlers) {
				if (!handlers.contains(handler)) {
					handlers.add(handler);
				}
			}
		}
	}

	public static void removeHandler(EventHandler handler) {
		if (handler != null) {
			synchronized (handlers) {
				handlers.remove(handler);
			}
		}
	}

	@Override
	public void onRechargeSuccess(Order order, P2p500405RspData response) {
		for (RechargeBalanceEventListener.EventHandler handler : handlers) {
			try {
				handler.hanldeSuccess(order, response);
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void onRechargeFailure(Order order, P2p500405RspData response) {
		for (RechargeBalanceEventListener.EventHandler handler : handlers) {
			try {
				handler.hanldeFailure(order, response);
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
