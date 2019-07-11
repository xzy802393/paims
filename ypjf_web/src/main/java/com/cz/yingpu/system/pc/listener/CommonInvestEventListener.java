package com.cz.yingpu.system.pc.listener;

import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.pc.activityhandler.$201812xxDrawActivityInvestmentHandler;
import com.cz.yingpu.system.pc.activityhandler.$201901GripDollActivityInvestmentHandler;
import com.cz.yingpu.system.pc.investmenthandler.InvestmentGetIntegralHandler;
import com.cz.yingpu.system.pc.investmenthandler.InvestmentShareIncomeHandler;
import com.cz.yingpu.system.service.IActivityQualificationService;
import com.cz.yingpu.system.service.IBaseSpringrainService;
import com.cz.yingpu.system.service.impl.UserProjectServiceImpl;
import com.cz.yingpu.system.pc.activityhandler.$201806DragonBoatActivityInvestmentHandler;
import com.cz.yingpu.system.pc.activityhandler.$201806WorldCupActivityInvestmentHandler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/** 通用的用于监听用户投资事件监听器 */
@Component("commonInvestEventListener")
public class CommonInvestEventListener implements UserProjectServiceImpl.InvestEventListener {

	@Autowired
	private IActivityQualificationService activityQualificationServiceImpl;

	List<InvestmentHanlder> investmentHandlers = new ArrayList<>();

	public CommonInvestEventListener() {
		UserProjectServiceImpl.investEventListeners.add(this);
		investmentHandlers.add(new $201812xxDrawActivityInvestmentHandler(1));
//		investmentHandlers.add(new $201901GripDollActivityInvestmentHandler(52));
		investmentHandlers.add(new InvestmentGetIntegralHandler());
		investmentHandlers.add(new InvestmentShareIncomeHandler());
	}

	@Override
	public void onInvestSuccess(Integer userId, Integer projectId, UserProject up) {
		activityQualificationServiceImpl.onUesrInvest(up);
		executInvestmentHandlers(userId, up);
	}

	@Override
	public void onInvestFail(Integer userId, Integer projectId, UserProject up) {
	}

	@Override
	public void onInvestException(Throwable t, Integer userId, Integer projectId) {
		writeLog(t, userId, projectId);
	}

	void executInvestmentHandlers(Integer userId, UserProject up) {
		for (InvestmentHanlder handler : investmentHandlers) {
			AppUser au = new AppUser();
			au.setId(userId);
			try {
				handler.handle(au, up, activityQualificationServiceImpl);
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

	public static void writeLog(Throwable t, Integer userId, Integer projectId) {
		String exStr;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		t.printStackTrace(new PrintStream(baos));
		exStr = new String(baos.toByteArray());
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		FileWriter fw = null;

		try {
			String path = "/webdata/invsetExceptionLogs";
			File logsDir = new File(path);
			if (!logsDir.isDirectory()) {
				logsDir.mkdirs();
			}

			fw = new FileWriter(new File(logsDir, sdf.format(new Date()) + ".log"), true);
			fw.append(new Date().toString()).append(" ")
					.append("[user:" + userId + "] ").append("[project:" + projectId + "]").append(" ")
					.append(exStr).append("\r\n");
			fw.flush();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if (fw != null) {
				try {
					fw.close();
				}
				catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}


	/** 项目投资成功的后续处理 */
	public interface InvestmentHanlder {
		void handle(AppUser au, UserProject up, IBaseSpringrainService service) throws Exception;
	}


	/** 项目投资成功的后续活动相关处理 */
	public interface ActivityInvestmentHanlder extends InvestmentHanlder {
	}


}

