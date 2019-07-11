package  com.cz.yingpu.system.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
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
import com.cz.yingpu.system.entity.WithdrawalsHistory;
import com.cz.yingpu.system.service.IAppUserService;
import com.cz.yingpu.system.service.IWithdrawHistoryService;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:44
 * @see com.cz.yingpu.system.web.WithdrawalsHistory
 */
@Controller
@RequestMapping(value="/system/withdraw")
public class WithdrawController  extends BaseController {
	@Resource
	private IWithdrawHistoryService withdrawHistoryService;
	
	private String listurl="/withdraw/history-list";
	
	@Resource
	private IAppUserService appUserService;
	
	   
	/**
	 * 抽奖历史记录
	 * 
	 * @param request
	 * @param model
	 * @param bank
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("history/list")
	public String list(HttpServletRequest request, Model model,WithdrawalsHistory bank, String userName,
			Date startTime, Date endTime) 
			throws Exception {
		ReturnDatas returnObject = listjson(request, model, bank, userName, startTime, endTime);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}
	
	
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 * 
	 * @param request
	 * @param model
	 * @param bank
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("history/list/export/json")
	public String listExport(HttpServletRequest request, Model model,WithdrawalsHistory bank, String userName,
			Date startTime, Date endTime, HttpServletResponse res) 
			throws Exception {
		
		ReturnDatas rt = listjson(request, model, bank, userName, startTime, endTime);
		downFile(res, withdrawHistoryService.findDataExportExcel((List) rt.getData(), listurl, rt.getPage(), null),
				"导出.xls", true);
		
		return null;
	}
	
	
	
	@RequestMapping("history/audit/pass/json")
	@ResponseBody
	public Object auditPass(HttpServletRequest request, Model model,WithdrawalsHistory bank) 
			throws Exception {
		
		if (bank != null) {
			try {
				bank.setStatus(2);
				bank.setAuditingTime(new Date());
				withdrawHistoryService.updateValidValue(bank);
			} 
			catch(Exception e) {
				e.printStackTrace();
				return ReturnDatas.getErrorReturnDatas();
			}
		}
		
		return ReturnDatas.getSuccessReturnDatas();
	}
	
	
	@RequestMapping("history/audit/reject/json")
	@ResponseBody
	public Object auditReject(HttpServletRequest request, Model model,WithdrawalsHistory bank) 
			throws Exception {
		if (bank != null) {
			try {
				WithdrawalsHistory w = withdrawHistoryService.findById(bank.getId(), bank.getClass());
				if (w == null) {
					throw new Exception("");
				}

				Finder f = new Finder("UPDATE t_app_user SET commission = commission + :wa WHERE id = :id");
				f.setParam("wa", w.getAmount());
				f.setParam("id", w.getUserid());
				appUserService.update(f);
				
				bank.setStatus(3);
				bank.setAuditingTime(new Date());
				withdrawHistoryService.updateValidValue(bank);
			} 
			catch(Exception e) {
				e.printStackTrace();
				return ReturnDatas.getErrorReturnDatas();
			}
		}
		
		return ReturnDatas.getSuccessReturnDatas();
	}
	
	

	
	/**
	 * 抽奖历史记录
	 * 
	 * @param request
	 * @param model
	 * @param bank
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,WithdrawalsHistory bank, String userName,
			Date startTime, Date endTime) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		page.setOrder("FIELD(wh.status,'1','3','2'),wh.`createTime`DESC");
		page.setSort("wh.`createTime`DESC");
		// ==执行分页查询
		
		Map<String, Object> map = new HashMap<>();
		Finder finder = new Finder("SELECT au.realName, au.phone, wh.* FROM t_withdrawals_history wh INNER JOIN t_app_user au ON  au.id = wh.userid "); 
	
		if (StringUtils.isNotBlank(userName)) {
			finder.append(" AND au.realName LIKE :name");
			finder.setParam("name", '%' + userName + '%');
		}
		
		if (startTime != null && endTime != null) {
			finder.append(" AND wh.createTime BETWEEN :start AND :end");
			finder.setParam("start", startTime);
			finder.setParam("end", endTime);	
		}
		
		if (bank.getStatus() != null) {
			finder.append(" AND wh.status = :s");
			finder.setParam("s", bank.getStatus());
		}

		List<Map<String, Object>> datas = new ArrayList<>();
		try {
			datas = withdrawHistoryService.queryForList(finder, page);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			map.put("startTime", startTime);
			map.put("endTime", endTime);
			map.put("userName", userName);
			map.put("status", new String(bank.getStatus() == null ? "" : bank.getStatus().toString()));
			
			returnObject.setQueryBean(map);
			returnObject.setMap(map);
			returnObject.setPage(page);
			returnObject.setData(datas);
		}
		
		return returnObject;
	}
	
	@RequestMapping("/list/export")
	public void listexport(HttpServletRequest request,HttpServletResponse response, Model model,WithdrawalsHistory bank) throws Exception{
		// ==构造分页请求
		Page page = newPage(request);
	
		File file = withdrawHistoryService.findDataExportExcel(null,listurl, page,WithdrawalsHistory.class,bank);
		String fileName="bank"+GlobalStatic.excelext;
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
		return "/system/bank/bankLook";
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
			 WithdrawalsHistory bank = withdrawHistoryService.findById(id, WithdrawalsHistory.class);
		   returnObject.setData(bank);
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
	ReturnDatas saveorupdate(Model model,WithdrawalsHistory bank,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
		
		
			withdrawHistoryService.update(bank,true) ;
			
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
		return "/bank/bankCru";
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
				withdrawHistoryService.deleteById(id,WithdrawalsHistory.class);
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
			withdrawHistoryService.deleteByIds(ids,WithdrawalsHistory.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);
		
		
	}

}

