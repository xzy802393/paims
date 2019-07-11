package com.cz.yingpu.system.pc;


import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.frame.util.fuyou.ConfigReader;
import com.cz.yingpu.system.entity.*;
import com.cz.yingpu.system.fuyoudata.*;
import com.cz.yingpu.system.pc.listener.CommonRechargeBalanceEventListener;
import com.cz.yingpu.system.pc.listener.RechargeBalanceEventListener;
import com.cz.yingpu.system.service.*;
import com.cz.yingpu.system.service.impl.SmartProjectInvestmentServiceImpl;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.apache.commons.beanutils.BeanMap;
import org.apache.commons.lang3.ObjectUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.cz.yingpu.frame.util.DateUtils.getRand;

/*
 * 智能投资实现
 */
@Controller
@RequestMapping("/pc/si")
public class SmartProjectInvestmentController extends BaseController implements RechargeBalanceEventListener.EventHandler {
	private static Logger logger = LoggerFactory.getLogger(SmartProjectInvestmentController.class);

	private static final String PAYMENT_SUCCESS_CODE = "0000";

	public static final String TAG_ERR_RETURN_MONEY_FAILURE = "退还用户资金失败";

	public static final String TAG_ERR_IVESTMENT_FAILURE = "用户投资失败";

	public static final String TAG_ERR_PAYMNET_FAILURE = "用户支付失败";

	public static final String TAG_ERR_DEBT_ASSIGNMENT_FAILURE = "用户债转失败";

	public static final String TAG_ERR_NORMAL = "出现异常";

	public static final int MAX_TRADE_PASSWORD_RETRY_TIMES = 5;

	public static final String TRADE_PASSWORD_RETRY_TIMES_KEY = "trade_password_retry_times";

    @Resource
    ISmartProjectInvestmentService smartProjectInvestmentService;

	@Resource
	IPCProjectListService pCProjectListService;

    @Resource
	HttpServletRequest request;

    @Resource
	HttpSession session;

    @Resource
	IAppUserService appUserService;

    @Resource
	JPushService jPushService;

	@Resource
	private DataSourceTransactionManager transactionManager;


    public SmartProjectInvestmentController() {
    	/** 添加余额充值处理器 */
		CommonRechargeBalanceEventListener.addHandler(this);
	}

	/** 获取Session中的User */
    AppUser getSessionUser() {
		return (AppUser) session.getAttribute(GlobalStatic.PCUSER);
	}

	/** 确保用户已登录 */
    public static void ensureLogin(AppUser user) throws Exception {
		if (user == null) {
			throw new Exception("您尚未登录，请先登录后在进行操作！");
		}
	}

	/** 确保交易密码输入正确 */
	public static void ensureTradePasswordRight(AppUser user, String password) throws Exception {
		String userTradePass = user.getTradPassword();
		if (userTradePass == null) {
			throw new Exception("请先设置交易密码！");
		}
		if (!userTradePass.equals(CryptAES.AES_Encrypt(ObjectUtils.defaultIfNull(password, "")))) {
			throw new Exception("您输入的交易密码有误！");
		}
	}

	/** 创建支付记录 */
	private void createPaymentRecord(AppUser appUser, TransferBmuReqData transferBmuReqData, double amount,
		 	Integer orderType, Integer historyType, Integer projectId) throws Exception {
		Order order = new Order();
		order.setUserId(appUser.getId());
		order.setTradeNo(transferBmuReqData.getMchnt_txn_ssn());
		order.setCreateTime(new Date());
		order.setMoney(amount);
		order.setType(orderType);
		order.setStatus(2);
		order.setProjectId(projectId);
		order.setId(Integer.parseInt(smartProjectInvestmentService.save(order).toString()));

		UserAccountHistory userAccountHistory = new UserAccountHistory();
		userAccountHistory.setUserId(appUser.getId());
		userAccountHistory.setMoney(amount);
		userAccountHistory.setAfterMoney(appUser.getBalance() + amount);
		userAccountHistory.setType(historyType);
		userAccountHistory.setTradeNo(transferBmuReqData.getMchnt_txn_ssn());
		userAccountHistory.setStatus(2);
		userAccountHistory.setCreatetime(new Date());
		userAccountHistory.setOrderId(order.getId());
		userAccountHistory.setProjectId(projectId);
		smartProjectInvestmentService.save(userAccountHistory);
	}

	/** 创建富有转账请求对象 */
	public static TransferBmuReqData createFuiouReq(Double amount, String transferor, String reciver)
			throws ParseException {
		TransferBmuReqData transferBmuReqData = new TransferBmuReqData();
		transferBmuReqData.setVer(ConfigReader.getConfig("ver"));
		transferBmuReqData.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
		transferBmuReqData.setMchnt_txn_ssn(DateUtils.setDateFormat(
				new Date(), "yyyyMMddHHmmss") + getRand());
		transferBmuReqData.setOut_cust_no(transferor);
		transferBmuReqData.setIn_cust_no(reciver);
		transferBmuReqData.setAmt(new BigDecimal(amount).multiply(new BigDecimal(100))
				.setScale(0, RoundingMode.DOWN).toString());
		return transferBmuReqData;
	}

	/** 投资支付 */
	private CommonRspData payment(AppUser appUser, double amount, Integer projectId) throws Exception {
    	TransferBmuReqData data = createFuiouReq(
    			amount, appUser.getPhone(), ConfigReader.getConfig("mchnt_no"));
    	createPaymentRecord(appUser, data, amount, 15, 11, projectId);
		CommonRspData commonRspData = FuiouService.transferBmu(data);
		return commonRspData;
	}

