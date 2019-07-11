package com.cz.yingpu.system.task;


import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.SmartInvestmentOrder;
import com.cz.yingpu.system.entity.SmartInvestmentProject;
import com.cz.yingpu.system.service.ISmartProjectInvestmentService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 智能投资任务
 */
@Component
public class SmartInvestmentTask {

	@Resource
	private ISmartProjectInvestmentService smartProjectInvestmentService;

	@Resource
	private HttpServletRequest request;

	/** 更新智能投资进度 */
	@Scheduled(cron = "59 59 23 * * ?")
	public void updateSmartInvestment() {
		try {
			List<SmartInvestmentOrder> orderList = smartProjectInvestmentService.queryForList(new Finder(
					"SELECT id FROM t_smart_investment_order WHERE status < 4"), SmartInvestmentOrder.class);

			for (SmartInvestmentOrder order : orderList) {
				smartProjectInvestmentService.updateSmartInvestment(order.getId());
			}

			//smartProjectInvestmentService.generateDummySmartInvestRecord();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	/** 项目满标分散投资 */
	@Scheduled(cron = "0 */1 * * * ?")
	public void projecRaisetOnComplete() {
		List<SmartInvestmentProject> projects = null;

		try {
			projects = smartProjectInvestmentService.queryForList(new Finder(
					"SELECT id FROM t_smart_investment_project WHERE status = 3 AND remainsAmount = 0"),
					SmartInvestmentProject.class);

			if (!projects.isEmpty()) {
				for (SmartInvestmentProject project : projects) {

					project = smartProjectInvestmentService.findById(
							project.getId(), SmartInvestmentProject.class);
					if (project.getStatus() != 4) {
						double[] arr = smartProjectInvestmentService.smartInvestDisperseProject(project);
						if (arr[0] == project.getTotalAmount() && arr[1] == 0.0) {
							project.setStatus(4);
						}
						double dispersedAmount = smartProjectInvestmentService.
								smartInvestDisperse(project);

						project.setDispersedAmount((double) dispersedAmount);
						smartProjectInvestmentService.update(project, true);
					}
				}

				smartProjectInvestmentService.generateDummyDispersedRecord();
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	/** 自动取消过期债转 */
	@Scheduled(cron = "0 */5 * * * ?")
	public void cancelExpiresDebtAssignment() {
		try {
			smartProjectInvestmentService.cancelExpiresDebtAssignment();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
