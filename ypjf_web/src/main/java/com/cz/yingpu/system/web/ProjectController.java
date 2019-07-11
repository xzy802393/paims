package com.cz.yingpu.system.web;

import com.cz.yingpu.frame.common.SessionUser;
import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.system.entity.*;
import com.cz.yingpu.system.exception.MoneyNotEnoughException;
import com.cz.yingpu.system.exception.ParameterErrorException;
import com.cz.yingpu.system.exception.PhoneNotExistException;
import com.cz.yingpu.system.exception.RecommendExistException;
import com.cz.yingpu.system.fuyoudata.CommonRspData;
import com.cz.yingpu.system.service.*;
import org.apache.commons.lang3.ObjectUtils;
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
 * @see com.cz.yingpu.system.web
 */
@Controller
@RequestMapping(value = "/system/project")
public class ProjectController extends BaseController {
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

    @Resource
	private ISmartProjectInvestmentService smartProjectInvestmentService;

    private String listurl = "/project/projectList";
    private String newlisturl = "/project/newProjectList";
    private String silisturl = "/project/siProjectList";
    private String randomCode = "";


    /**
     * 列表数据,调用listjson方法,保证和app端数据统一
     *
     * @param request
     * @param model
     * @param project
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public String list(HttpServletRequest request, Model model, Project project)
            throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        // ==构造分页请求
        Page page = newPage(request);
        // ==执行分页查询
        Finder finder = new Finder("select p.*,ca.name categoryName from ").append(Finder.getTableName(Project.class)).append(" p left join ").append(Finder.getTableName(ProjectCategory.class)).append(" ca ");
        finder.append("on p.categoryId = ca.id  where 1=1 and p.isready=0 AND p.isNew <> '是' AND p.type = 1");
        if (StringUtils.isNotBlank(project.getName())) {
            finder.append(" and p.name = :name");
            finder.setParam("name", project.getName());
            project.setName(null);
        }
        finder.setEscapeSql(false);

        List datas = projectService.findListDataByFinder(finder, page, Project.class, project);
        returnObject.setQueryBean(project);
        returnObject.setPage(page);
        returnObject.setData(datas);
        System.out.println(datas);
        model.addAttribute(GlobalStatic.returnDatas, returnObject);
        return listurl;
    }

	@RequestMapping("/new/list")
	public String newlist(HttpServletRequest request, Model model, Project project)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		Finder finder = new Finder("select p.*,ca.name categoryName from ").append(Finder.getTableName(Project.class)).append(" p left join ").append(Finder.getTableName(ProjectCategory.class)).append(" ca ");
		finder.append("on p.categoryId = ca.id  where 1=1 and p.isready=0 and p.isNew = '是' AND p.type = 1");
		finder.setEscapeSql(false);
		if (StringUtils.isNotBlank(project.getName())) {
			finder.append(" and p.name = :name");
			finder.setParam("name", project.getName());
			project.setName(null);
		}

		List datas = projectService.findListDataByFinder(finder, page, Project.class, project);
		returnObject.setQueryBean(project);
		returnObject.setPage(page);
		returnObject.setData(datas);
		System.out.println(datas);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return newlisturl;
	}

	@RequestMapping("/si/list")
	public String silist(HttpServletRequest request, Model model, Project project)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		Finder finder = new Finder("select (SELECT SUM(investmentAmount) FROM t_smart_investment_dispersed_project WHERE isDummy = 0 AND projectId = p.id) realAmount,")
				.append("(SELECT SUM(investmentAmount) FROM t_smart_investment_dispersed_project WHERE isDummy = 1 AND projectId = p.id) dummyAmount,")
				.append("p.*,ca.name categoryName from ")
				.append(Finder.getTableName(Project.class)).append(" p left join ")
				.append(Finder.getTableName(ProjectCategory.class)).append(" ca ")
				.append("on p.categoryId = ca.id  where 1=1 and p.isready=0 and p.type = 2");

		if (StringUtils.isNotBlank(project.getName())) {
			finder.append(" and p.name = :name");
			finder.setParam("name", project.getName());
			project.setName(null);
		}

		List datas = projectService.findListDataByFinder(finder, page, Project.class, project);
		returnObject.setQueryBean(project);
		returnObject.setPage(page);
		returnObject.setData(datas);
		System.out.println(datas);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return silisturl;
	}

    /**
     * 列表数据,调用listjson方法,保证和app端数据统一
     *
     * @param request
     * @param model
     * @param project
     * @return
     * @throws Exception
     */
    @RequestMapping("/listis")
    public String list1(HttpServletRequest request, Model model, Project project)
            throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        // ==构造分页请求
        Page page = newPage(request);
        // ==执行分页查询
        Finder finder = new Finder("select p.*,ca.name categoryName from ").append(Finder.getTableName(Project.class)).append(" p left join ").append(Finder.getTableName(ProjectCategory.class)).append(" ca ");
        finder.append("on p.categoryId = ca.id  where 1=1 and p.isready=1");
        if (StringUtils.isNotBlank(project.getName())) {
            finder.append(" and p.name = :name");
            finder.setParam("name", project.getName());
            project.setName(null);
        }

