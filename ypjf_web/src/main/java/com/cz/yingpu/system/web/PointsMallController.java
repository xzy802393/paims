package com.cz.yingpu.system.web;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.system.entity.Goods;
import com.cz.yingpu.system.entity.UserIntegralOrder;
import com.cz.yingpu.system.operator.OperatorController;
import com.cz.yingpu.system.service.IActivityService;
import com.cz.yingpu.system.service.IBaseSpringrainService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-07-17 16:55:01
 */
@Controller
@RequestMapping(value="/system/pointsMall")
public class PointsMallController  extends BaseController {
	@Resource
	private IActivityService activityService;
	@Resource
	private OperatorController operatorController;

	@Resource
	IBaseSpringrainService baseSpringrainService;



	/**
	 * 商品列表
	 */
	@RequestMapping("/list")
	public
	String worldCup2018UserBonus(HttpServletRequest request, Integer pageSize) {
		Finder finder = new Finder("SELECT * FROM t_goods tg,t_goodsType tt WHERE tg.goodsType=tt.tid");
		Page page = newPage(request);
		if (pageSize != null) {
			page.setPageSize(pageSize);
		}

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		String name = request.getParameter("name");
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");

		if (StringUtils.isNotBlank(name)) {
			finder.append(" AND tg.goodsName LIKE :name")
					.setParam("name", "%" + name + "%");
		}
		if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
			finder.append(" AND tg.addTime BETWEEN :start AND :end")
					.setParam("start", dateStart + " 00:00:00")
					.setParam("end", dateEnd + " 23:59:59");
		}
		finder.append(" ORDER BY tg.addTime DESC ");
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("dateStart", dateStart);
		map.put("dateEnd", dateEnd);
		try {
			list = activityService.queryForList(finder, page);
			rt.setData(list);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}
		rt.setPage(page);
		rt.setQueryBean(map);
		request.setAttribute(GlobalStatic.returnDatas, rt);
		return "/pointsMall/goodsList";
	}



	/**
	 * 查看的Json格式数据,为APP端提供数据
	 */
	@RequestMapping(value = "/look/json")
	public @ResponseBody
	ReturnDatas lookjson(Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		String  strId=request.getParameter("id");
		Integer id=null;
		if(StringUtils.isNotBlank(strId)){
			id= Integer.valueOf(strId.trim());
			Goods goods = activityService.findById(id,Goods.class);
			returnObject.setData(goods);
		}else{
			returnObject.setStatus(ReturnDatas.ERROR);
		}
		return returnObject;

	}


	/**
	 * 新增/修改 操作吗,返回json格式数据
	 *
	 */
	@RequestMapping("/update")
	@ResponseBody
	public ReturnDatas saveorupdate(Model model,Goods goods,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		goods.setAddtime(new Date());
		goods.setStatus(1);
		try {
			Integer id = Integer.parseInt(baseSpringrainService.saveorupdate(goods).toString());
		} catch (Exception e) {
			e.printStackTrace();
			String errorMessage = e.getLocalizedMessage();
			logger.error(errorMessage);
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;

	}

	/**
	 * 进入修改页面,APP端可以调用 lookjson 获取json格式数据
	 */
	@RequestMapping(value = "/update/pre")
	public String updatepre(Model model,HttpServletRequest request,HttpServletResponse response)  throws Exception{
		ReturnDatas returnObject = lookjson(model, request, response);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/pointsMall/goodsCru";
	}

	/**
	 * 删除操作
	 */
	@RequestMapping(value="/delete")
	public @ResponseBody ReturnDatas delete(HttpServletRequest request) throws Exception {

		// 执行删除
		try {
			String  strId=request.getParameter("id");
			Integer id=null;
			if(StringUtils.isNotBlank(strId)){
				id= Integer.valueOf(strId.trim());
				activityService.deleteById(id,Goods.class);
				return new ReturnDatas(ReturnDatas.SUCCESS,
						MessageUtils.DELETE_SUCCESS);
			} else {
				return new ReturnDatas(ReturnDatas.WARNING,
						MessageUtils.DELETE_WARNING);
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return new ReturnDatas(ReturnDatas.WARNING, MessageUtils.DELETE_WARNING);
	}

	/**
	 * 营普客栈用户银子兑换记录
	 */
	@RequestMapping("/user/orders")
	public
	String userOrders(HttpServletRequest request, Integer pageSize) {
		Finder finder = new Finder("SELECT sa.*, uio.*, uio.id as orderId, au.phone, au.realName, g.goodsName,")
				.append(" CONCAT(sa.province, sa.city, sa.region, sa.detailAddress) receiveAddress")
				.append(" FROM t_user_integral_order uio, t_app_user au, t_goods g, t_shopping_address sa")
				.append(" WHERE au.id = uio.userId AND g.id = uio.goodsId AND sa.id = uio.addressId");
		//finder.setEscapeSql(false);
		//Page page = newPage(request);
        Page page = newPage(request);
        page.setSort("DESC");
        page.setOrder("uio.createTime");
		if (pageSize != null) {
			page.setPageSize(pageSize);
		}

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");
		String status = request.getParameter("status");

		if (StringUtils.isNotBlank(phone)) {
			finder.append(" AND au.phone = :phone")
					.setParam("phone", phone);
		}
		if (StringUtils.isNotBlank(name)) {
			finder.append(" AND au.realName LIKE :name")
					.setParam("name", "%" + name + "%");
		}
		if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
			finder.append(" AND uio.createTime BETWEEN :start AND :end")
					.setParam("start", dateStart + " 00:00:00")
					.setParam("end", dateEnd + " 23:59:59");
		}
		if (StringUtils.isNotBlank(status)) {
			finder.append(" AND uio.status = :status")
					.setParam("status", status);
		}

		//finder.append(" ORDER BY uio.createTime DESC");
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);
		map.put("dateStart", dateStart);
		map.put("dateEnd", dateEnd);
		map.put("status", status);
		try {
			list = activityService.queryForList(finder, page);
			rt.setData(list);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}
		rt.setPage(page);
		rt.setQueryBean(map);
		request.setAttribute(GlobalStatic.returnDatas, rt);
		return "/pointsMall/user_orders";
	}


	/**
	 * 营普客栈用户银子兑换记录
	 */
	@RequestMapping("/user/orders/export")
	public
	void userOrdersExport(HttpServletRequest request, Integer pageSize, HttpServletResponse resp) {
		String url = userOrders(request, 99999);
		ReturnDatas rt = (ReturnDatas) request.getAttribute(GlobalStatic.returnDatas);
		Page page = newPage(request);
		page.setPageSize(99999);

		try {
			downFile(resp, activityService.findDataExportExcel(
					(List<?>) rt.getData(), url, page, null), "导出.xls", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 营普客栈用户银子兑换记录
	 */
	@RequestMapping("order/deliver")
	@ResponseBody
	public ReturnDatas  updateStaus(Integer id) {
		System.out.println(id+"=id");
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		UserIntegralOrder user=new UserIntegralOrder();
		user.setId(id);
		user.setStatus(5);
		try {
			baseSpringrainService.update(user,true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  rt;
	}

}





