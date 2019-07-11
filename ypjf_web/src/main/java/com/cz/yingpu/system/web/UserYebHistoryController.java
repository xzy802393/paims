package  com.cz.yingpu.system.web;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.system.entity.UserYebHistory;
import com.cz.yingpu.system.entity.UserYebList;
import com.cz.yingpu.system.exception.MoneyNotEnoughException;
import com.cz.yingpu.system.exception.NotCertificationException;
import com.cz.yingpu.system.exception.ParameterErrorException;
import com.cz.yingpu.system.service.IUserYebHistoryService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.List;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:50
 * @see com.cz.yingpu.system.web.UserYebHistory
 */
@Controller
@RequestMapping(value="/system/useryebhistory")
public class UserYebHistoryController  extends BaseController {
	@Resource
	private IUserYebHistoryService userYebHistoryService;
	
	private String listurl="/useryebhistory/useryebhistoryList";
	
	
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param userYebHistory
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,UserYebHistory userYebHistory) 
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		if(null != pageSize && !"".equals(pageSize)){
			page.setPageSize(Integer.parseInt(pageSize));
		}
		List list = null ;
		try {
			userYebHistory.setType(3);
			list = userYebHistoryService.listAdminJson(page,userYebHistory) ;
			returnObject.setData(list);
		}catch (Exception e){
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setPage(page);
		returnObject.setQueryBean(userYebHistory);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param userYebHistory
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,UserYebHistory userYebHistory) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		if(null != pageSize && !"".equals(pageSize)){
			page.setPageSize(Integer.parseInt(pageSize));
		}
		userYebHistory.setOsType(null);
		// ==执行分页查询
		Finder fin = new Finder("select * from ").append(Finder.getTableName(UserYebHistory.class)).append(" where type != 8 and money > 0 ");
		UserYebList result = new UserYebList() ;
		List<UserYebHistory> datas=userYebHistoryService.findListDataByFinder(fin,page,UserYebHistory.class,userYebHistory);
		result.setHistList(datas);
		if(userYebHistory.getUserId() != null){
			Finder finder = new Finder("select * from ").append(Finder.getTableName(UserYebHistory.class)).append(" where userId=:userId and type=:type ") ;
			finder.append(" and  1=1") ;
			finder.setParam("userId",userYebHistory.getUserId()) ;
			finder.setParam("type",3) ;
			Page p = newPage(request);
			List<UserYebHistory> historys = userYebHistoryService.findListDataByFinder(finder, p, UserYebHistory.class, new UserYebHistory());
			UserYebHistory history = historys.size() != 0 ? historys.get(0) : null;
			if(history != null){
				result.setEarnings(history.getMoney());
			}else {
				result.setEarnings(0.0);
			}
		}
			returnObject.setQueryBean(userYebHistory);
		returnObject.setPage(page);
		returnObject.setData(result);
