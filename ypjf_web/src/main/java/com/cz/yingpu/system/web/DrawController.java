package com.cz.yingpu.system.web;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.DateUtils;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.MessageUtils;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.Activity;
import com.cz.yingpu.system.entity.Prize;
import com.cz.yingpu.system.entity.UserPrizeHistory;
import com.cz.yingpu.system.service.IDrawService;
import com.cz.yingpu.system.service.IUserPrizeHistoryService;
import com.sun.star.lang.NullPointerException;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * 抽奖
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-07-17 16:55:01
 * @see com.cz.yingpu.system.web.Prize
 */
@Controller
@RequestMapping(value="/system/draw")
public class DrawController  extends BaseController {
	@Resource
	private IDrawService drawService;
	
	@Resource
	private IUserPrizeHistoryService userPrizeHistoryService;
	
	private String listurl="/draw/list";
	
	
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param Prize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,Prize Prize) 
			throws Exception {
		Prize = Prize == null ? new Prize() : Prize;
		ReturnDatas returnObject = listjson(request, model, Prize);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param Prize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,Prize Prize) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		page.setOrder("createTime");
		page.setSort("DESC");
		
		// ==执行分页查询
		List<Prize> datas=drawService.findListDataByFinder(null,page,Prize.class,Prize);
			returnObject.setQueryBean(Prize);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param Prize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/web/list/json")
	public @ResponseBody
	ReturnDatas listjsonweb(HttpServletRequest request, Model model,Prize Prize) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		
		page.setSort("desc");
		page.setOrder("id");
		Finder finder=new Finder("select * from t_Prize where 1=1 ");
		
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
		List<Prize> datas=drawService.findListDataByFinder(finder,page,Prize.class,Prize);
			returnObject.setQueryBean(Prize);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,Prize Prize) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = drawService.findDataExportExcel(null,listurl, page,Prize.class,Prize);
		String fileName="Prize"+GlobalStatic.excelext;
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
		return "/Prize/PrizeLook";
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
		  Prize Prize = drawService.findById(id, Prize.class);
		  returnObject.setQueryBean(drawService.queryForListByEntity(new Activity(), null));
		   returnObject.setData(Prize);
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
	ReturnDatas saveorupdate(Model model,Prize Prize,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			if (Prize == null) {
				new NullPointerException();
			}
			
			if (Prize.getId() == null) {
				Prize.setCreateTime(new Date());
				drawService.save(Prize);
			}
			else {
				drawService.updateValidValue(Prize);
			}
			
//			Integer id = Integer.parseInt(drawService.saveorupdate(Prize).toString());
			/*Prize act = drawService.findById(id,Prize.class);
			act.setUrl("http://wap.yingpuwealth.com/yingpu/web/Prize.html?id="+id);
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
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/draw/edit";
	}
	
	
	/**
	 * 进入修改页面,APP端可以调用 lookjson 获取json格式数据
	 */
	@RequestMapping(value = "/add")
	public String add(Model model,HttpServletRequest request,HttpServletResponse response)  throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setQueryBean(drawService.queryForListByEntity(new Activity(), null));
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/draw/edit";
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
				drawService.deleteById(id,Prize.class);
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
			drawService.deleteByIds(ids,Prize.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}
	
	
	/**
	 * 中奖记录
	 */
	@RequestMapping("/acquire_prize/list/json")	
	
	public String acquirePrizeList(String userName, String prizeName, Date startTime, Date endTime, HttpServletRequest request, Model model) {
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("SELECT uph.*, au.realName userName, p.prizename prizeName, au.phone  FROM t_user_prize_history uph, t_app_user au, t_prize p WHERE 1 = 1")
							.append(" AND  au.id = uph.userid AND p.id = uph.prizeid ");
		
		if (StringUtils.isNotBlank(userName)) {
			finder.append(" AND au.realName LIKE :realName ");
			finder.setParam("realName", '%' + userName + '%');
			
		}
		
		if (StringUtils.isNotBlank(prizeName)) {
			finder.append(" AND p.prizename LIKE :prizeName ");
			finder.setParam("prizeName", '%' + prizeName + '%');
		}

		String phone = request.getParameter("phone");
		if (StringUtils.isNotBlank(phone)) {
			finder.append(" AND au.phone = :phone")
				  .setParam("phone", phone);
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
			data = userPrizeHistoryService.queryForList(finder, page);
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
		map.put("phone", phone);
		rt.setQueryBean(map);
		model.addAttribute(GlobalStatic.returnDatas, rt);
		
		return "/draw/userPrizeList";
	}
	
	
	
	
	/**
	 * 中奖记录导出
	 */
	@RequestMapping("/acquire_prize/list/export/json")
	
	public void acquirePrizeListExport(String userName, String prizeName, Date startTime, Date endTime, HttpServletRequest request, Model model,
			HttpServletResponse response) {
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("SELECT uph.*, au.realName userName, p.prizename prizeName, au.phone FROM t_user_prize_history uph, t_app_user au, t_prize p WHERE 1 = 1")
							.append(" AND  au.id = uph.userid AND p.id = uph.prizeid ");
		
		if (StringUtils.isNotBlank(userName)) {
			finder.append(" AND au.realName LIKE :realName ");
			finder.setParam("realName", '%' + userName + '%');
			
		}
		
		if (StringUtils.isNotBlank(prizeName)) {
			finder.append(" AND p.prizename LIKE :prizeName ");
			finder.setParam("prizeName", '%' + prizeName + '%');
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
			data = userPrizeHistoryService.queryForList(finder, page);
			downFile(response, userPrizeHistoryService.findDataExportExcel(data, "draw/userPrizeList", page, null), "中奖记录.xls", true);
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
	ReturnDatas update(Model model,UserPrizeHistory Prize,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			if (Prize == null) {
				new NullPointerException();
			}
			Prize.setId(Integer.parseInt(request.getParameter("id")));
			Prize.setDescr("已发放");
			drawService.updateValidValue(Prize);

		} catch (Exception e){
			e.printStackTrace();
			String errorMessage = e.getLocalizedMessage();
			logger.error(errorMessage);
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;
	
	}

}