	/** 返还支付金额 */
	private CommonRspData returnMoney(AppUser au, double amount, Integer projectId) throws Exception {
		TransferBmuReqData data = createFuiouReq(
				amount, ConfigReader.getConfig("mchnt_no"), au.getPhone());
		createPaymentRecord(au, data, amount, 16, 12, projectId);
		CommonRspData commonRspData = FuiouService.transferBmu(data);
		return commonRspData;
	}

	/** 用户间转账 */
	private CommonRspData transferMoney(AppUser au, String transferorPhone, String reciverPhone, double amount)
			throws Exception {
		TransferBmuReqData data = createFuiouReq(amount, transferorPhone, reciverPhone);
		UserAccountHistory userAccountHistory = new UserAccountHistory();
		userAccountHistory.setUserId(au.getId());
		userAccountHistory.setMoney(amount);
		userAccountHistory.setAfterMoney(au.getBalance() - amount);
		userAccountHistory.setType(13);
		userAccountHistory.setTradeNo(data.getMchnt_txn_ssn());
		userAccountHistory.setStatus(2);
		userAccountHistory.setCreatetime(new Date());
		smartProjectInvestmentService.save(userAccountHistory);

		CommonRspData commonRspData = FuiouService.transferBu(data);
		return commonRspData;
	}

	class DBTransaction {
		TransactionStatus transactionStatus;
		public void begin() throws Exception {
			DefaultTransactionDefinition def = new DefaultTransactionDefinition();
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
			transactionStatus = transactionManager.getTransaction(def);
		}

		public void commit() throws Exception {
			if (transactionStatus != null) {
				transactionManager.commit(transactionStatus);
			}
		}

		public void rollback() {
			if (transactionStatus != null) {
				transactionManager.rollback(transactionStatus);
			}
		}
	}

	/** 选取最新的智能投资项目 */
	@RequestMapping("/project/newest/json")
	@ResponseBody
	public ReturnDatas newestProject() {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();
		Finder finder = new Finder("SELECT p.* FROM t_smart_investment_project p, (" +
				  "SELECT max(id) id FROM t_smart_investment_project GROUP BY deadLine" +
				") t WHERE p.id = t.id ORDER BY p.deadLine");
		finder.setEscapeSql(false);
		try {
			List<SmartInvestmentProject> projectList = smartProjectInvestmentService.queryForList(
					finder, SmartInvestmentProject.class);
			rt.setData(projectList);
		}
		catch (Exception e) {
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}

		return rt;
	}

	/**跳转至智能投资页面*/
	@RequestMapping("/boower/Project")
	@ResponseBody
	public Object boowerProject(HttpServletRequest request){
		ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
		List<Map<String,Object>> borrowerProject = new ArrayList<>();
		Finder Finder1 = new Finder("select tp.id,tp.name,tp.deadLine,tp.totalAmount,tb.legalPerson from t_project tp,t_borrower tb where tp.borrowerId=tb.id and tp.type = 2");
		Page  page = newPage(request);
		page.setPageSize(10);
		page.setSort("DESC");
		page.setOrder("tp.createTime");
		try {
			borrowerProject = pCProjectListService.queryForList(Finder1,page);
		}catch (Exception e){
			e.printStackTrace();
		}
		returnDatas.setData(borrowerProject);
		returnDatas.setPage(page);
		return returnDatas;
	}


	/** 智投结算页 */
	@RequestMapping("/checkout")
	public String checkout(Integer amount, Integer deadLine, Integer projectId) throws Exception {
		AppUser user = getSessionUser();

		try {
			ensureLogin(user);
			SmartInvestmentProject p = smartProjectInvestmentService.findById(
					projectId, SmartInvestmentProject.class);
			List<UserCard> cards = smartProjectInvestmentService.selectSuitableCoupons(
					user.getId(), deadLine, amount);
			Map<String, Object> map = smartProjectInvestmentService.queryForObject(
					new Finder("SELECT * FROM t_bank WHERE bankId=:bankId")
							.setParam("bankId", user.getBankId()));
			if (map != null) {
				map.put("banknum", user.getBankNum() != null ?
						user.getBankNum().substring(user.getBankNum().length() - 4) : "");
				map.put("project", p);
				map.put("userCards", cards);
			}
			request.setAttribute("bank", map);
			request.setAttribute("data", map);
		}
		catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return "pc/my-invest/zhitou-zhifu";
	}

	/** 获取用户投资金额选取合适的优惠券 */
	@RequestMapping("/coupons/suitable")
	@ResponseBody
	public ReturnDatas coupons(Integer amount, Integer deadLine) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();
		boolean isPaymentSuccess = false;

		try {
			ensureLogin(user);
			rt.setData(smartProjectInvestmentService.selectSuitableCoupons(user.getId(), deadLine, amount));
		}
		catch (Exception e) {
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}