//		returnObject.setData(datas);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,UserYebHistory userYebHistory) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = userYebHistoryService.findDataExportExcel(null,listurl, page,UserYebHistory.class,userYebHistory);
		String fileName="userYebHistory"+GlobalStatic.excelext;
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
		return "/system/useryebhistory/useryebhistoryLook";
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
		  UserYebHistory userYebHistory = userYebHistoryService.findUserYebHistoryById(id);
		   returnObject.setData(userYebHistory);
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
	ReturnDatas saveorupdate(Model model,UserYebHistory userYebHistory,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
		
		
			userYebHistoryService.saveorupdate(userYebHistory);
			
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
		return "/system/useryebhistory/useryebhistoryCru";
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
				userYebHistoryService.deleteById(id,UserYebHistory.class);
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
			userYebHistoryService.deleteByIds(ids,UserYebHistory.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}

	/**
	 * 余额宝转入
	 *
	 * @param request
	 * @param model
	 * @param userYebHistory
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yebTurnIn/json")
	public @ResponseBody
	ReturnDatas yebTurnIn(HttpServletRequest request, Model model,UserYebHistory userYebHistory) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {


			userYebHistoryService.yebTurnIn(userYebHistory.getUserId(),userYebHistory.getMoney(),userYebHistory.getOsType());

		} catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;
	}

	/**
	 * 余额宝转出申请
	 *
	 * @param request
	 * @param model
	 * @param userYebHistory
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yebTurnOut/json")
	public @ResponseBody
	ReturnDatas yebTurnOut(HttpServletRequest request, Model model,UserYebHistory userYebHistory) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage("申请成功");
		try {


//			userYebHistoryService.yebTurnOut(userYebHistory.getUserId(),userYebHistory.getMoney(),userYebHistory.getOsType());
			userYebHistoryService.applyTurnOut(userYebHistory.getUserId(),userYebHistory.getMoney(),userYebHistory.getOsType());
		} catch (NotCertificationException e){
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("还未开通富有账户");
		}catch (ParameterErrorException e){
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("申请转出金额必须大于100");
		} catch (MoneyNotEnoughException e){
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("天天存吧余额不足");
		}catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;
	}

	@RequestMapping(value = "/applyturnout/list")
	public String  applyList(HttpServletRequest request, Model model,UserYebHistory userYebHistory) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		if(null != pageSize && !"".equals(pageSize)){
			page.setPageSize(Integer.parseInt(pageSize));
		}
		List list = null ;
		try {
			userYebHistory.setType(4);
			list = userYebHistoryService.listAdminJson(page,userYebHistory) ;
			returnObject.setData(list);
		}catch (Exception e){
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setPage(page);
		returnObject.setQueryBean(userYebHistory);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/useryebhistory/applyList";
	}

	@RequestMapping(value = "/turnout/list")
	public String  turnoutList(HttpServletRequest request, Model model,UserYebHistory userYebHistory) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		if(null != pageSize && !"".equals(pageSize)){
			page.setPageSize(Integer.parseInt(pageSize));
		}
		List list = null ;
		try {
			userYebHistory.setType(2);
			list = userYebHistoryService.listAdminJson(page,userYebHistory) ;
			returnObject.setData(list);
		}catch (Exception e){
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setPage(page);
		returnObject.setQueryBean(userYebHistory);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/useryebhistory/turnoutList";
	}


	@RequestMapping("/turnOut")
	public @ResponseBody
	ReturnDatas turnOut(HttpServletRequest request, Model model) {
		// 执行删除
		try {
			String  strId=request.getParameter("id");
			java.lang.Integer id=null;
			if(StringUtils.isNotBlank(strId)){
				id= java.lang.Integer.valueOf(strId.trim());
				userYebHistoryService.yebTurnOut(id);
				return new ReturnDatas(ReturnDatas.SUCCESS,
						MessageUtils.DELETE_SUCCESS);
			} else {
				return new ReturnDatas(ReturnDatas.WARNING,
						MessageUtils.DELETE_WARNING);
			}
		} catch (NotCertificationException e) {
			logger.error(e.getMessage(), e);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return new ReturnDatas(ReturnDatas.WARNING, MessageUtils.DELETE_WARNING);


	}

	@RequestMapping(value = "/report/list")
	public String  reportList(HttpServletRequest request, Model model,UserYebHistory userYebHistory) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		if(null != pageSize && !"".equals(pageSize)){
			page.setPageSize(Integer.parseInt(pageSize));
		}
		List list = null ;
		try {
			list = userYebHistoryService.reportList(page,userYebHistory) ;
			UserYebHistory uyh = userYebHistoryService.getTotalMoney(userYebHistory);
			userYebHistory.setMoney(uyh.getMoney());
			returnObject.setData(list);
		}catch (Exception e){
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setPage(page);
		returnObject.setQueryBean(userYebHistory);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/useryebhistory/reportList";
	}

	
	@RequestMapping(value = "report/export/json")
	public void  exportList(HttpServletRequest request, Model model,UserYebHistory userYebHistory, HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		page.setPageSize(((((((10000)))))));
		List list = null ;
		try {
			list = userYebHistoryService.reportList(page,userYebHistory);
			downFile(response, userYebHistoryService.findDataExportExcel(list, "/useryebhistory/reportList", page, null), "导出.xls", true);
		}catch (Exception e){
			e.printStackTrace();
		}
	}


	@RequestMapping("/signMoney/json")
	public void signMoney(HttpServletRequest request, Model model,String date) throws Exception {

		Date d = DateUtils.convertString2Date("yyyy-MM-dd HH:mm:ss",date);
		userYebHistoryService.signMoney(d);
	}
}
