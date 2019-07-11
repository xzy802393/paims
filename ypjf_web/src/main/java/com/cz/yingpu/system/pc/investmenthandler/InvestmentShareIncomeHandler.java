package com.cz.yingpu.system.pc.investmenthandler;

import com.cz.yingpu.frame.util.DateUtils;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.fuyou.ConfigReader;
import com.cz.yingpu.system.entity.*;
import com.cz.yingpu.system.fuyoudata.CommonRspData;
import com.cz.yingpu.system.fuyoudata.TransferBmuReqData;
import com.cz.yingpu.system.pc.listener.CommonInvestEventListener;
import com.cz.yingpu.system.service.FuiouService;
import com.cz.yingpu.system.service.IBaseSpringrainService;
import org.apache.commons.lang3.ObjectUtils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.util.Date;
import java.util.Map;
import java.util.Random;


public class InvestmentShareIncomeHandler implements CommonInvestEventListener.InvestmentHanlder {

	public String getRand() {
		String x = "";
		Random r = new Random();
		x = r.nextInt(9999) + "";
		if (x.length() < 5) {
			for (int i = 0; i <= 5 - x.length(); i++) {
				x += "0";
			}
		}
		return x;
	}

	/** 创建富有转账请求对象 */
	public static TransferBmuReqData createFuiouReq(Double amount, String transferor, String reciver)
			throws ParseException {
		TransferBmuReqData transferBmuReqData = new TransferBmuReqData();
		transferBmuReqData.setVer(ConfigReader.getConfig("ver"));
		transferBmuReqData.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
		transferBmuReqData.setMchnt_txn_ssn(DateUtils.setDateFormat(
				new Date(), "yyyyMMddHHmmss") + DateUtils.getRand());
		transferBmuReqData.setOut_cust_no(transferor);
		transferBmuReqData.setIn_cust_no(reciver);
		transferBmuReqData.setAmt(new BigDecimal(amount).multiply(new BigDecimal(100)).setScale(0, RoundingMode.DOWN).toString());
		return transferBmuReqData;
	}

	/**
	 * 用户注册成功后奖励积分
	 */
	@Override
	public void handle(AppUser au, UserProject up, IBaseSpringrainService service) throws Exception {
		if (up.getPath() == null) {
			return;
		}

		try {
			au = service.queryForObject(au);
			if (au == null) {
				return;
			}

			AppUser fatherUser = service.queryForObject(
					new Finder("SELECT * FROM t_app_user WHERE id = :userId")
							.setParam("userId", au.getParentId()), AppUser.class);
			if (fatherUser == null) {
				return;
			}

			Finder paramFinder = new Finder("SELECT value FROM t_sys_sysparam WHERE code = 'fenxiaoPercent'");
			paramFinder.setEscapeSql(false);
			Map<String, Object> param = service.queryForObject(paramFinder);
			BigDecimal commission = new BigDecimal(up.getTotolInterest()).multiply(
					new BigDecimal(ObjectUtils.defaultIfNull(param.get("value"), 0).toString()));

			Finder uahFinder = new Finder("SELECT * FROM t_user_inviter WHERE userId=:userId");
			uahFinder.setParam("userId",fatherUser.getId());
			UserInviter userInviter = service.queryForObject(uahFinder, UserInviter.class);
			if(userInviter == null){
				UserInviter usi = new UserInviter();
				usi.setUserId(fatherUser.getId());
				usi.setTotalmoney(commission.doubleValue());
				usi.setStaymoney(commission.doubleValue());
				service.save(usi);
			}else {
				userInviter.setTotalmoney(commission.doubleValue() + userInviter.getTotalmoney());
				userInviter.setStaymoney(commission.doubleValue() + userInviter.getStaymoney());
				service.updateValidValue(userInviter);
			}
			UserAccountHistory uas = new UserAccountHistory();
			uas.setUserId(fatherUser.getId());
			uas.setMoney(commission.doubleValue());
			uas.setProjectId(up.getProjectId());
			uas.setPoundage(0D);
			uas.setType(8);
			uas.setStatus(1);
			uas.setCreatetime(new Date());
			uas.setProjectId(up.getProjectId());

			service.save(uas);

			fatherUser.setBalance(ObjectUtils.defaultIfNull(fatherUser.getBalance(), 0D) + commission.doubleValue());
			service.updateValidValue(fatherUser);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
