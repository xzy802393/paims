package com.cz.yingpu.system.web;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.system.entity.Activity;
import com.cz.yingpu.system.entity.WorldCupUserGuessInfo;
import com.cz.yingpu.system.operator.OperatorController;
import com.cz.yingpu.system.service.IActivityService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.*;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-07-17 16:55:01
 * @see com.cz.yingpu.system.web.Activity
 */
@Controller
@RequestMapping(value="/system/activity")
public class ActivityController  extends BaseController {
	@Resource
	private IActivityService activityService;
	
	private String listurl="/activity/activityList";

	@Resource
	private OperatorController operatorController;
	
	
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param activity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,Activity activity) 
			throws Exception {
		ReturnDatas returnObject = listjson(request, model, activity);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param activity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,Activity activity) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		page.setOrder("");
		page.setSort("");
		
		// ==执行分页查询
		List<Activity> datas=activityService.findListDataByFinder(null,page,Activity.class,activity);
			returnObject.setQueryBean(activity);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param activity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/web/list/json")
	public @ResponseBody
	ReturnDatas listjsonweb(HttpServletRequest request, Model model,Activity activity) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		page.setOrder("INSTR('是否',isCq)ASC,`startTime`DESC");
		page.setSort("");
		Finder finder=new Finder("SELECT * FROM t_activity where 1=1");
		finder.setEscapeSql(false);

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
		List<Activity> datas=activityService.findListDataByFinder(finder,page,Activity.class,activity);

		System.out.println(finder.getSql());
			returnObject.setQueryBean(activity);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,Activity activity) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = activityService.findDataExportExcel(null,listurl, page,Activity.class,activity);
		String fileName="activity"+GlobalStatic.excelext;
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
		return "/activity/activityLook";
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
		  Activity activity = activityService.findActivityById(id);
		   returnObject.setData(activity);
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
	ReturnDatas saveorupdate(Model model,Activity activity,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			Integer id = Integer.parseInt(activityService.saveorupdate(activity).toString());
			/*Activity act = activityService.findById(id,Activity.class);
			act.setUrl("http://wap.yingpuwealth.com/yingpu/web/activity.html?id="+id);
			activityService.update(act,true);*/
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
		return "/activity/activityCru";
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
				activityService.deleteById(id,Activity.class);
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
			activityService.deleteByIds(ids,Activity.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}


	/**
	 * 营普2周年PK用户投资记录详情
	 */
	@RequestMapping("/20180501_PK/invest_history_details")
	public
	String investHistory_20180501PK(HttpServletRequest request, Integer pageSize) {
		Finder finder = new Finder("SELECT p.name, au.phone, au.realName, up.*, ais.*")
				.append(" FROM t_activity_invest_history ais, t_app_user au, t_project p, t_user_project up")
				.append(" WHERE au.id = ais.userId AND up.id = ais.userProjectId  AND p.id = up.projectId")
				.append(" AND ais.thisAnnualized IS NULL");

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		Page page = newPage(request);
		page.setSort("DESC");
		page.setOrder("up.createTime");
		if (pageSize != null) {
			page.setPageSize(pageSize);
		}

		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");
		Map<String, String> map = new HashMap<>();

		map.put("phone", phone);
		map.put("name", name);
		map.put("dateStart", dateStart);
		map.put("dateEnd", dateEnd);

		if (StringUtils.isNotBlank(phone)) {
			finder.append(" AND au.phone = :phone")
					.setParam("phone", phone);
		}
		if (StringUtils.isNotBlank(name)) {
			finder.append(" AND u.realName LIKE :name")
					.setParam("name", "%" + name + "%");
		}
		if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
			finder.append(" AND up.createTime BETWEEN :start AND :end")
					.setParam("start", dateStart + " 00:00:00")
					.setParam("end", dateEnd + " 23:59:59");
		}

		try {
			list = activityService.queryForList(finder, page);
			rt.setData(list);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}

		rt.setQueryBean(map);
		rt.setPage(page);
		request.setAttribute(GlobalStatic.returnDatas, rt);
		return "activity/history/20180501pk_invest_hisotry";
	}

	/**
	 * 营普2周年PK用户投资记录详情
	 */
	@RequestMapping("/20180501_PK/invest_history_details/export")
	public
	void investHistoryExport_20180501PK(HttpServletRequest request, Model model, HttpServletResponse resp) {
		String url = investHistory_20180501PK(request, 99999);
		ReturnDatas rt = (ReturnDatas) request.getAttribute(GlobalStatic.returnDatas);

		try {
			downFile(resp, activityService.findDataExportExcel(
					(List<?>) rt.getData(), url, rt.getPage(), null), "导出.xls", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 营普2周年PK用户详情
	 */
	@RequestMapping("/20180501_PK/user_details")
	public
	String userDetails_20180501PK(HttpServletRequest request, Integer pageSize) {
		Finder finder = new Finder("SELECT ag.*, au.*, u.realName, u.phone,")
				.append(" ROUND(au.annualized / ag.totalAnnualized, 2) percentage")
				.append(" FROM t_activity_user_group ag, t_activity_user au, t_app_user u")
				.append(" WHERE au.groupId = ag.id AND u.id = au.userId AND au.activityId IS NULL");
		Page page = newPage(request);
		page.setSort("DESC");
		page.setOrder("ag.id,au.annualized/ag.totalAnnualized");
		if (pageSize != null) {
			page.setPageSize(pageSize);
		}

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		if (StringUtils.isNotBlank(phone)) {
			finder.append(" AND u.phone = :phone")
					.setParam("phone", phone);
		}
		if (StringUtils.isNotBlank(name)) {
			finder.append(" AND u.realName LIKE :name")
					.setParam("name", "%" + name + "%");
		}

		try {
			list = activityService.queryForList(finder, page);
			rt.setData(list);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}

		rt.setPage(page);
		request.setAttribute(GlobalStatic.returnDatas, rt);
		return "activity/history/20180501pk_user_details";
	}

	/**
	 * 营普2周年PK用户投资记录详情
	 */
	@RequestMapping("/20180501_PK/user_details/export")
	public
	void userDetailsExport_20180501PK(HttpServletRequest request, Model model, HttpServletResponse resp) {
		String url = userDetails_20180501PK(request, 99999);
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
	 * 赛龙舟用户投资记录详情
	 */
	@RequestMapping("/201806_dragonboat/invest_history_details")
	public String investHistory_201806_Dragonboat(HttpServletRequest request, Integer pageSize) {
		Finder finder = new Finder("SELECT p.name, au.phone, au.realName, up.*, ais.*")
				.append(" FROM t_activity_invest_history ais, t_app_user au, t_project p, t_user_project up")
				.append(" WHERE au.id = ais.userId AND up.id = ais.userProjectId  AND p.id = up.projectId")
				.append(" AND NOT ais.thisAnnualized IS NULL");

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		Page page = newPage(request);
		page.setSort("DESC");
		page.setOrder("up.createTime");
		if (pageSize != null) {
			page.setPageSize(pageSize);
		}

		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");
		Map<String, String> map = new HashMap<>();

		map.put("phone", phone);
		map.put("name", name);
		map.put("dateStart", dateStart);
		map.put("dateEnd", dateEnd);

		if (StringUtils.isNotBlank(phone)) {
			finder.append(" AND au.phone = :phone")
					.setParam("phone", phone);
		}
		if (StringUtils.isNotBlank(name)) {
			finder.append(" AND u.realName LIKE :name")
					.setParam("name", "%" + name + "%");
		}
		if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
			finder.append(" AND up.createTime BETWEEN :start AND :end")
					.setParam("start", dateStart + " 00:00:00")
					.setParam("end", dateEnd + " 23:59:59");
		}

		try {
			list = activityService.queryForList(finder, page);
			rt.setData(list);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}

		rt.setQueryBean(map);
		rt.setPage(page);
		request.setAttribute(GlobalStatic.returnDatas, rt);
		return "/activity/201806/dragonboat_invest_hisotry";
	}

	/**
	 * 营普2周年PK用户投资记录详情
	 */
	@RequestMapping("/201806/dragonboat/invest_history_details/export")
	public
	void investHistoryExport_201806_Dragonboat(HttpServletRequest request, Model model, HttpServletResponse resp) {
		String url = investHistory_201806_Dragonboat(request, 99999);
		ReturnDatas rt = (ReturnDatas) request.getAttribute(GlobalStatic.returnDatas);

		try {
			downFile(resp, activityService.findDataExportExcel(
					(List<?>) rt.getData(), url, rt.getPage(), null), "导出.xls", true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 营普2周年PK用户详情
	 */
	@RequestMapping("/201806/dragonboat/user_details")
	public
	String userDetails_201806_Dragonboat(HttpServletRequest request, Integer pageSize) {
		Finder finder = new Finder("SELECT ag.*, au.*, u.realName, u.phone,")
				.append(" ROUND(au.annualized / ag.totalAnnualized, 2) percentage")
				.append(" FROM t_activity_user_group ag, t_activity_user au, t_app_user u")
				.append(" WHERE au.groupId = ag.id AND u.id = au.userId AND au.activityId = 39");
		Page page = newPage(request);
		page.setSort("DESC");
		page.setOrder("ag.id,au.annualized/ag.totalAnnualized");
		if (pageSize != null) {
			page.setPageSize(pageSize);
		}

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		if (StringUtils.isNotBlank(phone)) {
			finder.append(" AND u.phone = :phone")
					.setParam("phone", phone);
		}
		if (StringUtils.isNotBlank(name)) {
			finder.append(" AND u.realName LIKE :name")
					.setParam("name", "%" + name + "%");
		}

		try {
			list = activityService.queryForList(finder, page);
			rt.setData(list);
		}
		catch(Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
		}

		rt.setPage(page);
		request.setAttribute(GlobalStatic.returnDatas, rt);
		return "activity/201806/dragonboat_user_details";
	}

	/**
	 * 营普2周年PK用户投资记录详情
	 */
	@RequestMapping("/201806/dragonboat/user_details/export")
	public
	void userDetailsExport_201806_Dragonboat(HttpServletRequest request, Model model, HttpServletResponse resp) {
		String url = userDetails_201806_Dragonboat(request, 99999);
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
	 * 2018世界杯用户竞猜奖励
	 */
	@RequestMapping("/worldcup/2018/user_bonus")
	public
	String worldCup2018UserBonus(HttpServletRequest request, Integer pageSize) {
		Finder finder = new Finder("SELECT tt.isWinner, tt.matchTeams, ugi.*, au.phone, au.realName FROM (")
				.append(" SELECT GROUP_CONCAT(t.chineseName separator ' vs ') matchTeams, m.startTime, si.isWinner, si.matchId")
				.append(" FROM (t_world_cup_2018_team t, t_world_cup_2018_match m, t_world_cup_2018_score_info si)")
				.append(" WHERE si.matchId = m.id AND t.id = si.teamId AND m.startDate < DATE_FORMAT(NOW(), '%Y%-%m-%d') GROUP BY m.id) tt")
				.append(" INNER JOIN t_world_cup_2018_user_guess_info ugi ON ugi.matchId = tt.matchId")
				.append(" INNER JOIN t_app_user au ON au.id = ugi.userId")
				.append(" WHERE 1 = 1");
		finder.setEscapeSql(false);
		Page page = newPage(request);
		if (pageSize != null) {
			page.setPageSize(pageSize);
		}

		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<Map<String, Object>> list = new ArrayList<>();
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		String dateStart = request.getParameter("dateStart");
		String dateEnd = request.getParameter("dateEnd");

		if (StringUtils.isNotBlank(phone)) {
			finder.append(" AND au.phone = :phone")
					.setParam("phone", phone);
		}
		if (StringUtils.isNotBlank(name)) {
			finder.append(" AND au.realName LIKE :name")
					.setParam("name", "%" + name + "%");
		}
		if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
			finder.append(" AND ugi.guessTime BETWEEN :start AND :end")
					.setParam("start", dateStart + " 00:00:00")
					.setParam("end", dateEnd + " 23:59:59");
		}

		finder.append(" ORDER BY ugi.guessTime DESC");
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("phone", phone);
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
		return "/activity/worldcup_2018/user_bonus";
	}

	/**
	 * 2018世界杯用户竞猜奖励导出
	 */
	@RequestMapping("/worldcup/2018/user_bonus/export")
	public
	void worldCup2018UserBonusExport(HttpServletRequest request, Integer pageSize, HttpServletResponse resp) {
		String url = worldCup2018UserBonus(request, 99999);
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
	 * 2018世界杯用户竞猜奖励
	 */
	@RequestMapping("/worldcup/2018/user_bonus/remark")
	@ResponseBody
	public
	ReturnDatas worldCup2018UserBonusRemark(HttpServletRequest request, WorldCupUserGuessInfo info) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		try {
			activityService.updateValidValue(info);
		}
		catch(Exception e) {
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}

		return rt;
	}
}
