package  com.cz.yingpu.system.web;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.system.entity.Announce;
import com.cz.yingpu.system.entity.Project;
import com.cz.yingpu.system.service.IAnnounceService;
import com.cz.yingpu.system.service.IProjectService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.system.entity.LunboPic;
import com.cz.yingpu.system.service.ILunboPicService;
import com.cz.yingpu.frame.controller.BaseController;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:46
 * @see com.cz.yingpu.system.web.LunboPic
 */
@Controller
@RequestMapping(value="/system/lunbopic")
public class LunboPicController  extends BaseController {
	@Resource
	private ILunboPicService lunboPicService;

	@Resource
	private IProjectService projectService ;
	@Resource
	private IAnnounceService announceService ;
	
	private String listurl="/lunbopic/lunbopicList";
	
	
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param lunboPic
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,LunboPic lunboPic) 
			throws Exception {
		// ==构造分页请求
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List<LunboPic> datas=lunboPicService.list(page,lunboPic);
		returnObject.setQueryBean(lunboPic);
		returnObject.setPage(page);
		returnObject.setData(datas);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param lunboPic
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,LunboPic lunboPic) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List<LunboPic> datas=lunboPicService.findListDataByFinder(null,page,LunboPic.class,lunboPic);
			returnObject.setQueryBean(lunboPic);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,LunboPic lunboPic) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = lunboPicService.findDataExportExcel(null,listurl, page,LunboPic.class,lunboPic);
		String fileName="lunboPic"+GlobalStatic.excelext;
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
		return "/system/lunbopic/lunbopicLook";
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
		  LunboPic lunboPic = lunboPicService.findLunboPicById(id);
		   returnObject.setData(lunboPic);
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
	ReturnDatas saveorupdate(Model model,LunboPic lunboPic,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {

			if(lunboPic.getSkipType() == 1)
				lunboPic.setItem(lunboPic.getUrl());
			lunboPic.setCreateTime(new Date());
			lunboPicService.saveorupdate(lunboPic);
			
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
		return "/lunbopic/lunbopicCru";
	}
	
	/**
	 * 删除操作
	 */
	@RequestMapping(value="/delete/json")
	public @ResponseBody ReturnDatas delete(HttpServletRequest request) throws Exception {

			// 执行删除
		try {
		  String  strId=request.getParameter("id");
		  java.lang.Integer id=null;
		  if(StringUtils.isNotBlank(strId)){
			 id= java.lang.Integer.valueOf(strId.trim());
				lunboPicService.deleteById(id,LunboPic.class);
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
			lunboPicService.deleteByIds(ids,LunboPic.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}


	/**
	 * 获取链接目标列表
	 * @author wj
	 * @param request
	 * @param model
	 * @param lunboPic
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/position/list/json")
	public @ResponseBody
	ReturnDatas positionList(HttpServletRequest request, Model model,LunboPic lunboPic) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		String skipType = request.getParameter("skipType");
		if(StringUtils.isNotBlank(skipType)){
			//2.投资产品   3.站内公告
			if("2".equals(skipType)){

				Finder finder =  new Finder("select id,name from ").append(Finder.getTableName(Project.class)).append(" where status<3") ;
				List<Project> list = projectService.queryForList(finder, Project.class) ;
				returnObject.setData(list);
			}else if("3".equals(skipType)){
				Finder finder =  new Finder("select id,title from ").append(Finder.getTableName(Announce.class)) ;
				List<Announce> list = projectService.queryForList(finder, Announce.class) ;
				returnObject.setData(list);
			}
		}
		return returnObject;
	}

}
