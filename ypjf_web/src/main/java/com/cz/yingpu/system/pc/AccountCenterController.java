package com.cz.yingpu.system.pc;


import com.alibaba.druid.support.json.JSONUtils;
import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.frame.util.fuyou.ConfigReader;
import com.cz.yingpu.system.entity.*;
import com.cz.yingpu.system.exception.*;
import com.cz.yingpu.system.fuyoudata.*;
import com.cz.yingpu.system.service.*;
import com.cz.yingpu.system.service.impl.SmartProjectInvestmentServiceImpl;
import com.sun.star.lang.IllegalArgumentException;
import org.apache.commons.httpclient.util.DateUtil;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 用户管理Controller,PC和手机浏览器用ACE自适应,APP提供JSON格式的数据接口
 *
 * @author 9iu.org<Auto                               generate>
 * @version 2017-10-09 11:36:47
 * @copyright {@link 9iu.org}
 */
@Controller
@RequestMapping("pc/myaccount")
public class AccountCenterController extends BaseController {
    @Resource
    IPCProjectListService pCProjectListService;

    @Resource
    IProjectCategoryService projectCategoryService;

    @Resource
    IProjectDeadlineService projectDeadlineService;

    @Resource
    IUserProjectService userProjectService;

    @Resource
    IAppUserService appUserService;

    @Resource
    IUserAccountHistoryService userAccountHistoryService;

    @Resource
    IProjectService projectService;

    @Resource
    IUserSignHisService userSignHisService;

    @Resource
    private ISysSysparamService sysSysparamService;

    @Resource
    private IUserCardService userCardService;

    @Resource
    private IMessageService messageService;

    @Autowired
    private IBorrowerService borrowerService;

    @Resource
    private IBankService bankService;
    @Resource
    private IAnnounceService announceService;

    @Resource
    private IAnnounceService companyStateService;

    @Resource
    private IAnnounceService contractSampleService;

    @Resource
    private IAnnounceService newsService;

    @Resource
    private IOrderService orderService;


    //跳转签到奖励
    @RequestMapping("mysignrewards")
    public String signhis(HttpServletRequest request) {
        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        try {

            //当月签到的记录
            Finder finder = new Finder("select * from  t_user_sign_his   where userId=:userId and createTime like :createTime");
            HashMap<String, Object> map = new HashMap<String, Object>();
            finder.setParam("userId", user.getId());
            finder.setParam("createTime", DateUtil.formatDate(new Date(), "yyyy-MM") + "%");
            map.put("usersign", JSONUtils.toJSONString(userSignHisService.queryForList(finder)));
            //当天是否签到
            finder = new Finder("select count(1) as num from  t_user_sign_his   where userId=:userId and createTime like :createTime");
            finder.setParam("userId", user.getId());
            finder.setParam("createTime", DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "%");
            map.put("jandao", userSignHisService.queryForObject(finder));
            //总签到次数
            finder = new Finder("select count(1) as tianshu from  t_user_sign_his   where userId=:userId ");
            finder.setParam("userId", user.getId());
            map.put("tianshu", userSignHisService.queryForObject(finder));

            //今日总签到次数

            //当天签到记录
            finder = new Finder("select us.*,app.phone as phone from  t_user_sign_his as us  inner join t_app_user as app on  userId =app.id  where  us.createTime like :createTime");
            finder.setParam("createTime", DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "%");
            List<Map<String, Object>> maplist = userSignHisService.queryForList(finder);
            map.put("daylists", maplist);
            String daycount = String.valueOf(maplist.size());
            //今日签到获取奖励
            SysParamBean datas = sysSysparamService.findParamBean();
            String amount = new BigDecimal(datas.getSignTotalAmount()).divide(new BigDecimal(daycount), 2).toString();
            //总获取奖励
            finder = new Finder("select sum(money) as amount  from  t_user_sign_his    where userId=:userId");
            finder.setParam("userId", user.getId());
            map.put("amount", userSignHisService.queryForObject(finder));

            map.put("daycount", daycount);
            map.put("dayamount", amount);
            request.setAttribute("data", map);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "pc/myaccount/mysignrewards";
    }

    public String getRand1() {
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

    //跳转到充值
    @RequestMapping("deposit")
    public String deposit(HttpServletRequest request) {
        try {
            AppUser aUser = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
            if (aUser.getBankId() != null) {

                Map<String, Object> map = bankService.queryForObject(new Finder("select * from t_bank where bankId=:bankId").setParam("bankId", aUser.getBankId()));

                map.put("banknum", aUser.getBankNum().substring(aUser.getBankNum().length() - 4));
                request.setAttribute("bank", map);
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "pc/myaccount/deposit";
    }


    /**
     * 用户快捷充值富友APP接口
     *
     * @param request
     * @param response
     * @throws Exception /system/fuiou/appWebRech2/json
     */
    @RequestMapping("/pcWebRech/json")
    public void pcWebRech(Model model, AppUser appUser, HttpServletRequest request, HttpServletResponse response) throws Exception {
        AppUser aUser = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        AppTransReqData appTransReqData = new AppTransReqData();
        P2p500405ReqData data = new P2p500405ReqData();
        data.setAmt(new BigDecimal(appUser.getMoney()).multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).toString());
        data.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
        data.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
        data.setLogin_id(aUser.getPhone());
//		data.setBack_notify_url(ConfigReader.getConfig("chongzhi_notify_url"));
//		data.setPage_notify_url(ConfigReader.getConfig("pc_page_notify_url")+"?type=2");
        data.setPage_notify_url(ConfigReader.getConfig("webP2PRech_notify_url"));

        appTransReqData.setMchnt_txn_ssn(data.getMchnt_txn_ssn());
        aUser.setMoney(appUser.getMoney());
        appUserService.saveDetail(1, aUser, appTransReqData);

        FuiouService.p2p500405(data, response);
    }

    /**
     * 用户网银充值富友pc接口
     *
     * @param request
     * @param response
     * @throws Exception /system/fuiou/appWebRech2/json
     */
    @RequestMapping("/pcWyWebRech/json")
    public String pcWyWebRech(Model model, AppUser appUser, HttpServletRequest request, HttpServletResponse response, String bank) throws Exception {
        AppUser aUser = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        AppTransReqData appTransReqData = new AppTransReqData();
        Wy500012ReqData data = new Wy500012ReqData();
        data.setAmt(new BigDecimal(appUser.getMoney()).multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).toString());
        data.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
        data.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
        data.setLogin_id(aUser.getPhone());
        data.setOrder_pay_type("B2C");
        //data.setBack_notify_url(ConfigReader.getConfig("chongzhi_notify_url")+"?type=2");
        data.setPage_notify_url(ConfigReader.getConfig("webP2PRech_notify_url"));
        //data.setIss_ins_cd("080"+aUser.getBankId()+"0000");
        data.setIss_ins_cd(bank);
        appTransReqData.setMchnt_txn_ssn(data.getMchnt_txn_ssn());
        aUser.setMoney(appUser.getMoney());
        appUserService.saveDetail(1, aUser, appTransReqData);
        FuiouService.wy500012(data, response);
        return null;
    }

    /**
     * 用户网银充值富友pc接口
     *
     * @param request
     * @param response
     * @throws Exception /system/fuiou/appWebRech2/json
     */
    @RequestMapping("/pcWyWebRech/test/json")
    public String pcWyWebRechtest(Model model, AppUser appUser, HttpServletRequest request, HttpServletResponse response, String bank) throws Exception {
        AppUser aUser = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        AppTransReqData appTransReqData = new AppTransReqData();
        Wy500012ReqData data = new Wy500012ReqData();
        data.setAmt(new BigDecimal(appUser.getMoney()).multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_UP).toString());
        data.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
        data.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
        data.setLogin_id(aUser.getPhone());
        data.setOrder_pay_type("B2C");
        data.setBack_notify_url(ConfigReader.getConfig("chongzhi_notify_url") + "?type=2");
        data.setPage_notify_url(ConfigReader.getConfig("pc_page_notify_url") + "?type=2");
        data.setIss_ins_cd(bank);
        appTransReqData.setMchnt_txn_ssn(data.getMchnt_txn_ssn());
        aUser.setMoney(appUser.getMoney());
        appUserService.saveDetail(1, aUser, appTransReqData);
        FuiouService.wy500012(data, response);
        return null;
    }

    //跳转到邀请奖励
    @RequestMapping("myrewards")
    public String myrewards() {
        return "pc/myaccount/myrewards";
    }


    //站内信列表
    @RequestMapping("mail/list/json")
    public @ResponseBody
    ReturnDatas maillistjson(HttpServletRequest request, Integer type, String pushType) throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        // ==构造分页请求
        String pageSize = request.getParameter("pageSize");
        // ==构造分页请求
        Page page = newPage(request);
        page.setPageSize(10);
        if (null != pageSize && !"".equals(pageSize)) {
            page.setPageSize(Integer.parseInt(pageSize));
        }
        // ==执行分页查询
        Finder finder = new Finder("select * from t_message where 1=1 and userId=:userId ");
        if (type != null) {
            finder.append(" AND type = :type ");
            finder.setParam("type", type);
        }

        if (pushType != null && !"".equals(pushType)) {
            finder.append(" AND pushType in(");
            String a[] = pushType.split("-");

            for (int i = 0; i < a.length; i++) {
                if (a.length == i + 1)
                    finder.append(a[i] + ")");
                else
                    finder.append(a[i] + ",");
            }

        }

        finder.setParam("userId", user.getId());
        finder.append(" order by createTime desc");
        List<Map<String, Object>> datas = userCardService.queryForList(finder, page);
        returnObject.setPage(page);
        returnObject.setData(datas);
        return returnObject;
    }


    //邀请的好友列表
    @RequestMapping("yaoqing/list/json")
    public @ResponseBody
    ReturnDatas qaoqinglistjson(HttpServletRequest request, Model model) throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        // ==构造分页请求
        String pageSize = request.getParameter("pageSize");
        // ==构造分页请求
        Page page = newPage(request);
        if (null != pageSize && !"".equals(pageSize)) {
            page.setPageSize(Integer.parseInt(pageSize));
        }
        // ==执行分页查询
        Finder finder = new Finder("select phone,dateline from t_app_user where 1=1 and parentId=:parentId ");
        finder.setParam("parentId", user.getId());
        finder.append(" order by dateline desc");
        List<Map<String, Object>> datas = userCardService.queryForList(finder, page);
        returnObject.setPage(page);
        returnObject.setData(datas);

