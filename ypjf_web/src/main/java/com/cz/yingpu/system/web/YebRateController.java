package com.cz.yingpu.system.web;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cz.yingpu.frame.util.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.system.entity.YebRate;
import com.cz.yingpu.system.service.IYebRateService;
import com.cz.yingpu.frame.controller.BaseController;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-31 14:27:27
 * @see com.cz.yingpu.system.web.YebRate
 */
@Controller
@RequestMapping(value="/system/yebrate")
public class YebRateController  extends BaseController {
	@Resource
	private IYebRateService yebRateService;
	
	private String listurl="/yebrate/yebrateList";
	
	
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param yebRate
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,YebRate yebRate) 
			throws Exception {
		ReturnDatas returnObject = listjson(request, model, yebRate);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param yebRate
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,YebRate yebRate) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		String size = request.getParameter("pageSize");
		if(null!=size){
			Integer pageSize = Integer.parseInt(size);
			page.setPageSize(pageSize);
		}
		// ==执行分页查询
		Finder finder = new Finder("select * from ").append(Finder.getTableName(YebRate.class)).append(" where DATEDIFF(NOW() ,createDate) > -1 ") ;
		List<YebRate> datas=yebRateService.findListDataByFinder(null,page,YebRate.class,yebRate);
			returnObject.setQueryBean(yebRate);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,YebRate yebRate) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = yebRateService.findDataExportExcel(null,listurl, page,YebRate.class,yebRate);
		String fileName="yebRate"+GlobalStatic.excelext;
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
		return "/system/yebrate/yebrateLook";
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
		  YebRate yebRate = yebRateService.findYebRateById(id);
		   returnObject.setData(yebRate);
		}else{
			  Finder finder = new Finder("select * from ").append(Finder.getTableName(YebRate.class)).append(" where id = (select max(id) from t_yeb_rate)") ;
		  	List<YebRate> list = yebRateService.queryForList(finder,YebRate.class) ;
		  	if(list != null)
		  		returnObject.setData(list.get(0));
		returnObject.setStatus(ReturnDatas.ERROR);
		}
		return returnObject;
		
	}
	
	
	/**
	 * 新增/修改 操作吗,返回json格式数据
	 * 
	 */
	@RequestMapping("/update/json")
	public @ResponseBody
	ReturnDatas saveorupdate(Model model,YebRate yebRate,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			Finder finder = new Finder("select * from ").append(Finder.getTableName(YebRate.class)) ;
			finder.append(" where createDate=:createDate") ;
			finder.setParam("createDate", com.cz.yingpu.frame.util.DateUtils.formatDate(DateUtils.addDays(new Date(),1))) ;
			YebRate result = yebRateService.queryForObject(finder,YebRate.class) ;

			if(yebRate.getRate() != null){
				if(result != null){
					result.setRate(yebRate.getRate());
					yebRateService.update(result) ;
				}else {
					yebRate.setCreateDate(DateUtils.addDays(new Date(),1));
					yebRateService.saveorupdate(yebRate);
				}
			}

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
	@RequestMapping(value = "/update/look")
	public String updatepre(Model model,HttpServletRequest request,HttpServletResponse response)  throws Exception{
		ReturnDatas returnObject = lookjson(model, request, response);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/yebrate/yebrateCru";
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
				yebRateService.deleteById(id,YebRate.class);
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
			yebRateService.deleteByIds(ids,YebRate.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}

}
