package com.cz.yingpu.system.pc.activityhandler;

import com.cz.yingpu.system.entity.Activity;
import com.cz.yingpu.system.entity.ActivityUserQualification;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.service.IBaseSpringrainService;
import com.cz.yingpu.system.pc.listener.CommonInvestEventListener;

import org.apache.commons.lang3.StringUtils;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.management.RuntimeErrorException;

public abstract class AbstractActivityInvestmentHanlder implements CommonInvestEventListener.ActivityInvestmentHanlder {

	protected IBaseSpringrainService service;

	protected Activity activity;

	protected int activityId;

	protected Activity getActivity(Integer actId) throws Exception {
		Activity activity = new Activity();
		activity.setId(actId);
		this.activity= service.queryForObject(activity);
		return this.activity;
	}

	protected boolean isActivityAvaliable(Activity activity) {
		String msg = "";
		Date now = new Date();
		if (activity == null) {
			msg = "此活动不存在！";
		}
		if (now.before(activity.getStarttime())) {
			msg = "活动暂未开始！";
		} else if (now.after(activity.getEndtime())) {
			msg = "活动已经结束！";
		}
		if (StringUtils.isNotBlank(msg)) {
			System.out.println(msg);
		}

		return msg.length() == 0;
	}

	public AbstractActivityInvestmentHanlder(int actId) {
		activityId = actId;
	}

	public void handle(AppUser au, UserProject up, IBaseSpringrainService service) throws Exception {
		this.service = service;
		if (!isActivityAvaliable(getActivity(activityId))) {
			throw new RuntimeErrorException(null, "此活动暂时不可用！");
		}
		if (up.getStatus() != 2) {
			throw new RuntimeErrorException(null, "项目未投资成功！");
		}
	}

	protected Map<String, String> getQualificationMap(List<ActivityUserQualification> dbQlfList) {
		Map<String, String> map = new HashMap<>();

		try {
			for (ActivityUserQualification qlf : dbQlfList) {
				map.put(qlf.getQualificationName(), qlf.getQualificationValue());
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		return map;
	}
}