        return returnObject;
    }


    /**
     * 跳转我的优惠券
     */
    @RequestMapping("/mycoupons")
    public String mycoupons(HttpServletRequest request) {
        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        try {
            HashMap<String, Object> map = new HashMap<String, Object>();
            //未使用优惠券数量

            Finder finder = new Finder("select count(1)  as count  from t_user_card where 1=1  and status=:status and userId=:userId");
            finder.setParam("userId", user.getId());
            finder.setParam("status", "1");
            map.put("wcount", userCardService.queryForObject(finder));
            //未使用优惠券总额
            finder = new Finder("select  sum(money) as totol from t_user_card where 1=1 and type=:type and status=:status and userId=:userId");
            finder.setParam("userId", user.getId());
            finder.setParam("status", "1");
            finder.setParam("type", "1");
            map.put("wtotol", userCardService.queryForObject(finder));
            //已使用优惠券总额
            finder = new Finder("select  sum(money) as totol from t_user_card where 1=1 and type=:type and status=:status and userId=:userId");
            finder.setParam("userId", user.getId());
            finder.setParam("status", "2");
            finder.setParam("type", "1");
            map.put("ytotol", userCardService.queryForObject(finder));
            //已过期优惠券
            finder = new Finder("select count(1) as count  from t_user_card where 1=1  and status=:status and userId=:userId");
            finder.setParam("userId", user.getId());
            finder.setParam("status", "3");
            map.put("ycount", userCardService.queryForObject(finder));
            request.setAttribute("data", map);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "pc/myaccount/mycoupons";
    }


    //加载优惠券列表
    @RequestMapping("/usercard/list/json")
    public @ResponseBody
    ReturnDatas usercardlistjson(HttpServletRequest request, Model model, UserCard usercard) throws Exception {
        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        // ==构造分页请求
        String pageSize = request.getParameter("pageSize");
        // ==构造分页请求
        Page page = newPage(request);
        if (null != pageSize && !"".equals(pageSize)) {
            page.setPageSize(Integer.parseInt(pageSize));
        }
        // ==执行分页查询
        Finder finder = new Finder("select * from t_user_card where 1=1 and userId=:userId and type=:type and status=:status");
        if (usercard.getType() == 4) {
            finder = new Finder("select * from t_user_card where 1=1 and userId=:userId and cardType=:cardType and status=:status");
            finder.setParam("cardType", 4);
        } else {
            finder.setParam("type", usercard.getType());
        }
        finder.setParam("userId", user.getId());

        finder.setParam("status", usercard.getStatus());
        finder.append(" order by id desc");
//		if(null != userProject.getProjectStatus()){
//			if(1==userProject.getProjectStatus()){
//				finder = new Finder("select * from t_user_project where projectStatus in (2,3)");
//				userProject.setProjectStatus(null);
//			}else if(2==userProject.getProjectStatus()){
//				userProject.setProjectStatus(4);
//			}else{
//				userProject.setProjectStatus(null);
//			}
//		}

        List<Map<String, Object>> datas = userCardService.queryForList(finder, page);
        returnObject.setQueryBean(usercard);
        returnObject.setPage(page);
        returnObject.setData(datas);
        return returnObject;
    }


    //跳转到资产统计
    @RequestMapping("account")
    public String account(HttpServletRequest request) {
        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        try {

            Finder f = new Finder("select IF(SUM(totolInterest) IS NULL,0.00,SUM(totolInterest)) as  total  from t_user_project where projectStatus=4 and userId=:userId");
            f.append(" UNION  ALL select IF(SUM(totolInterest) IS NULL,0.00,SUM(totolInterest)) as  total  from t_user_project where projectStatus=3 and userId=:userId");
            f.append(" UNION ALL select IF(SUM(totolInterest) IS NULL,0.00,SUM(totolInterest)) as  total  from t_user_project where projectStatus=2 and userId=:userId");
            f.append(" UNION ALL select IF(SUM(money) IS NULL,0.00,SUM(money)) as total from t_user_account_history where 1=1 and type=:type and status=:status and userId=:userId");
            f.append(" UNION ALL select count(1) as total from  t_user_sign_his   where userId=:userId and createTime like :createTime");

            f.setParam("userId", user.getId());
            f.setParam("type", "2");
            f.setParam("status", "1");
            f.setParam("createTime", DateUtil.formatDate(new Date(), "yyyy-MM-dd") + "%");
            List<Map<String, Object>> list = userProjectService.queryForList(f);


            user = appUserService.findAppUserById(user.getId());
            request.getSession().setAttribute(GlobalStatic.PCUSER, user);

            HashMap<String, Object> map = new HashMap<String, Object>();


            //累计收益
            map.put("shouyi", list.get(0).get("total") == null ? "0.00" : list.get(0).get("total"));
            map.put("daihuoqu", new BigDecimal(list.get(1).get("total").toString()).add(new BigDecimal(list.get(2).get("total").toString())).doubleValue());
            //map.put("tixian", list.get(3).get("total")==null ? "0.00" :list.get(3).get("total"));
            map.put("tixian", "0.00");
            Finder finder = new Finder("select * from t_project where status in(2,3,5) AND deadLine=:deadline AND isNew=:isnew order by startTime desc limit 0,1");
            finder.setParam("deadline","1");
            finder.setParam("isnew","是");
            map.put("project", projectService.queryForList(finder));

            Finder finder3 = new Finder("select * from t_project where status in(2,3,5) AND deadLine=:deadline AND isNew=:isnew order by startTime desc limit 0,1");
            finder3.setParam("deadline","3");
            finder3.setParam("isnew","是");
            map.put("project3", projectService.queryForList(finder3));

            Finder SmartProject = new Finder("select * from t_smart_investment_project where status in(2,4) AND deadLine=:deadline ORDER BY raiseStartTime DESC LIMIT 0,1");
            SmartProject.setParam("deadline", "3");
            map.put("smart", projectService.queryForList(SmartProject));
            map.put("jandao", list.get(4).get("total"));

            Map<?, ?> newMap = new HashMap<>();
            Finder newProjectMoney = new Finder("SELECT SUM(IFNULL(tu.money,0)+IFNULL(tu.cardPrice,0)) sum FROM t_user_project tu,t_project tp WHERE tu.projectId=tp.id AND tp.isNew=:isNew AND tp.status IN(2,3,5) AND tu.userId=:userId");
            newProjectMoney.setParam("isNew", "是");
            newProjectMoney.setParam("userId", user.getId());
            map.put("newSumMoney", ObjectUtils.defaultIfNull(projectService.queryForObject(newProjectMoney), newMap).get("sum"));

            Finder sanProjectMoney = new Finder("SELECT SUM(IFNULL(tu.money,0)+IFNULL(tu.cardPrice,0)) sum FROM t_user_project tu,t_project tp WHERE tu.projectId=tp.id AND tp.isNew!=:isNew AND tp.status IN(2,3,5) AND tu.userId=:userId");
            sanProjectMoney.setParam("isNew", "是");
            sanProjectMoney.setParam("userId", user.getId());
            map.put("sanSumMoney", ObjectUtils.defaultIfNull(projectService.queryForObject(sanProjectMoney), newMap).get("sum"));

            Finder smartSumMoney = new Finder("SELECT SUM(IFNULL(investmentAmount,0)) sum FROM t_smart_investment_order WHERE STATUS IN(1) AND userId=:userId");
            smartSumMoney.setParam("userId", user.getId());
            map.put("smartSumMoney", ObjectUtils.defaultIfNull(projectService.queryForObject(smartSumMoney), newMap).get("sum"));

//			Finder zhaiSumMoney = new Finder("SELECT SUM(IFNULL(tsida.amount,0)) FROM t_smart_investment_debt_assignment tsida,t_smart_investment_order tsio WHERE tsida.siOrderId = tsio.siProjectId AND tsio.userId=:userId");

            Finder zhaiSumMoney = new Finder("SELECT SUM(IFNULL(investmentAmount,0)) FROM t_smart_investment_order WHERE STATUS IN(2) AND userId=:userId");
            zhaiSumMoney.setParam("userId", user.getId());
            map.put("zhaiSumMoney", ObjectUtils.defaultIfNull(projectService.queryForObject(zhaiSumMoney), newMap).get("sum"));

            Finder sanbiaoOrder = new Finder("SELECT FLOOR(DATEDIFF(NOW(),tp.releaseTime)/30) das, tp.name,tp.deadLine,tp.nextInterest,tp.status,IFNULL(tup.money,0)+IFNULL(tup.cardPrice,0) money, tup.interest, tup.totolInterest FROM t_project tp,t_user_project tup WHERE tp.id=tup.projectId AND tp.status=:status AND tup.userId=:userId");
            sanbiaoOrder.setParam("status", "3");
            sanbiaoOrder.setParam("userId", user.getId());
            request.setAttribute("sanOrde", pCProjectListService.queryForList(sanbiaoOrder));

            Finder dayMoney = new Finder("SELECT SUM(IFNULL(tup.interest,0)) dayMoney FROM t_user_project tup, t_project tp WHERE TO_DAYS(tp.nextInterest )=TO_DAYS(NOW()) AND tp.id=tup.projectId AND tup.userId=:userId AND tp.status=:status");
            dayMoney.setParam("userId", user.getId());
            dayMoney.setParam("status","3");
            dayMoney.setEscapeSql(false);
            map.put("dayMoney", ObjectUtils.defaultIfNull(projectService.queryForObject(dayMoney), newMap).get("dayMoney"));

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            int m=2,i=1;
            int mo = calendar.get(Calendar.MONTH)+m;
            int year = calendar.get(Calendar.YEAR);
            int isMonth = calendar.get(Calendar.MONTH)+i;
            if(isMonth==12){
                year = year+1;
                mo=1;
            }
            Finder collectDayMoney = new Finder("SELECT SUM(IFNULL(tup.interest,0)) dayMoney FROM t_user_project tup, t_project tp WHERE Year(tp.nextInterest )=:year AND MONTH(tp.nextInterest)=:mo AND tp.id=tup.projectId AND tup.userId=:userId AND tp.status=:status");
            collectDayMoney.setParam("year",year);
            collectDayMoney.setParam("mo",mo);
            collectDayMoney.setParam("userId", user.getId());
            collectDayMoney.setParam("status", "3");
            dayMoney.setEscapeSql(false);
            map.put("collectDayMoney", ObjectUtils.defaultIfNull(projectService.queryForObject(collectDayMoney), newMap).get("dayMoney"));


            Finder MonthDayMoney = new Finder("SELECT SUM(IFNULL(tup.interest,0)) dayMoney FROM t_user_project tup, t_project tp WHERE DATE_FORMAT(tp.nextInterest,'%Y%m')=DATE_FORMAT(CURDATE(),'%Y%m') AND tp.status=:status AND tp.id=tup.projectId AND tup.userId=:userId");
            MonthDayMoney.setParam("userId", user.getId());
            MonthDayMoney.setParam("status", "3");
            MonthDayMoney.setEscapeSql(false);
            map.put("MonthDayMoney", ObjectUtils.defaultIfNull(projectService.queryForObject(MonthDayMoney), newMap).get("dayMoney"));


            Finder collectSmartProject = new Finder("SELECT tsio.deadLine,tsio.expiresDate,tsio.actualAmount,tsio.status,tsii.accumulatedEarning,FLOOR(tsii.holdDays/30) hold, tsip.name FROM t_smart_investment_order tsio,t_smart_investment_info tsii,t_smart_investment_project tsip WHERE tsio.siprojectId = tsip.id AND tsii.siOrderId = tsio.id AND tsio.userId=:userId");
            collectSmartProject.setParam("userId", user.getId());
            collectSmartProject.setEscapeSql(false);
            request.setAttribute("collectSmartProject", pCProjectListService.queryForList(collectSmartProject));

//            Finder newMonyValue = new Finder("SELECT SUM(IFNULL(money,0)+IFNULL(cardPrice,0)) sumNewMoney FROM t_user_project WHERE userid=:userid");
//            newMonyValue.setParam("userid",user.getId());
//            map.put("sumMoney",ObjectUtils.defaultIfNull(projectService.queryForObject(newMonyValue), newMap).get("sumNewMoney"));

//			Finder numberDas = new Finder("SELECT DATEDIFF(NOW(),tp.endTitme) das FROM t_project tp, t_user_project tup WHERE tp.status=:status AND tp.id=tup.projectId AND tup.userId=:userId");
//			numberDas.setParam("status","3");
//			numberDas.setParam("userId",user.getId());
//			request.setAttribute("month",pCProjectListService.queryForList(numberDas));


			/*Finder finder1 = new Finder("select * from t_app_user_experience where userId=:userid");
			finder1.setParam("userid",user.getId());
			ExperienceMoney experienceMoney = null;
			map.put("tiyan", experienceMoney = projectService.queryForObject(finder1, ExperienceMoney.class));

            Finder withdarwnFinder = new Finder("SELECT SUM(IFNULL(amount, 0)) amount FROM t_user_experience_history" +
                    " WHERE userId = :userId AND type = 2 AND status IN (1, 2)").setParam("userId", user.getId());
            Finder investFinder = new Finder("SELECT SUM(IFNULL(money, 0)) + SUM(IFNULL(cardPrice, 0)) sum" +
                    " FROM t_user_project WHERE userId = :userId AND createTime >= DATE(:start)" +
                    " AND status = 2")
                    .setParam("userId", user.getId())
                    .setParam("start", experienceMoney == null ? new Date() : experienceMoney.getDrawTime());

            Map<?, ?> emptyMap = new HashMap<>();
            Double investAmount, currentWithdrawableAmount = 0d;

            map.put("withdrawnAmount",
                    ObjectUtils.defaultIfNull(projectService.queryForObject(withdarwnFinder), emptyMap).get("amount"));
            map.put("investAmount", ObjectUtils.defaultIfNull(
                    projectService.queryForObject(investFinder), emptyMap).get("sum"));
            investAmount = map.get("investAmount") == null ? 0d : Double.parseDouble(map.get("investAmount").toString());
            map.put("remainsAmount", experienceMoney == null ? 0 : experienceMoney.getEarningsDummyMoney());

            if (investAmount >= 35e4) {
                currentWithdrawableAmount = 1342.46;
            } else if (investAmount > 0) {
                currentWithdrawableAmount =  Math.floor(investAmount / 50000) * 200;
            }

            map.put("withdrawableAmount", currentWithdrawableAmount);*/

            //资产总额
            map.put("zichan", new BigDecimal("0.00").add(new BigDecimal(map.get("tixian").toString()))
                    .add(new BigDecimal(user.getNowInvestAmount() == null ? 0.00 : user.getNowInvestAmount())).add(new BigDecimal(user.getCfBalance() == null ? 0.00 : user.getCfBalance()))
                    .add(new BigDecimal(user.getCaBalance().toString()))
                    .add(new BigDecimal(user.getYebBalance().toString()))
                    .add(new BigDecimal(user.getFreezeYebBalance()))
                    .doubleValue());
            request.setAttribute("data", map);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
//		return "pc/html/account";
        return "pc/html/account/account";
    }

    /**
     * 获取当月当天待回收金额
     * @return
     */
    @RequestMapping("/getmoney")
    @ResponseBody
    public Object getMoney(String year,String month,String day,HttpServletRequest request) throws Exception {

        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
        String dateTime="";
        if(StringUtils.isNotBlank(day)){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date da = sdf.parse(day);
            dateTime = sdf.format(da);
        }
        HashMap<String, Object> map = new HashMap<String, Object>();
        Map<?, ?> newMap = new HashMap<>();
        if (StringUtils.isNotBlank(year) && StringUtils.isNotBlank(month)) {
            if(month.equals("0")){
                month="12";
               year = String.valueOf(Integer.parseInt(year)-1);
            }else if (month.equals("13")){
                month="1";
                year = String.valueOf(Integer.parseInt(year)+1);
            }
//           获取当月待收金额
            Finder MonthDayMoney = new Finder("SELECT SUM(IFNULL(tup.interest,0)) monthMoney FROM t_user_project tup, t_project tp WHERE 1=1 AND tp.id=tup.projectId");
            MonthDayMoney.append(" AND YEAR(tp.nextInterest)=:year AND MONTH(tp.nextInterest)=:month");
            MonthDayMoney.setParam("year", year);
            MonthDayMoney.setParam("month", month);
            MonthDayMoney.append(" AND tup.userId=:userId AND tp.status=:status");
            MonthDayMoney.setParam("userId", user.getId());
            MonthDayMoney.setParam("status","3");
            map.put("MMoney",ObjectUtils.defaultIfNull(projectService.queryForObject(MonthDayMoney), newMap).get("monthMoney"));
            System.out.println("当月待收金额："+map.get("MMoney"));

            //次月待收金额
            if(month.equals("12")){
                month="1";
                year= String.valueOf(Integer.parseInt(year)+1);
            }else{
                month=String.valueOf(Integer.parseInt(month)+1);
            }
            Finder paymentMoney = new Finder("SELECT SUM(IFNULL(tup.interest,0)) monthMoney FROM t_user_project tup, t_project tp WHERE 1=1 AND tp.id=tup.projectId");
            paymentMoney.append(" AND YEAR(tp.nextInterest)=:year AND MONTH(tp.nextInterest)=:month");
            paymentMoney.setParam("year",year);
            paymentMoney.setParam("month",month);
            paymentMoney.append(" AND tp.status=:status AND tup.userId=:userId");
            paymentMoney.setParam("status","3");
            paymentMoney.setParam("userId",user.getId());
            map.put("PaymentMoney",ObjectUtils.defaultIfNull(projectService.queryForObject(paymentMoney), newMap).get("monthMoney"));
            System.out.println("次月待收金额："+map.get("PaymentMoney"));
        }
        if(StringUtils.isNotBlank(day)){
          Finder dayMoney = new Finder("SELECT SUM(IFNULL(tup.interest,0)) dayMoney FROM t_user_project tup, t_project tp WHERE 1=1 AND tp.id=tup.projectId");
          dayMoney.append(" AND DATE_FORMAT(tp.nextInterest,'%Y-%m-%d')=:dateTime AND tp.status=:status AND tup.userId=:userId");
          dayMoney.setParam("dateTime",dateTime);
          dayMoney.setParam("status","3");
          dayMoney.setParam("userId",user.getId());
          dayMoney.setEscapeSql(false);
          map.put("DMoney",ObjectUtils.defaultIfNull(projectService.queryForObject(dayMoney), newMap).get("dayMoney"));
        }
        returnDatas.setMap(map);
        return returnDatas;
    }


    //签到记录
    @RequestMapping("/signhis/list/json")
    public @ResponseBody
    ReturnDatas listjson(HttpServletRequest request, Model model, UserSignHis userSignHis) throws Exception {

        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        // ==构造分页请求
        String pageSize = request.getParameter("pageSize");
        // ==构造分页请求
        Page page = newPage(request);
        if (null != pageSize && !"".equals(pageSize)) {
            page.setPageSize(Integer.parseInt(pageSize));
        }
        // ==执行分页查询
        Finder finder = new Finder("select * from t_user_sign_his where 1=1 and userId=:userId");
        finder.setParam("userId", user.getId());
//		if(null != userProject.getProjectStatus()){
//			if(1==userProject.getProjectStatus()){
//				finder = new Finder("select * from t_user_project where projectStatus in (2,3)");
//				userProject.setProjectStatus(null);
//			}else if(2==userProject.getProjectStatus()){
//				userProject.setProjectStatus(4);
//			}else{
//				userProject.setProjectStatus(null);
//			}
//		}
        List<UserSignHis> datas = userSignHisService.findListDataByFinder(finder, page, UserSignHis.class, userSignHis);
        returnObject.setQueryBean(userSignHis);
        returnObject.setPage(page);
        returnObject.setData(datas);
        return returnObject;
    }


    /**
     * 我的投资列表。
     */
    @RequestMapping("invests")
    @ResponseBody
    public Object list(Integer id, Integer status, String repayRate, String totalAmount, HttpServletRequest r) {
        List<Map<String, Object>> invests = new ArrayList<>();
        Finder finder = new Finder("SELECT up.*, p.name, p.estimatedAnnualRate repayRate, " +
                "IF(p.nextInterest IS NULL, '', DATE_ADD(DATE_SUB(p.nextInterest, INTERVAL 1 Month), INTERVAL up.deadLine Month)) endTitme, p.nextInterest, p.id projectId FROM t_user_project up, " +
                "t_project p, t_app_user au WHERE au.id = up.userId AND up.projectId = p.id");
        Page page = newPage(r);
        page.setSort("DESC");
        page.setOrder("up.createTime");
        finder.setEscapeSql(false);

        try {
            if (id == null) {
                throw new Exception();
            }

            finder.append(" AND au.id=:id");
            finder.setParam("id", id);

            if (status != null) {
                switch (status) {
                    case 2: // 投标中
                        finder.append(" AND p.financingAmount >= 0");
                        break;

                    case 3: // 回款中
                        finder.append(" AND p.financingAmount = 0");
                        //					status = 2;
                        break;

                    case 4: // 已还款
                        break;

                    case 5: // 已逾期
                        finder.append(" AND DATE_ADD(p.releaseTime, INTERVAL up.deadLine MONTH) < NOW()");
                        status = 3;
                        break;
                }
                if(status==2){
                    finder.append(" AND p.status in(2,5)");
                }else{
                    finder.append(" AND p.status = :status");
                    finder.setParam("status", status);
                }

            }
            finder.setEscapeSql(false);

            SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
            SimpleDateFormat sdf2 = new SimpleDateFormat("YYYY-MM-dd");
            invests = pCProjectListService.queryForList(finder, page);
            if (invests != null) {
                for (int i = 0; i < invests.size(); i++) {
                    if (invests.get(i).get("createTime") != null) {
                        invests.get(i).put("createTime",
                                sdf.format(new Date(((Timestamp) invests.get(i).get("createTime")).getTime())));
                    }

                    if (invests.get(i).get("nextInterest") != null) {
                        invests.get(i).put("nextInterest",
                                sdf2.format(((Timestamp) invests.get(i).get("nextInterest")).getTime()));
                    }

                    if (invests.get(i).get("cardPrice") != null) {
//						invests.get(i).put("money",new BigDecimal(invests.get(i).get("cardPrice").toString()).add(new BigDecimal(invests.get(i).get("money").toString())).toString()
//								);
                    }
                }
            }
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }

        ReturnDatas ret = ReturnDatas.getSuccessReturnDatas();
        ret.setPage(page);
        ret.setData(invests);
        return ret;
    }


    /**
     * 签到
     */
    @RequestMapping("/signhis")
    public @ResponseBody
    ReturnDatas signhis(Model model, UserSignHis userSignHis, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        returnObject.setMessage("签到成功");

        try {
            AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
            userSignHisService.sign(user.getId(), userSignHis.getType(), userSignHis.getOsType());
        } catch (SignExistException e) {
            String errorMessage = e.getLocalizedMessage();
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("今日您已签到！");
        } catch (SignLimitNotEnoughException e) {
            String errorMessage = e.getLocalizedMessage();
            returnObject.setStatus(ReturnDatas.ERROR);
            SysParamBean datas = sysSysparamService.findParamBean();
            returnObject.setMessage("正在投资的金额大于等于" + datas.getSignLimitAmount() + "元时，才可以签到。");
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
     * 我的交易记录
     */
    @RequestMapping("transaction/list")
    @ResponseBody
    public Object getTransactions(Integer id, String type, String dateBefore, String dateStart, String dateEnd,
                                  String status, HttpServletRequest r) {
        List<Map<String, Object>> history = new ArrayList<>();
        List<?> yebHistory = new ArrayList<>();
        List<Map<String, Object>> count = new ArrayList<>();
        Finder finder = new Finder("SELECT * FROM (SELECT ta.money, ta.type, ta.tradeNo, ta.status, ta.createTime, p.name FROM t_order ta "
                + "LEFT JOIN t_project p ON p.id = ta.projectId WHERE ta.status = 2 ");

        Finder conditionFinder = new Finder();
        Page page = newPage(r);

        try {
            if (id == null) {
                throw new RuntimeException();
            }
            conditionFinder.append(" AND ta.userId = :id");
            conditionFinder.setParam("id", id);
            if (StringUtils.isNotBlank(dateBefore)) {
                conditionFinder.append(" AND ta.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND ta.createTime <= NOW()");
                conditionFinder.setParam("dateBefore", dateBefore);
            } else if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
                conditionFinder.append(" AND ta.createTime >= :dateStart AND ta.createTime <= :dateEnd");
                conditionFinder.setParam("dateStart", dateStart + " 00:00:00");
                conditionFinder.setParam("dateEnd", dateEnd + " 23:59:59");
            }
            finder.appendFinder(conditionFinder);
            if (StringUtils.isNotBlank(type)) {
                finder.append(" AND FIND_IN_SET(ta.type, :type)");
                finder.setParam("type", type);
                if (type.contains("8")) {
                    finder.append(" UNION SELECT money, 16 type, tradeNo, 2 status, createTime, '' name  "
                            + " FROM t_user_yeb_history ta WHERE ta.type = 3")
                            .appendFinder(conditionFinder);
                }

                finder.setEscapeSql(false);
            }
			/*else if (StringUtils.isNotBlank(status)) {
				finder.append(" AND ( p.status = 3 AND p.repaymentTime < NOW() ");	// 逾期
				finder.append(" OR p.status = 3 "); 								// 已回款
				finder.append(" OR p.status = 2 )"); 								// 待回款
			}*/

            Finder countFinder = new Finder("SELECT COUNT(0) FROM (").append(finder.getSql()).append(")tt ) t");
            countFinder.getParams().putAll(finder.getParams());
            countFinder.setEscapeSql(false);
            count = pCProjectListService.queryForList(countFinder);
            if (count != null && count.size() != 0) {
                int dataCount = Integer.parseInt(count.get(0).get("COUNT(0)").toString());
                page.setTotalCount(dataCount);
            }

            finder.append(" ) _x_x");
            finder.append(" ORDER BY _x_x.createTime DESC");
            finder.append(" LIMIT " + (~-page.getPageIndex() * page.getPageSize()) + "," + page.getPageSize());
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY.MM.dd HH:mm:ss");
            history = pCProjectListService.queryForList(finder);
            if (history != null) {
                for (int i = 0; i < history.size(); i++) {
                    if (history.get(i).get("createTime") != null) {
                        history.get(i).put("createTime",
                                sdf.format(new Date(((Timestamp) history.get(i).get("createTime")).getTime())));
                    }

                    if (history.get(i).get("endTitme") != null) {
                        history.get(i).put("endTitme",
                                sdf.format(((Timestamp) history.get(i).get("endTitme")).getTime()));
                    }
                }
            }
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }

        ReturnDatas ret = ReturnDatas.getSuccessReturnDatas();
        ret.setPage(page);
        ret.setData(history);
        return ret;
    }

    /**
     * 交易记录查询
     * @return
     */
    @RequestMapping("/getDealOrder")
    @ResponseBody
    public Object getDealOrder(Integer id, String type, String dateBefore, String dateStart, String dateEnd, String status, HttpServletRequest request){
        ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
        Page page =newPage(request);
        page.setPageSize(8);
        List<Map<String,Object>> OrderList = new ArrayList<>();
		if(!type.equals("3")){
			Finder findGetOreder = new Finder("SELECT ta.createTime,ta.tradeNo,ta.status,ta.money,ta.type");
			try {
				if (id==null){
					throw new RuntimeException();
				}
				if(StringUtils.isNotBlank(type)){
					if(type.equals("0")){
						findGetOreder.append(",tp.code FROM t_user_account_history AS ta LEFT JOIN t_project AS tp ON(ta.projectId=tp.id) LEFT JOIN t_smart_investment_project AS tsip ON(tsip.id=ta.projectId) where ta.type IN(3,4,8,11,12,13,14,15)");
					}else if(type.equals("1")){
						findGetOreder.append(" FROM t_user_account_history ta WHERE ta.type IN(1)");
					}else if(type.equals("2")){
						findGetOreder.append(" FROM t_user_account_history ta WHERE ta.type IN(2)");
					}
				}else{
					findGetOreder.append(",tp.code FROM t_user_account_history AS ta LEFT JOIN t_project AS tp ON(ta.projectId=tp.id) LEFT JOIN t_smart_investment_project AS tsip ON(tsip.id=ta.projectId) where ta.type IN(3,4,8,11,12,13,14,15)");
				}
				if (StringUtils.isNotBlank(dateBefore)) {
					if(dateBefore.equals("1")){
					}
					else if (dateBefore.equals("2")){
						findGetOreder.append(" AND ta.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND ta.createTime <= NOW()");
						findGetOreder.setParam("dateBefore", "30");
					}else if (dateBefore.equals("3")){
						findGetOreder.append(" AND ta.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND ta.createTime <= NOW()");
						findGetOreder.setParam("dateBefore", "90");
					}else if (dateBefore.equals("4")){
						findGetOreder.append(" AND ta.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND ta.createTime <= NOW()");
						findGetOreder.setParam("dateBefore", "365");
					}
				}else if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
					findGetOreder.append(" AND ta.createTime >= :dateStart AND ta.createTime <= :dateEnd");
					findGetOreder.setParam("dateStart", dateStart + " 00:00:00");
					findGetOreder.setParam("dateEnd", dateEnd + " 23:59:59");
				}
				if(StringUtils.isNotBlank(status)){
					if(type.equals("0")){
						if(status.equals("1")){
							findGetOreder.append(" AND ta.TYPE IN(3,4,8,11,12,13,14,15)");
						}else if(status.equals("2")){
							findGetOreder.append(" AND ta.type in(3,11,13)");
						}else if(status.equals("3")) {
							findGetOreder.append(" AND ta.type in(4,8,12,14,15)");
						}
					}else if(type.equals("1")){
						if(status.equals("1")){
							findGetOreder.append(" AND ta.status in(1,2,3)");
						}else if(status.equals("2")){
							findGetOreder.append(" AND ta.status=:status");
							findGetOreder.setParam("status","1");
						}else if(status.equals("3")){
							findGetOreder.append(" AND ta.status=:status");
							findGetOreder.setParam("status","2");
						}else if(status.equals("4")){
							findGetOreder.append(" AND ta.status=:status");
							findGetOreder.setParam("status","3");
						}else{
							findGetOreder.append(" AND ta.status in(1,2,3)");
						}
					}else if(type.equals("2")){
						if(status.equals("1")){
							findGetOreder.append(" AND ta.status in(1,2,3)");
						}else if(status.equals("2")){
							findGetOreder.append(" AND ta.status=:status");
							findGetOreder.setParam("status","1");
						}else if(status.equals("3")){
							findGetOreder.append(" AND ta.status=:status");
							findGetOreder.setParam("status","2");
						}else if(status.equals("4")){
							findGetOreder.append(" AND ta.status=:status");
							findGetOreder.setParam("status","3");
						}else{
							findGetOreder.append(" AND ta.status in(1,2,3)");
						}
					}else{
						if(status.equals("1")){
							findGetOreder.append(" AND ta.TYPE IN(3,4,8,11,12,13,14,15)");
						}else if(status.equals("2")){
							findGetOreder.append(" AND ta.type in(3,11,13)");
						}else if (status.equals("3")){
							findGetOreder.append(" AND ta.type in(4,8,12,14,15)");
						}
					}
				}
				findGetOreder.append(" AND ta.userId=:userId");
				findGetOreder.append(" AND ta.money!=0");
				findGetOreder.setParam("userId",id);
				System.out.println(findGetOreder.getSql());
				page.setSort("DESC");
				page.setOrder("ta.createTime");
				OrderList =pCProjectListService.queryForList(findGetOreder,page);
			}catch (RuntimeException e){
				e.printStackTrace();
				return  ReturnDatas.getErrorReturnDatas();
			} catch (Exception e) {
				e.printStackTrace();
				return ReturnDatas.getErrorReturnDatas();
			}
		}else {
			try{
				Finder ushfinder = new Finder("select DISTINCT ah.projectId,ah.money,ah.createtime,ah.status,appus.realName,appus.phone from t_user_account_history ah,(select DISTINCT tuah.userId from t_user_account_history tuah WHERE tuah.type=3 AND tuah.money!=0) usId,(SELECT au.realName,au.phone FROM t_app_user au WHERE  au.parentId=:parentId) appus WHERE ah.userId=:userId AND ah.type=8 AND ah.money!=0").setParam("userId",id).setParam("parentId",id);
				if (StringUtils.isNotBlank(dateBefore)) {
					if(dateBefore.equals("1")){
					}
					else if (dateBefore.equals("2")){
						ushfinder.append(" AND ah.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND ah.createTime <= NOW()");
						ushfinder.setParam("dateBefore", "30");
					}else if (dateBefore.equals("3")){
						ushfinder.append(" AND ah.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND ah.createTime <= NOW()");
						ushfinder.setParam("dateBefore", "90");
					}else if (dateBefore.equals("4")){
						ushfinder.append(" AND ah.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND ah.createTime <= NOW()");
						ushfinder.setParam("dateBefore", "365");
					}
				}else if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
					ushfinder.append(" AND ah.createTime >= :dateStart AND ah.createTime <= :dateEnd");
					ushfinder.setParam("dateStart", dateStart + " 00:00:00");
					ushfinder.setParam("dateEnd", dateEnd + " 23:59:59");
				}
				if(StringUtils.isNotBlank(status)) {
					if (status.equals("1")) {
						//findGetOreder.append(" AND ta.status in(1,2,3)");
					} else if (status.equals("2")) {
						ushfinder.append(" AND ah.status=:status");
						ushfinder.setParam("status", "2");
					} else if (status.equals("3")) {
						ushfinder.append(" AND ah.status=:status");
						ushfinder.setParam("status", "1");
					}
				}
				ushfinder.append(" order by ah.id DESC");
				OrderList = pCProjectListService.queryForList(ushfinder,page);
				/*Finder ush2finder = new Finder();
				Finder userfinder = new Finder();
				AppUser appUser = new AppUser();
				List<Map<String, Object>> userIdMaps = new ArrayList<>();*/
				/*for (int i = 0; i < userAccountHistorys.size(); i++) {
					ush2finder = new Finder("select DISTINCT userId from t_user_account_history WHERE projectId=:projectId AND type=3 AND money!=0").setParam("projectId",userAccountHistorys.get(i).get("projectId"));
					userIdMaps = pCProjectListService.queryForList(ush2finder);
					for (int j = 0; j < userIdMaps.size(); j++) {
						userfinder = new Finder("SELECT * FROM t_app_user WHERE id=:id AND parentId=:parentId");
						userfinder.setParam("id",userIdMaps.get(j).get("userId"));
						userfinder.setParam("parentId",id);
						appUser = pCProjectListService.queryForObject(userfinder, AppUser.class);
						if(appUser != null){
							userAccountHistorys.get(i).put("realName",appUser.getRealName());
							userAccountHistorys.get(i).put("phone",appUser.getPhone());
						}
					}
				}*/
				//OrderList = userAccountHistorys;
			}catch (Exception e){
				e.printStackTrace();
				return ReturnDatas.getErrorReturnDatas();
			}

		}
        returnDatas.setData(OrderList);
        returnDatas.setPage(page);
        return returnDatas;
    }

    /**
     * 散标投资记录
     *
     * @return
     */
    @RequestMapping("/getInvestOrder")
    @ResponseBody
    public Object getInvestOrder(Integer id, String deadLine, String status, String type, HttpServletRequest request) {
        ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
        String pageSize = request.getParameter("pageSize");
        Page page = newPage(request);
        if (null != pageSize && !"".equals(pageSize)) {
            page.setPageSize(Integer.parseInt(pageSize));
        }
        List<Map<String, Object>> maps = new ArrayList<>();
        Finder finder = new Finder("SELECT tp.name,tp.code,tp.status,tup.projectId,tup.id,tup.rate,tup.createTime,tup.cardType,tup.cardRate,tup.dikouRate,tp.deadLine,IFNULL(money,0)+IFNULL(cardPrice,0) money,tup.totolInterest,tp.nextInterest,tup.cardPrice,IFNULL(tup.money,0)+IFNULL(tup.cardPrice,0)+IFNULL(tup.totolInterest,0)sumMoney,tup.rest,DATE_ADD(tp.releaseTime,INTERVAL tup.deadLine Month) Etime FROM t_user_project tup,t_project tp WHERE tup.projectId=tp.id");
        try {
            if (id == null) {
                throw new RuntimeException();
            }
            finder.append(" AND tup.userId=:userId AND tp.type=:type AND tp.isNew!=:isNew");
            finder.setParam("userId", id);
            finder.setParam("type","1");
            finder.setParam("isNew","是");
            if (StringUtils.isNotBlank(deadLine)) {
                if (deadLine.equals("1")) {
                    finder.append(" AND tp.deadLine IN(1,3,6,9,12)");
                } else if (deadLine.equals("2")) {
                    finder.append(" AND tp.deadLine=:deadLine");
                    finder.setParam("deadLine", "1");
                } else if (deadLine.equals("3")) {
                    finder.append(" AND tp.deadLine=:deadLine");
                    finder.setParam("deadLine", "3");
                } else if (deadLine.equals("4")) {
                    finder.append(" AND tp.deadLine=:deadLine");
                    finder.setParam("deadLine", "6");
                } else if (deadLine.equals("5")) {
                    finder.append(" AND tp.deadLine=:deadLine");
                    finder.setParam("deadLine", "9");
                } else if (deadLine.equals("6")) {
                    finder.append(" AND tp.deadLine=:deadLine");
                    finder.setParam("deadLine", "12");
                }
            } else {
                finder.append(" AND tp.deadLine IN(1,3,6,9,12)");
            }
            if (StringUtils.isNotBlank(type)) {
                if (type.equals("0")) {
                    finder.append(" AND tp.categoryId=:categoryId");
                    finder.setParam("categoryId", "16");
                } else if (type.equals("1")) {
                    finder.append(" AND tp.categoryId=:categoryId");
                    finder.setParam("categoryId", "13");
                } else if (type.equals("2")) {
                    finder.append(" AND tp.categoryId=:categoryId");
                    finder.setParam("categoryId", "15");
                } else if (type.equals("3")) {
                    finder.append(" AND tp.categoryId=:categoryId");
                    finder.setParam("categoryId", "14");
                }
            } else {
                finder.append(" AND tp.categoryId=:categoryId");
                finder.setParam("categoryId", "16");
            }
            if (StringUtils.isNotBlank(status)) {
                if (status.equals("1")) {
                    finder.append(" AND tp.status IN(2,5)");
//                    finder.setParam("status", "2");
                } else if (status.equals("2")) {
                    finder.append(" AND tp.status=:status");
                    finder.setParam("status", "3");
                } else if (status.equals("3")) {
                    finder.append(" AND tp.status=:status");
                    finder.setParam("status", "4");
                }
            }else {
                finder.append(" AND tp.status IN(2,5)");
//                finder.setParam("status", "2");
            }
            finder.setEscapeSql(false);
            page.setSort("DESC");
            page.setOrder("tup.createTime");
//            System.out.println("查询语句："+finder.getSql());
            maps = pCProjectListService.queryForList(finder, page);
//            System.out.println("查询结果："+maps);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
        returnDatas.setData(maps);
        returnDatas.setPage(page);
        return returnDatas;
    }

    /**
     * X智投订单
     * @return
     */
    @RequestMapping("/getSmartOrder")
    @ResponseBody
    public Object getSmartOrder(Integer id,String dateBefore, String dateStart, String dateEnd,String status, HttpServletRequest request){
        ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
        Page page = newPage(request);
        page.setPageSize(8);
        List<Map<String, Object>> amartList = new ArrayList<>();
        Finder smartfinder = new Finder("SELECT IFNULL(tp.name, tsio.fakedProjectName) name,tsio.id oid,tp.id projectId,tsio.status ostatus,tp.interestRate rate," +
				"tsio.createTime createtime,tsio.deadline deadline,tsio.expiresDate expiresdate,tsio.investmentAmount money," +
				"ti.accumulatedEarning Earning,tsio.discountAmount amount,\n" +
                "IFNULL(tsio.investmentAmount,0)+IFNULL(ti.accumulatedEarning,0) summoney FROM t_smart_investment_order tsio " +
				"LEFT JOIN t_smart_investment_project tp ON tsio.siProjectId=tp.id " +
				"LEFT JOIN t_smart_investment_info ti ON ti.siOrderId = tsio.id WHERE  1 = 1 ");
        try {
            if (id == null) {
                throw new RuntimeException();
            }
            smartfinder.append(" AND tsio.userId=:userId");
            smartfinder.setParam("userId", id);
            if (StringUtils.isNotBlank(dateBefore)) {
                if(dateBefore.equals("1")){
                }
                else if (dateBefore.equals("2")){
                    smartfinder.append(" AND tsio.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND tsio.createTime <= NOW()");
                    smartfinder.setParam("dateBefore", "30");
                }else if (dateBefore.equals("3")){
                    smartfinder.append(" AND tsio.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND tsio.createTime <= NOW()");
                    smartfinder.setParam("dateBefore", "90");
                }else if (dateBefore.equals("4")){
                    smartfinder.append(" AND tsio.createTime >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND tsio.createTime <= NOW()");
                    smartfinder.setParam("dateBefore", "365");
                }
            }else if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
                smartfinder.append(" AND tsio.createTime >= :dateStart AND tsio.createTime <= :dateEnd");
                smartfinder.setParam("dateStart", dateStart + " 00:00:00");
                smartfinder.setParam("dateEnd", dateEnd + " 23:59:59");
            }
            if (StringUtils.isNotBlank(status)) {
                if (status.equals("1")) {
                    smartfinder.append(" AND tsio.status=:status");
                    smartfinder.setParam("status", "1");
                }else if(status.equals("2")) {
                    smartfinder.append(" AND tsio.status=:status");
                    smartfinder.setParam("status", "2");
                }
            } else {
                smartfinder.append(" AND tsio.status=:status");
                smartfinder.setParam("status", "1");
            }
            page.setSort("DESC");
            page.setOrder("tsio.createTime");
            amartList = pCProjectListService.queryForList(smartfinder, page);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
        returnDatas.setData(amartList);
        returnDatas.setPage(page);
        return returnDatas;
    }

    /**
     * 获取新手标记录
     * @param id
     * @param deadLine
     * @param status
     * @param request
     * @return
     */
    @RequestMapping("/getNewProjectOrder")
    @ResponseBody
    public Object getNewProjectOrder(Integer id, String deadLine, String status, HttpServletRequest request) {
        ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
        String pageSize = request.getParameter("pageSize");
        Page page = newPage(request);
        if (null != pageSize && !"".equals(pageSize)) {
            page.setPageSize(Integer.parseInt(pageSize));
        }
        List<Map<String, Object>> maps = new ArrayList<>();
        Finder finder = new Finder("SELECT tp.name,tp.code,tp.status,tup.projectId,tup.id,tup.rate,tup.createTime,tup.cardType,tup.cardRate,tup.dikouRate,tp.deadLine,IFNULL(money,0)+IFNULL(cardPrice,0) money,tup.totolInterest,tup.cardPrice,tp.nextInterest,tp.repaymentTime,IFNULL(tup.money,0)+IFNULL(tup.cardPrice,0)+IFNULL(tup.totolInterest,0)sumMoney,tup.rest,DATE_ADD(tp.releaseTime,INTERVAL tup.deadLine Month) Etime FROM t_user_project tup,t_project tp WHERE tup.projectId=tp.id");
        try {
            if (id == null) {
                throw new RuntimeException();
            }
            finder.append(" AND tup.userId=:userId AND tp.isNew=:isNew AND tp.type=:type");
            finder.setParam("userId", id);
            finder.setParam("isNew", "是");
            finder.setParam("type","1");
            if (StringUtils.isNotBlank(deadLine)) {
                if (deadLine.equals("1")) {
                    finder.append(" AND tp.deadLine IN(1,3)");
                } else if (deadLine.equals("2")) {
                    finder.append(" AND tp.deadLine=:deadLine");
                    finder.setParam("deadLine", "1");
                } else if (deadLine.equals("3")) {
                    finder.append(" AND tp.deadLine=:deadLine");
                    finder.setParam("deadLine", "3");
                }
            } else {
                finder.append(" AND tp.deadLine IN(1,3)");
            }
            if (StringUtils.isNotBlank(status)) {
                if (status.equals("1")) {
                    finder.append(" AND tp.status IN(2,5)");
//                    finder.setParam("status", "2");
                } else if (status.equals("2")) {
                    finder.append(" AND tp.status=:status");
                    finder.setParam("status", "3");
                } else if (status.equals("3")) {
                    finder.append(" AND tp.status=:status");
                    finder.setParam("status", "4");
                }
            } else {
                finder.append(" AND tp.status IN(2,5)");
            }
            finder.setEscapeSql(false);
            page.setSort("DESC");
            page.setOrder("tup.createTime");
            maps = pCProjectListService.queryForList(finder, page);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
        returnDatas.setData(maps);
        returnDatas.setPage(page);
        return returnDatas;
    }





    /**
     * 我的交易记录
     */
    @RequestMapping("experience-fund/income/list")
    @ResponseBody
    public Object experienceFundIncome(Integer id, String type, String dateBefore, String dateStart, String dateEnd,
                                       String status, HttpServletRequest r) {
        List<UserExperienceHistory> history = new ArrayList<>();
        List<?> yebHistory = new ArrayList<>();
        List<Map<String, Object>> count = new ArrayList<>();
        Finder finder = new Finder("SELECT * FROM t_user_experience_history ta WHERE 1 = 1");
        Page page = newPage(r);
        try {
            if (id == null) {
                throw new RuntimeException();
            }
            finder.append(" AND ta.userId = :id");
            finder.setParam("id", id);
            if (StringUtils.isNotBlank(dateBefore)) {
                finder.append(" AND ta.createDate >= DATE_SUB(NOW(), INTERVAL :dateBefore DAY) AND ta.createDate <= NOW()");
                finder.setParam("dateBefore", dateBefore);
            } else if (StringUtils.isNotBlank(dateStart) && StringUtils.isNotBlank(dateEnd)) {
                finder.append(" AND ta.createDate >= :dateStart AND ta.createDate <= :dateEnd");
                finder.setParam("dateStart", dateStart + " 00:00:00");
                finder.setParam("dateEnd", dateEnd + " 23:59:59");
            }
            if (StringUtils.isNotBlank(type)) {
                finder.append(" AND FIND_IN_SET(ta.type, :type)");
                finder.setParam("type", type);
            }
            finder.append(" ORDER BY ta.createDate DESC");

            history = pCProjectListService.queryForList(finder, UserExperienceHistory.class, page);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }

        ReturnDatas ret = ReturnDatas.getSuccessReturnDatas();
        ret.setPage(page);
        ret.setData(history);

        return ret;
    }

    /**
     * 还款操作。
     */
    @RequestMapping("doRepay")
    @ResponseBody
    public Object doRepay(String phone, Integer projectId, Double money, HttpServletRequest r) {
        List<Borrower> bows = new ArrayList<>();
        Borrower bow = new Borrower();
        bow.setLegalPersonPhone(phone);

        try {
            if ((bows = borrowerService.findListDataByFinder(null, null, Borrower.class, bow)) == null
                    || bows.size() == 0) {
                throw new PhoneNotExistException();
            }

            bow = bows.get(0);
            projectService.repayment(bow.getId(), projectId, money);

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
     * 我的借款列表
     */
    @RequestMapping("loan/list")
    @ResponseBody
    public Object getLoans(Integer id, Integer status, HttpServletRequest r) {
        List<Map<String, Object>> invests = new ArrayList<>();
        Finder finder = new Finder("SELECT p.*, @a := (SELECT SUM(IF(money IS NULL, 0, money) + IF(totolInterest IS NULL, 0, totolInterest)"
                + " + IF(cardPrice IS NULL, 0, cardPrice)) FROM t_user_project WHERE projectId = p.id)"
                + " ,IF (@a IS NULL, 0, ROUND(@a, 2)) totolInterest FROM (t_app_user au, t_borrower bo, t_project p)"
                + " WHERE bo.legalPersonPhone = au.phone AND p.`borrowerId` = bo.`id`");


        Page page = newPage(r);

        try {
            if (id == null) {
                throw new RuntimeException();
            }

            finder.append(" AND au.id=:id");
            finder.setParam("id", id);
            if (status != null) {
                finder.append(" AND p.status = :status");
                if (status == 5) {
                    status = 3;
                    finder.append(" AND DATE_ADD(p.releaseTime, INTERVAL p.deadline Month) < NOW()");
                }
                finder.setParam("status", status);
            }

            List<Map<String, Object>> count = pCProjectListService.queryForList(new Finder("SELECT COUNT(*) FROM (").appendFinder(finder).append(") t"));
            if (count != null && count.size() != 0) {
                int dataCount = Integer.parseInt(count.get(0).get("COUNT(*)").toString());
                page.setTotalCount(dataCount);
            }

            finder.append(" ORDER BY p.createTime DESC");
            finder.append(" LIMIT " + (~-page.getPageIndex() * page.getPageSize()) + "," + page.getPageSize());
            SimpleDateFormat sdf = new SimpleDateFormat("YYYY.MM.dd");
            invests = pCProjectListService.queryForList(finder);
            if (invests != null) {
                for (int i = 0; i < invests.size(); i++) {
                    if (invests.get(i).get("createTime") != null) {
                        invests.get(i).put("createTime",
                                sdf.format(new Date(((Timestamp) invests.get(i).get("createTime")).getTime())));
                    }

                    if (invests.get(i).get("endTitme") != null) {
                        invests.get(i).put("endTitme",
                                sdf.format(((Timestamp) invests.get(i).get("endTitme")).getTime()));
                    }
                }
            }
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }

        ReturnDatas ret = ReturnDatas.getSuccessReturnDatas();
        ret.setPage(page);
        ret.setData(invests);
        return ret;
    }


    /**
     * 获取未读消息数量
     */
    @RequestMapping("msg/count")
    @ResponseBody
    public Object getMsgCount(HttpServletRequest r, Integer type) {
        List<Map<String, Object>> msgs = new ArrayList<>();
        Page page = newPage(r);

        try {
            ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
            AppUser user = (AppUser) r.getSession().getAttribute(GlobalStatic.PCUSER);
            Finder finder = new Finder("SELECT COUNT(id) FROM t_message WHERE isRead = 0 AND userid = :userId "
                    + "UNION ALL SELECT COUNT(id) FROM t_message where pushType IN(1,2,3,6,8) AND isRead = 0 AND userid = :userId "
                    + "UNION ALL SELECT COUNT(id) FROM t_message where pushType IN(4,5) AND isRead = 0 AND userid = :userId "
                    + "UNION ALL SELECT COUNT(id) FROM t_message where type = 1 AND isRead = 0 AND userid = :userId ");

            finder.setParam("userId", user.getId());
            if (type != null) {
                finder.setParam("type", type);
            }

            msgs = messageService.queryForList(finder);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }

        ReturnDatas ret = ReturnDatas.getSuccessReturnDatas();
        ret.setPage(page);
        ret.setData(msgs);
        return ret;
    }


    /**
     * 删除消息
     */
    @RequestMapping("msg/delete")
    @ResponseBody
    public Object doDeleteMsg(HttpServletRequest r, Integer mid) {
        Page page = newPage(r);
        Message msg = new Message();
        try {
            ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
            AppUser user = (AppUser) r.getSession().getAttribute(GlobalStatic.PCUSER);
            if (mid == null || user == null) {
                throw new RuntimeException("Id");
            }
            msg.setId(mid);
            msg.setUserId(user.getId());
            messageService.deleteByEntity(msg);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }

        ReturnDatas ret = ReturnDatas.getSuccessReturnDatas();
        ret.setPage(page);
        return ret;
    }

    /**
     * 删除用户站内所有信息
     *
     * @return
     */
    @RequestMapping("msg/deletes")
    public Object DeleteMsg(HttpServletRequest request) {
        Page page = newPage(request);
        Message message = new Message();
        try {
            ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
            AppUser appUser = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
            message.setUserId(appUser.getId());
            messageService.deleteMessages(message);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
        ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
        returnDatas.setPage(page);
        return returnDatas;
    }

    /**
     * 将用户通知改为已读
     *
     * @return
     */
    @RequestMapping("mes/reads")
    public Object UpdateMessage(HttpServletRequest request) {
        Message message = new Message();
        try {
            ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
            AppUser appUser = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
            message.setUserId(appUser.getId());
            messageService.updateReda(message);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
        ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
        return returnDatas;
    }


    /**
     * 阅读消息
     */
    @RequestMapping("msg/read")
    @ResponseBody
    public Object doReadMsg(HttpServletRequest r, Integer mid) {
        Page page = newPage(r);
        Message msg = new Message();
        try {
            ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
            AppUser user = (AppUser) r.getSession().getAttribute(GlobalStatic.PCUSER);
            if (mid == null || user == null) {
                throw new RuntimeException("Id");
            }

            msg.setId(mid);
            msg.setUserId(user.getId());
            msg.setIsRead("1");
            messageService.updateValidValue(msg);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }

        ReturnDatas ret = ReturnDatas.getSuccessReturnDatas();
        ret.setPage(page);
        return ret;
    }


    /**
     * 获取用户信息
     */
    @RequestMapping("accountproile")
    @ResponseBody
    public Object getAccountProfile(HttpServletRequest r, Integer userid) {
        Page page = newPage(r);
        Message msg = new Message();
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            AppUser user = (AppUser) r.getSession().getAttribute(GlobalStatic.PCUSER);
            if (user == null && userid == null) {
                throw new RuntimeException("Id");
            }

            Finder finder = new Finder(
                    "SELECT b.name bankName, b.logo, au.name nickname, au.bankNum, au.balance, au.phone, au.idCard,"
                            + " au.ctBalance, au.isIdCard, au.caBalance, au.header, au.realName, au.isIdCard, au.quota, au.yebBalance,"
                            + " au.dateline, au.cardTime, au.lastLogin, au.totalInvestAmount, au.nowInvestAmount, au.cityName, au.isFirst,"
                            + " au.isFirst, au.isFirstProject, au.cuBalance, au.freezeYebBalance, COUNT(m.id) msgNum"
                            + " FROM t_app_user au LEFT JOIN t_bank b ON b.bankId = au.bankId "
                            + " LEFT JOIN t_message m ON m.userId = au.id AND m.isRead = :isRead"
                            + " WHERE au.id = :id LIMIT 0, 1"
            );

            finder.setParam("isRead", "0")
                    .setParam("id", (user == null ? userid : user.getId()));
            list = userCardService.queryForList(finder);
        } catch (RuntimeException e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        } catch (Throwable e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }

        ReturnDatas ret = ReturnDatas.getSuccessReturnDatas();
        ret.setPage(page);
        ret.setData(list);

        return ret;
    }


    public String getRand() {
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


    /**
     * 去富有提现
     */
    @RequestMapping("toWithdrawPage")

    public String toWithdrawPage(HttpServletRequest r, HttpServletResponse res, Double amount) {
        try {
            AppUser user = (AppUser) r.getSession().getAttribute(GlobalStatic.PCUSER);
            AppTransReqData data = new AppTransReqData();
            amount = (double) (amount == null ? 0 : amount);
            int amountInFen = (int) new BigDecimal((double) amount).multiply(new BigDecimal(100f)).doubleValue();
            data.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
            try {
                data.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
            } catch (ParseException e) {
                e.printStackTrace();
            }

            data.setLogin_id(user.getPhone());
            data.setAmt(amountInFen + "");
            data.setPage_notify_url(ConfigReader.getConfig("withdraw_notify_url"));
//			data.setBack_notify_url(ConfigReader.getConfig("withdraw_notify_url"));
            Integer id = appUserService.findAppUserByphone(user.getPhone()).getId();

            Order order = new Order();
            order.setType(2);
            order.setStatus(1);
            order.setUserId(id);
            order.setMoney(amount);
            order.setCreateTime(new Date());
            order.setTradeNo(data.getMchnt_txn_ssn());
            Object orderId = orderService.save(order);

            UserAccountHistory history = new UserAccountHistory();
            history.setUserId(id);
            history.setType(2);
            history.setMoney(amount);
            history.setCreatetime(new Date());
            history.setPoundage((double) 0);
            history.setStatus(1);
            history.setTradeNo(data.getMchnt_txn_ssn());
            history.setOrderId(Integer.parseInt(orderId.toString()));
            userAccountHistoryService.save(history);

            FuiouService.p2p500003(data, res);
        } catch (RuntimeException e) {
            e.printStackTrace();
        } catch (Throwable e) {
            e.printStackTrace();
        }

        return null;
    }


    /**
     * Pc段更换银行卡
     */
    @RequestMapping("changeBankCard")
    public String changeBankCard(HttpServletRequest r, HttpServletResponse res, AppUser au) {
        try {
            AppUser user = (AppUser) r.getSession().getAttribute(GlobalStatic.PCUSER);
            ChangeCard2ReqData data = new ChangeCard2ReqData();
            data.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
            try {

                Order order = new Order();
                String lishui = DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand();
                order.setTradeNo(lishui);
                order.setType(15);
                order.setUserId(user.getId());
                order.setStatus(1);
                order.setCreateTime(new Date());
                orderService.save(order);
                data.setMchnt_txn_ssn(lishui);

                user.setIsreplacebank(lishui);
                appUserService.update(user);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            data.setLogin_id(user.getPhone());
            data.setPage_notify_url(ConfigReader.getConfig("pc_page_notify_url") + "?type=3");
            FuiouService.changeCard2(data, res);
        } catch (RuntimeException e) {
            e.printStackTrace();
        } catch (Throwable e) {
            e.printStackTrace();
        }

        return null;
    }


    /**
     * 更换用户头像
     */
    @RequestMapping("doChangeUserAvatar")
    @ResponseBody
    public Object doChangeUserAvatar(HttpServletRequest r, HttpServletResponse res, AppUser au) {
        ReturnDatas rd = new ReturnDatas();

        try {
            AppUser user = (AppUser) r.getSession().getAttribute(GlobalStatic.PCUSER);
            if (user == null) {
                throw new RuntimeException();
            }

            au.setId(user.getId());
            if (StringUtils.isNotBlank(au.getHeader())) {
                appUserService.updateValidValue(au);
            }
            rd.setStatus(ReturnDatas.SUCCESS);
        } catch (RuntimeException e) {
            e.printStackTrace();
            rd.setStatus(ReturnDatas.ERROR);
        } catch (Throwable e) {
            e.printStackTrace();
            rd.setStatus(ReturnDatas.ERROR);
        }

        return rd;
    }


    /**
     * Pc段更换交易密码
     */
    @RequestMapping("changeTradePassword")
    public String changeTradePassword(HttpServletRequest r, HttpServletResponse res, AppUser au) {
        try {
            AppUser user = (AppUser) r.getSession().getAttribute(GlobalStatic.PCUSER);
            ResetPassWordReqData data = new ResetPassWordReqData();
            data.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
            try {
                data.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
            } catch (ParseException e) {
                e.printStackTrace();
            }

            data.setLogin_id(user.getPhone());
            data.setBack_url(ConfigReader.getConfig("pc_page_notify_url") + "?type=4");
            data.setBusi_tp("3");

            FuiouService.resetPassWord(data, res);
        } catch (RuntimeException e) {
            e.printStackTrace();
        } catch (Throwable e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 手机号检查
     */
    @RequestMapping("checkPhone")
    @ResponseBody
    public Object checkPhone(HttpServletRequest r, HttpServletResponse res, AppUser au) {
        try {
            if (au != null && au.getPhone() != null) {
                au = appUserService.findAppUserByphone(au.getPhone());
                if (au.getId() != null) {
                    return ReturnDatas.getErrorReturnDatas();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ReturnDatas.getSuccessReturnDatas();
    }


    //公告内容
    @RequestMapping("announce/content")
    public String announceContent(HttpServletRequest request, Model model, Integer id, String type, HttpServletResponse rep) {
        try {
            if (id == null || id < 1 || !StringUtils.isNotBlank(type)) {
                throw new IllegalArgumentException();
            }

            IAnnounceService service = announceService;
            Class<?> clazz = Announce.class;
            switch (type) {
                case "announce":
                    service = announceService;
                    break;
                case "companystate":
                    service = companyStateService;
                    clazz = CompanyState.class;
                    break;
                case "news":
                    service = newsService;
                    clazz = News.class;
                    break;
                case "contractsample":
                    service = contractSampleService;
                    clazz = ContractSample.class;
                    break;
            }

            Object adata = service.findById(id, clazz);
            Method getContent = clazz.getMethod("getContent");
            Object value = null;
            rep.setCharacterEncoding("UTF-8");
            if (adata != null && (value = getContent.invoke(adata)) != null) {
                rep.getWriter().write(value.toString());
            } else {
                rep.getWriter().write("没有找到内容！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 债转列表
     */
    @RequestMapping("debt/list/json")
    @ResponseBody
    public Object debtList(Integer status, String recent, String assignreceiver, Date dateStart, Date dateEnd,
                           HttpServletRequest request) {
        ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
        AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
        Finder orderFinder = new Finder("SELECT sio.*, sip.name, " +
                "LEAST(sio.deadline, LEAST(1, FLOOR(TIMESTAMPDIFF(MONTH, sio.valueDate, :curDateStr)))) holdMonths" +
                " FROM t_smart_investment_project sip,")
                .append("t_smart_investment_order sio WHERE sip.id = sio.siProjectId ")
				.setParam("curDateStr", SmartProjectInvestmentServiceImpl.curDateStr());
        Finder debtFinder = new Finder("SELECT sida.*, p.name, sio.id orderId, sio.valueDate, sio.deadline," +
				"LEAST(sio.deadline, LEAST(1, FLOOR(TIMESTAMPDIFF(MONTH, sio.valueDate, :curDateStr)))) holdMonths" +
                " FROM t_smart_investment_project sip,")
                .append("t_smart_investment_order sio, t_smart_investment_debt_assignment sida,t_smart_investment_debt_assignment_item sidai,t_smart_investment_dispersed_project sidp,t_project p")
                .append(" WHERE sida.siOrderId = sio.id AND sio.siProjectId = sip.id")
				.setParam("curDateStr", SmartProjectInvestmentServiceImpl.curDateStr());

        Map<String, String> dateCodeMap = new HashMap<>();
        dateCodeMap.put("m", "MONTH");
        dateCodeMap.put("y", "YEAR");

        Page page = newPage(request);
        page.setPageSize(8);
        Finder finder = null;
        String tableAlias = "sio";
        if (status != null) {
            switch (status) {
                case 1:
                    finder = orderFinder;
                    finder.append(" AND " + tableAlias + ".status = :status").setParam("status", 2);
                    if (assignreceiver == null) {
						finder.append(" AND sio.investmentAmount - sio.assigningAmount > 0");
                    }
                    break;
                case 2:
					tableAlias = "sida";
					finder = debtFinder;
					finder.append(" AND " + tableAlias + ".status = :status").setParam("status", status - 1).append(" AND sida.id=sidai.debtAssignmentId AND sidai.dispersedProjectId=sidp.id AND p.id=sidp.projectId");
					finder.append(" AND sidp.userId = :uId").setParam("uId",user.getId());
					break;
                case 3:
                    finder = new Finder("SELECT DISTINCT sida.*,p.name, sio.id orderId, sio.valueDate, sio.deadline,LEAST(sio.deadline, LEAST(1, FLOOR(TIMESTAMPDIFF(MONTH, sio.valueDate, NOW())))) holdMonths FROM t_smart_investment_debt_receive r,t_smart_investment_debt_assignment sida,t_smart_investment_project sip,t_smart_investment_order sio,t_smart_investment_dispersed_project sidp,t_project p WHERE r.assignerId=:uId AND sidp.id=r.dispersedProjectId AND sidp.siOrderId=sio.id AND sio.siProjectId=sip.id AND sida.siOrderId=sio.id AND p.id=sidp.projectId").setParam("uId",user.getId());
                    break;
				case 4:
					finder = new Finder("SELECT dp.*, p.name,p.code, p.deadLine, p.nextInterest, p.repaymentNum, p.id pid, ")
						.append("ROUND(dp.investmentAmount * p.estimatedAnnualRate / 12 * (p.deadLine - p.repaymentNum), 2) totolInterest ")
						.append("FROM t_smart_investment_dispersed_project dp, ")
						.append("t_project p WHERE dp.projectId = p.id")
						.append(" AND dp.assignStatus = 2 AND dp.userId = :uId")
						.setParam("uId", user.getId());
					tableAlias = "dp";
					break;
            }
        }
        if (recent != null) {
            String actualDateExp = recent.substring(0, recent.length() - 1) + ' ' + dateCodeMap.get(
                    recent.substring(recent.length() - 1));
            finder.append(" AND " + tableAlias + ".createTime >= DATE_SUB(CURDATE(), INTERVAL " + actualDateExp + ")");
        }
        else if (dateStart != null && dateEnd != null) {
            finder.append(" AND " + tableAlias + ".createTime BETWEEN :start AND :end")
                    .setParam("start", dateStart)
                    .setParam("end", dateEnd);
        }

        if (status == 1) {
			finder.append(" AND sio.userId = :uId").setParam("uId", user.getId());
		}
        try {
            List<?> list = pCProjectListService.queryForList(finder, page);
            rt.setData(list);
            rt.setPage(page);
        } catch (Exception e) {
            e.printStackTrace();
            rt.setStatus(ReturnDatas.ERROR);
            rt.setMessage(e.getMessage());
        }

        return rt;
    }

    /**
     * 债转列表
     */
    @RequestMapping("debt/detail")
    @ResponseBody
    public Object debtDetail(Integer id, HttpServletRequest request) {
        ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
        Finder finder = new Finder("SELECT dp.*, i.amount, i.interest, p.name, p.deadLine, p.nextInterest,")
                .append("LEAST(sio.deadline, GREATEST(1, FLOOR(DATEDIFF(:curDateStr, sio.valueDate) / 30))) holdMonths ")
                .append("FROM t_smart_investment_debt_assignment_item i, t_smart_investment_dispersed_project dp, ")
                .append("t_project p WHERE i.dispersedProjectId = dp.id AND dp.projectId = p.id")
                .append(" AND i.debtAssignmentId = :daId")
                .setParam("daId", id);

        Page page = newPage(request);
        try {
            List<?> list = pCProjectListService.queryForList(finder, page);
            rt.setData(list);
            rt.setPage(page);
        } catch (Exception e) {
            e.printStackTrace();
            rt.setStatus(ReturnDatas.ERROR);
            rt.setMessage(e.getMessage());
        }

        return rt;
    }

	@RequestMapping("/smartinvest/detail")
	public String smartInvestDetail(Integer id, HttpServletRequest request) {
		Page p = newPage(request);
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		Finder finder = new Finder("SELECT IFNULL(p.name, o.fakedProjectName) name, o.*, i.holdDays ")
				.append("FROM t_smart_investment_order o LEFT JOIN t_smart_investment_project p ON p.id  = o.siprojectId " +
						"LEFT JOIN t_smart_investment_info i ON i.siorderId = o.id ")
				.append("WHERE o.id = :id")
				.setParam("id", id);

		try {
			rt.setData(pCProjectListService.queryForObject(finder));
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		rt.setPage(p);
		request.setAttribute("data", rt.getData());

		return "pc/my-invest/zhitou-futou";
	}

	/**
	 * 智投相关的散标项目列表
	 */
	@RequestMapping("/order/project/list")
	@ResponseBody
	public Object orderProjectList(Integer id, Integer cate, HttpServletRequest request) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		StringBuilder columnPart = new StringBuilder("SELECT p.name,p.id,dp.investmentAmount, dp.createTime, dp.expiresDate, ")
				.append("TRUNCATE(dp.investmentAmount * o.earningRate / 12 * o.deadLine, 2) totalAmount ");
		StringBuilder fromPart = new StringBuilder("FROM t_smart_investment_order o, t_smart_investment_dispersed_project dp, ")
				.append("t_project p ");
		StringBuilder wherePart = new StringBuilder("WHERE dp.siOrderId = o.id AND p.id = dp.projectId ")
				.append("AND o.id = :id");

		if (cate != null) {
			switch(cate) {
				case 1:
					wherePart.append(" AND dp.status = 1 AND dp.assignStatus < 2");
					break;
				case 2:
					wherePart.append(" AND dp.status >= 2 AND dp.assignStatus < 2");
					break;
				case 3:
					columnPart.append(", dr.interest + dr.amount debtAmount ");
					fromPart.append(", t_smart_investment_debt_receive dr ");
					wherePart.append(" AND dp.assignStatus = 2 AND dr.dispersedProjectId = dp.id");
					break;
			}
		}

		Finder finder = new Finder(columnPart.append(fromPart.toString()).append(wherePart.toString()).toString());
		finder.setEscapeSql(false);
		finder.setParam("id", id);

		Page page = newPage(request);
		page.setPageSize(10);
		page.setOrder("dp.createTime");
		page.setSort("DESC");
		try {
			List<?> list = pCProjectListService.queryForList(finder, page);
			rt.setData(list);
			rt.setPage(page);
		} catch (Exception e) {
			e.printStackTrace();
			rt.setStatus(ReturnDatas.ERROR);
			rt.setMessage(e.getMessage());
		}

		return rt;
	}
}
