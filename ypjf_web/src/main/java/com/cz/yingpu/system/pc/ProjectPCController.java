package com.cz.yingpu.system.pc;

import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.RepayWay;
import com.cz.yingpu.system.service.impl.SmartProjectInvestmentServiceImpl;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.system.entity.ProjectCategory;
import com.cz.yingpu.system.entity.ProjectDeadline;
import com.cz.yingpu.system.service.IPCProjectListService;
import com.cz.yingpu.system.service.IProjectCategoryService;
import com.cz.yingpu.system.service.IProjectDeadlineService;
import com.cz.yingpu.system.service.IUserProjectService;

/**
 * 用户管理Controller,PC和手机浏览器用ACE自适应,APP提供JSON格式的数据接口
 *
 * @author 9iu.org<Autogenerate>
 * @version 2017-10-09 11:36:47
 * @copyright {@link 9iu.org}
 * @see
 */
@Controller
@RequestMapping("pc/project")
public class ProjectPCController extends BaseController {
    @Resource
    IPCProjectListService pCProjectListService;

    @Resource
    IProjectCategoryService projectCategoryService;

    @Resource
    IProjectDeadlineService projectDeadlineService;

    @Resource
    IUserProjectService userProjectService;

    @Resource
    HttpServletRequest request;

    @RequestMapping(value = "invest")
    public String index() {
        return "pc/html/invest";
    }

    @RequestMapping("list")
    public String list(String categoryId, String deadLine, String estimatedAnnualRate, String totalAmount, HttpServletRequest r, String repayment) {

        int cid = StringUtil.str2Int(categoryId, 0);
        if (cid < 1) {
            //
        }
        List<?> list = new ArrayList<>();
        List<ProjectCategory> cates = new ArrayList<>();
        List<ProjectDeadline> dls = new ArrayList<>();
        List<RepayWay> repay = new ArrayList<>();
        List<Map<String, Object>> investers = new ArrayList<>();
        Map<String, String> params = new HashMap<>();
        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

        Finder finder = new Finder("SELECT au.realName, au.phone, up.money, p.name FROM t_user_project up, t_project p, t_app_user au WHERE au.id = up.userId AND up.projectId = p.id ");
        Page page = newPage(r);
        Page sortPage = new Page(1);
        sortPage.setPageSize(30);
        sortPage.setSort("DESC");
        sortPage.setOrder("up.createTime");

        page.setOrder("FIELD(p.STATUS,2,5,3,4,1),(p.financingAmount/p.totalAmount)DESC,`createTime`DESC");
        page.setSort("asdfa`DESC`");
        page.setPageSize(8);

        params.put("categoryId", categoryId);
        params.put("deadLine", deadLine);
        params.put("estimatedAnnualRate", estimatedAnnualRate);
        params.put("totalAmount", totalAmount);
        params.put("repayment", repayment);
        params.put("status", "2,3,5");
        params.put("userId", user != null && user.getId() != null ? user.getId().toString() : "0");

        // 未登录
        if (user == null) {
            //params.put("status", "2");
        }
        try {
            list = pCProjectListService.findProjectDataByCondition(params, page);
            cates = projectCategoryService.findListDataByFinder(null, null, ProjectCategory.class, new ProjectCategory());
            repay = projectCategoryService.findListDataByFinder(null, null, RepayWay.class, new RepayWay());
            dls = projectDeadlineService.findListDataByFinder(null, null, ProjectDeadline.class, new ProjectDeadline());
            investers = pCProjectListService.queryForList(finder, sortPage);
        } catch (Throwable e) {
            e.printStackTrace();
        }
        r.setAttribute("list", list);
        r.setAttribute("categories", cates);
        r.setAttribute("repayment", repay);
        r.setAttribute("deadlines", dls);
        r.setAttribute("page", page);
        r.setAttribute("investers", investers);

//        return "pc/html/invest";
        return "pc/html/my-lend";
    }

    @RequestMapping("investable/count/json")
    @ResponseBody
    public ReturnDatas investableCount() {
        Finder f = new Finder("SELECT COUNT(id) FROM t_project WHERE status = 2");
        List<Map<String, Object>> data = null;
        ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();

        try {
            data = pCProjectListService.queryForList(f);
        } catch (Exception e) {
            e.printStackTrace();
        }

        rt.setData(data);

        return rt;
    }

