package  com.cz.yingpu.system.web;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.MessageUtils;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.Announce;
import com.cz.yingpu.system.entity.ContractSample;
import com.cz.yingpu.system.service.IAnnounceService;
import com.cz.yingpu.system.service.impl.ContractSampleServiceImpl;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:43
 * @see com.cz.yingpu.system.web.ContractSample
 */
@Controller
@RequestMapping(value="/system/contractsample")
public class ContractSampleController  extends BaseController {
	@Resource
	private IAnnounceService contractSampleService;
	
	private String listurl="/announce/announceList";
	
	
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param ContractSample
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,ContractSample ContractSample) 
			throws Exception {
		ReturnDatas returnObject = listjson(request, model, ContractSample);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param ContractSample
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,ContractSample ContractSample) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
//		page.setPageSize(8);
//		page.setOrder("weight");
//		page.setSort("DESC");
		page.setOrder("`weight`DESC,`postTime`DESC");
		page.setSort("`postTime`DESC");
		// ==执行分页查询
		List<ContractSample> datas=contractSampleService.findListDataByFinder(null,page,ContractSample.class,ContractSample);
			returnObject.setQueryBean(ContractSample);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,ContractSample ContractSample) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = contractSampleService.findDataExportExcel(null,listurl, page,ContractSample.class,ContractSample);
		String fileName="ContractSample"+GlobalStatic.excelext;
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
		return "/system/ContractSample/ContractSampleLook";
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
		  ContractSample ContractSample =  contractSampleService.findContractSampleById(id);
		   Announce a = new Announce();
		   a.setTitle(ContractSample.getTitle());
		   a.setDescr(ContractSample.getDescr());
		   a.setCreateTime(ContractSample.getCreateDate());
		   a.setId(ContractSample.getId());
		   a.setContent(ContractSample.getContent());
		   a.setIcon(ContractSample.getPic());
		   a.setWeight(ContractSample.getWeight());
		   a.setKeyword(ContractSample.getKeyword());
		   a.setPostTime(ContractSample.getPostTime());
		   returnObject.setData(a);
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
	ReturnDatas saveorupdate(Model model,ContractSample ContractSample, Announce a, HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			
			ContractSample.setPic(a.getIcon());
			ContractSample.setCreateDate(a.getCreateTime());
			//ContractSample.setCreateDate(a.getCreateTime());
			if(ContractSample != null && ContractSample.getId() == null)
				ContractSample.setCreateDate( new Date());
			

			contractSampleService.saveorupdate(ContractSample);
			//开始推送
//			JPushUtil.sendAllPushNotification();
			
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
		return "/system/ContractSample/ContractSampleCru";
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
				contractSampleService.deleteById(id,ContractSample.class);
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
			contractSampleService.deleteByIds(ids,ContractSample.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}

}