		return rt;
	}

	/** 投资流程 */
	private void doInvest(AppUser user, Integer projectId, Integer orderId, Double amount, Integer deadLine)
			throws Exception {
		smartProjectInvestmentService.initUserInfo(user.getId(), orderId);
		smartProjectInvestmentService.investProject(user.getId(), amount, projectId, deadLine);
	}

	/**
	 * 自动投资债转
	 */
	private double doInvestDebt(List<SmartInvestmentDebtAssignmentItem> debts, double investAmount) {
		double actualInvestAmount = 0D;
		for (SmartInvestmentDebtAssignmentItem item : debts) {
			if (investAmount < 100) {
				break;
			}

			double debtAmount = item.getAmount() - item.getInterest();
			if (item.getAmount() <= investAmount) {
				actualInvestAmount = item.getAmount() - item.getInterest();
			}
			else {
				if (item.getAmount() - item.getInterest() < 500) {
					continue;
				}

				if (!item.getIsCharge()) {
					actualInvestAmount = investAmount;
				}
				else {
					actualInvestAmount = (int) (investAmount -
							investAmount / (item.getAmount() - item.getInterest()) * item.getInterest());
				}
			}

			ReturnDatas returnDatas = debtProjectBuy(item.getId(), actualInvestAmount, "", true);
			if (ReturnDatas.ERROR.equals(returnDatas.getStatus())) {
				break;
			}

			investAmount -= (Double) returnDatas.getData();
			System.out.println("自动购买" + actualInvestAmount + "元债转");
		}
		return investAmount;
	}

	/** 智能投资使用余额 */
	@RequestMapping("/invest/balance/pay")
	@ResponseBody
	public ReturnDatas investByBalance(Integer projectId, Double amount, Integer deadLine,
			Integer[] couponIdArr, String tradePassword) throws Exception {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();
		boolean isPaymentSuccess = false;
		DBTransaction transaction = new DBTransaction();

		try {
			transaction.begin();
			ensureLogin(user);
			ensureTradePasswordRight(user, tradePassword);
			CommonRspData rsp = payment(user, amount, projectId);
			if (!PAYMENT_SUCCESS_CODE.equals(rsp.getResp_code())) {
				throw new PaymentFailException(rsp.getResp_desc(), rsp.getResp_code());
			}

			isPaymentSuccess = true;
			double amountOfDebtDisperse = amount * SmartProjectInvestmentServiceImpl.DEBT_INVESTMENT_DISPERSE_RATIO,
				   amountOfSmartInvest = amount * SmartProjectInvestmentServiceImpl.SMART_INVESTMENT_DISPERSE_RATIO;
			List<SmartInvestmentDebtAssignmentItem> debts = smartProjectInvestmentService.selectSuitableDebts(
					user, amount);
			if (!debts.isEmpty()) {
				amountOfDebtDisperse = doInvestDebt(debts, amountOfDebtDisperse);
			}

			amountOfSmartInvest += amountOfDebtDisperse;
			SmartInvestmentOrder order = smartProjectInvestmentService.createOrder(
					projectId, user.getId(), amountOfSmartInvest, deadLine, couponIdArr, null);
			doInvest(user, projectId, order.getId(), amountOfSmartInvest, deadLine);

			user.setBalance(user.getBalance() - order.getInvestmentAmount());
			smartProjectInvestmentService.update(user, true);

			order.setStatus(1);
			smartProjectInvestmentService.update(order, true);
			transaction.commit();
		}
		catch (Exception e) {
			transaction.rollback();
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
			logger.error(e instanceof PaymentFailException ?
					TAG_ERR_IVESTMENT_FAILURE : TAG_ERR_PAYMNET_FAILURE, e);

			if (isPaymentSuccess) {
				try {
					//退回已支付的资金
					CommonRspData rsp = returnMoney(user, amount, projectId);
					if (!PAYMENT_SUCCESS_CODE.equals(rsp.getResp_code())) {
						throw new PaymentFailException(rsp.getResp_desc(), rsp.getResp_code());
					}
				}
				catch (Exception e1) {
					logger.error(TAG_ERR_RETURN_MONEY_FAILURE, e1);
					e1.printStackTrace();
				}
			}
		}
		finally {
			transaction = null;
		}

		return rt;
    }

    private String obj2UrlQueryString(Object obj) throws UnsupportedEncodingException {
		BeanMap map = new BeanMap(obj);
		StringBuilder sb = new StringBuilder();
		for (Object object : map.entrySet()) {
			Map.Entry entry = (Map.Entry) object;
			sb.append(entry.getKey().toString()).append("=")
					.append(URLEncoder.encode(entry.getValue().toString(), "UTF-8")).append("&");
		}
		return sb.substring(0, sb.length() - 1);
	}

	/** 创建投资订单 */
	@RequestMapping("/invest/order/create")
	@ResponseBody
	public ReturnDatas createOrder(Integer projectId, Double amount, Integer deadLine,
	    	Integer[] couponIdArr, Integer orderId, String type, String bank, AppUser au, Double money) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();

		try {
			ensureLogin(user);
			RechargeRequest request = createRechargeRequest(au, type, bank);
			SmartInvestmentOrder order = smartProjectInvestmentService.createOrder(
					projectId, user.getId(), amount, deadLine, couponIdArr, request.order.getId());
			double realMoney = order.getActualAmount();
			if (realMoney != money) {
				throw new Exception("参数异常，请不要更改参数！");
			}

			String api = "kj".equals(type) ? "/yingpu/pc/si/invest/recharge?"
					: "/yingpu/pc/si/invest/obs/recharge?";
			rt.setData(api + obj2UrlQueryString(request.data) + "&money=" + realMoney);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}

		return rt;
	}

	class RechargeRequest {
		Order order;
		Object data;
	}

	private RechargeRequest createRechargeRequest(AppUser appUser, String type, String bank) throws Exception {
		AppUser aUser = getSessionUser();
		AppTransReqData appTransReqData = new AppTransReqData();
		Object data;

		if (!"kj".equals(type)) {
			Wy500012ReqData wy500012ReqData = new Wy500012ReqData();
			wy500012ReqData.setAmt(new BigDecimal(appUser.getMoney()).multiply(
					new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).toString());
			wy500012ReqData.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
			wy500012ReqData.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
			wy500012ReqData.setLogin_id(aUser.getPhone());
			wy500012ReqData.setOrder_pay_type("B2C");
			wy500012ReqData.setPage_notify_url(ConfigReader.getConfig("webP2PRech_notify_url"));
			wy500012ReqData.setIss_ins_cd(bank);
			appTransReqData.setMchnt_txn_ssn(wy500012ReqData.getMchnt_txn_ssn());
			data = wy500012ReqData;
		}
		else {
			P2p500405ReqData p2p500405ReqData = new P2p500405ReqData();
			p2p500405ReqData.setAmt(new BigDecimal(appUser.getMoney()).multiply(
					new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).toString());
			p2p500405ReqData.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
			p2p500405ReqData.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
			p2p500405ReqData.setLogin_id(aUser.getPhone());
			p2p500405ReqData.setPage_notify_url(ConfigReader.getConfig("webP2PRech_notify_url"));
			aUser.setMoney(appUser.getMoney());
			appTransReqData.setMchnt_txn_ssn(p2p500405ReqData.getMchnt_txn_ssn());
			data = p2p500405ReqData;
		}

		Order order = appUserService.saveDetail(1, aUser, appTransReqData);
		RechargeRequest request = new RechargeRequest();
		request.order = order;
		request.data = data;
		return request;
	}

	/**
	 *  pc智投投资充值
	 */
	@RequestMapping("/invest/recharge")
	public String investRecharge(P2p500405ReqData data, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		FuiouService.p2p500405(data, response);
		return null;
	}

	/**
	 * pc投资网银充值 (Online bank service)
	 */
	@RequestMapping("/invest/obs/recharge")
	public String investOBSRecharge(Wy500012ReqData data, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		FuiouService.wy500012(data, response);
		return null;
	}

	/**
	 * 执行一个基于充值回调的投资
	 */
	private void investOnCallback(Order order) {
		boolean isPaymentSuccess = false;
		AppUser user = null;
		SmartInvestmentOrder sio = new SmartInvestmentOrder();
		DBTransaction transaction = new DBTransaction();

		try {
			List<SmartInvestmentOrder> sioList;
			user = smartProjectInvestmentService.findById(order.getUserId(), AppUser.class);
			sio.setOrderId(order.getId());
			sioList = smartProjectInvestmentService.queryForListByEntity(sio, null);
			if (sioList.size() > 1) {
				throw new Exception("订单出现重复情况！");
			}
			if (sioList.isEmpty()) {
				throw new Exception("未找到ID为" + order.getId() + "的订单！");
			}

			sio = sioList.get(0);
			if (sio.getStatus() != 0) {
				throw new Exception("订单[" + order.getId() + "]重复支付！");
			}
			if (!order.getMoney().equals(sio.getActualAmount())) {
				throw new Exception("支付金额与订单金额不一致！");
			}

			CommonRspData rsp = payment(user, sio.getActualAmount(), order.getProjectId());
			if (!PAYMENT_SUCCESS_CODE.equals(rsp.getResp_code())) {
				throw new PaymentFailException(rsp.getResp_desc(), rsp.getResp_code());
			}

			isPaymentSuccess = true;
			sio.setStatus(1);

			transaction.begin();
			smartProjectInvestmentService.update(sio, true);
			double amountOfDebtDisperse = sio.getInvestmentAmount()
							* SmartProjectInvestmentServiceImpl.DEBT_INVESTMENT_DISPERSE_RATIO,
				   amountOfSmartInvest = sio.getInvestmentAmount()
							* SmartProjectInvestmentServiceImpl.SMART_INVESTMENT_DISPERSE_RATIO,
				   debtInvestdAmount = 0;
			List<SmartInvestmentDebtAssignmentItem> debts = smartProjectInvestmentService.selectSuitableDebts(
					user, amountOfDebtDisperse);
			if (!debts.isEmpty()) {
				amountOfDebtDisperse = doInvestDebt(debts, amountOfDebtDisperse);
			}

			amountOfSmartInvest += amountOfDebtDisperse;
			doInvest(user, sio.getSiProjectId(), sio.getId(), amountOfSmartInvest, sio.getDeadLine());

			sio.setInvestmentAmount(sio.getInvestmentAmount() - debtInvestdAmount);
			sio.setInvestmentAmount(sio.getActualAmount() - debtInvestdAmount);
			smartProjectInvestmentService.update(sio, true);
			transaction.commit();
		}
		catch (Exception e) {
			transaction.rollback();
			logger.error(e instanceof PaymentFailException ?
					TAG_ERR_IVESTMENT_FAILURE : TAG_ERR_PAYMNET_FAILURE, e);
			if (isPaymentSuccess) {
				try {
					//退回已支付的资金
					CommonRspData rsp = returnMoney(user, sio.getActualAmount(), order.getProjectId());
					if (!PAYMENT_SUCCESS_CODE.equals(rsp.getResp_code())) {
						throw new PaymentFailException(rsp.getResp_desc(), rsp.getResp_code());
					}
				}
				catch (Exception e1) {
					logger.error(TAG_ERR_RETURN_MONEY_FAILURE, e1);
					e1.printStackTrace();
				}
			}
		}
		finally {
			transaction = null;
		}
	}

	/** 支付成功处理 */
	@Override
	public void hanldeSuccess(Order order, P2p500405RspData response) {
		Integer type = order.getType();
		switch(type) {
			case 1:	//充值成功
				investOnCallback(order);
				break;
		}
	}

	/** 支付失败处理 */
	@Override
	public void hanldeFailure(Order order, P2p500405RspData response) {
		Integer type = order.getType();
		switch(type) {
			case 1:
				SmartInvestmentOrder sio = new SmartInvestmentOrder();
				sio.setOrderId(order.getId());
				try {
					List<SmartInvestmentOrder> sioList =
							smartProjectInvestmentService.queryForListByEntity(sio, null);
					if (sioList.size() > 1) {
						logger.error(TAG_ERR_NORMAL, "订单出现重复情况[ID:" + order.getId() + "]！");
					}
					for (SmartInvestmentOrder _sio : sioList) {
						_sio.setStatus(0);
					}

					smartProjectInvestmentService.update(sioList);
				}
				catch (Exception e) {
					e.printStackTrace();
				}
				break;
		}
	}

	/**
	 * 获取债转相关的利息信息
	 */
	@RequestMapping("/debt/interest/get")
	@ResponseBody
	public ReturnDatas debtInterests(Integer siOrderId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();

		try {
			ensureLogin(user);
			SmartInvestmentOrder order = smartProjectInvestmentService.findById(
					siOrderId, SmartInvestmentOrder.class);
			if (order == null) {
				throw new Exception(String.format("找不到此智能投资单[%d]的利息信息！", siOrderId));
			}

			if (order.getUserId().equals(user.getId())) {
				rt.setData(smartProjectInvestmentService.getAssignBebtInterestInfo(order));
			}
		}
		catch (Exception e) {
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
			logger.error(TAG_ERR_NORMAL, e);
		}

		return rt;
	}

	/**
	 * 债权卖出
	 */
	@RequestMapping(value = "/debt/sell")
	@ResponseBody
	public ReturnDatas debtSell(Integer id, String itemJson, Double interest
			/*String tradePassword*/) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();

		try {
			ensureLogin(user);
//			ensureTradePasswordRight(user, tradePassword);

			itemJson = itemJson == null ? "[]" : itemJson;
			SmartInvestmentOrder order = smartProjectInvestmentService.findById(
					id, SmartInvestmentOrder.class);
			List<SmartInvestmentDebtAssignmentItem> itemList = new Gson().fromJson(
					itemJson, new TypeToken<List<SmartInvestmentDebtAssignmentItem>>(){}.getType());
			if (itemList.size() == 0) {
				throw new Exception("请至少选择一个债转项！");
			}

			Finder finder = new Finder("SELECT COUNT(o.id) num FROM t_smart_investment_debt_assignment da, ")
					.append(" t_smart_investment_order o ")
					.append(" WHERE o.userId = :userId AND YEAR(da.createTime) = YEAR(:curDate) ")
					.append(" AND MONTH(da.createTime) = MONTH(:curDate) AND da.siOrderId = o.id")
					.setParam("userId", user.getId())
					.setParam("curDate", SmartProjectInvestmentServiceImpl.curDateStr());
			Map<String, Object> count = smartProjectInvestmentService.queryForObject(finder);
			if (count != null) {
				Number debtAssignTimes = (Number) count.get("num");
				if (debtAssignTimes != null && debtAssignTimes.intValue() > 4) {
					throw new Exception("每月最大债转次数为3次！");
				}
			}

			Integer debtAssignmentId = smartProjectInvestmentService.createDebtAssignment(interest,
					id, itemList.toArray(new SmartInvestmentDebtAssignmentItem[itemList.size()]));
		}
		catch (Exception e) {
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
			logger.error(TAG_ERR_NORMAL, e);
		}

		return rt;
	}

	/**
	 * 债权卖出
	 */
	@RequestMapping(value = "/debt/sell/cj")
	@ResponseBody
	public ReturnDatas debtSell1(Integer id, String itemJson, Double interest) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();

		try {
			SmartInvestmentDispersedProject sdp = smartProjectInvestmentService.findById(id, SmartInvestmentDispersedProject.class);
			itemJson = itemJson == null ? "[]" : itemJson;
			SmartInvestmentOrder order = smartProjectInvestmentService.findById(
					sdp.getSiOrderId(), SmartInvestmentOrder.class);
			List<SmartInvestmentDebtAssignmentItem> itemList = new Gson().fromJson(
					itemJson, new TypeToken<List<SmartInvestmentDebtAssignmentItem>>(){}.getType());

			Finder finder = new Finder("SELECT COUNT(o.id) num FROM t_smart_investment_debt_assignment da, ")
					.append(" t_smart_investment_order o ")
					.append(" WHERE o.userId = :userId AND YEAR(da.createTime) = YEAR(:curDate) ")
					.append(" AND MONTH(da.createTime) = MONTH(:curDate) AND da.siOrderId = o.id")
					.setParam("userId", user.getId())
					.setParam("curDate", SmartProjectInvestmentServiceImpl.curDateStr());
			Map<String, Object> count = smartProjectInvestmentService.queryForObject(finder);
			if (count != null) {
				Number debtAssignTimes = (Number) count.get("num");
				if (debtAssignTimes != null && debtAssignTimes.intValue() > 3) {
					throw new Exception("每月最大债转次数为3次！");
				}
			}

			Integer debtAssignmentId = smartProjectInvestmentService.createDebtAssignment(interest,
					sdp.getSiOrderId(), itemList.toArray(new SmartInvestmentDebtAssignmentItem[itemList.size()]));
		}
		catch (Exception e) {
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
			logger.error(TAG_ERR_NORMAL, e);
		}

		return rt;
	}

	/** 取消债转单 */
	@RequestMapping("/debt/sell/cancel")
	@ResponseBody
	public ReturnDatas debtCancelSell(Integer debtAssignmentId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();

		try {
			ensureLogin(user);
			SmartInvestmentDebtAssignment debtAssignment = smartProjectInvestmentService.queryForObject(
					new Finder("SELECT * FROM t_smart_investment_debt_assignment WHERE id = :id FOR UPDATE")
							.setParam("id", debtAssignmentId),
					SmartInvestmentDebtAssignment.class);
			if (debtAssignment == null) {
				throw new Exception("未找到此债转记录！");
			}
			if (debtAssignment.getStatus() == 3) {
				throw new Exception("此债转已取消！");
			}
			/*if (debtAssignment.getExpiresTime().before(new Date())) {
				throw new Exception("此债转单已经失效！");
			}*/

			SmartInvestmentOrder order = smartProjectInvestmentService.queryForObject(
					new Finder("SELECT * FROM t_smart_investment_order WHERE id = :id FOR UPDATE")
							.setParam("id", debtAssignment.getSiOrderId()),
					SmartInvestmentOrder.class);
			/*if (!order.getUserId().equals(user.getId())) {
				throw new Exception("您无权操作此债转单！");
			}*/

			Finder finder = new Finder("UPDATE t_smart_investment_dispersed_project dp, ")
					.append("t_smart_investment_debt_assignment_item i SET dp.assignStatus = 0 ")
					.append("WHERE dp.id = i.dispersedProjectId AND i.debtAssignmentId = :daId")
					.setParam("daId", debtAssignment.getId());
			smartProjectInvestmentService.update(finder);

			debtAssignment.setStatus(3);
			debtAssignment.setCancelTime(new Date());
			smartProjectInvestmentService.update(debtAssignment, true);
			double amount = debtAssignment.getAssignedAmount() == null ? 0d : debtAssignment.getAssignedAmount();
			order.setAssigningAmount(order.getAssigningAmount() -
					(debtAssignment.getAmount() - debtAssignment.getInterest() - amount));
			smartProjectInvestmentService.update(order, true);
		}
		catch (Exception e) {
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
			logger.error(TAG_ERR_NORMAL, e);
		}

		return rt;
	}

	/** 散标转让（承接） */
	@RequestMapping("/debt/project/receive")
	@ResponseBody
	public ReturnDatas debtProjectBuy(Integer itemId, Double amount, String tradePassword, Boolean insideCall) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();
		AppUser seller = null;
		boolean isPaymentSuccess = false;
		double paymentAmount = 0D;
		final int minimalReceiveAmount = 100;

		try {
			ensureLogin(user);
			if (insideCall == null || !insideCall) {
				ensureTradePasswordRight(user, tradePassword);
			}

			SmartInvestmentDebtAssignmentItem debtAssignmentItem = smartProjectInvestmentService.findById(
					itemId, SmartInvestmentDebtAssignmentItem.class);
			SmartInvestmentDebtAssignment debtAssignment = smartProjectInvestmentService.findById(
					debtAssignmentItem.getDebtAssignmentId(), SmartInvestmentDebtAssignment.class);
			SmartInvestmentOrder order = smartProjectInvestmentService.findById(
					debtAssignment.getSiOrderId(), SmartInvestmentOrder.class);
			SmartInvestmentDispersedProject history = smartProjectInvestmentService.findById(
					debtAssignmentItem.getDispersedProjectId(), SmartInvestmentDispersedProject.class);

			seller = smartProjectInvestmentService.findById(order.getUserId(), AppUser.class);
			user = smartProjectInvestmentService.findById(user.getId(), AppUser.class);
			if (debtAssignment == null || history == null || order == null) {
				throw new Exception("找不到此债转信息！");
			}
			if (amount == null) {
				throw new Exception("请输入合法的债转金额！");
			}
			if (amount > history.getInvestmentAmount()) {
				throw new Exception("您输入的承接金额不能大于债转金额！");
			}
			if (amount < minimalReceiveAmount) {
				throw new Exception("承接金额最小为100！");
			}
			if (amount != amount.intValue()) {
				throw new Exception("承接金额必须为整数！");
			}
			/*if (amount % minimalReceiveAmount != 0) {
				throw new Exception("承接金额必须为100的整数倍！");
			}*/
			if (history.getInvestmentAmount() <= 0) {
				throw new Exception("此债转项可债转金额不足！");
			}
			if (user.getId().equals(seller.getId())) {
				throw new Exception("您不能承接自己的债权！");
			}
			if (history.getAssignStatus() == 3 || history.getStatus() == 3) {
				throw new Exception("此项目目前无法承接！");
			}
			if (history.getInvestmentAmount() - amount < 500 && history.getInvestmentAmount() - amount != 0) {
				throw new Exception("当债权剩余金额低于500时必须全部承接！");
			}

			double rate = /*order.getStatus() == 2 ? history.getEarningRate() : history.getProjectEarningRate()*/
					history.getEarningRate();
			double interest = SmartProjectInvestmentServiceImpl.calculateEarningsByDays(amount,
					debtAssignmentItem.getIsCharge() ? rate : 0,
					SmartProjectInvestmentServiceImpl.dateTruncatedDiffDays(new Date(),
							history.getLastInterestDay() == null ? history.getStartDate()
									: history.getLastInterestDay()));

			paymentAmount = amount + interest;
			if (user.getBalance() < paymentAmount) {
				throw new Exception("您的可用余额不足！");
			}

			CommonRspData rsp = transferMoney(user, user.getPhone(), seller.getPhone(), paymentAmount);
			if (!PAYMENT_SUCCESS_CODE.equals(rsp.getResp_code())) {
				throw new PaymentFailException(rsp.getResp_desc(), rsp.getResp_code());
			}

			isPaymentSuccess = true;
			smartProjectInvestmentService.assignDebtProject(itemId, seller.getId(),
					user.getId(), amount, interest, debtAssignment, debtAssignmentItem, order, user, seller);

			debtAssignmentItem.setAmount(debtAssignment.getAmount() - amount);
			smartProjectInvestmentService.update(debtAssignmentItem, true);

			user.setBalance(user.getBalance() - paymentAmount);
			seller.setBalance(seller.getBalance() + paymentAmount);
			smartProjectInvestmentService.update(user, true);
			smartProjectInvestmentService.update(seller, true);

			rt.setData(paymentAmount);

			try {
				jPushService.notify(16, itemId, Arrays.asList(seller.getId()), "您的授权转让的债权已被承接！");
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		catch (Exception e) {
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
			logger.error(e instanceof PaymentFailException ?
					TAG_ERR_DEBT_ASSIGNMENT_FAILURE : TAG_ERR_PAYMNET_FAILURE, e);
			if (isPaymentSuccess) {
				try {
					//退回已支付的资金
					CommonRspData rsp = transferMoney(user, seller.getPhone(), user.getPhone(), paymentAmount);
					if (!PAYMENT_SUCCESS_CODE.equals(rsp.getResp_code())) {
						throw new PaymentFailException(rsp.getResp_desc(), rsp.getResp_code());
					}
				}
				catch (Exception e1) {
					logger.error(TAG_ERR_RETURN_MONEY_FAILURE, e1);
					e1.printStackTrace();
				}
			}
		}

		return rt;
	}

	/** 债权单买入（承接） */
	@RequestMapping("/debt/order/receive")
	@ResponseBody
	public ReturnDatas debtBuy(Integer debtAssignmentId, Double amount, String tradePassword) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();
		AppUser seller = null;
		boolean isPaymentSuccess = false;
		double paymentAmount = 0D;

		try {
			ensureLogin(user);
			ensureTradePasswordRight(user, tradePassword);
			SmartInvestmentDebtAssignment debtAssignment = smartProjectInvestmentService.findById(
					debtAssignmentId, SmartInvestmentDebtAssignment.class);
			if (debtAssignment == null) {
				throw new Exception("债权转让失败！");
			}
			if (debtAssignment.getStatus() != 2) {
				throw new Exception("债转单状态有误！");
			}

			SmartInvestmentOrder order = smartProjectInvestmentService.findById(
					debtAssignment.getSiOrderId(), SmartInvestmentOrder.class);
			if (order == null) {
				throw new Exception("未找到与此次转让相关的订单！");
			}
			if (amount > debtAssignment.getAmount()) {
				throw new Exception("您输入的承接金额不能大于债转金额！");
			}

			seller = smartProjectInvestmentService.findById(order.getUserId(), AppUser.class);
			paymentAmount = amount == null ? debtAssignment.getAmount() : amount;
			CommonRspData rsp = transferMoney(user, user.getPhone(), seller.getPhone(), paymentAmount);
			if (!PAYMENT_SUCCESS_CODE.equals(rsp.getResp_code())) {
				throw new PaymentFailException(rsp.getResp_desc(), rsp.getResp_code());
			}

			isPaymentSuccess = true;
			smartProjectInvestmentService.assignDebt(
					debtAssignment.getSiOrderId(), seller.getId(), user.getId(), amount);

			user.setBalance(user.getBalance() - paymentAmount);
			seller.setBalance(seller.getBalance() + paymentAmount);
			smartProjectInvestmentService.update(Arrays.asList(user, seller), true);

			try {
				jPushService.notify(16, debtAssignmentId, Arrays.asList(seller.getId()), "您的授权转让的债权已被买入！");
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		catch (Exception e) {
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
			logger.error(e instanceof PaymentFailException ?
					TAG_ERR_DEBT_ASSIGNMENT_FAILURE : TAG_ERR_PAYMNET_FAILURE, e);
			if (isPaymentSuccess) {
				try {
					//退回已支付的资金
					CommonRspData rsp = transferMoney(user, seller.getPhone(), user.getPhone(), paymentAmount);
					if (!PAYMENT_SUCCESS_CODE.equals(rsp.getResp_code())) {
						throw new PaymentFailException(rsp.getResp_desc(), rsp.getResp_code());
					}
				}
				catch (Exception e1) {
					logger.error(TAG_ERR_RETURN_MONEY_FAILURE, e1);
					e1.printStackTrace();
				}
			}
		}

		return rt;
	}

	/** 债权承接记录 */
	@RequestMapping("/debt/receive/history")
	@ResponseBody
	public ReturnDatas debtHistory(Integer projectId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();
		AppUser seller = null;
		boolean isPaymentSuccess = false;
		double paymentAmount = 0D;

		try {
//			ensureLogin(user);
			Page page = newPage(request);
			page.setPageSize(10);
			Finder finder = new Finder("SELECT dr.*, au.realName receiver FROM t_smart_investment_debt_receive dr, t_app_user au, ")
					.append("t_smart_investment_dispersed_project dp WHERE dr.sourceDispersedProjectId = dp.id ")
					.append("AND dp.id = :dpId AND au.id = dr.userId")
					.setParam("dpId", projectId);
			rt.setData(smartProjectInvestmentService.queryForList(finder, page));
			rt.setPage(page);
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		return rt;
	}

	/** 设置智投在锁定期后自动复投 */
	@RequestMapping("/debt/resmartinvset/confirm")
	@ResponseBody
	public ReturnDatas debtResmartinvestConfirm(Integer orderId, Integer deadline, Double additionalEarningRate) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = getSessionUser();
		AppUser seller = null;
		boolean isPaymentSuccess = false;
		double paymentAmount = 0D;

		try {
			ensureLogin(user);
			if (additionalEarningRate == null || additionalEarningRate <= 0) {
				throw new Exception("错误的续购加息值！");
			}
			if (deadline == null || (deadline != 3 && deadline != 6 && deadline != 9 && deadline != 12)) {
				throw new Exception("复投期限无效！");
			}

			SmartInvestmentOrder order = smartProjectInvestmentService.findById(
					orderId, SmartInvestmentOrder.class);
			if (!user.getId().equals(order.getUserId())) {
				throw new Exception("您不能对非本人的智投订单做此操作！");
			}
			/*if (SmartProjectInvestmentServiceImpl.dateTruncatedDiffDays(
					order.getExpiresDate(), new Date()) > 7) {
				throw new Exception("只能在智投项目锁定期剩余7日内可进行此操作！");
			}*/

			order.setReinvestAdditionalEarningRate(additionalEarningRate);
			order.setReinvest(true);
			order.setReinvestDeadline(deadline);
			smartProjectInvestmentService.update(order, true);
		}
		catch (Exception e) {
			rt.setMessage(e.getMessage());
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}

		return rt;
	}

	/**
	 * 项目满标分散(测试)
	 */
	@RequestMapping("/raise")
	public void projecRaisetOnComplete() {
		List<SmartInvestmentProject> projects = null;

		try {
			projects = smartProjectInvestmentService.queryForList(new Finder(
					"SELECT id FROM t_smart_investment_project WHERE status = 3" +
					" AND remainsAmount = 0"
				), SmartInvestmentProject.class);

			for (SmartInvestmentProject project : projects) {
				project = smartProjectInvestmentService.findById(
						project.getId(), SmartInvestmentProject.class);
				if (project.getStatus() != 4) {
					double dispersedAmount = smartProjectInvestmentService.
							smartInvestDisperse(project);
					if (dispersedAmount == project.getTotalAmount()) {
						project.setStatus(4);
					}

					project.setDispersedAmount((double) dispersedAmount);
					smartProjectInvestmentService.update(project, true);
				}
			}

			smartProjectInvestmentService.generateDummyDispersedRecord();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}


	/** 设置系统时间 */
	public static void setOSDatetime(Date datetime) {
		String osName = System.getProperty("os.name");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
		String cmd = "";
		String date = dateFormat.format(datetime);
		String time = timeFormat.format(datetime);

		try {
			if (osName.matches("^(?i)Windows.*$")) {// Window 系统
				// 格式 HH:mm:ss
				cmd = "cmd /c time " + time;
				Runtime.getRuntime().exec(cmd);
				// 格式：yyyy-MM-dd
				cmd = "cmd /c date " + date;
				Runtime.getRuntime().exec(cmd);
			} else {// Linux 系统
				// 格式：yyyyMMdd
				cmd = "date -s " + date.replace("-", "");
				Runtime.getRuntime().exec(cmd);
				// 格式 HH:mm:ss
				cmd = "date -s " + time;
				Runtime.getRuntime().exec(cmd);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 更新投资信息(测试)
	 */
	@RequestMapping("/update")
	public void update() {
		try {

			Integer times = 0,
					days = 0;
			try {
				times = Integer.parseInt(request.getParameter("times") == null ?
						"1" : request.getParameter("times"));
				days = Integer.parseInt(request.getParameter("days") == null ?
						"1" : request.getParameter("days"));

				setOSDatetime(DateUtils.addDay(days, new Date()));
				Thread.sleep(500);
			}
			catch(Exception e) {
				e.printStackTrace();
			}

			for (int i = 0; i < times ; i++) {
				System.out.println(SmartProjectInvestmentServiceImpl.curDateStr());
				List<SmartInvestmentOrder> orders = smartProjectInvestmentService.queryForList(
						new Finder("SELECT * FROM t_smart_investment_order WHERE status > 0"),
						SmartInvestmentOrder.class
				);
				for (SmartInvestmentOrder order : orders) {
					smartProjectInvestmentService.updateSmartInvestment(order.getId());
				}
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 测试
	 */
	@RequestMapping("/test")
	public void test() {
		DBTransaction transaction = new DBTransaction();
		try {
			transaction.begin();
			smartProjectInvestmentService.test();
			Project p = new Project();
			p.setName("sssss");
			smartProjectInvestmentService.save(p, true);
			if ( 1 == 1 ) throw new Exception("");
			transaction.commit();
		}
		catch(Exception e) {
			transaction.rollback();
			e.printStackTrace();
		}
	}




	public static class PaymentFailException extends Exception {
		String code,
			   desc;
		public PaymentFailException(String msg, String code) {
			super(msg);
			this.code = code;
		}

		public PaymentFailException(String msg, String desc, String code) {
			super(msg);
			this.desc = desc;
			this.code = code;
		}

		public String getCode() {
			return code;
		}

		public String getDesc() {
			return desc;
		}
	}
}