    /**
     * 投资页面查询
     *
     * @param request
     * @return
     */
    @RequestMapping("/findProject")
    public String findProject(HttpServletRequest request) throws Exception {
        if (null == (request.getParameter("projectType")) || request.getParameter("projectType").equals("0")) {
            List<Map<String, Object>> newProject = new ArrayList<>();
            Finder finderProject = new Finder("select * from t_project where isNew=:isnew and status IN(2,5) and type=:type ORDER BY deadLine");
            finderProject.setParam("isnew", "是");
//            finderProject.setParam("status", "2");
            finderProject.setParam("type","1");
            Page page = newPage(request);
            page.setPageSize(2);
            page.setSort("DESC");
            page.setOrder("createTime");
            newProject = pCProjectListService.queryForList(finderProject, page);
            request.setAttribute("newProject", newProject);
            request.setAttribute("page", page);
        }
        return "pc/html/my-lend-new";
    }

    @RequestMapping("/findZhai")
    public String 	findZhai(String sort, String deadline, String sortType, HttpServletRequest request) {
		Finder debtFinder = new Finder("SELECT p.*, sidp.assignedAmount, sidp.investmentAmount, sio.status, sidai.id itemId,")
				.append(" DATEDIFF(:curDate, sidp.startDate) holdDays, DATEDIFF(p.endTitme, :curDate) remainsDays,")
				.append(" @m := DATEDIFF(:curDate, IFNULL(sidp.lastInterestDay, sidp.startDate)) holdDaysCurMonth,")
				.append(" sidai.interest debtInterest")
				.append(" FROM t_smart_investment_debt_assignment sida, t_smart_investment_debt_assignment_item sidai,")
				.append(" t_smart_investment_dispersed_project sidp, t_project p, t_smart_investment_order sio")
				.append(" WHERE sidai.debtAssignmentId = sida.id AND sidai.dispersedProjectId = sidp.id")
				.append(" AND p.id = sidp.projectId AND sida.status = 1 AND sidp.siOrderid = sio.id")
				.setParam("curDate", new Date());


		if (deadline != null && deadline.contains("-")) {
			String[] deadlineArr = deadline.split("-");
			debtFinder.append(" AND p.deadline BETWEEN :a AND :b")
					.setParam("a", deadlineArr[0])
					.setParam("b", deadlineArr[1]);
		}
		if (StringUtils.isNotBlank(sort)) {
			String orderBySqlTpl = " ORDER BY %s %s",
					orderBySql = "",
					orderBy = "",
					sortBy = (String) ObjectUtils.defaultIfNull(sortType, "DESC");
			switch(sort) {
				case "rate":
					orderBy = "p.estimatedAnnualRate";
					break;
				case "deadline":
					orderBy = "p.deadline";
					break;
				case "premium":
					orderBy = "@i";
					break;

			}
			orderBySql = String.format(orderBySqlTpl, orderBy, sortBy);
			debtFinder.append(orderBySql);
		}


		Page p = newPage(request);
		List<?> list = null;
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		try {
			debtFinder.setEscapeSql(false);
			list = pCProjectListService.queryForList(debtFinder, p);
		}
		catch (Exception e) {
			e.printStackTrace();
		}


		rt.setPage(p);
		rt.setData(list);
		request.setAttribute("data", rt);

        return "pc/html/my-lend-zhai";
    }

	@RequestMapping("/debt/receive/confirm")
	public String debtReceive(Integer id, HttpServletRequest request) {
		Page p = newPage(request);
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		Finder finder = new Finder("SELECT p.*, dp.earningRate, da.expiresTime, dp.investmentAmount, dp.assignedAmount, dai.interest,  dp.id dpId, ")
				.append("DATEDIFF(:date, IFNULL(lastInterestDay, startDate)) holdDays ")
				.append("FROM t_smart_investment_debt_assignment_item dai, t_smart_investment_debt_assignment da, ")
				.append("t_smart_investment_dispersed_project dp, t_project p ")
				.append("WHERE dai.dispersedProjectId = dp.id AND dp.projectId = p.id ")
				.append("AND dai.id = :id AND da.id = dai.debtAssignmentId ")
				.setParam("id", id)
		        .setParam("date", SmartProjectInvestmentServiceImpl.curDateStr());

		try {
			rt.setData(pCProjectListService.queryForObject(finder));
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		rt.setPage(p);
		request.setAttribute("data", rt.getData());

		return "pc/my-invest/zhaiQuanZhuanRang";
	}
}