        List datas = projectService.findListDataByFinder(finder, page, Project.class, project);
        returnObject.setQueryBean(project);
        returnObject.setPage(page);
        returnObject.setData(datas);
        System.out.println(datas);
        model.addAttribute(GlobalStatic.returnDatas, returnObject);
        return "/project/projectLists";
    }

    /**
     * 未还款项目列表
     *
     * @param request
     * @param model
     * @param project
     * @return
     * @throws Exception
     */
    @RequestMapping("/norefund/list")
    public String noRefundList(HttpServletRequest request, Model model, Project project)
            throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        // ==构造分页请求
        Page page = newPage(request);
        List list = null;
        project.setRepaymentThis(1);
        try {
            list = projectService.repaymentList(page, project);
            returnObject.setData(list);
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("内部错误");
        }
        returnObject.setQueryBean(project);
        returnObject.setPage(page);
        model.addAttribute(GlobalStatic.returnDatas, returnObject);
        return "/project/norefundList";
    }

    /**
     * 待还款项目列表
     *
     * @param request
     * @param model
     * @param project
     * @return
     * @throws Exception
     */
    @RequestMapping("/repaymentList/list")
    public String repaymentList(HttpServletRequest request, Model model, Project project)
            throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        // ==构造分页请求
        Page page = newPage(request);
        List list = null;
        try {
            com.cz.yingpu.system.entity.User user = userServive.findUserById(SessionUser.getShiroUser().getId());
            project.setBorrowerId(user.getBorrowerId());
			list = projectService.repaymentList(page, project);
            returnObject.setData(list);
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("内部错误");
        }
        returnObject.setQueryBean(project);
        returnObject.setPage(page);
        model.addAttribute(GlobalStatic.returnDatas, returnObject);
        return "/repayment/repaymentList";
    }

	/**
	 * 邀请人还款列表
	 *
	 * @param request
	 * @param model
	 * @param project
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yaoqingrenList/list")
	public String yaoqingrenList(HttpServletRequest request, Model model, AppUser appUser)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		List list = null;
		try {
			//com.cz.yingpu.system.entity.User user = userServive.findUserById(SessionUser.getShiroUser().getId());
			//project.setBorrowerId(user.getBorrowerId());

			list = projectService.yaoqingrenList(page,appUser.getName());
			returnObject.setData(list);
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setPage(page);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/repayment/yaoqingrenList";
	}

	/**
	 * 邀请人分红明细
	 *
	 * @param
	 * @param model
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/inviterList/list")
	public String inviterList(HttpServletRequest request, Model model)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		String proname = request.getParameter("name");
		String yname = request.getParameter("yname");
		String yusercode = request.getParameter("yusercode");
		String bname = request.getParameter("bname");
		String busercode = request.getParameter("busercode");
		Map objectMap = returnObject.getMap();
		Page page = newPage(request);
		List list = null;
		try {
			/*com.cz.yingpu.system.entity.User user = userServive.findUserById(SessionUser.getShiroUser().getId());
			project.setBorrowerId(user.getBorrowerId());*/
			list = projectService.inviterList(page,proname,yname,yusercode,bname,busercode);
			returnObject.setData(list);
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setPage(page);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/repayment/inviterList";
	}

	/**
	 * 邀请人还款
	 *
	 * @param
	 * @param
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/inviter")
	public @ResponseBody
	ReturnDatas inviter(HttpServletRequest request) throws Exception {
		try {
			Integer id = Integer.valueOf(request.getParameter("id"));
			Integer userId = Integer.valueOf(request.getParameter("userId"));

			Double money = Double.valueOf(request.getParameter("staymoney"));
			Double amountPaidOut = Double.valueOf(request.getParameter("amountPaidOut"));
			Double totalmoney = Double.valueOf(request.getParameter("totalmoney"));
			projectService.inviter( id,userId, money , amountPaidOut ,totalmoney);



			return new ReturnDatas(ReturnDatas.SUCCESS,
					MessageUtils.DELETE_SUCCESS);
		} catch (ParameterErrorException e) {
			return new ReturnDatas(ReturnDatas.WARNING, "参数缺失");
		} catch (PhoneNotExistException e) {
			return new ReturnDatas(ReturnDatas.ERROR, "你的手机号还没有开通富友账户，请开通");
		} catch (MoneyNotEnoughException e) {
			return new ReturnDatas(ReturnDatas.WARNING, "账户余额不足，请充值");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}

	/**
	 * 邀请人分红明细
	 *
	 * @param request
	 * @param model
	 * @param project
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/inviterList/export")
	public void inviterListExport(HttpServletRequest request,HttpServletResponse response ,Model model)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		String proname = request.getParameter("name");
		String yname = request.getParameter("yname");
		String yusercode = request.getParameter("yusercode");
		String bname = request.getParameter("bname");
		String busercode = request.getParameter("busercode");
		Page page = newPage(request);
		page.setPageSize(10000);
		List list = null;
		try {
			//com.cz.yingpu.system.entity.User user = userServive.findUserById(SessionUser.getShiroUser().getId());
			//project.setBorrowerId(user.getBorrowerId());
			list = projectService.inviterList(page,proname,yname,yusercode,bname,busercode);
			File file = projectService.findDataExportExcel(list, "/repayment/inviterList", page, Project.class.newInstance());
			downFile(response, file, "邀请人分红明细.xls", true);
			returnObject.setData(list);
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setPage(page);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
	}
    /**
     * 待还款项目列表
     *
     * @param request
     * @param model
     * @param project
     * @return
     * @throws Exception
     */
    @RequestMapping("/repaymentList/list/export")
    public void repaymentListExport(HttpServletRequest request, HttpServletResponse response, Model model, Project project)
            throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        // ==构造分页请求
        Page page = newPage(request);
        page.setPageSize(10000);
        List list = null;
        try {
            com.cz.yingpu.system.entity.User user = userServive.findUserById(SessionUser.getShiroUser().getId());
            project.setBorrowerId(user.getBorrowerId());

            list = projectService.repaymentList(page, project);
            File file = projectService.findDataExportExcel(list, "/repayment/repaymentList", page, Project.class.newInstance());
            downFile(response, file, "待还款列表.xls", true);
            returnObject.setData(list);
        } catch (Exception e) {
            e.printStackTrace();
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("内部错误");
        }
        returnObject.setQueryBean(project);
        returnObject.setPage(page);
        model.addAttribute(GlobalStatic.returnDatas, returnObject);
    }


    /**
     * json数据,为APP提供数据
     *
     * @param request
     * @param model
     * @param project
     * @return
     * @throws Exception
     */
    @RequestMapping("/list/json")
    public @ResponseBody
    ReturnDatas listjson(HttpServletRequest request, Model model, Project project) throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        // ==构造分页请求
        Page page = newPage(request);
        // ==执行分页查询
        if (project.getDeadLine() != null && project.getDeadLine() == 0) {
            project.setDeadLine(null);
            project.setIsNew("是");
        }

        Finder finder = new Finder("select p.*,ca.name categoryName from ").append(Finder.getTableName(Project.class)).append(" as p left join ").append(Finder.getTableName(ProjectCategory.class)).append(" ca ");
        finder.append("on p.categoryId = ca.id  where 1=1 and p.isready = 0 ");
        page.setSort("desc");
        page.setOrder("p.startTime") /* ,FIELD(p.`status`,2,1,3,5,4) */;
        List datas = projectService.findListDataByFinder(finder, page, Project.class, project);
        //推荐项目查询bean
        Project recommend = new Project();
        recommend.setIsRecommend("是");
        if (StringUtils.isNotBlank(project.getIsNew()) && "是".equals(project.getIsNew())) {
            recommend.setIsNew("是");   //新人专享
        } else {
            recommend.setDeadLine(project.getDeadLine());   //项目期限
        }
        List<Project> projectResults = projectService.queryForListByEntity(recommend, null);
        if (null != projectResults && projectResults.size() > 0) {
            Project projectResult = projectResults.get(0);
            if (null == projectResult) {
                recommend = new Project();
                recommend.setDeadLine(project.getDeadLine());
                page.setOrder(null);
                List data = projectService.findListDataByFinder(null, page, Project.class, recommend);
                if (null != data && data.size() > 0) {
                    projectResult = (Project) data.get(0);
                }

            }
            returnObject.setQueryBean(projectResult);
        }


        returnObject.setPage(page);
        returnObject.setData(datas);
        return returnObject;
    }

    @RequestMapping("/list/export")
    public void listexport(HttpServletRequest request, HttpServletResponse response, Model model, Project project) throws Exception {
        // ==构造分页请求
        Page page = newPage(request);

        File file = projectService.findDataExportExcel(null, listurl, page, Project.class, project);
        String fileName = "project" + GlobalStatic.excelext;
        downFile(response, file, fileName, true);
        return;
    }

	@RequestMapping("/new/list/export")
	public void newlistexport(HttpServletRequest request, HttpServletResponse response, Model model, Project project) throws Exception {
		// ==构造分页请求
		Page page = newPage(request);
		project.setIsNew("是");

		File file = projectService.findDataExportExcel(null, listurl, page, Project.class, project);
		String fileName = "project" + GlobalStatic.excelext;
		downFile(response, file, fileName, true);
		return;
	}

	@RequestMapping("/si/list/export")
	public void silistexport(HttpServletRequest request, HttpServletResponse response, Model model, Project project) throws Exception {
		// ==构造分页请求
		Page page = newPage(request);
		project.setType(2);

		File file = projectService.findDataExportExcel(null, listurl, page, Project.class, project);
		String fileName = "project" + GlobalStatic.excelext;
		downFile(response, file, fileName, true);
		return;
	}

    /**
     * 查看操作,调用APP端lookjson方法
     */
    @RequestMapping(value = "/look")
    public String look(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ReturnDatas returnObject = lookjson(model, request, response);
        model.addAttribute(GlobalStatic.returnDatas, returnObject);
        return "/project/projectLook";
    }


    /**
     * 查看的Json格式数据,为APP端提供数据
     */
    @RequestMapping(value = "/look/json")
    public @ResponseBody
    ReturnDatas lookjson(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        String strId = request.getParameter("id");
        String userId = request.getParameter("userId");
        java.lang.Integer id = null;
        java.lang.Integer uId = null;
        if (StringUtils.isNotBlank(strId)) {
            id = java.lang.Integer.valueOf(strId.trim());
            if (StringUtils.isNotBlank(userId)) {
                uId = Integer.parseInt(userId);
            } else {
                uId = null;
            }
            Project project = projectService.findById(id, uId);
            if (project != null) {
                ProjectCategory category = categoryService.findById(project.getCategoryId(), ProjectCategory.class);
                if (category != null)
                    project.setCategoryName(category.getName());
            }
            BorrowUser bu = new BorrowUser();
            bu.setProjectID(id);
            returnObject.setData(project);
            returnObject.setQueryBean(categoryService.queryForObject(bu));
        } else {
            returnObject.setStatus(ReturnDatas.ERROR);
        }
        return returnObject;

    }

    @RequestMapping("/code/json")
	public @ResponseBody
	String findcode(Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		int random = (int)((Math.random()*9+1)*100000);
		randomCode = "JQD" + random;
		Finder finder = new Finder("SELECT * FROM t_project WHERE code=:code");
		finder.setParam("code",randomCode);
		List<Project> projects = projectService.queryForList(finder, Project.class);

		while(projects.size() != 0){
			random = (int)((Math.random()*9+1)*100000);
			randomCode = "JQD" + random;
			finder.setParam("code",randomCode);
			projects = projectService.queryForList(finder, Project.class);
		}
		return randomCode;
	}


    @InitBinder("bi")
    public void initBinderBorrowerInfo(WebDataBinder binder) {
        binder.setFieldDefaultPrefix("bi.");
    }

    /**
     * 新增/修改 操作吗,返回json格式数据
     */
    @RequestMapping("/update")
    public @ResponseBody
    ReturnDatas saveorupdate(Model model, Project project, @ModelAttribute("bi") BorrowUser bi, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
        String borrowerName = request.getParameter("bi.name");
        if (bi != null) {
            bi.setName(borrowerName);
        }

        try {
            if (project != null) {
                if (project.getId() == null) {
                    System.out.println("开始发标了");
                    System.out.println(project);
                    System.out.println("------------------------");
                    project.setCreateTime(new Date());
                } else {
                    Project p = projectService.findById(project.getId(), Project.class);
                    project.setCreateTime(project.getCreateTime());
                    project.setInterestAdd(p.getInterestAdd());
					project.setInterestAdd(new BigDecimal(project.getInterestAdd()).movePointLeft(2).doubleValue());
					project.setRepayRate(new BigDecimal(project.getRepayRate()).movePointLeft(2).doubleValue());
					project.setEstimatedAnnualRate(new BigDecimal(project.getEstimatedAnnualRate()).movePointLeft(2).doubleValue());

                    BorrowUser bu = new BorrowUser();
                    bu.setProjectID(project.getId());
                    bi.setProjectID(project.getId());
                    bi.setId(null);

                    List<BorrowUser> buList;
                    if ((buList = baseSpringrainService.queryForListByEntity(bu, null)).size() == 0) {
                        baseSpringrainService.save(bi);
                    } else {
                        bi.setId(buList.get(0).getId());
                        baseSpringrainService.update(bi);
                    }
                    projectService.updateValidValue(project);
                    return returnObject;
                }

                project.setCode(randomCode);
				project.setStatus(1);
                project.setRepaymentNum(0);
                project.setRepaymentThis(0);
                project.setSendNum(0);
                project.setIsRecommend("否");
                project.setInterestAdd(new BigDecimal(project.getInterestAdd()).movePointLeft(2).doubleValue());
                project.setRepayRate(new BigDecimal(project.getRepayRate()).movePointLeft(2).doubleValue());
                project.setEstimatedAnnualRate(new BigDecimal(project.getEstimatedAnnualRate()).movePointLeft(2).doubleValue());
                project.setFinancingAmount(project.getTotalAmount());
//				project.setStartTime(org.apache.commons.lang.time.DateUtils.addHours(project.getStartTime(),10));
//				project.setEndTitme(DateUtils.addMonths(project.getStartTime(),project.getDeadLine()));

            }
            System.out.println("项目是" + project);
            //判断时间是否符合T+1规则
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
            if (project.getEndTitme().before(endTime)) {
                returnObject.setStatus(ReturnDatas.ERROR);
                returnObject.setMessage("流标时间必须为上线时间的T+1");
            } else {
                if (project.getRepayRate() < project.getEstimatedAnnualRate()) {
                    returnObject.setStatus(ReturnDatas.ERROR);
                    returnObject.setMessage("还款利率必须大于预计年利率");
                } else {
                    Object o = projectService.saveorupdate(project);
                    if (project.getId() == null) {
                        bi.setProjectID(Integer.parseInt(o.toString()));
                        //推送给客户
                        //jPushService.notify(1,Integer.parseInt(o.toString()),null,project.getName(),
                        //new BigDecimal(project.getEstimatedAnnualRate()).movePointLeft(-2).setScale(0,BigDecimal.ROUND_HALF_UP).toString(),project.getDeadLine().toString());
                    }

                    bi.setId(null);
                    baseSpringrainService.save(bi);
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
    @RequestMapping(value = "/update/pre")
    public String updatepre(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ReturnDatas returnObject = lookjson(model, request, response);

        model.addAttribute(GlobalStatic.returnDatas, returnObject);
        return "/project/projectCru";
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
            java.lang.Integer id = null;
            if (StringUtils.isNotBlank(strId)) {
                id = java.lang.Integer.valueOf(strId.trim());
                projectService.deleteById(id, Project.class);
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
     * 推荐操作
     */
    @RequestMapping(value = "/recommend")
    public @ResponseBody
    ReturnDatas recommend(HttpServletRequest request) throws Exception {

        // 执行删除
        try {
            String strId = request.getParameter("id");
            String type = request.getParameter("type");
            java.lang.Integer id = null;
            if (StringUtils.isNotBlank(strId)) {
                id = java.lang.Integer.valueOf(strId.trim());
                Integer result = projectService.recommend(id, type);
                if (22 == result) {
                    return new ReturnDatas(ReturnDatas.ERROR,
                            MessageUtils.RECOMMEND_FALSE);
                } else {
                    return new ReturnDatas(ReturnDatas.SUCCESS,
                            MessageUtils.DELETE_SUCCESS);
                }

            } else {
                return new ReturnDatas(ReturnDatas.WARNING,
                        MessageUtils.DELETE_WARNING);
            }
        } catch (RecommendExistException e) {
            logger.error(e.getMessage(), e);
            return new ReturnDatas(ReturnDatas.WARNING,
                    "已有推荐项目，请取消之前的推荐");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 放款操作
     */
    @RequestMapping(value = "/loan")
    public @ResponseBody
    ReturnDatas loan(HttpServletRequest request) throws Exception {
        ReturnDatas rt = new ReturnDatas(ReturnDatas.SUCCESS,
                MessageUtils.DELETE_SUCCESS);
        // 执行删除
        try {
            String strId = request.getParameter("id");

            java.lang.Integer id = null;
            if (StringUtils.isNotBlank(strId)) {
                id = java.lang.Integer.valueOf(strId.trim());
                CommonRspData cdata = projectService.loan(id);
                rt.setMessage(cdata.getResp_desc());
                rt.setStatus(ReturnDatas.ERROR);
                return rt;
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
	 * 放款操作
	 */
	@RequestMapping(value = "/si/project/loan")
	public @ResponseBody
	ReturnDatas siProjectLoan(HttpServletRequest request, Integer projectIdArr[], Boolean onlyReal) throws Exception {
		ReturnDatas rt = new ReturnDatas(ReturnDatas.SUCCESS,
				MessageUtils.DELETE_SUCCESS);
		// 执行删除
		try {
			CommonRspData cdata = projectService.smartProjectLoan(projectIdArr, onlyReal);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ReturnDatas(ReturnDatas.WARNING,
					"对不起放款失败！");
		}

		return new ReturnDatas(ReturnDatas.WARNING, "放款成功！");
	}

    /**
     * 还款操作
     */
    @RequestMapping(value = "/repayment")
    public @ResponseBody
    ReturnDatas repayment(HttpServletRequest request) throws Exception {
        try {
            Integer projectId = Integer.valueOf(request.getParameter("projectId"));
            Integer borrowerId = Integer.valueOf(request.getParameter("borrowerId"));

            Double money = Double.valueOf(request.getParameter("money"));
            projectService.repayment(borrowerId, projectId, money);



            return new ReturnDatas(ReturnDatas.SUCCESS,
                    MessageUtils.DELETE_SUCCESS);
        } catch (ParameterErrorException e) {
            return new ReturnDatas(ReturnDatas.WARNING, "参数缺失");
        } catch (PhoneNotExistException e) {
            return new ReturnDatas(ReturnDatas.ERROR, "你的手机号还没有开通富友账户，请开通");
        } catch (MoneyNotEnoughException e) {
            return new ReturnDatas(ReturnDatas.WARNING, "账户余额不足，请充值");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }

    /**
     * 推荐操作
     */
    @RequestMapping(value = "/isNew")
    public @ResponseBody
    ReturnDatas isNew(HttpServletRequest request) throws Exception {

        // 执行删除
        try {
            String strId = request.getParameter("id");
            String type = request.getParameter("type");
            java.lang.Integer id = null;
            if (StringUtils.isNotBlank(strId)) {
                id = java.lang.Integer.valueOf(strId.trim());
                Integer result = projectService.isNew(id, type);
                return new ReturnDatas(ReturnDatas.SUCCESS,
                        MessageUtils.DELETE_SUCCESS);
            } else {
                return new ReturnDatas(ReturnDatas.WARNING,
                        MessageUtils.DELETE_WARNING);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return null;
    }

	/**
	 * 项目类型查询
	 */
	@RequestMapping("/type/list/json")
	public @ResponseBody
	ReturnDatas typeList(HttpServletRequest request) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		// ==执行分页查询
		List<ProjectType> datas=projectService.queryForList(
				new Finder("SELECT * FROM t_project_type"), ProjectType.class);
		returnObject.setPage(page);
		returnObject.setData(datas);
		return returnObject;
	}

	/**
	 * 智投 待还款项目列表
	 *
	 * @param request
	 * @param model
	 * @param project
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/si/repayment/list")
	public String siRepaymentList(HttpServletRequest request, Model model, SmartInvestmentProject project)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		List list = null;
		try {
			com.cz.yingpu.system.entity.User user = userServive.findUserById(SessionUser.getShiroUser().getId());
			//project.setBorrowerId(user.getBorrowerId());

			list = projectService.siProjectRepaymentList(page, project);
			returnObject.setPage(page);
			returnObject.setData(list);
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setQueryBean(project);
		returnObject.setPage(page);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		return "/repayment/siRepaymentList";
	}

	/**
	 * 智投 待还款项目列表
	 *
	 * @param request
	 * @param model
	 * @param project
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/si/repayment/dispersed/project/list/json")
	public String siRepaymentDispersedProjectList(HttpServletRequest request, Model model, Project project, Boolean embedded)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		List list = null;
		try {
			com.cz.yingpu.system.entity.User user = userServive.findUserById(SessionUser.getShiroUser().getId());
			//project.setBorrowerId(user.getBorrowerId());

			list = projectService.siDispersedProjectRepaymentList(page, project);
			returnObject.setData(list);
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}

		returnObject.setQueryBean(project);
		returnObject.setPage(page);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);

		return ObjectUtils.defaultIfNull(embedded, false) ? "/repayment/smartProjectRepayDetails"
				: "/repayment/siRepaymentDispersedProject";
	}

	/**
	 * 智投散标 还款操作
	 */
	@RequestMapping(value = "/si/repayment")
	public @ResponseBody
	ReturnDatas siRepayment(HttpServletRequest request) throws Exception {
		try {
			Integer projectId = Integer.valueOf(request.getParameter("projectId"));
			Integer borrowerId = 0;//Integer.valueOf(request.getParameter("borrowerId"));

			Double money = 0d;//Double.valueOf(request.getParameter("money"));
			projectService.repaymentSiProject(borrowerId, projectId, money);

			return new ReturnDatas(ReturnDatas.SUCCESS,
					MessageUtils.DELETE_SUCCESS);
		} catch (ParameterErrorException e) {
			return new ReturnDatas(ReturnDatas.WARNING, "参数缺失");
		} catch (PhoneNotExistException e) {
			return new ReturnDatas(ReturnDatas.ERROR, "你的手机号还没有开通富友账户，请开通");
		} catch (MoneyNotEnoughException e) {
			return new ReturnDatas(ReturnDatas.WARNING, "账户余额不足，请充值");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}

	/**
	 * 待还款项目列表
	 *
	 * @param request
	 * @param model
	 * @param project
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/si/repayment/list/export")
	public void siRepaymentExport(HttpServletRequest request, HttpServletResponse response, Model model, Project project)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		Page page = newPage(request);
		page.setPageSize(10000);
		List list = null;
		try {
			com.cz.yingpu.system.entity.User user = userServive.findUserById(SessionUser.getShiroUser().getId());
			project.setBorrowerId(user.getBorrowerId());

			list = projectService.siDispersedProjectRepaymentList(page, project);
			File file = projectService.findDataExportExcel(list, "/repayment/siRepaymentList", page, Project.class.newInstance());
			downFile(response, file, "待还款列表.xls", true);
			returnObject.setData(list);
		} catch (Exception e) {
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("内部错误");
		}
		returnObject.setQueryBean(project);
		returnObject.setPage(page);
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
	}
}
