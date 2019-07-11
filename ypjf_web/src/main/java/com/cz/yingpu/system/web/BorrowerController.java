package  com.cz.yingpu.system.web;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.frame.util.fuyou.ConfigReader;
import com.cz.yingpu.system.exception.PhoneExistException;
import com.cz.yingpu.system.fuyoudata.WebRegReqData;
import com.cz.yingpu.system.service.FuiouService;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.system.entity.Borrower;
import com.cz.yingpu.system.service.IBorrowerService;
import com.cz.yingpu.frame.controller.BaseController;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:45
 * @see com.cz.yingpu.system.web.Borrower
 */
@Controller
@RequestMapping(value="/system/borrower")
public class BorrowerController  extends BaseController {
	@Resource
	private IBorrowerService borrowerService;
	@Resource
	private FuiouService fuiouService;
	private String listurl="/borrower/borrowerList";
	
	private String randomCode = "";
	   
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param borrower
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model,Borrower borrower) 
			throws Exception {
		System.out.println(borrower.getName()+"1111111111111111");
//		String a="王少晶";
//		borrower.setLegalPerson(a);
		ReturnDatas returnObject = listjson(request, model, borrower);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
			return listurl;
		
		
	}
	
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param borrower
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,Borrower borrower) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List<Borrower> datas=borrowerService.findListDataByFinder(null,page,Borrower.class,borrower);
			returnObject.setQueryBean(borrower);
		returnObject.setPage(page);
		returnObject.setData(datas);

		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,Borrower borrower) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = borrowerService.findDataExportExcel(null,listurl, page,Borrower.class,borrower);
		String fileName="borrower"+GlobalStatic.excelext;
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
		return "/borrower/borrowerLook";
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
		  Borrower borrower = borrowerService.findBorrowerById(id);
		   returnObject.setData(borrower);
		}else{
		returnObject.setStatus(ReturnDatas.ERROR);
		}
		return returnObject;
		
	}

	@RequestMapping("/code/json")
	public @ResponseBody
	String findcode(Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		int random = (int)((Math.random()*9+1)*100000);
		randomCode = "JQDJKR" + random;
		Finder finder = new Finder("SELECT * FROM t_borrower WHERE borrowerCode=:borrowerCode");
		finder.setParam("borrowerCode",randomCode);
		List<Borrower> borrowers = borrowerService.queryForList(finder, Borrower.class);
		while (borrowers.size() != 0){
			random = (int)((Math.random()*9+1)*100000);
			randomCode = "JQDJKR" + random;
			finder.setParam("borrowerCode",randomCode);
			borrowers = borrowerService.queryForList(finder, Borrower.class);
		}
		return randomCode;
	}
	/**
	 * 新增/修改 操作吗,返回json格式数据
	 * 
	 */
	@RequestMapping("/update")
	public @ResponseBody
	ReturnDatas saveorupdate(Model model,Borrower borrower,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage("数据修改成功!新增借款人请前去业务管理的用户管理里分配角色");
		try {
		
			borrower.setBorrowerCode(randomCode);
			borrowerService.saveorupdate(borrower);
			
		}catch (PhoneExistException e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("该手机号已注册");
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
		return "/borrower/borrowerCru";
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
				borrowerService.deleteById(id,Borrower.class);
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
			borrowerService.deleteByIds(ids,Borrower.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}


	/**
	 * 借款人新用户注册富友
	 * @param request
	 * @param response
	 * @throws Exception
	 *
	 * /system/fuiou/webReg
	 */
	@RequestMapping("/webReg/json")
	public void  webReg(Borrower borrower, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Borrower borrowerUser = borrowerService.findBorrowerById(borrower.getId());
		WebRegReqData webRegReqData = new WebRegReqData();
		webRegReqData.setVer(ConfigReader.getConfig("ver"));
		webRegReqData.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
		webRegReqData.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(),"yyyyMMddHHmmss")+getRand());
		webRegReqData.setUser_id_from(borrowerUser.getId().toString());
		webRegReqData.setMobile_no(borrowerUser.getLegalPersonPhone());
		webRegReqData.setCertif_tp("0");
		webRegReqData.setCertif_id(borrowerUser.getCertNo());
//		webRegReqData.setBack_notify_url(ConfigReader.getConfig("webReg_notify_url"));
		webRegReqData.setPage_notify_url(ConfigReader.getConfig("adminWebReg_page_notify_url"));
		FuiouService.webReg(webRegReqData,response);
	}

	public String getRand(){
		String x = "";
		Random r = new Random();
		x = r.nextInt(9999) + "";
		if (x.length() < 5) {
			for (int i = 0; i <= 5 - x.length(); i++) {
				x += "0";
			}
		}
		return x;
	}

}
