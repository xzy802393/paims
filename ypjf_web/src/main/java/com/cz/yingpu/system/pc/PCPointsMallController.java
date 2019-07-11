package com.cz.yingpu.system.pc;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.*;
import com.cz.yingpu.system.service.IBaseSpringrainService;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/pc/pointsmall")
public class PCPointsMallController extends BaseController {
	@Resource
	private IBaseSpringrainService baseSpringrainService;

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletRequest response;


	/** 获取订单号 */
	private synchronized String getOrderNumber() {
		return "YP" + new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
	}


	/** 下单。生成商品购买订单。 */
	@RequestMapping("/goods/order/create")
	@ResponseBody
	public ReturnDatas createOrder(Integer goodsId, Integer goodsNumber, Integer addressId, String deliverMethod) {
		ReturnDatas data = ReturnDatas.getSuccessReturnDatas();
		AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			if (au == null) {
				throw new Error("请登录后再进行下单操作！");
			}
			if (goodsId == null || goodsNumber == null) {
				throw new Error("商品ID或商品数量不能为空！");
			}
			if (goodsNumber <= 0) {
				throw new Error("商品数量无效！");
			}

			Goods goods = new Goods();
			goods.setId(goodsId);
			goods = baseSpringrainService.queryForObject(goods);
			if (goods == null) {
				throw new Error(String.format("ID为%d的商品不存在！", goodsId));
			}

			double goodsIntegral = goods.getPoints(),
				   totalIntegral = new BigDecimal(goods.getPoints()).multiply(
					new BigDecimal(goodsNumber)).doubleValue();
			String orderNumber = getOrderNumber();

			UserIntegralOrder order = new UserIntegralOrder();
			order.setUserId(au.getId());
			order.setStatus(1);
			order.setGoodsId(goodsId);
			order.setTotalIntegral(totalIntegral);
			order.setCreateTime(new Date());
			order.setOrderNumber(orderNumber);
			order.setAddressId(addressId);
			order.setGoodsNumber(goodsNumber);
			order.setDeliverMethod(deliverMethod);
			baseSpringrainService.save(order);

			data.setData(orderNumber);
		}
		catch (Throwable e) {
			data.setStatus("error");
			e.printStackTrace();
			if (e instanceof Error) {
				data.setMessage(e.getMessage());
			}
		}

