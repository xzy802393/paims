package  com.cz.yingpu.system.web;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.system.entity.Order;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.service.IOrderService;
import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.MessageUtils;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:47
 * @see com.cz.yingpu.system.web.Order
 */
@Controller
@RequestMapping(value="/system/order")
public class OrderController  extends BaseController {
	@Resource
	private IOrderService orderService;
	
	private String listurl="/order/orderList";
	
	/**
	 * 提现列表数据
	 * 
	 * @param request
	 * @param model
	 * @param order
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("withdraw/export/json")
	public void withdrawListexport(HttpServletRequest request, Model model,Order order,HttpServletResponse response)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);

		Map<String,Object> values = new HashMap<String,Object>() ;
		String types = "2,4" ;
		values.put("types",types) ;
		if(order.getStartTime() != null && order.getEndTime() != null){
			values.put("startTime", DateFormatUtils.format(order.getStartTime(),"yyyy-MM-dd HH:mm:ss")) ;
			values.put("endTime",DateFormatUtils.format(order.getEndTime(),"yyyy-MM-dd HH:mm:ss")) ;
		}
		if(order.getUserId() != null){
			values.put("userId",order.getUserId()) ;
		}
		if(StringUtils.isNotBlank(order.getTradeNo())){
			values.put("tradeNo",order.getTradeNo()) ;
		}
		if(StringUtils.isNotBlank(order.getUserName())){
			values.put("userName",order.getUserName()) ;
		}
		if(StringUtils.isNotBlank(order.getUserPhone())){
			values.put("userPhone",order.getUserPhone()) ;
		}
		if(null!=order.getStatus() && 0!=order.getStatus()){
			values.put("status",order.getStatus()) ;
		}
		List list = null ;
		try {
			list = orderService.listOrder(null,values) ;
			File file=	orderService.findDataExportExcel(list,"/order/withdrawList", page,Order.class);
			
			String fileName="order"+GlobalStatic.excelext;
			downFile(response, file, fileName,true);
			
		}catch (Exception e){
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
//			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
	}
	
	   
	/**
	 * 提现列表数据
	 * 
	 * @param request
	 * @param model
	 * @param order
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("withdraw/list")
	public String withdrawList(HttpServletRequest request, Model model,Order order,HttpServletResponse response)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);

		Map<String,Object> values = new HashMap<String,Object>() ;
		String types = "2,4" ;
		values.put("types",types) ;
		if(order.getStartTime() != null && order.getEndTime() != null){
			values.put("startTime", DateFormatUtils.format(order.getStartTime(),"yyyy-MM-dd HH:mm:ss")) ;
			values.put("endTime",DateFormatUtils.format(order.getEndTime(),"yyyy-MM-dd HH:mm:ss")) ;
		}
		if(order.getUserId() != null){
			values.put("userId",order.getUserId()) ;
		}
		if(StringUtils.isNotBlank(order.getTradeNo())){
			values.put("tradeNo",order.getTradeNo()) ;
		}
		if(StringUtils.isNotBlank(order.getUserName())){
			values.put("userName",order.getUserName()) ;
		}
		if(StringUtils.isNotBlank(order.getUserPhone())){
			values.put("userPhone",order.getUserPhone()) ;
		}
		if(null!=order.getStatus() && 0!=order.getStatus()){
			values.put("status",order.getStatus()) ;
		}
		List list = null ;
		try {
			list = orderService.listOrder(page,values) ;
			Order o = orderService.getTotalMoney(values);
			order.setMoney(o.getMoney());
			order.setTotalFee(o.getTotalFee());
		}catch (Exception e){
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
//			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setQueryBean(order);
		returnObject.setPage(page);
		returnObject.setData(list);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/order/withdrawList";
	}
	
	/**
	 * 充值列表数据
	 *
	 * @param request
	 * @param model
	 * @param order
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/recharge/export/json")
	public void recargeexport(HttpServletRequest request, HttpServletResponse response,Model model,Order order)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);

		Map<String,Object> values = new HashMap<String,Object>() ;
		String types = "1,3" ;
		values.put("types",types) ;
		if(order.getStartTime() != null && order.getEndTime() != null){
			values.put("startTime", DateFormatUtils.format(order.getStartTime(),"yyyy-MM-dd HH:mm:ss")) ;
			values.put("endTime",DateFormatUtils.format(order.getEndTime(),"yyyy-MM-dd HH:mm:ss")) ;
		}
		if(order.getUserId() != null){
			values.put("userId",order.getUserId()) ;
		}
		if(StringUtils.isNotBlank(order.getUserName())){
			values.put("userName",order.getUserName()) ;
		}
		if(StringUtils.isNotBlank(order.getUserPhone())){
			values.put("userPhone",order.getUserPhone()) ;
		}
		if(StringUtils.isNotBlank(order.getTradeNo())){
			values.put("tradeNo",order.getTradeNo()) ;
		}
		if(null!=order.getStatus() && 0!=order.getStatus()){
			values.put("status",order.getStatus()) ;
		}
		List list = null ;
		try {
			list = orderService.listOrder(null,values) ;
			File file=	orderService.findDataExportExcel(list,"/order/rechargeList", page,Order.class);
			
			String fileName="order"+GlobalStatic.excelext;
			downFile(response, file, fileName,true);
			Order o = orderService.getTotalMoney(values);
			order.setMoney(o.getMoney());
			order.setTotalFee(o.getTotalFee());
		}catch (Exception e){
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
	}
	
	/**
	 * 充值列表数据
	 *
	 * @param request
	 * @param model
	 * @param order
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/recharge/list")
	public String recargeList(HttpServletRequest request, Model model,Order order)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);

		Map<String,Object> values = new HashMap<String,Object>() ;
		String types = "1,3" ;
		values.put("types",types) ;
		if(order.getStartTime() != null && order.getEndTime() != null){
			values.put("startTime", DateFormatUtils.format(order.getStartTime(),"yyyy-MM-dd HH:mm:ss")) ;
			values.put("endTime",DateFormatUtils.format(order.getEndTime(),"yyyy-MM-dd HH:mm:ss")) ;
		}
		if(order.getUserId() != null){
			values.put("userId",order.getUserId()) ;
		}
		if(StringUtils.isNotBlank(order.getUserName())){
			values.put("userName",order.getUserName()) ;
		}
		if(StringUtils.isNotBlank(order.getUserPhone())){
			values.put("userPhone",order.getUserPhone()) ;
		}
		if(StringUtils.isNotBlank(order.getTradeNo())){
			values.put("tradeNo",order.getTradeNo()) ;
		}
		if(null!=order.getStatus() && 0!=order.getStatus()){
			values.put("status",order.getStatus()) ;
		}
		List list = null ;
		try {
			list = orderService.listOrder(page,values) ;
			Order o = orderService.getTotalMoney(values);
			order.setMoney(o.getMoney());
			order.setTotalFee(o.getTotalFee());
		}catch (Exception e){
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setQueryBean(order);
		returnObject.setPage(page);
		returnObject.setData(list);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "order/rechargeList";
	}

	/**
	 * 提现列表数据
	 *
	 * @param request
	 * @param model
	 * @param order
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("fenxiaoList/list")
	public String fenxiaoList(HttpServletRequest request, Model model,Order order)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);

		Map<String,Object> values = new HashMap<String,Object>() ;
		String types = "14" ;
		values.put("types",types) ;
		if(order.getStartTime() != null && order.getEndTime() != null){
			values.put("startTime", DateFormatUtils.format(order.getStartTime(),"yyyy-MM-dd HH:mm:ss")) ;
			values.put("endTime",DateFormatUtils.format(order.getEndTime(),"yyyy-MM-dd HH:mm:ss")) ;
		}
		if(order.getUserId() != null){
			values.put("userId",order.getUserId()) ;
		}
		if(StringUtils.isNotBlank(order.getTradeNo())){
			values.put("tradeNo",order.getTradeNo()) ;
		}
		if(StringUtils.isNotBlank(order.getUserName())){
			values.put("userName",order.getUserName()) ;
		}
		if(StringUtils.isNotBlank(order.getUserPhone())){
			values.put("userPhone",order.getUserPhone()) ;
		}
		if(null!=order.getStatus() && 0!=order.getStatus()){
			values.put("status",order.getStatus()) ;
		}
		List list = null ;
		try {
			list = orderService.listOrder(page,values) ;
			Order o = orderService.getTotalMoney(values);
			order.setMoney(o.getMoney());
			order.setTotalFee(o.getTotalFee());
		}catch (Exception e){
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
//			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setQueryBean(order);
		returnObject.setPage(page);
		returnObject.setData(list);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/order/fenxiaoList";
	}

	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param order
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,Order order) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List<Order> datas=orderService.findListDataByFinder(null,page,Order.class,order);
			returnObject.setQueryBean(order);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,Order order) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = orderService.findDataExportExcel(null,listurl, page,Order.class,order);
		String fileName="order"+GlobalStatic.excelext;
		downFile(response, file, fileName,true);
		return;
	}
	
		/**
	 * 查看操作,调用APP端lookjson方法
	 */
	@RequestMapping(value = "/look")
	public String look(Model model,HttpServletRequest request,HttpServletResponse response)  throws Exception {
		ReturnDatas returnObject = lookjson(model, request, response);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/system/order/orderLook";
	}

	
	/**
	 * 查看的Json格式数据,为APP端提供数据
	 */
	@RequestMapping(value = "/look/json")
	public @ResponseBody
	ReturnDatas lookjson(Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		  String  strId=request.getParameter("id");
		  java.lang.Integer id=null;
		  if(StringUtils.isNotBlank(strId)){
			 id= java.lang.Integer.valueOf(strId.trim());
		  Order order = orderService.findOrderById(id);
		   returnObject.setData(order);
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
	public @ResponseBody
	ReturnDatas saveorupdate(Model model,Order order,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
		
		
			orderService.saveorupdate(order);
			
		} catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
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
		return "/system/order/orderCru";
	}
	
	/**
	 * 删除操作
	 */
	@RequestMapping(value="/delete")
	public @ResponseBody ReturnDatas delete(HttpServletRequest request) throws Exception {

			// 执行删除
		try {
		  String  strId=request.getParameter("id");
		  java.lang.Integer id=null;
		  if(StringUtils.isNotBlank(strId)){
			 id= java.lang.Integer.valueOf(strId.trim());
				orderService.deleteById(id,Order.class);
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
	 * 删除多条记录
	 * 
	 */
	@RequestMapping("/delete/more")
	public @ResponseBody
	ReturnDatas deleteMore(HttpServletRequest request, Model model) {
		String records = request.getParameter("records");
		if(StringUtils.isBlank(records)){
			 return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		String[] rs = records.split(",");
		if (rs == null || rs.length < 1) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_NULL_FAIL);
		}
		try {
			List<String> ids = Arrays.asList(rs);
			orderService.deleteByIds(ids,Order.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}

}
