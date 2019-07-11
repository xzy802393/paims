package  com.cz.yingpu.system.web;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.system.entity.SysParamBean;
import com.cz.yingpu.system.exception.SignExistException;
import com.cz.yingpu.system.exception.SignLimitNotEnoughException;
import com.cz.yingpu.system.service.ISysSysparamService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.system.entity.UserSignHis;
import com.cz.yingpu.system.service.IUserSignHisService;
import com.cz.yingpu.frame.controller.BaseController;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:50
 * @see com.cz.yingpu.system.web.UserSignHis
 */
@Controller
@RequestMapping(value="/system/usersignhis")
public class UserSignHisController  extends BaseController {
	@Resource
	private IUserSignHisService userSignHisService;
	@Resource
	private ISysSysparamService sysSysparamService;
	
	private String listurl="/usersignhis/usersignhisList";
	
	
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param userSignHis
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,UserSignHis userSignHis) 
			throws Exception {
		ReturnDatas returnObject = listjson(request, model, userSignHis);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param userSignHis
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,UserSignHis userSignHis) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
//		List<UserSignHis> datas=userSignHisService.findListDataByFinder(null,page,UserSignHis.class,userSignHis);
		Map<String,Object> values = new HashMap<String,Object>() ;
		if(StringUtils.isNotBlank(userSignHis.getUserName())){
			values.put("userName",userSignHis.getUserName()) ;
		}
		if(StringUtils.isNotBlank(userSignHis.getUserPhone())){
			values.put("userPhone",userSignHis.getUserPhone()) ;
		}
		if(StringUtils.isNotBlank(userSignHis.getIsSend())){
			values.put("isSend",userSignHis.getIsSend()) ;
		}
		if(null != userSignHis.getCreateTime()){
			values.put("createTime", DateUtils.convertDate2String("yyyy-MM-dd",userSignHis.getCreateTime())) ;
		}
		List list = null ;
		try {
			list = userSignHisService.listUserSignHis(page,values) ;
		}catch (Exception e){
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
//			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
			returnObject.setQueryBean(userSignHis);
		returnObject.setPage(page);
		returnObject.setData(list);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,UserSignHis userSignHis) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = userSignHisService.findDataExportExcel(null,listurl, page,UserSignHis.class,userSignHis);
		String fileName="userSignHis"+GlobalStatic.excelext;
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
		return "/system/usersignhis/usersignhisLook";
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
		  UserSignHis userSignHis = userSignHisService.findUserSignHisById(id);
		   returnObject.setData(userSignHis);
		}else{
		returnObject.setStatus(ReturnDatas.ERROR);
		}
		return returnObject;
		
	}
	
	
	/**
     *
	 * 新增/修改 操作吗,返回json格式数据
	 * 
	 */
	@RequestMapping("/update")
	public @ResponseBody
	ReturnDatas saveorupdate(Model model,UserSignHis userSignHis,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage("签到成功");

		try {
		
			userSignHisService.sign(userSignHis.getUserId(),userSignHis.getType(),userSignHis.getOsType());
			
		} catch (SignExistException e) {
			String errorMessage = e.getLocalizedMessage();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("你已经签到过了，请勿重复");
		} catch (SignLimitNotEnoughException e) {
			String errorMessage = e.getLocalizedMessage();
			returnObject.setStatus(ReturnDatas.ERROR);
			SysParamBean datas = sysSysparamService.findParamBean();
			returnObject.setMessage("正在投资的金额大于等于"+datas.getSignLimitAmount()+"元时，才可以签到。");
		} catch (Exception e) {
			e.printStackTrace();
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("签到失败");
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
		return "/system/usersignhis/usersignhisCru";
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
				userSignHisService.deleteById(id,UserSignHis.class);
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
			userSignHisService.deleteByIds(ids,UserSignHis.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
	}


}
