package  com.cz.yingpu.system.web;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.Project;
import com.cz.yingpu.system.service.IAppUserService;
import com.cz.yingpu.system.service.impl.AppUserServiceImpl;
import org.apache.bcel.generic.LSTORE;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.MessageUtils;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.UserAccountHistory;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.service.IUserAccountHistoryService;
import com.cz.yingpu.system.service.IUserProjectService;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:49
 * @see com.cz.yingpu.system.web
 */
@Controller
@RequestMapping(value="/system/useraccounthistory")
public class UserAccountHistoryController  extends BaseController {
	@Resource
	private IUserAccountHistoryService userAccountHistoryService;
	
	private String listurl="/system/useraccounthistory/useraccounthistoryList";
	
	
	@Resource
	private IUserProjectService userProjectService;

	@Resource
	private IAppUserService appUserService;
	
	
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param userAccountHistory
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,UserAccountHistory userAccountHistory) 
			throws Exception {
		ReturnDatas returnObject = listjson(request, model, userAccountHistory);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param userAccountHistory
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,UserAccountHistory userAccountHistory) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		Finder finder = new Finder("select * from ").append(Finder.getTableName(UserAccountHistory.class)).append(" where money != 0 ") ;
		List<UserAccountHistory> datas=userAccountHistoryService.findListDataByFinder(finder,page,UserAccountHistory.class,userAccountHistory);
		returnObject.setQueryBean(userAccountHistory);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,UserAccountHistory userAccountHistory) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = userAccountHistoryService.findDataExportExcel(null,listurl, page,UserAccountHistory.class,userAccountHistory);
		String fileName="userAccountHistory"+GlobalStatic.excelext;
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
		return "/system/useraccounthistory/useraccounthistoryLook";
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
		  UserAccountHistory userAccountHistory = userAccountHistoryService.findUserAccountHistoryById(id);
		   returnObject.setData(userAccountHistory);
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
	ReturnDatas saveorupdate(Model model,UserAccountHistory userAccountHistory,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
		
		
			userAccountHistoryService.saveorupdate(userAccountHistory);
			
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
		return "/system/useraccounthistory/useraccounthistoryCru";
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
				userAccountHistoryService.deleteById(id,UserAccountHistory.class);
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
			userAccountHistoryService.deleteByIds(ids,UserAccountHistory.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);


	}

	@RequestMapping("/fenxiaolist/json")
	public  @ResponseBody
	ReturnDatas fenxiaoUser(HttpServletRequest request,UserAccountHistory userAccountHistory) {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List datas= null;
		try {
			if(userAccountHistory.getUserId() == null){
				returnObject.setMessage("参数缺失");
				returnObject.setStatus(ReturnDatas.ERROR) ;
			}else {
				datas = userAccountHistoryService.fenxiaoList(page,userAccountHistory);
			}
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setMessage("系统内部原因");
			returnObject.setStatus(ReturnDatas.ERROR) ;
		}
		returnObject.setQueryBean(userAccountHistory);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}

	@RequestMapping("/fenxiaodetaillist/json")
	public  @ResponseBody
	ReturnDatas fenxiaoDetailUser(HttpServletRequest request,UserAccountHistory userAccountHistory) {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List datas= null;
		try {
			if(userAccountHistory.getUserId() == null || userAccountHistory.getFenxiaoUserId() == null){
				returnObject.setMessage("参数缺失");
				returnObject.setStatus(ReturnDatas.ERROR) ;
			}else {
				datas = userAccountHistoryService.fenxiaoDetailList(page,userAccountHistory) ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setMessage("系统内部原因");
			returnObject.setStatus(ReturnDatas.ERROR) ;
		}
		returnObject.setQueryBean(userAccountHistory);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}

	@RequestMapping("/investIncome/json")
	public  @ResponseBody
	ReturnDatas investIncome(HttpServletRequest request,UserAccountHistory userAccountHistory) {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List datas= null;
		try {
			datas = userAccountHistoryService.investIncome(page,userAccountHistory) ;
		
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setMessage("系统内部原因");
			returnObject.setStatus(ReturnDatas.ERROR) ;
		}
		returnObject.setQueryBean(userAccountHistory);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}


	/**
	 * json数据,为APP提供数据
	 *
	 * @param request
	 * @param model
	 * @param appUser
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/repaymentDetailList")
	public String repaymentDetailList(HttpServletRequest request, Model model, UserAccountHistory userAccountHistory, AppUser appUser, Project project) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List<java.util.Map<String, Object>> userAccountHistories = userAccountHistoryService.repaymentDetailList(page,userAccountHistory,appUser,project);
		returnObject.setQueryBean(userAccountHistory);
		returnObject.setPage(page);
		returnObject.setData(userAccountHistories);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/repayment/repaymentDetailList";
	}
	
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param
	 * @param userProject
	 * @return
	 * @throws Exception
	 */
	public
	ReturnDatas listjson(HttpServletRequest request,UserProject userProject) throws Exception{
 		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		java.util.Map<String, String> map = new HashMap<>();
		map.put("type_invest", request.getParameter("type_invest"));
		
		Finder finder = null;
		Integer id = userProject.getProjectId();
		if(null != pageSize && !"".equals(pageSize)){
			page.setPageSize(Integer.parseInt(pageSize));
		}
		
		if(StringUtils.isNotBlank(request.getParameter("type_invest"))){
			userProject.setPath(request.getParameter("type_invest"));
		}
		
		userProject.setOsType(null);
		List<UserProject> datas=userProjectService.findListDataByFinder(finder,page,UserProject.class,userProject);
		UserProject up = userProjectService.getTotalMoney(userProject);
		if(page.getPageIndex()<page.getPageCount()){
			page.setHasNext(true);
		}
		userProject.setMoney(up.getMoney());
		userProject.setProjectId(id);
		returnObject.setQueryBean(userProject);
		returnObject.setPage(page);
		returnObject.setData(datas);
		returnObject.setMap(map);
		return returnObject;
	}
	
	
	/**
	 * 获取项目的投资记录
	 */
	@RequestMapping("/invest-history/json")
	public String investHistory(HttpServletRequest request, Integer id) {
		UserProject up = new UserProject();
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		
		try {
			if (id == null) {
				throw new RuntimeException("");
			}
			up.setProjectId(id);
			rt = listjson(request, up);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}
		
		request.setAttribute(GlobalStatic.returnDatas, rt);
		
		return "/repayment/investHisotry";
	}

	/**
	 * 获取充值的记录
	 * @return
	 */
	@RequestMapping("/rechargHisotry/json")
	public String rechargHisotry(HttpServletRequest request,Integer id){
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		Page page = newPage(request);
		String pageSize = request.getParameter("pageSize");
		Map<String,Object> appUser = new HashMap<>();
		if(null != pageSize && !"".equals(pageSize)){
			page.setPageSize(Integer.parseInt(pageSize));
		}
		try {
			if(id==null){
				throw  new RuntimeException("");
			}
			appUser = appUserService.queryForObject(new Finder("SELECT id,realName,SUM(IFNULL(balance,0)+IFNULL(nowInvestAmount,0)) sumMoney,balance,nowInvestAmount FROM t_app_user WHERE id=:id").setParam("id",id));
			List<Map<String,Object>> maps =  userAccountHistoryService.queryForList(new Finder("SELECT createtime,TYPE,STATUS,money,remarkers,tradeNo FROM t_user_account_history WHERE TYPE=:type AND userid=:uid").setParam("uid",id).setParam("type",1),page);
			Map<String,Object> topUps = userAccountHistoryService.queryForObject(new Finder("SELECT SUM(IFNULL(money,0)) money FROM t_user_account_history WHERE userid=:uid AND TYPE=:type AND STATUS=:status").setParam("uid",id).setParam("type",1).setParam("status",2));
			appUser.put("topUp",topUps.get("money"));

			rt.setData(maps);

		}catch (Exception e){
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}
		rt.setPage(page);
		rt.setMap(appUser);
		request.setAttribute(GlobalStatic.returnDatas,rt);
		return "/order/rechargeHisotry";
	}

}
