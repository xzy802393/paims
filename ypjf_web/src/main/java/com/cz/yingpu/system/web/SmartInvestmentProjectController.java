package com.cz.yingpu.system.web;

import com.cz.yingpu.frame.common.SessionUser;
import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.system.entity.BorrowUser;
import com.cz.yingpu.system.entity.Project;
import com.cz.yingpu.system.entity.ProjectCategory;
import com.cz.yingpu.system.entity.SmartInvestmentProject;
import com.cz.yingpu.system.exception.MoneyNotEnoughException;
import com.cz.yingpu.system.exception.ParameterErrorException;
import com.cz.yingpu.system.exception.PhoneNotExistException;
import com.cz.yingpu.system.exception.RecommendExistException;
import com.cz.yingpu.system.fuyoudata.CommonRspData;
import com.cz.yingpu.system.service.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.math.BigDecimal;
import java.util.*;


/**
 * @author springrain<Auto       generate>
 * @version 2017-03-21 15:09:47
 * @copyright {@link 9iu.org}
 * @see com.cz.yingpu.system.web.Project
 */
@Controller
@RequestMapping(value = "/system/sip")
public class SmartInvestmentProjectController extends BaseController {
	@Resource
	private IProjectService projectService;
	@Resource
	private IProjectCategoryService categoryService;
	@Resource
	private JPushService jPushService;
	@Resource
	private IUserService userServive;
	@Resource
	private IBaseSpringrainService baseSpringrainService;

	private String listurl = "/smartinvest/project-list";

	/**
	 * 进入修改页面,APP端可以调用 lookjson 获取json格式数据
	 */
	@RequestMapping(value = "/list")
	public String list(Model model, HttpServletRequest request, SmartInvestmentProject project) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		Page page = newPage(request);

		try {
			List<SmartInvestmentProject> projectList = baseSpringrainService.queryForListByEntity(
					project, page);
			returnObject.setData(projectList);
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
		}

		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return listurl;
	}


	/**
	 * 新增/修改 操作吗,返回json格式数据
	 */
	@RequestMapping("/save")
	public @ResponseBody
	ReturnDatas saveorupdate(Model model, SmartInvestmentProject project,
							 HttpServletRequest request, HttpServletResponse response) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);

		try {
			if (project != null) {
				if (project.getInterestRate() != null) {
					project.setInterestRate(new BigDecimal(project.getInterestRate()).divide(new BigDecimal(100)).doubleValue());
				}
				if (project.getId() == null) {
					project.setRemainsAmount(project.getTotalAmount());
					project.setCreateTime(new Date());
					project.setStatus(2);
					project.setRepaymentTimes(1);
					baseSpringrainService.save(project, true);
				} else {
					baseSpringrainService.update(project, true);
				}
			}

           /* //判断时间是否符合T+1规则
            Date endTime = null;  //判断标准
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(project.getStartTime());
            int weekday = calendar.get(Calendar.DAY_OF_WEEK);
            if (weekday > 5 || weekday == 1) {  //判断今天是否we是周五/六/日
                Calendar monday = DateUtils.getNextMonday(calendar);
                endTime = org.apache.commons.lang.time.DateUtils.addDays(monday.getTime(), 1);
            } else {  //否则就T+1
                endTime = org.apache.commons.lang.time.DateUtils.addDays(project.getStartTime(), 2);
            }

            //开始判断
            if (project.getRaiseEndTime().before(endTime)) {
                returnObject.setStatus(ReturnDatas.ERROR);
                returnObject.setMessage("流标时间必须为上线时间的T+1");
            }*/

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
	@RequestMapping(value = "/detail")
	public String updatepre(Model model, Integer id) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();

		try {
			if (id != null) {
				SmartInvestmentProject project = baseSpringrainService.findById(
						id, SmartInvestmentProject.class);
				returnObject.setData(project);
			}
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
		}

		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/smartinvest/smart_invest_project";
	}

	/**
	 * 删除操作
	 */
	@RequestMapping(value = "/delete")
	public @ResponseBody
	ReturnDatas delete(HttpServletRequest request) throws Exception {
		// 执行删除
		try {
			String strId = request.getParameter("id");
			Integer id = null;
			if (StringUtils.isNotBlank(strId)) {
				id = Integer.valueOf(strId.trim());
				baseSpringrainService.deleteById(id, SmartInvestmentProject.class);
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
	 */
	@RequestMapping("/delete/more")
	public @ResponseBody
	ReturnDatas deleteMore(HttpServletRequest request, Model model) {
		String records = request.getParameter("records");
		if (StringUtils.isBlank(records)) {
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
			projectService.deleteByIds(ids, Project.class);
		} catch (Exception e) {
			return new ReturnDatas(ReturnDatas.ERROR,
					MessageUtils.DELETE_ALL_FAIL);
		}
		return new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_ALL_SUCCESS);


	}

	/**
	 * 放款
	 */
	@RequestMapping("/siploan")
	public @ResponseBody
	String siploan(HttpServletRequest request, Model model) throws Exception {
		String strId = request.getParameter("id");
		String strTotalAmount = request.getParameter("totalAmount");
		Integer id = null;
		double totalAmount = 0D;
		if(StringUtils.isNotBlank(strId)){
			id = Integer.valueOf(strId);
		}
		if(StringUtils.isNotBlank(strTotalAmount)){
			totalAmount = Double.valueOf(strTotalAmount);
		}
		projectService.siploan(id,totalAmount);

		return listurl;
	}

}