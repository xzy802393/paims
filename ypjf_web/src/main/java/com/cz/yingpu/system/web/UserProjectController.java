package  com.cz.yingpu.system.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cz.yingpu.system.entity.SmartInvestmentOrder;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.frame.common.SessionUser;
import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.CopyUtil;
import com.cz.yingpu.frame.util.ExportExcelUtil;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.MessageUtils;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.ExportUserProjectBean;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.exception.CardNotUseException;
import com.cz.yingpu.system.exception.MoneyException;
import com.cz.yingpu.system.exception.MoneyNotEnoughException;
import com.cz.yingpu.system.exception.NotCertificationException;
import com.cz.yingpu.system.exception.ParameterErrorException;
import com.cz.yingpu.system.exception.ProjectAmountNotEnoughException;
import com.cz.yingpu.system.exception.UserPorjectExistException;
import com.cz.yingpu.system.service.IUserProjectService;
import com.cz.yingpu.system.service.IUserRoleService;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:49
 * @see com.cz.yingpu.system.web
 */
@Controller
@RequestMapping(value="/system/userproject")
public class UserProjectController  extends BaseController {
	@Resource
	private IUserProjectService userProjectService;
	@Resource
	private IUserRoleService userRoleService;
	private String listurl="/userproject/userprojectList";
	
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param userProject
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/userlist")
	public String userlist(HttpServletRequest request, Model model,UserProject userProject) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		if(null != pageSize && !"".equals(pageSize)){
			page.setPageSize(Integer.parseInt(pageSize));
		}
		Map<String, String> map=new HashMap<>();
		
		
		
		
		map.put("ishezuo", SessionUser.getUserId());
	
		map.put("phone", request.getParameter("phone") );
		map.put("qixian", request.getParameter("qixian") );	
		map.put("yaoqingma", request.getParameter("yaoqingma") );
		map.put("isbangding", request.getParameter("isbangding") );
		map.put("istouzi", request.getParameter("istouzi") );
		map.put("registerstartTime", request.getParameter("registerstartTime") );
		map.put("registerendTime", request.getParameter("registerendTime") );
		map.put("touzistartTime", request.getParameter("touzistartTime") );
		map.put("touziendTime", request.getParameter("touziendTime") );
		map.put("isshoucitouzi", request.getParameter("isshoucitouzi") );
		map.put("type_invest", request.getParameter("type_invest"));
		
		/*Enumeration  e=  request.getAttributeNames();
		while (e.hasMoreElements()) {
			String string = (String) e.nextElement();
			map.put(string,  request.getParameter(string));
		}*/
		List datas=userProjectService.listAdminjson(page, map);
		returnObject.setQueryBean(userProject);
		returnObject.setPage(page);
		String s=userProjectService.totol(map);
		map.put("totol", s.split("-")[0]);
		map.put("nhtotol", s.split("-")[1]);
		Finder finder=new Finder("select count(1) as count from t_user_role  where userId = :userId and roleId =:roleId");
		finder.setParam("userId",  SessionUser.getUserId());
		finder.setParam("roleId",  "admin");
		Map<String, Object> ma= userRoleService.queryForObject(finder);
		map.put("isadmin", "否");
		if(Integer.parseInt(ma.get("count").toString())>0){
			map.put("isadmin", "是");
		}
		returnObject.setMap(map);
		returnObject.setData(datas);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		
		return "/user/userproject";
	}

	@RequestMapping("/uexport/json")
	public void userlistexport(HttpServletRequest request,HttpServletResponse response, Model model,UserProject userProject) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
