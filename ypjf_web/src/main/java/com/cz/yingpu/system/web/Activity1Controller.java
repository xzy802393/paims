package com.cz.yingpu.system.web;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.DateUtils;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.MessageUtils;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.Activity1History;
import com.cz.yingpu.system.entity.Activity1Prize;
import com.cz.yingpu.system.entity.Activity1Site;
import com.cz.yingpu.system.service.IActivity1HistoryService;
import com.cz.yingpu.system.service.IDrawService;
import com.sun.star.lang.NullPointerException;


/**
 * 抽奖
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-07-17 16:55:01
 * @see com.cz.yingpu.system.web.Activity1Prize
 */
@Controller
@RequestMapping(value="/system/activity-draw")
public class Activity1Controller  extends BaseController {
	@Resource
	private IDrawService drawService;
	
	@Resource
	private IActivity1HistoryService activity1HistoryService;
	
	private String listurl="/activity1/list";
	
	
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param Activity1Prize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,Activity1Prize Activity1Prize) 
			throws Exception {
		Activity1Prize = Activity1Prize == null ? new Activity1Prize() : Activity1Prize;
		ReturnDatas returnObject = listjson(request, model, Activity1Prize);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param Activity1Prize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,Activity1Prize Activity1Prize) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
	/*	page.setOrder("siteId");
		page.setSort("DESC");
		*/
		Finder f = new Finder("SELECT p.*, s.name siteName, CASE p.type WHEN 1 THEN '奖品' WHEN 2 THEN '交通工具' END typeDesc "
							+ "FROM t_activity1_prize p, t_activity1_site s WHERE s.id = p.siteId order by p.siteId desc");
		f.setEscapeSql(false);
		// ==执行分页查询
		List<Map<String, Object>> datas=drawService.queryForList(f, page);
			returnObject.setQueryBean(Activity1Prize);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param Activity1Prize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/web/list/json")
	public @ResponseBody
	ReturnDatas listjsonweb(HttpServletRequest request, Model model,Activity1Prize Activity1Prize) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		
		page.setSort("desc");
		page.setOrder("id");
		Finder finder=new Finder("select * from t_Activity1Prize where 1=1 ");
		
 		if(request.getParameter("type")!=null){
			if(request.getParameter("type").equals("2")){
				
				finder.append(" and (endtime > :endtime or  isCq=:isCq)");
				finder.setParam("isCq", "是");
				finder.setParam("endtime", DateUtils.convertDate2String(new Date()));
			}else if(request.getParameter("type").equals("3")){
				finder.append(" and endtime < :endtime  and isCq <> :isCq");
				finder.setParam("isCq", "是");
				finder.setParam("endtime", DateUtils.convertDate2String(new Date()));
			}else{
				
			}
		}
		// ==执行分页查询
		List<Activity1Prize> datas=drawService.findListDataByFinder(finder,page,Activity1Prize.class,Activity1Prize);
			returnObject.setQueryBean(Activity1Prize);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,Activity1Prize Activity1Prize) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);

		File file = drawService.findDataExportExcel(null,listurl, page,Activity1Prize.class,Activity1Prize);
		String fileName="Activity1Prize"+GlobalStatic.excelext;
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
		return "/activity1/look";
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
		  Activity1Prize Activity1Prize = drawService.findById(id, Activity1Prize.class);
		   returnObject.setData(Activity1Prize);
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
	ReturnDatas saveorupdate(Model model,Activity1Prize Activity1Prize,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			if (Activity1Prize == null) {
				new NullPointerException();
			}
			
			if (Activity1Prize.getId() == null) {
				Activity1Prize.setCreateTime(new Date());
				drawService.save(Activity1Prize);
			}
			else {
				drawService.updateValidValue(Activity1Prize);
			}
			
//			Integer id = Integer.parseInt(drawService.saveorupdate(Activity1Prize).toString());
			/*Activity1Prize act = drawService.findById(id,Activity1Prize.class);
			act.setUrl("http://wap.yingpuwealth.com/yingpu/web/Activity1Prize.html?id="+id);
			drawService.update(act,true);*/
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
	@RequestMapping(value = "/edit")
	public String edit(Model model,HttpServletRequest request,HttpServletResponse response)  throws Exception{
		ReturnDatas returnObject = lookjson(model, request, response);
		returnObject.setQueryBean(drawService.findListDataByFinder(null, null, Activity1Site.class, new Activity1Site()));
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/activity1/edit";
	}
	
	
	/**
	 * 进入修改页面,APP端可以调用 lookjson 获取json格式数据
	 */
	@RequestMapping(value = "/add")
	public String add(Model model,HttpServletRequest request,HttpServletResponse response)  throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setQueryBean(drawService.findListDataByFinder(null, null, Activity1Site.class, new Activity1Site()));
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/activity1/edit";
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
				drawService.deleteById(id,Activity1Prize.class);
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
			drawService.deleteByIds(ids,Activity1Prize.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}
	
	
	/**
	 * 投资记录添加备注 
	 */
	@RequestMapping("/invest_history/remark/update/json")	
	@ResponseBody
	public ReturnDatas acquireActivity1PrizeList(Activity1History history) {
		if (history.getId() == null) {
			return null;
		}

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		if (StringUtils.isNotBlank(history.getDescr())) {
			try {
				activity1HistoryService.updateValidValue(history);
			} catch (Exception e) {
				rt.setStatus(ReturnDatas.ERROR);
				e.printStackTrace();
			}			
		}
		
		return rt;
	}
	
	
	/**
	 * 投资记录 
	 */
	@RequestMapping("/acquire_prize/list/json")	
	
	public String acquireActivity1PrizeList(String userName, String prizeName, Date startTime, Date endTime, Integer type, HttpServletRequest request, Model model) {
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("SELECT uph.*, au.realName userName, au.phone phoneNumber, s.name siteName, ")
							.append("CASE uph.type WHEN 1 THEN '投资行进' WHEN 2 THEN '加速行进' END typeDesc, ")
							.append("CASE uph.drawtype WHEN -1 THEN '不可抽奖' WHEN 0 THEN '未抽奖' ")
							.append("ELSE ap.prizename END drawtypeDesc, ")
							.append("CASE uph.acceleratetype WHEN -1 THEN '不可加速' WHEN 0 THEN '可加速' ")
							.append("ELSE (SELECT prizename FROM t_activity1_prize WHERE id = uph.acceleratetype) END  acceleratetypeDesc ")
							.append("FROM ( t_activity1_history uph, t_app_user au, t_activity1_site s ) ")
							.append("LEFT JOIN t_activity1_prize ap ON ap.id = uph.drawtype WHERE ")
							.append("au.id = uph.userid AND uph.siteId = s.id");
		finder.setEscapeSql(false);
		
		if (StringUtils.isNotBlank(userName)) {
			finder.append(" AND au.realName LIKE :realName ");
			finder.setParam("realName", '%' + userName + '%');
		}
		
		if (StringUtils.isNotBlank(prizeName)) {
			finder.append(" AND ap.prizename LIKE :Activity1PrizeName ");
			finder.setParam("Activity1PrizeName", '%' + prizeName + '%');
		}

		if (type != null) {
			finder.append(" AND uph.drawtype ");
			if (type <= 0) {
				finder.append("= :type");
				finder.setParam("type", type);
			}
			else {
				finder.append(" > 0");
			}
		}
		
		if (startTime != null && endTime != null) {
			finder.append(" AND uph.createTime BETWEEN :startTime AND :endTime");
			finder.setParam("startTime", startTime)
				  .setParam("endTime", endTime);
		}
			
		Map<String, Object> map = new HashMap<>();
		Page page = newPage(request);
		page.setOrder("uph.createTime");	
		page.setSort("DESC");

		try {
			data = activity1HistoryService.queryForList(finder, page);
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		rt.setData(data);
		rt.setPage(page);

		map.put("userName", userName);
		map.put("prizeName", prizeName);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		map.put("type", "" + type);

		rt.setQueryBean(map);
		model.addAttribute(GlobalStatic.returnDatas, rt);
		
		return "/activity1/userPrizeList";
	}
	
	
	
	
	/**
	 * 投资记录导出
	 */
	@RequestMapping("/acquire_prize/list/export/json")
	
	public void acquireActivity1PrizeListExport(String userName, String prizeName, Date startTime, Date endTime, HttpServletRequest request, Model model,
			HttpServletResponse response, Integer type) {
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("SELECT uph.*, au.realName userName, au.phone phoneNumber, s.name siteName, ")
		.append("CASE uph.type WHEN 1 THEN '投资行进' WHEN 2 THEN '加速行进' END typeDesc, ")
		.append("CASE uph.drawtype WHEN -1 THEN '不可抽奖' WHEN 0 THEN '未抽奖' ")
		.append("ELSE ap.prizename END drawtypeDesc, ")
		.append("CASE uph.acceleratetype WHEN -1 THEN '不可加速' WHEN 0 THEN '可加速' ")
		.append("ELSE (SELECT prizename FROM t_activity1_prize WHERE id = uph.acceleratetype) END  acceleratetypeDesc ")
		.append("FROM ( t_activity1_history uph, t_app_user au, t_activity1_site s ) ")
		.append("LEFT JOIN t_activity1_prize ap ON ap.id = uph.drawtype WHERE ")
		.append("au.id = uph.userid AND uph.siteId = s.id");
		finder.setEscapeSql(false);
		
		if (StringUtils.isNotBlank(userName)) {
		finder.append(" AND au.realName LIKE :realName ");
		finder.setParam("realName", '%' + userName + '%');
		}
		
		if (StringUtils.isNotBlank(prizeName)) {
		finder.append(" AND ap.prizename LIKE :Activity1PrizeName ");
		finder.setParam("Activity1PrizeName", '%' + prizeName + '%');
		}
		
		if (type != null) {
		finder.append(" AND uph.drawtype ");
		if (type <= 0) {
		finder.append("= :type");
		finder.setParam("type", type);
		}
		else {
		finder.append(" > 0");
		}
		}
		
		if (startTime != null && endTime != null) {
		finder.append(" AND uph.createTime BETWEEN :startTime AND :endTime");
		finder.setParam("startTime", startTime)
		.setParam("endTime", endTime);
		}
				
		Map<String, Object> map = new HashMap<>();
		Page page = newPage(request);
		page.setPageSize(1000);
		page.setOrder("uph.createTime");
		page.setSort("DESC");
		try {
			data = activity1HistoryService.queryForList(finder, page);
			downFile(response, activity1HistoryService.findDataExportExcel(data, "activity1/userPrizeList", page, null), "中奖记录.xls", true);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 用户总览
	 */
	@RequestMapping("/acquire_prize/overview/json")	
	public String overviewList(String userName, String Activity1PrizeName, Date startTime, Date endTime, HttpServletRequest request, Model model) {
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("SELECT actu.*, acts.name siteName, au.realName FROM t_activity1_user actu, t_activity1_site acts, t_app_user au WHERE ")
							.append(" acts.id = actu.siteId AND au.id = actu.userid ");
		 
		if (StringUtils.isNotBlank(userName)) {
			finder.append(" AND au.realName LIKE :realName ");
			finder.setParam("realName", '%' + userName + '%');
		}
		
		if (startTime != null && endTime != null) {
			finder.append(" AND uph.createTime BETWEEN :startTime AND :endTime");
			finder.setParam("startTime", startTime)
				  .setParam("endTime", endTime);
		}
			
		Map<String, Object> map = new HashMap<>();
		Page page = newPage(request);
		page.setOrder("actu.createTime");
		page.setSort("DESC");
		try {
			data = activity1HistoryService.queryForList(finder, page);
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		rt.setData(data);
		rt.setPage(page);

		map.put("userName", userName);
		map.put("Activity1PrizeName", Activity1PrizeName);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		rt.setQueryBean(map);
		model.addAttribute(GlobalStatic.returnDatas, rt);
		
		return "/activity1/userOverview";
	}
	
	
	/**
	 * 用户总览
	 */
	@RequestMapping("/acquire_prize/overview/export")	
	public void overviewListExpt(String userName, String Activity1PrizeName, Date startTime, Date endTime, HttpServletRequest request, Model model,
			HttpServletResponse response) {
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("SELECT actu.*, acts.name siteName, au.realName FROM t_activity1_user actu, t_activity1_site acts, t_app_user au WHERE ")
							.append(" acts.id = actu.siteId AND au.id = actu.userid ");
		
		if (StringUtils.isNotBlank(userName)) {
			finder.append(" AND au.realName LIKE :realName ");
			finder.setParam("realName", '%' + userName + '%');
		}
		
		if (startTime != null && endTime != null) {
			finder.append(" AND uph.createTime BETWEEN :startTime AND :endTime");
			finder.setParam("startTime", startTime)
				  .setParam("endTime", endTime);
		}
			
		Map<String, Object> map = new HashMap<>();
		Page page = newPage(request);
		page.setPageSize(1000);
		page.setOrder("actu.createTime");
		page.setSort("DESC");

		try {
			data = activity1HistoryService.queryForList(finder, page);
			downFile(response, activity1HistoryService.findDataExportExcel(data, "activity1/userOverview", page, null), "中奖记录.xls", true);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 新增/修改 操作吗,返回json格式数据
	 * 
	 */
	@RequestMapping("/history/update/json")
	public @ResponseBody
	ReturnDatas update(Model model,Activity1History Activity1Prize,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			if (Activity1Prize == null) {
				new NullPointerException();
			}
	
			drawService.updateValidValue(Activity1Prize);
		} catch (Exception e) {
			e.printStackTrace();
			String errorMessage = e.getLocalizedMessage();
			logger.error(errorMessage);
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;
	
	}

}