		return data;
	}

	/** 订单支付 */
	@RequestMapping("/goods/order/payment")
	@ResponseBody
	public ReturnDatas orderPayment(String orderNumber) {
		ReturnDatas data = ReturnDatas.getSuccessReturnDatas();
		AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			if (au == null) {
				throw new Error("请登录后再进行下单操作！");
			}

			UserIntegralOrder order = new UserIntegralOrder();
			order.setOrderNumber(orderNumber);
			order = baseSpringrainService.queryForObject(order);
			if (order == null) {
				throw new Error("订单不存在！");
			}
			if (order.getStatus() == 2) {
				throw new Error("订单已经支付，请勿重复支付！");
			}
			if (order.getStatus() == 3) {
				throw new Error("订单已经取消，请勿重复支付！");
			}

			AppUser appUser = baseSpringrainService.queryForObject(new Finder(
					"SELECT * FROM t_app_user WHERE id = " + au.getId()
			), AppUser.class);
			if (appUser.getIntegral() < order.getTotalIntegral()) {
				throw new Error("您的剩余积分不足！");
			}

			appUser.setIntegral(appUser.getIntegral() - order.getTotalIntegral());
			baseSpringrainService.updateValidValue(appUser);

			UserIntegralHistory uis = new UserIntegralHistory();
			uis.setOperationType(4);
			uis.setUserId(au.getId());
			uis.setIntegral(-order.getTotalIntegral());
			uis.setTotalIntegral(appUser.getIntegral());
			uis.setOperationTime(new Date());
			baseSpringrainService.save(uis);

			order.setStatus(2);
			order.setPaymentTime(new Date());
			baseSpringrainService.updateValidValue(order);
			data.setMessage("订单支付成功！");

            request.getSession().setAttribute(GlobalStatic.PCUSER, appUser);
		}
		catch (Throwable e) {
			data.setStatus("error");
			e.printStackTrace();
			if (e instanceof Error) {
				data.setMessage(e.getMessage());
			}
		}

		return data;
	}

	/** 取消订单 */
	@RequestMapping("/goods/order/cancel")
	@ResponseBody
	public ReturnDatas orderCancel(Integer orderId) {
		ReturnDatas data = ReturnDatas.getSuccessReturnDatas();
		AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			if (au == null) {
				throw new Error("请登录后再进行取消订单操作！");
			}

			UserIntegralOrder order = new UserIntegralOrder();
			order.setId(orderId);
			order = baseSpringrainService.queryForObject(order);
			if (order == null) {
				throw new Error("订单不存在！");
			}
			if (order.getStatus() == 3) {
				throw new Error("订单已经取消，请勿重复取消！");
			}
			if (order.getStatus() == 1) {
				throw new Error("订单尚未支付！");
			}

			AppUser appUser = baseSpringrainService.queryForObject(new Finder(
					"SELECT * FROM t_app_user WHERE userId = " + au.getId()
			), AppUser.class);

			appUser.setIntegral(appUser.getIntegral() + order.getTotalIntegral());
			baseSpringrainService.updateValidValue(appUser);

			UserIntegralHistory uis = new UserIntegralHistory();
			uis.setOperationType(5);
			uis.setUserId(au.getId());
			uis.setIntegral(order.getTotalIntegral());
			uis.setTotalIntegral(appUser.getIntegral());
			uis.setOperationTime(new Date());
			baseSpringrainService.save(uis);

			order.setStatus(3);
			order.setCancelTime(new Date());
			baseSpringrainService.updateValidValue(order);
			data.setMessage("订单取消成功！");
		}
		catch (Throwable e) {
			data.setStatus("error");
			e.printStackTrace();
			if (e instanceof Error) {
				data.setMessage(e.getMessage());
			}
		}

		return data;
	}

	/** 积分商城商品详情 */
	@RequestMapping("/goodsDetails")
	public String goodsDetails(Integer goodsId) {
		AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		Map<String, Object> data = new HashMap<>();

		try {
			if (goodsId == null) {
				throw new Error("商品ID为空！");
			}

			Goods goods = new Goods();
			goods.setId(goodsId);
			if ((goods = baseSpringrainService.queryForObject(goods)) == null) {
				throw new Error(String.format("ID为%d的商品不存在！", goodsId));
			}

			Map result = baseSpringrainService.queryForObject(new Finder(
					"SELECT COUNT(DISTINCT userId) abc FROM t_user_integral_order WHERE goodsId = :goodsId")
					.setParam("goodsId", goodsId));
			request.setAttribute("goods", goods);
			request.setAttribute("buyerNumber", result == null ? 0 : result.get("abc"));

		}
		catch (Throwable e) {
			e.printStackTrace();
		}

		return "pc/pointsmall/product_details";
	}

	/**
	 * 首页商品列表
	 */
	@RequestMapping("/list/json")
	@ResponseBody
	public  ReturnDatas getList(String userId) {
		Finder finder = new Finder("  SELECT * FROM t_goods tg,t_goodsType tt WHERE tg.goodsType=tt.tid ORDER BY tg.goodsCount DESC ");
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		List<Map<String, Object>> count = new ArrayList<>();
		List<Map<String, Object>> points = new ArrayList<>();
		List<Map<String, Object>> draw = new ArrayList<>();
		List<Map<String, Object>> order = new ArrayList<>();
		Map map=new HashMap();
		try {
			if (StringUtils.isNotBlank(userId)) {
				Finder point = new Finder(" SELECT th.*,tp.name FROM t_user_integral_history th LEFT JOIN t_project tp ON th.projectId=tp.id WHERE th.userId=:userId ORDER BY th.operationTime desc ")
						.setParam("userId",userId);
				Finder draw1 = new Finder(" SELECT tuo.id td,createTime,tuo.status ts,goodsName,goodsNumber,totalIntegral FROM t_user_integral_order tuo,t_goods tg WHERE tuo.goodsId=tg.`id` AND userId=:userId AND tuo.status !=1 ORDER BY createTime DESC ")
						.setParam("userId",userId);
				points=	baseSpringrainService.queryForList(point);
				draw=	baseSpringrainService.queryForList(draw1);
				if(points != null){
					map.put("points",points);
				}
				if(draw != null){
					map.put("draw",draw);
				}
			}
			//展示所有订单
			Finder  order1=new Finder("   SELECT phone,tuo.status,goodsName,goodsNumber FROM t_user_integral_order tuo,t_goods tg,t_app_user tu WHERE tuo.goodsId=tg.`id` AND tuo.userId=tu.id AND tuo.status !=1 ORDER BY createTime DESC ");
			order=baseSpringrainService.queryForList(order1);
			if(order != null){
				for(int i=0;i<order.size();i++){
					String str=(String)order.get(i).get("phone");
					String phoneNumber = str.substring(0, 3) + "****" + str.substring(7, str.length());
					order.get(i).put("phone",phoneNumber);
				}
				map.put("order",order);
			}
			list = baseSpringrainService.queryForList(finder);
			map.put("list",list);
			count=baseSpringrainService.queryForList(new Finder("SELECT (SELECT COUNT(DISTINCT tu.userId) FROM t_user_integral_order tu WHERE tu.goodsId=tg.id ) count1,tg.*  FROM t_goods tg ORDER BY tg.goodsCount DESC ,tg.goodsType "));
			map.put("count",count);
			rt.setData(map);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}
		return rt;
	}

	/**
	 * 订单提交页
	 */
	@RequestMapping("/orderSubmit")
	public String orderSubmit(Integer goodsId, Integer goodsNum) {
		AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		Map<String, Object> data = new HashMap<>();

		try {
			if (au == null) {
				throw new Error("请先登录！");
			}
			if (goodsId == null || goodsNum == null) {
				throw new Error("商品ID或商品数量不能为空！");
			}
			if (goodsNum <= 0) {
				throw new Error("商品数量无效！");
			}

			Goods goods = new Goods();
			goods.setId(goodsId);
			if ((goods = baseSpringrainService.queryForObject(goods)) == null) {
				throw new Error(String.format("ID为%d的商品不存在！", goodsId));
			}

			ShoppingAddress receiveAddress = new ShoppingAddress();
			receiveAddress.setUserId(au.getId());
			request.setAttribute("addresses", baseSpringrainService.queryForListByEntity(receiveAddress, null));
			request.setAttribute("goods", goods);
		}
		catch (Throwable e) {
			e.printStackTrace();
		}

		return "pc/pointsmall/points_submit";
	}

	/**
	 * 添加收货地址
	 */
	@RequestMapping("/shopping/address/add")
	@ResponseBody
	public  ReturnDatas addShoppingAddress(ShoppingAddress address) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			if (au == null) {
				throw new Error("请先登录！");
			}
			if (address.getProvince() == null) {
				throw new Error("省不能为空！");
			}
			if (address.getCity() == null) {
				throw new Error("市不能为空！");
			}
			if (address.getRegion() == null) {
				throw new Error("区/县不能为空！");
			}
			if (address.getDetailAddress() == null) {
				throw new Error("详细地址不能为空！");
			}
			if (address.getReceiverName() == null) {
				throw new Error("收货人姓名不能为空！");
			}
			if (address.getReceiverPhone() == null) {
				throw new Error("收货人手机号不能为空！");
			}
			if (address.getZipCode() == null) {
				throw new Error("邮政编码不能为空！");
			}

			ShoppingAddress conditionAddress = new ShoppingAddress();
			conditionAddress.setUserId(au.getId());
			Page page = newPage(request);
			baseSpringrainService.queryForListByEntity(conditionAddress, page);

			address.setUserId(au.getId());
			address.setCreateTime(new Date());
			address.setIsDefault(page.getTotalCount() != 0 ? 0 : 1);
			baseSpringrainService.save(address);
		}
		catch (Throwable e) {
			rt.setStatus("error");
			e.printStackTrace();
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
		}
		return rt;
	}
	/**
	 * 添加收货地址
	 */
	@RequestMapping("/shopping/address/modify")
	@ResponseBody
	public  ReturnDatas updateShoppingAddress(ShoppingAddress address) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			if (au == null) {
				throw new Error("请先登录！");
			}
			if (address.getProvince() == null) {
				throw new Error("省不能为空！");
			}
			if (address.getCity() == null) {
				throw new Error("市不能为空！");
			}
			if (address.getRegion() == null) {
				throw new Error("区/县不能为空！");
			}
			if (address.getDetailAddress() == null) {
				throw new Error("详细地址不能为空！");
			}
			if (address.getReceiverName() == null) {
				throw new Error("收货人姓名不能为空！");
			}
			if (address.getReceiverPhone() == null) {
				throw new Error("收货人手机号不能为空！");
			}
			if (address.getZipCode() == null) {
				throw new Error("邮政编码不能为空！");
			}
			if (address.getId() == null || address.getUserId() == null) {
				throw new Error("修改地址出错！");
			}

			baseSpringrainService.updateValidValue(address);
		}
		catch (Throwable e) {
			rt.setStatus("error");
			e.printStackTrace();
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
		}
		return rt;
	}

	/**
	 * 添加收货地址
	 */
	@RequestMapping("/shopping/address/delete")
	@ResponseBody
	public  ReturnDatas deleteShoppingAddress(ShoppingAddress address) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			if (au == null) {
				throw new Error("请先登录！");
			}
			if (address.getId() == null) {
				throw new Error("删除地址出错！");
			}

			baseSpringrainService.deleteByEntity(address);
		}
		catch (Throwable e) {
			rt.setStatus("error");
			e.printStackTrace();
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
		}
		return rt;
	}

	/**
	 * 添加收货地址
	 */
	@RequestMapping("/shopping/address")
	@ResponseBody
	public  ReturnDatas queryShoppingAddress(ShoppingAddress address) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			if (au == null) {
				throw new Error("请先登录！");
			}

			rt.setData(baseSpringrainService.queryForObject(address));
		}
		catch (Throwable e) {
			rt.setStatus("error");
			e.printStackTrace();
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
		}
		return rt;
	}

	/**
	 * 用户签到得积分
	 */
	@RequestMapping("/user/sign-in")
	@ResponseBody
	public  ReturnDatas userSignIn(Integer userId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		try {
			AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
			if (au == null) {
				throw new Error("请先登录！");
			}

			List<UserMallSignInHistory> todaySignIn = baseSpringrainService.queryForList(
					new Finder("SELECT * FROM t_user_mall_sign_in_history WHERE userId = :userId")
							.setParam("userId", au.getId())
							.append(" AND DATE(signInTime) = DATE(:date)")
							.setParam("date", new Date()), UserMallSignInHistory.class);
			if (!todaySignIn.isEmpty()) {
				throw new Error("您今日已签到！");
			}

			Finder finder = new Finder("SELECT value FROM t_sys_sysparam WHERE code = :code")
					.setParam("code", "userSignInIntegral");
			Map<String, Object> result = baseSpringrainService.queryForObject(finder);
			double userSignInIntegral = Double.parseDouble(result.get("value").toString()),
					userIntegral = au.getIntegral() == null ? 0 : au.getIntegral();
			au.setIntegral(userIntegral+userSignInIntegral);
            //double yinzi=userIntegral+userSignInIntegral;
			//au.setIntegral(yinzi);
			baseSpringrainService.updateValidValue(au);

			UserMallSignInHistory lastMallSignInHistory = baseSpringrainService.queryForObject(
					new Finder("SELECT * FROM t_user_mall_sign_in_history WHERE userId = :userId")
							.append(" ORDER BY signInTime DESC LIMIT 1")
							.setParam("userId", au.getId()), UserMallSignInHistory.class);

			UserIntegralHistory uis = new UserIntegralHistory();
			uis.setOperationType(5);
			uis.setUserId(au.getId());
			uis.setIntegral(userSignInIntegral);
			uis.setTotalIntegral(au.getIntegral());
			uis.setOperationTime(new Date());
			baseSpringrainService.save(uis);

			UserMallSignInHistory history = new UserMallSignInHistory();
			history.setUserId(au.getId());
			history.setSignInTime(new Date());
			history.setAcquireIntegral(userSignInIntegral);
			baseSpringrainService.save(history);

			UserMallSignStatistics statistics = new UserMallSignStatistics();
			UserMallSignStatistics dbStatistics = new UserMallSignStatistics();
			statistics.setUserId(au.getId());
			if ((dbStatistics = baseSpringrainService.queryForObject(statistics)) == null) {
				statistics.setContinuousSignInTimes(1);
				statistics.setMaxContinuousSignInTimes(1);
				baseSpringrainService.save(statistics);
			}
			else {
				int continuousSignInTimes = dbStatistics.getContinuousSignInTimes(),
					maxContinuousSignInTime = dbStatistics.getMaxContinuousSignInTimes();
				if (lastMallSignInHistory != null) {
					if (DateUtils.truncatedEquals(
							new Date(), DateUtils.addDays(lastMallSignInHistory.getSignInTime(), 1), Calendar.DATE)) {
						continuousSignInTimes++;
						if (maxContinuousSignInTime < continuousSignInTimes) {
							maxContinuousSignInTime = continuousSignInTimes;
						}

						dbStatistics.setContinuousSignInTimes(continuousSignInTimes);
						dbStatistics.setMaxContinuousSignInTimes(maxContinuousSignInTime);
						baseSpringrainService.updateValidValue(dbStatistics);
					}
				}
			}

		}
		catch (Throwable e) {
			rt.setStatus("error");
			e.printStackTrace();
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
		}
		return rt;
	}

	/**
	 * 用户签到记录
	 */
	@RequestMapping("/user/sign-in/history")
	@ResponseBody
	public  ReturnDatas userSignInHistory(Date date, String dateMonthStr) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		try {
			AppUser au = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
			if (au == null) {
				throw new Error("请先登录！");
			}
			Page page = newPage(request);
			page.setSort("DESC");
			page.setOrder("signInTime");
			Finder finder = new Finder("SELECT * FROM t_user_mall_sign_in_history WHERE userId = :userId")
					.setParam("userId", au.getId());
			if (date != null) {
				finder.append(" AND DATE(signInTime) = DATE(:date)")
						.setParam("date", date);
			}

			if (dateMonthStr != null) {
				finder.append(" AND DATE_FORMAT(signInTime, '%Y-%m') = :monthStr")
						.setParam("monthStr", dateMonthStr);
			}

			finder.setEscapeSql(false);
			rt.setData(baseSpringrainService.queryForList(finder, page));
			System.out.println(finder.getSql());
			System.out.println(finder.getParams());

			UserMallSignStatistics statistics = new UserMallSignStatistics();
			statistics.setUserId(au.getId());
			statistics = baseSpringrainService.queryForObject(statistics);
			rt.setQueryBean(statistics);
		}
		catch (Throwable e) {
			rt.setStatus("error");
			e.printStackTrace();
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
		}
		return rt;
	}

	/**
	 * 所有商品列表
	 */
	@RequestMapping("/list1/json")
	@ResponseBody
	public  ReturnDatas getList1(HttpServletRequest r,Integer type,String sort) {
		Finder finder=new Finder();
		Page page = newPage(r);
		if(type==0) {
			 finder= new Finder("SELECT tg.*,(SELECT COUNT(DISTINCT tu.userId)  FROM t_user_integral_order tu WHERE tu.goodsId=tg.id ) count1 FROM t_goods tg");

		}	else {
			finder= new Finder("SELECT tg.*,(SELECT COUNT(DISTINCT tu.userId)  FROM t_user_integral_order tu WHERE tu.goodsId=tg.id ) count1 FROM t_goods tg WHERE tg.goodsType=:goodsType").setParam("goodsType",type);
			page.setPageSize(10);
		}
		if(sort.equals("desc")){
			finder.append("  ORDER BY count1 DESC, tg.points");
		}
		page.setSort("desc");
		page.setOrder("tg.points");

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			list = baseSpringrainService.queryForList(finder,page);
			rt.setData(list);
			rt.setPage(page);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}
		return rt;
	}



	//根据时间查询兑换详情
	@RequestMapping("/byDate")
	@ResponseBody
	public  ReturnDatas byDate(String userId,String date,String biaozhi) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		Finder finder=new Finder();
		if(biaozhi.equals("order1")){
		 finder=new Finder("SELECT tuo.id td,createTime,tuo.status ts,goodsName,totalIntegral  FROM t_user_integral_order tuo,t_goods tg  WHERE tuo.goodsId=tg.`id` AND userId=:userId AND DATE_SUB(CURDATE(), INTERVAL "+date+" DAY) <= DATE(tuo.createTime) ORDER BY tuo.createTime DESC")
				.setParam("userId",userId);
		}
		else{
			finder=new Finder(" SELECT th.*,tp.name FROM t_user_integral_history th LEFT JOIN t_project tp ON th.projectId=tp.id WHERE th.userId=:userId  AND DATE_SUB(CURDATE(), INTERVAL "+date+" DAY) <= DATE(th.operationTime) ORDER BY  th.operationTime DESC")
					.setParam("userId",userId);
		}
		finder.setEscapeSql(false);
		try {
			list=baseSpringrainService.queryForList(finder);
			rt.setData(list);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}
		return rt;
	}

	//指定时间查询兑换详情
	@RequestMapping("/byDate1")
	@ResponseBody
	public  ReturnDatas byDate1(String userId,String startDate,String endDate) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		Finder finder=new Finder("SELECT tuo.id td,createTime,tuo.status ts,goodsName,totalIntegral  FROM t_user_integral_order tuo,t_goods tg  WHERE tuo.goodsId=tg.`id` AND userId=userId ");

		try {
			if(startDate.equals(endDate)){
				finder.append(" AND createTime >  '"+startDate+ " 00:00:00' AND  createTime < '"+startDate+" 23:59:59' ORDER BY createTime DESC")
						.setParam("userId",userId);
			}
				else{finder.append(" AND createTime >  '"+startDate+ " 00:00:00' AND  createTime < '"+endDate+" 23:59:59' ORDER BY createTime DESC")
						.setParam("userId",userId);}
				finder.setEscapeSql(false);
				list=baseSpringrainService.queryForList(finder);
				rt.setData(list);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}
		return rt;
	}

	//制定时间查询兑换详情
	@RequestMapping("/byDate2")
	@ResponseBody
	public  ReturnDatas byDate2(String userId,String startDate,String endDate) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		Finder finder=new Finder(" SELECT th.*,tp.name FROM t_user_integral_history th LEFT JOIN t_project tp ON th.projectId=tp.id WHERE th.userId=:userId ");

		try {
			if(startDate.equals(endDate)){
				finder.append(" AND th.operationTime >  '"+startDate+ " 00:00:00' AND  th.operationTime < '"+startDate+" 23:59:59' ORDER BY th.operationTime DESC")
						.setParam("userId",userId);
			}
			else{finder.append(" AND th.operationTime >  '"+startDate+ " 00:00:00' AND  th.operationTime < '"+endDate+" 23:59:59' ORDER BY th.operationTime DESC")
					.setParam("userId",userId);}
			finder.setEscapeSql(false);
			list=baseSpringrainService.queryForList(finder);
			rt.setData(list);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}
		return rt;
	}

}