Map<String, String> map=new HashMap<>();
		
		map.put("phone", request.getParameter("phone") );
		map.put("qixian", request.getParameter("qixian") );
		map.put("yaoqingma", request.getParameter("yaoqingma") );
		map.put("isbangding", request.getParameter("isbangding") );
		map.put("istouzi", request.getParameter("istouzi") );
		map.put("registerstartTime", request.getParameter("registerstartTime") );
		map.put("registerendTime", request.getParameter("registerendTime") );
		map.put("touzistartTime", request.getParameter("touzistartTime") );
		map.put("touziendTime", request.getParameter("touziendTime") );
		map.put("isshoucitouzi", request.getParameter("isshoucitouzi") );
		
		List datas=userProjectService.listAdminjson(null, map);	
		Map<String, String> amap=new HashMap<>();
		
		
		for (int i = 0; i < datas.size(); i++) {
			amap=	(Map<String, String>) datas.get(i);
			
			if(amap.get("phone").indexOf("15976054375")>-1){
				amap.put("phone",(amap.get("phone").replace("15976054375","A1")));
			}else if(amap.get("phone").indexOf("18056355661")>-1){
					amap.put("phone",(amap.get("phone").replace("18056355661","A2")));
			}else if(amap.get("phone").indexOf("13714437917")>-1){
					amap.put("phone",(amap.get("phone").replace("13714437917","A3")));
			}else if(amap.get("phone").indexOf("15018686946")>-1){
					amap.put("phone",(amap.get("phone").replace("15018686946","A4")));
			}else if(amap.get("phone").indexOf("15129480020")>-1){
					amap.put("phone",(amap.get("phone").replace("15129480020","A5")));
			}else if(amap.get("phone").indexOf("15001361401")>-1){
					amap.put("phone",(amap.get("phone").replace("15001361401","A6")));
			}
		}
		File file = userProjectService.findDataExportExcel(datas,"/user/userproject", page,UserProject.class);
		String fileName="userProject"+GlobalStatic.excelext;
		downFile(response, file, fileName,true);
		return;
	}

	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param userProject
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,UserProject userProject) 
			throws Exception {
		ReturnDatas returnObject = listjson(request, model, userProject);
		
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param userProject
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,UserProject userProject) throws Exception{
 		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		Map<String, String> map = new HashMap<>();
		map.put("type_invest", request.getParameter("type_invest"));
		
		Finder finder = null;
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
		returnObject.setQueryBean(userProject);
		returnObject.setPage(page);
		returnObject.setData(datas);
		returnObject.setMap(map);
		return returnObject;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/list/export/json")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,UserProject userProject) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
		List<UserProject> data = (List<UserProject>) listjson(request, model, userProject).getData();

		File file = userProjectService.findDataExportExcel(data,listurl, page,null);
		String fileName="userProject"+GlobalStatic.excelext;
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
		return "/userproject/userprojectLook";
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
		  UserProject userProject = userProjectService.findUserProjectById(id);
		   returnObject.setData(userProject);
		}else{
		returnObject.setStatus(ReturnDatas.ERROR);
		}
		return returnObject;
		
	}
	
	/**
	 * 查看的Json格式数据,为APP端提供数据
	 */
	@RequestMapping(value = "/look2/json")
	public @ResponseBody
	ReturnDatas look2json(Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		  String  strId=request.getParameter("id");
		  java.lang.Integer id=null;
		  if(StringUtils.isNotBlank(strId)){
			 id= java.lang.Integer.valueOf(strId.trim());
		  UserProject userProject = userProjectService.findUserProjectById(id);
		
		   returnObject.setData(userProject);
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
	ReturnDatas saveorupdate(Model model,UserProject userProject,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage("投资成功！");
		try {
		
			UserProject project = userProjectService.investProject(userProject);
			returnObject.setData(project);
			if(null!=project.getFalseCode()){
				returnObject.setStatus(ReturnDatas.ERROR);
				returnObject.setMessage(MessageUtils.UPDATE_ERROR);
			}
			
		}catch (NotCertificationException e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("你还未认证用户，请前去认证");
		}catch (UserPorjectExistException e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("你不能重复购买");
		}catch (CardNotUseException e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(errorMessage);
		} catch (ProjectAmountNotEnoughException e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("你的投资大于项目剩余金额，请重新选择金额");
		} catch (ParameterErrorException e){
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("投资金额必须大于零");
		}catch (MoneyException e){
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("投资金额必须为100的整倍数");
		}catch(MoneyNotEnoughException e){
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("您的账户可用余额不足");
		}  catch (Exception e) {
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
		return "/system/userproject/userprojectCru";
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
				userProjectService.deleteById(id,UserProject.class);
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
			userProjectService.deleteByIds(ids,UserProject.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}

	/**
	 * 获取预计收益
	 *
	 */
	@RequestMapping("/getInterest")
	public @ResponseBody
	ReturnDatas getInterest(Model model,UserProject userProject,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {

			returnObject.setData(userProjectService.getInterest(userProject));

		} catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;

	}

	@RequestMapping("/expectedIncome/json")
	public  @ResponseBody
	ReturnDatas expectedIncome(HttpServletRequest request,UserProject userProject) {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List datas= null;
		try {
			datas = userProjectService.expectedIncome(page,userProject);
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setMessage("系统内部原因");
			returnObject.setStatus(ReturnDatas.ERROR) ;
		}
		returnObject.setQueryBean(userProject);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}

	@RequestMapping("/findList/json")
	public @ResponseBody
	ReturnDatas findList(HttpServletRequest request, Model model,UserProject userProject) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求

		List<UserProject> datas=userProjectService.findList(userProject);
		Map<String,Object>  map = userProjectService.findTotal(userProject);
		if(null!=map.get("money")){
			userProject.setMoney(Double.parseDouble(map.get("money").toString()));
		}else {
			userProject.setMoney(0d);
		}
		returnObject.setQueryBean(userProject);

		returnObject.setData(datas);
		return returnObject;
	}

	@RequestMapping("/exportList/json")
	public void exportList(HttpServletRequest request,HttpServletResponse response, Model model,UserProject userProject) throws Exception{
		List<UserProject> datas=userProjectService.findList(userProject);
		ExportExcelUtil excel=new ExportExcelUtil();
		List<Object> objects = new ArrayList<>();
		if(null != datas && datas.size() > 0){
			for(UserProject up : datas){
				ExportUserProjectBean exportUserProjectBean = (ExportUserProjectBean) CopyUtil.copyAndCreate(ExportUserProjectBean.class,up);
				Object object = new Object();
				object = exportUserProjectBean;
				objects.add(object);
			}
		}
		String[] Title={"真实姓名","级别","投资项目名称","投资金额","投资时间","投资期限"};
		ExportExcelUtil.exportExcel(response,"fenxiaoUserProject.xls",Title, objects,1);


	}

	public 
	String gethetong(Integer uid, Integer pid, Integer id) {
		String s="";
		try {
			UserProject u = new UserProject();
			u.setUserId(uid);
			u.setProjectId(pid);
			u.setId(id);
			s= userProjectService.gethetong(u);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public String getSmartHeTong(Integer uid,Integer pid,Integer id){
		String s="";
		try{
			SmartInvestmentOrder SO = new SmartInvestmentOrder();
			SO.setUserId(uid);
			SO.setId(id);
			SO.setSiProjectId(pid);
			s=userProjectService.getSmartHeTong(SO);
		}catch (Exception e){
			e.printStackTrace();
		}
		return s;
	}

	public String getCreditorPact(Integer uid,Integer pid,Integer id,String status){

		String s="";
		try {
			s=userProjectService.getCreditorPact(uid,pid,id,status);
		}catch (Exception e){
			e.printStackTrace();
		}
		return s;
	}

	public String getContinueToBuy(Integer uid,Integer oid,Integer projectId){
		String s="";
		try{
			s = userProjectService.getContinueToBuy(uid,oid,projectId);
		}catch (Exception e){

		}
		return s;
	}
	
	
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param userProject
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/repay/list")
	public String repayList(HttpServletRequest request, Model model, UserProject userProject) 
			throws Exception {
		Page page = newPage(request);
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		rt.setQueryBean(userProject);
		
		List<Map<String, Object>> list = userProjectService.repayList(userProject, page);
		rt.setData(list);
		rt.setPage(page);
		model.addAttribute(GlobalStatic.returnDatas, rt);

		return "repayment/list";
	}
	
	/**
	 * 导出数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param userProject
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/repay/export/json")
	public void repayExport(HttpServletRequest request, HttpServletResponse response, Model model, UserProject userProject) 
			throws Exception {
		Page page = newPage(request);
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		rt.setQueryBean(userProject);
		page.setPageSize(1000);
		List<Map<String, Object>> list = userProjectService.repayList(userProject, page);
		rt.setData(list);
		rt.setPage(page);
//		model.addAttribute(GlobalStatic.returnDatas, rt);

		File file= userProjectService.findDataExportExcel(list, "/repayment/list", new Page(), null);
		downFile(response, file, "还款列表.xls",true);
	}
}
