package com.cz.yingpu.system.pc;

import com.cz.yingpu.frame.annotation.SecurityApi;
import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.frame.util.fuyou.ConfigReader;
import com.cz.yingpu.system.entity.*;
import com.cz.yingpu.system.exception.*;
import com.cz.yingpu.system.fuyoudata.CommonRspData;
import com.cz.yingpu.system.fuyoudata.QueryChangeCardReqData;
import com.cz.yingpu.system.fuyoudata.QueryChangeCardRspData;
import com.cz.yingpu.system.fuyoudata.RegReqData;
import com.cz.yingpu.system.pc.listener.CommonRegisterEventListener;
import com.cz.yingpu.system.pc.realnamecertificationhandler.CommonHandler;
import com.cz.yingpu.system.service.*;
import com.cz.yingpu.system.web.AppUserController;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.*;


/**
 * 用户管理Controller,PC和手机浏览器用ACE自适应,APP提供JSON格式的数据接口
 *
 * @author 9iu.org<Auto generate>
 * @version 2017-10-09 11:36:47
 * @copyright {@link 9iu.org}
 * @see
 */
@Controller
@RequestMapping(value = "/pc")
public class UserPcController extends BaseController {


    /**
     * 验证码Session key。
     */
    public final static String VALIDATION_CODE_KEY = "VALIDATION_CODE_KEY";

    @Resource
    IBaseSpringrainService baseSpringrainService;

    @Resource
    private ILunboPicService lunboPicService;

    @Resource
    private IAnnounceService announceService;

    @Resource
    private IProjectService projectService;

    @Resource
    private IAppUserService appUserService;

    @Resource
    private IAnnounceService companyStateService;

    @Resource
    private IAnnounceService newsService;

    @Resource
    private AppUserController appUserController;

    @Resource
    private ISmsService smsService;

    @Resource
    private IUserCardService userCardService;

    @Resource
    private IBorrowerService borrowerService;

    @Resource
    private IUserProjectService userProjectService;

    @Resource
    ISysSysparamService sysSysparamService;

    @Resource
    IBankService bankService;

    @Resource
    IOrderService orderService;

    @Resource
    HttpServletRequest request;

    @Resource
    IPCProjectListService pCProjectListService;

    //统计
    @RequestMapping(value = "tongji/json")
    @ResponseBody
    public List<Map<String, Object>> tongji() {
        try {
            //首页数据
            Finder finder = new Finder("SELECT SUM(totalAmount) as total FROM `t_project` WHERE `status` IN (3,4,5)");
            finder.append("UNION  ALL SELECT  SUM(interest)  as total FROM `t_user_project` WHERE projectStatus IN(3,4,5)");
            finder.append("UNION  ALL SELECT COUNT(1)  as total FROM `t_app_user`");
            List<Map<String, Object>> shujus = companyStateService.queryForList(finder);
            //累计成交
            String chengjiao = shujus.get(0).get("total").toString();
            //114557207.81
            chengjiao = String.valueOf(new BigDecimal(chengjiao).add(new BigDecimal("88249000")).doubleValue());
            shujus.get(0).put("total", chengjiao);
            //赚取收益4707644.97
            //chengjiao=shujus.get(1).get("total").toString();
            chengjiao = new BigDecimal(chengjiao).multiply(new BigDecimal(0.07)).toString();
            shujus.get(1).put("total", chengjiao);

            //收获用户
            chengjiao = shujus.get(2).get("total").toString();
            chengjiao = new BigDecimal(chengjiao).add(new BigDecimal("5093")).toString();
            chengjiao = new BigDecimal(chengjiao).subtract(new BigDecimal(17083)).multiply(new BigDecimal(29)).add(new BigDecimal(chengjiao)).toString();
            shujus.get(2).put("total", chengjiao);

            //安全运营
            Map<String, Object> m = new HashMap<String, Object>();
            @SuppressWarnings("deprecation")
            Date date = new Date(117, 10, 01);
            int i = DateUtils.daysBetween(date, new Date());
            chengjiao = 542 + i + "";
            m.put("total", chengjiao);
            shujus.add(m);
            return shujus;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }
	/*//跳转到首页
	@RequestMapping(value="indexs")
	public String indexs(HttpServletRequest request,Model model ){
		// ==构造分页请求
				HashMap<String, List>  map=new HashMap<String, List>();
				long startTime=System.currentTimeMillis();  
				
						Page page = newPage(request);
						// ==执行分页查询
						try {
							LunboPic l=new LunboPic();
							Page p = new Page(1);
							Page p1 = new Page(1);
							Page p2 = new Page(1);
							p.setPageSize(3);
							p1.setPageSize(5);
							p2.setPageSize(3);
							p.setOrder("`weight`DESC,`postTime`DESC");
							p.setSort("`postTime`DESC");
							p1.setOrder("`weight`DESC,`postTime`DESC");
							p1.setSort("`postTime`DESC");
							p2.setOrder("`weight`DESC,`postTime`DESC");
							p2.setSort("`postTime`DESC");
							l.setPosition(3);
							page.setPageIndex(1);
							page.setPageSize(7);
							List<LunboPic> datas=lunboPicService.findListDataByFinder(null,page,LunboPic.class,l);
						*//*	Finder finder=new Finder("select")
							lunboPicService.queryForList(new Finder())*//*
							List<Announce> adata=announceService.findListDataByFinder(null, p1, Announce.class, new Announce());
							Map<String, List<Project>> amap=projectService.loadPcMainProjects();
							map.put("lunbo", datas);
							map.put("gonggao", adata);
							map.put("allproject", amap.get("allproject"));

							map.put("announces", adata);  
							map.put("companystate", companyStateService.findListDataByFinder(null, p2, CompanyState.class, new CompanyState()));
							map.put("news", companyStateService.findListDataByFinder(null, p, News.class, new News()));
							//首页数据
							Finder finder=new Finder("SELECT SUM(totalAmount) as total FROM `t_project` WHERE `status` IN (3,4,5)");
							finder.append("UNION  ALL SELECT  SUM(interest)  as total FROM `t_user_project` WHERE projectStatus IN(3,4,5)");
							finder.append("UNION  ALL SELECT COUNT(1)  as total FROM `t_app_user`");
						    List<Map<String,Object>> shujus=  companyStateService.queryForList(finder);
						   //累计成交
						    String chengjiao=shujus.get(0).get("total").toString();
						    //114557207.81
						    chengjiao= String.valueOf(new BigDecimal(chengjiao).add(new BigDecimal("88249000")).doubleValue()) ;
						    shujus.get(0).put("total",chengjiao);
						  //赚取收益4707644.97
						    chengjiao=shujus.get(1).get("total").toString();
						    chengjiao=new BigDecimal(chengjiao).add(new BigDecimal("4662690.61")).toString();
						    shujus.get(1).put("total",chengjiao);

						  //收获用户
						    chengjiao=shujus.get(2).get("total").toString();
						    chengjiao=new BigDecimal(chengjiao).add(new BigDecimal("5093")).toString();
						    chengjiao= new BigDecimal(chengjiao).subtract(new BigDecimal(17083)).multiply(new BigDecimal(29)).add(new BigDecimal(chengjiao)).toString();
						    shujus.get(2).put("total",chengjiao);
						    
						  //安全运营
						    Map<String, Object> m=new HashMap<String, Object>();
						    @SuppressWarnings("deprecation")
							Date date=new Date(117, 10, 01);
						    int i =  DateUtils.daysBetween(date, new Date());
						    chengjiao=540+i+"";
						    m.put("total", chengjiao);
						    shujus.add(m);
						    map.put("shuju", shujus);
							request.setAttribute("data", map);
							
							long endTime=System.currentTimeMillis(); //获取结束时间
							System.out.println("程序运行时间： "+(endTime-startTime)+"ms");
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
		return "pc/indexs";
	}*/
    //跳转到新版
   /* @RequestMapping(value="index")
    public String index(HttpServletRequest request,Model model ){
        // ==构造分页请求
        HashMap<String, List>  map=new HashMap<String, List>();
        long startTime=System.currentTimeMillis();

        Page page = newPage(request);
        // ==执行分页查询
        try {
            LunboPic l=new LunboPic();
            Page p = new Page(1);
            Page p1 = new Page(1);
            Page p2 = new Page(1);
            p.setPageSize(3);
            p1.setPageSize(5);
            p2.setPageSize(3);
            p.setOrder("`weight`DESC,`postTime`DESC");
            p.setSort("`postTime`DESC");
            p1.setOrder("`weight`DESC,`postTime`DESC");
            p1.setSort("`postTime`DESC");
            p2.setOrder("`weight`DESC,`postTime`DESC");
            p2.setSort("`postTime`DESC");
            l.setPosition(3);
            page.setPageIndex(1);
            page.setPageSize(7);
            List<LunboPic> datas=lunboPicService.findListDataByFinder(null,page,LunboPic.class,l);
						*//*	Finder finder=new Finder("select")
							lunboPicService.queryForList(new Finder())*//*
            List<Announce> adata=announceService.findListDataByFinder(null, p1, Announce.class, new Announce());

			//查询当月的公告
			Finder finder1 = new Finder("SELECT * FROM t_announce WHERE DATE_FORMAT(createTime,'%Y%m')=DATE_FORMAT(CURDATE(),'%Y%m')");
//            //finder1.setParam("createTime","");
			finder1.setEscapeSql(false);
			List<Announce> adatas=announceService.findListDataByFinder(finder1, p1, Announce.class, new Announce());

            Map<String, List<Project>> amap=projectService.loadPcMainProjects();
            map.put("lunbo", datas);
            map.put("gonggao", adata);
			map.put("gonggaoshu",adatas);
            map.put("allproject", amap.get("allproject"));
            map.put("announces", adata);
            map.put("companystate", companyStateService.findListDataByFinder(null, p2, CompanyState.class, new CompanyState()));
            map.put("news", companyStateService.findListDataByFinder(null, p, News.class, new News()));
            //首页数据
            Finder finder=new Finder("SELECT SUM(totalAmount) as total FROM `t_project` WHERE `status` IN (3,4,5)");
            finder.append("UNION  ALL SELECT  SUM(interest)  as total FROM `t_user_project` WHERE projectStatus IN(3,4,5)");
            finder.append("UNION  ALL SELECT COUNT(1)  as total FROM `t_app_user`");
            List<Map<String,Object>> shujus=  companyStateService.queryForList(finder);
            //累计成交
            String chengjiao=shujus.get(0).get("total").toString();
            //114557207.81
            chengjiao= String.valueOf(new BigDecimal(chengjiao).add(new BigDecimal("88249000")).doubleValue()) ;
            shujus.get(0).put("total",chengjiao);
            //赚取收益4707644.97
            //chengjiao=shujus.get(1).get("total").toString();
            chengjiao=new BigDecimal(chengjiao).multiply(new BigDecimal(0.07)).toString();
            shujus.get(1).put("total",chengjiao);

            //收获用户
            chengjiao=shujus.get(2).get("total").toString();
            chengjiao=new BigDecimal(chengjiao).add(new BigDecimal("5093")).toString();
            chengjiao= new BigDecimal(chengjiao).subtract(new BigDecimal(17083)).multiply(new BigDecimal(29)).add(new BigDecimal(chengjiao)).toString();
            shujus.get(2).put("total",chengjiao);

            //安全运营
            Map<String, Object> m=new HashMap<String, Object>();
            @SuppressWarnings("deprecation")
            Date date=new Date(117, 10, 01);
            int i =  DateUtils.daysBetween(date, new Date());
            chengjiao=542+i+"";
            m.put("total", chengjiao);
            shujus.add(m);
            map.put("shuju", shujus);
            request.setAttribute("data", map);

            long endTime=System.currentTimeMillis(); //获取结束时间
            System.out.println("程序运行时间： "+(endTime-startTime)+"ms");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "pc/index";
    }*/

    //跳转到首页
    @RequestMapping(value = "index")
    public String indexs(HttpServletRequest request, Model model) {
        // ==构造分页请求
        HashMap<String, List> map = new HashMap<String, List>();
        long startTime = System.currentTimeMillis();

        Page page = newPage(request);
        // ==执行分页查询
        try {
            LunboPic l = new LunboPic();
            Page p = new Page(1);
            Page p1 = new Page(1);
            Page p2 = new Page(1);
            Page zhuanPage = newPage(request);
            zhuanPage.setPageSize(7);
            p.setPageSize(5);
            p1.setPageSize(9);
            p2.setPageSize(5);
            p.setOrder("`weight`DESC,`postTime`DESC");
            p.setSort("`postTime`DESC");
            p1.setOrder("`weight`DESC,`postTime`DESC");
            p1.setSort("`postTime`DESC");
            p2.setOrder("`weight`DESC,`postTime`DESC");
            p2.setSort("`postTime`DESC");
            l.setPosition(3);
            page.setPageIndex(1);
            page.setPageSize(7);
            List<LunboPic> datas = lunboPicService.findListDataByFinder(null, page, LunboPic.class, l);
						/*	Finder finder=new Finder("select")
							lunboPicService.queryForList(new Finder())*/
            List<Announce> adata = announceService.findListDataByFinder(null, p1, Announce.class, new Announce());

            //查询当月的公告
//            Finder finder1 = new Finder("SELECT * FROM t_announce WHERE DATE_FORMAT(createTime,'%Y%m')=DATE_FORMAT(CURDATE(),'%Y%m')");

//            查询最新的公告，仅显示三条；
//            Finder finder1 = new Finder("SELECT * FROM t_announce ORDER BY postTime DESC LIMIT 3");
//            //finder1.setParam("createTime","");
//            finder1.setEscapeSql(false);
//            List<Announce> adatas = announceService.findListDataByFinder(finder1, p1, Announce.class, new Announce());


            Map<String, List<Project>> amap = projectService.loadPcMainProject();
            map.put("lunbo", datas);
            map.put("gonggao", adata);
//            map.put("gonggaoshu", adatas);
            map.put("fangdairong", amap.get("fangdairong"));
            map.put("youqirong", amap.get("youqirong"));
            map.put("chedairong", amap.get("chedairong"));
            map.put("xinren", amap.get("xinren"));
            map.put("xiaofeidai", amap.get("xiaofei"));
            map.put("xinrenThree",amap.get("xinrenthree"));


            Finder debtFinder = new Finder("SELECT p.*, sidp.assignedAmount, sidp.investmentAmount, sio.status, sidai.id itemId,")
                    .append(" DATEDIFF(:curDate, sidp.startDate) holdDays, DATEDIFF(p.endTitme, :curDate) remainsDays,")
                    .append(" @m := DATEDIFF(:curDate, IFNULL(sidp.lastInterestDay, sidp.startDate)) holdDaysCurMonth,")
                    .append(" sidai.interest debtInterest")
                    .append(" FROM t_smart_investment_debt_assignment sida, t_smart_investment_debt_assignment_item sidai,")
                    .append(" t_smart_investment_dispersed_project sidp, t_project p, t_smart_investment_order sio")
                    .append(" WHERE sidai.debtAssignmentId = sida.id AND sidai.dispersedProjectId = sidp.id")
                    .append(" AND p.id = sidp.projectId AND sida.status = 1 AND sidp.siOrderid = sio.id")
                    .setParam("curDate", new Date());
            debtFinder.setEscapeSql(false);
            map.put("zhaizhuan", pCProjectListService.queryForList(debtFinder, zhuanPage));

            Finder SmartProject3 = new Finder("select * from t_smart_investment_project where status IN(2,4) and deadLine=3 ORDER BY createTime DESC limit 0,1");
            Finder SmartProject6 = new Finder("select * from t_smart_investment_project where status IN(2,4) and deadLine=6 ORDER BY createTime DESC limit 0,1");
            Finder SmartProject9 = new Finder("select * from t_smart_investment_project where status IN(2,4) and deadLine=9 ORDER BY createTime DESC limit 0,1");
            Finder SmartProject12 = new Finder("select * from t_smart_investment_project where status IN(2,4) and deadLine=12 ORDER BY createTime DESC limit 0,1");
//            SmartProject.setParam("status", "2");

            map.put("smart3", projectService.queryForList(SmartProject3));
            map.put("smart6", projectService.queryForList(SmartProject6));
            map.put("smart9", projectService.queryForList(SmartProject9));
            map.put("smart12", projectService.queryForList(SmartProject12));

            map.put("announces", adata);
            map.put("companystate", companyStateService.findListDataByFinder(null, p2, CompanyState.class, new CompanyState()));
            map.put("news", companyStateService.findListDataByFinder(null, p, News.class, new News()));
            //首页数据
            Finder finder = new Finder("SELECT SUM(totalAmount) as total FROM `t_project` WHERE `status` IN (3,4,5)");
            finder.append("UNION  ALL SELECT  SUM(interest)  as total FROM `t_user_project` WHERE projectStatus IN(3,4,5)");
            finder.append("UNION  ALL SELECT COUNT(1)  as total FROM `t_app_user`");
            List<Map<String, Object>> shujus = companyStateService.queryForList(finder);
            //累计成交
           /* String chengjiao = shujus.get(0).get("total").toString();
            //114557207.81
            chengjiao = String.valueOf(new BigDecimal(chengjiao).add(new BigDecimal("88249000")).doubleValue());
            shujus.get(0).put("total", chengjiao);
            //赚取收益4707644.97
            //chengjiao=shujus.get(1).get("total").toString();
            chengjiao = new BigDecimal(chengjiao).multiply(new BigDecimal(0.07)).toString();
            shujus.get(1).put("total", chengjiao);

            //收获用户
            chengjiao = shujus.get(2).get("total").toString();
            chengjiao = new BigDecimal(chengjiao).add(new BigDecimal("5093")).toString();
            chengjiao = new BigDecimal(chengjiao).subtract(new BigDecimal(17083)).multiply(new BigDecimal(29)).add(new BigDecimal(chengjiao)).toString();
            shujus.get(2).put("total", chengjiao);

            //安全运营
            Map<String, Object> m = new HashMap<String, Object>();
            @SuppressWarnings("deprecation")
            Date date = new Date(117, 10, 01);
            int i = DateUtils.daysBetween(date, new Date());
            chengjiao = 542 + i + "";
            m.put("total", chengjiao);
            shujus.add(m);
            map.put("shuju", shujus);*/
            request.setAttribute("data", map);

            long endTime = System.currentTimeMillis(); //获取结束时间
            System.out.println("程序运行时间： " + (endTime - startTime) + "ms");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "pc/newpc/indexfu";
    }

    /**
     * 退出登录
     **/
    @RequestMapping("logout")
    public String logout(HttpServletRequest req) {
        req.getSession().invalidate();
        return "redirect:index";
    }


    @RequestMapping("register")
    public String register() {
        return "pc/rejisterNew";
    }


    @RequestMapping("findpassword")
    public String findpassword() {
        return "pc/find_passward";
    }

    @RequestMapping("downloadborrow")
    public void downloadborrow(HttpServletResponse response) {

        File file;
        try {
            String name = sysSysparamService.findParamBean().getBorrowfileurl();
            file = new File(name);
            downFile(response, file, "九趣贷借款人申请表.docx", false);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


    }

    @RequestMapping("checkPicCode")
    @ResponseBody
    public Object checkCode(HttpSession session, String code) {
        System.out.println((String) session.getAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM));
        if (code != null && code.equalsIgnoreCase(
                (String) session.getAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM))) {
            /*	session.setAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM,"已失效");*/
            return ReturnDatas.getSuccessReturnDatas();
        }
        return ReturnDatas.getErrorReturnDatas();
    }

    @RequestMapping("checkSMSCode")
    @ResponseBody
    public Object checkSMSCode(HttpSession session, String code, String phone) {
        try {
            if (code == null || phone == null) {
                throw new RuntimeException();
            }
            Page p = new Page(1);
            p.setOrder("createTime");
            p.setSort("DESC");
            List<Sms> sms = smsService.findListDataByFinder(null, p, Sms.class, new Sms());
            if (sms.size() == 0 || !sms.get(0).getPhone().equals(phone) || !sms.get(0).getContent().equalsIgnoreCase(code)) {
                throw new RuntimeException();
            }
            return ReturnDatas.getSuccessReturnDatas();
        } catch (RuntimeException e) {
            return ReturnDatas.getErrorReturnDatas();
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
    }

    @RequestMapping("checkSMSCodePhone")
    @ResponseBody
    public Object checkSMSCodePhone(HttpSession session, String code, String phone) {
        try {
            AppUser appUser = (AppUser) session.getAttribute(GlobalStatic.PCUSER);
            if (!appUser.getPhone().equals(phone)) {
                return ReturnDatas.getErrorReturnDatas();
            }
            if (code == null || phone == null) {
                throw new RuntimeException();
            }
            Page p = new Page(1);
            p.setOrder("createTime");
            p.setSort("DESC");
            List<Sms> sms = smsService.findListDataByFinder(null, p, Sms.class, new Sms());
            if (sms.size() == 0 || !sms.get(0).getPhone().equals(phone) || !sms.get(0).getContent().equalsIgnoreCase(code)) {
                throw new RuntimeException();
            }
            return ReturnDatas.getSuccessReturnDatas();
        } catch (RuntimeException e) {
            return ReturnDatas.getErrorReturnDatas();
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
    }

    @RequestMapping(value = "/sendphone/json")
    public @ResponseBody
    ReturnDatas sendsendphonejson(Model model, HttpServletRequest request, HttpServletResponse response, Sms sms, String code) throws Exception {
        if (request.getSession().getAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM) == null) {
            return null;
        }
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        Sms smsRecord = null;
        try {
            AppUser appUser = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
            if (!sms.getPhone().equals(appUser.getPhone())) {
                throw new NoUserException();
            }

            ReturnDatas data = (ReturnDatas) this.checkCode(request.getSession(), code);
            if (data.getStatus().equals("success")) {
                request.getSession().setAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM, "已失效");
                smsRecord = smsService.sendCode(sms);
            } else {
                if (!request.getSession().getAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM).equals("已失效")) {
                    returnObject.setStatus(ReturnDatas.ERROR);
                    returnObject.setMessage("验证码错误");
                } else {
                    returnObject.setStatus("shixiao");
                    returnObject.setMessage("验证码失效，请刷新验证码后重新输入");
                }
            }
        } catch (UserExistException e) {
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("该用户已存在");
        } catch (NoUserException e) {
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("该用户不存在");
        }
        //	returnObject.setData(smsRecord);
        return returnObject;
    }

    @RequestMapping(value = "/send/json")
    public @ResponseBody
    ReturnDatas sendjson(Model model, HttpServletRequest request, HttpServletResponse response, Sms sms, String code) throws Exception {
        if (request.getSession().getAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM) == null) {
            return null;
        }
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        Sms smsRecord = null;
        try {


            ReturnDatas data = (ReturnDatas) this.checkCode(request.getSession(), code);
            if (data.getStatus().equals("success")) {
                request.getSession().setAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM, "已失效");
                smsRecord = smsService.sendCode(sms);
            } else {
                if (!request.getSession().getAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM).equals("已失效")) {
                    returnObject.setStatus(ReturnDatas.ERROR);
                    returnObject.setMessage("验证码错误");
                } else {
                    returnObject.setStatus("shixiao");
                    returnObject.setMessage("验证码失效，请刷新验证码后重新输入");
                }
            }
        } catch (UserExistException e) {
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("该用户已存在");
        } catch (NoUserException e) {
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("该用户不存在");
        }
        //	returnObject.setData(smsRecord);
        return returnObject;
    }

    protected Map<String, String> getParameterMap() {
        Map<String, String> paramMap = new HashMap<>();
        for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
            String[] values = entry.getValue();
            paramMap.put(entry.getKey(), values.length != 0 ? values[0] : "");
        }

        return paramMap;
    }

    private CommonRegisterEventListener listener = new CommonRegisterEventListener();

    /**
     * 新用户注册
     */
    @RequestMapping("doRegister")
    public @ResponseBody
    ReturnDatas register(Model model, AppUser appUser, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        returnObject.setMessage(MessageUtils.ADD_SUCCESS);
        try {
            Page page = newPage(request);
            Map<String, Object> map = new HashMap<>();
            appUser = appUserService.register(appUser, page);
            request.getSession().setAttribute(GlobalStatic.PCUSER, appUser);
            map.put("userId", appUser.getId());
            map.put("phone", appUser.getPhone());
            returnObject.setData(map);
            listener.onRegisterSuccess(appUser, getParameterMap(), baseSpringrainService);
        } catch (NoUserException e) {
            String errorMessage = e.getLocalizedMessage();
            logger.error(errorMessage);
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("邀请人不存在");
        } catch (ParameterErrorException e) {
            String errorMessage = e.getLocalizedMessage();
            logger.error(errorMessage);
            returnObject.setStatus(ReturnDatas.ERROR);
            //returnObject.setMessage("参数缺失");
        } catch (PhoneExistException e) {
            String errorMessage = e.getLocalizedMessage();
            logger.error(errorMessage);
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("该手机号已注册");
        } catch (VerifyCodeFailException e) {
            String errorMessage = e.getLocalizedMessage();
            logger.error(errorMessage);
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("验证码错误");
        } catch (Exception e) {
            String errorMessage = e.getLocalizedMessage();
//			logger.error(errorMessage);
            e.printStackTrace();
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage(MessageUtils.ADD_FAIL);
        }
        return returnObject;
    }

    //跳转活动中心
    @RequestMapping("active_center")
    public String active_center() {
        return "pc/html/active_center";
    }

    /**
     * 设置支付密码 验证验证码
     */
    @RequestMapping("setuppassword")
    public @ResponseBody
    ReturnDatas settingps(HttpServletRequest request, String phone, String code, String password) throws Exception {
        if (StringUtils.isBlank(code) || StringUtils.isBlank(password) || StringUtils.isBlank(phone))
            return new ReturnDatas(ReturnDatas.ERROR, "请填写完整信息");
        AppUser userQuery = new AppUser();
        userQuery.setPhone(phone);
        AppUser user = appUserService.queryForObject(userQuery);
        if (user == null)
            return new ReturnDatas(ReturnDatas.ERROR, "该用户不存在");
        Sms sms = new Sms();
        sms.setContent(code);
        sms.setPhone(user.getPhone());
        sms.setType(6);
        Sms smsResult = smsService.queryForObject(sms);
        if (smsResult == null)
            return new ReturnDatas(ReturnDatas.ERROR, "验证码错误");
        user.setTradPassword(CryptAES.AES_Encrypt(password));
        user.setErrorNum(0);
        appUserService.update(user, true);
        request.getSession().setAttribute(GlobalStatic.PCUSER, user);
        return new ReturnDatas(ReturnDatas.SUCCESS, "成功");
    }

    /**
     * 新增/修改 操作吗,返回json格式数据
     */
    @RequestMapping("doFindPassword")
    public @ResponseBody
    ReturnDatas findPwd(HttpServletRequest request, String phone, String code, String password) throws Exception {
        if (StringUtils.isBlank(code) || StringUtils.isBlank(password) || StringUtils.isBlank(phone))
            return new ReturnDatas(ReturnDatas.ERROR, "请填写完整信息");
        AppUser userQuery = new AppUser();
        userQuery.setPhone(phone);
        AppUser user = appUserService.queryForObject(userQuery);
        if (user == null)
            return new ReturnDatas(ReturnDatas.ERROR, "该用户不存在");
        Sms sms = new Sms();
        sms.setContent(code);
        sms.setPhone(user.getPhone());
        sms.setType(4);
        Sms smsResult = smsService.queryForObject(sms);
        if (smsResult == null)
            return new ReturnDatas(ReturnDatas.ERROR, "验证码错误");
        user.setPassword(CryptAES.AES_Encrypt(password));
        appUserService.update(user, true);
        return new ReturnDatas(ReturnDatas.SUCCESS, "成功");
    }

    //跳转到login
    @RequestMapping(value = "login")
    public String login(HttpServletRequest request) {
        // ==构造分页请求

        return "pc/loginNew";
    }

    //跳转到我要借款
    @RequestMapping(value = "borrow")
    public String borrow(HttpServletRequest request) {
        // ==构造分页请求
        return "pc/html/borrow";
    }

    @RequestMapping(value = "huidiao/json")
    public String huitiao(HttpServletRequest req) {
        if ("2".equals(req.getParameter("type"))) {
            return "redirect:../myaccount/deposit?type=" + req.getParameter("type");
        } else {
            return "redirect:../myaccount/withdraw_deposit.html?type=" + req.getParameter("type");
        }

    }

    @RequestMapping(value = "xiugaiu/dong")
    @ResponseBody
    public String xiugaiu() {
        try {
            Finder finder = new Finder("SELECT *  FROM `t_project`  WHERE startTime >= :startTime1  AND startTime<=:startTime2 ");
            finder.setParam("startTime1", "2016-05-05 00:10:00");
            finder.setParam("startTime2", "2017-09-20 10:00:00");

            List<Project> plist = projectService.queryForList(finder, Project.class);
            Integer year = 0, month = 0, day = 0;
            Date date = null;
            for (Project project : plist) {
                try {
                    year = Integer.parseInt(project.getName().substring(3, 7));
                    month = Integer.parseInt(project.getName().substring(7, 9));
                    day = Integer.parseInt(project.getName().substring(9, 11));
                    date = new Date(year - 1900, month - 1, day, 11, 0);
                    System.out.println("项目的名字" + project.getName());
                    System.out.println("修改后的日期" + DateUtils.convertDate2String("yyyy-MM-dd HH:mm:ss", date));
                    project.setStartTime(DateUtils.formatDate("yyyy-MM-dd HH:mm:ss", date));
                    project.setCreateTime(DateUtils.formatDate("yyyy-MM-dd HH:mm:ss", date));

                    projectService.update(project);

                } catch (NumberFormatException e) {
                    // TODO: handle exception
                    continue;
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            //e.printStackTrace();
        }
        return "ok";
    }

    @RequestMapping(value = "xiugaiu1/dong")
    @ResponseBody
    public String xiugaiu1() {
        int count = 0;
        try {
            Finder finder = new Finder("SELECT *  FROM `t_project`  WHERE startTime >= :startTime1  AND startTime<=:startTime2 ");
            finder.setParam("startTime1", "2016-05-05 00:10:00");
            finder.setParam("startTime2", "2017-09-20 10:00:00");

            List<Project> plist = projectService.queryForList(finder, Project.class);
            List<UserProject> ulist = null;

            Date date = null;
            for (Project project : plist) {
                try {
                    date = project.getStartTime();


                    finder = new Finder("SELECT *   FROM t_user_project  where projectId=:projectId");
                    finder.setParam("projectId", project.getId());

                    ulist = userProjectService.queryForList(finder, UserProject.class);

                    for (UserProject userProject : ulist) {
                        if (userProject != null) {
                            count++;
                            int i = (int) (10 + Math.random() * (40 - 20 + 1));
                            date = DateUtils.addMinute(i, date);
                            userProject.setCreateTime(DateUtils.formatDate("yyyy-MM-dd HH:mm:ss", date));
                            userProjectService.update(userProject);
                        }
                    }
				/*project.setStartTime(DateUtils.formatDate("yyyy-MM-dd HH:mm:ss", date));
				project.setCreateTime(DateUtils.formatDate("yyyy-MM-dd HH:mm:ss", date));
				
				projectService.update(project);*/

                } catch (NumberFormatException e) {
                    // TODO: handle exception
                    continue;
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            //e.printStackTrace();
            e.printStackTrace();
        }
        System.out.println("修改的投资数量" + count);
        return "ok";
    }


    //跳转到项目详情
    @RequestMapping(value = "projectdetails")
    public String projectdetails(HttpServletRequest request, Model model) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        long beginTimeMillis = System.currentTimeMillis();

        try {
            Integer projectid = Integer.parseInt(request.getParameter("projectid"));
            AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
            Integer userid = null;
            if (user != null) {
                userid = user.getId();
            }
            Integer i = null;
            Project project = projectService.findById(projectid, i);

            List<Project> proList = new ArrayList<Project>();
            proList.add(project);
            if (userid != null) {
                UserCard userCard = new UserCard();
                userCard.setUserId(userid);
                userCard.setStatus(1);
                userCard.setDeadLine(project.getDeadLine());
                map.put("usercard", userCardService.findUserCard(null, userCard));
                System.out.println("#1: " + (System.currentTimeMillis() - beginTimeMillis));
                /*  UserProject userProject=new UserProject();
                    userProject.setUserId(user.getId());;
                    Finder finder=new Finder("select status from t_user_project where userId=:userId and projectId=:projectId");
                    finder.setParam("userId", user.getId());
                    finder.setParam("projectId", request.getParameter("projectid"));
                   List<Map<String, Object>> ul= 	userProjectService.queryForList(finder);
                   if(ul.size()>0){
                       if(ul.get(0).get("status").equals(1)){
                           map.put("isproject","即将上线");
                       }else if(ul.get(0).get("status").equals(2)){
                           map.put("isproject","待放款");
                       }else if(ul.get(0).get("status").equals(3)){
                           map.put("isproject","还款中");
                       }else if(ul.get(0).get("status").equals(4)){
                           map.put("isproject","已结束");
                       }else if(ul.get(0).get("status").equals(5)){
                           map.put("isproject","已满标");
                       }
                   }else{

                       if(project.getStatus().equals(1)){
                           map.put("isproject","即将上线");
                       }else if(project.getStatus().equals(2)){
                          // map.put("isproject","待放款");
                       }else if(project.getStatus().equals(3)){
                           map.put("isproject","还款中");
                       }else if(project.getStatus().equals(4)){
                           map.put("isproject","已结束");
                       }else if(project.getStatus().equals(5)){
                           map.put("isproject","已满标");
                       }
                   }*/
                if (project.getStatus().equals(1)) {
                    map.put("isproject", "即将上线");
                } else if (project.getStatus().equals(2)) {
                    // map.put("isproject","待放款");
                } else if (project.getStatus().equals(3)) {
                    map.put("isproject", "还款中");
                } else if (project.getStatus().equals(4)) {
                    map.put("isproject", "已结束");
                } else if (project.getStatus().equals(5)) {
                    map.put("isproject", "已满标");
                }
            }
            if (proList.size() > 0) {

                BorrowUser queryBorrowUser = new BorrowUser();
                List<BorrowUser> BuserList = new ArrayList<>();
                queryBorrowUser.setProjectID(projectid);
                BorrowUser borrowUser =  borrowerService.queryForObject(queryBorrowUser);
                BuserList.add(borrowUser);
                map.put("borrowUser", BuserList);

//                Borrower borrower = borrowerService.findBorrowerById(proList.get(0).getBorrowerId());
//
//                List<Borrower> bList = new ArrayList<Borrower>();
//                bList.add(borrower);
//                map.put("borrower", bList);
            }
            System.out.println("#2: " + (System.currentTimeMillis() - beginTimeMillis));
            map.put("project", proList);
            request.setAttribute("data", map);

            if (proList.get(0).getCategoryId() == 13) {
                return "pc/my-invest/my-invest-car";
            } else if (proList.get(0).getCategoryId() == 14) {
//                System.out.println("该标是优企融");
                return "pc/my-invest/my-invest-company";
            } else if (proList.get(0).getCategoryId() == 15) {
//                System.out.println("该标是房贷融");
                return "pc/my-invest/my-invest-hourse";
            } else {
                return "pc/my-invest/my-invest-xiaofeidai";

            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
//        return "pc/html/projectdetails";
        return "";
    }

    @RequestMapping("/getProjectDetails")
    public String getProjectDetails(HttpServletRequest request){
        HashMap<String, Object> map = new HashMap<String, Object>();
        try {
            Integer projectid = Integer.parseInt(request.getParameter("projectid"));
            Integer i=null;
            Project project = projectService.findById(projectid,i);
            List<Project> proList = new ArrayList<>();
            proList.add(project);
            if(proList.size()>0){
                BorrowUser queryBorrowUser = new BorrowUser();
                List<BorrowUser> BuserList = new ArrayList<>();
                queryBorrowUser.setProjectID(projectid);
                BorrowUser borrowUser =  borrowerService.queryForObject(queryBorrowUser);
                BuserList.add(borrowUser);
                map.put("borrowUser", BuserList);
            }
            map.put("project",proList);
            request.setAttribute("data",map);
            if(proList.get(0).getCategoryId() == 13){
                return "pc/my-invest/zhitou-car";
            }else if(proList.get(0).getCategoryId() == 14){
                return "pc/my-invest/zhitou-company";
            }else if (proList.get(0).getCategoryId() == 15){
                return "pc/my-invest/zhitou-house";
            }else{
                return "pc/my-invest/zhitou-xiaofei";
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public static void main(String[] args) {
        List<Bank> banklist = null;
        for (Bank bank : banklist) {
            System.out.println(bank);
        }
    }

    /**
     * 用户denglu
     */
    @RequestMapping("login/json")
    public @ResponseBody
    ReturnDatas login(Model model, AppUser appUser, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        returnObject.setMessage(MessageUtils.SELECT_SUCCESS);
        try {
            if (request.getSession().getAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM).equals(request.getParameter("code"))) {
                Page page = newPage(request);
                appUser.setType("1");
                AppUser user = appUserService.login(appUser, page);
                appUser.setPhone(request.getParameter("phone"));
                appUser.setPassword(request.getParameter("password"));
                //若是用户有更换银行卡去富友查询更换结果
                if (user.getIsreplacebank() != null && !"否".equals(user.getIsreplacebank())) {
                    QueryChangeCardReqData queryChangeCardReqData = new QueryChangeCardReqData();
                    queryChangeCardReqData.setLogin_id(user.getPhone());
                    queryChangeCardReqData.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
                    queryChangeCardReqData.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
                    queryChangeCardReqData.setTxn_ssn(user.getIsreplacebank());
                    QueryChangeCardRspData data = FuiouService.queryChangeCard(queryChangeCardReqData);
                    if (data.getResp_code().equals("0000")) {
                        if (data.getExamine_st().equals("1")) {
                            user.setIsreplacebank("否");
                            user.setBankNum(data.getCard_no());
                            List<Bank> banklist = bankService.queryForList(new Finder("select * from t_bank"), Bank.class);
                            if (banklist != null) {
                                for (Bank bank : banklist) {
                                    if (data.getBank_nm().contains(bank.getName())) {
                                        user.setBankId(bank.getBankId());
                                        break;
                                    }
                                }
                            }
                            appUserService.updateValidValue(user);
						/*	Bank bank=new Bank();
							bank.setName(data.getBank_nm());
							bank=bankService.queryForObject(bank);
							user.setBankId(bank.getBankId());
							*/
                            Order order = new Order();
                            order.setTradeNo(data.getTxn_ssn());
                            order = orderService.queryForObject(order);
                            if (order != null) {
                                order.setStatus(2);

                                orderService.update(order);
                            }
                        } else if (data.getExamine_st().equals("2")) {
                            user.setIsreplacebank("否");
                            appUserService.updateValidValue(user);
                            Order order = new Order();
                            order.setTradeNo(data.getTxn_ssn());
                            order = orderService.queryForObject(order);
                            if (order != null) {
                                order.setStatus(3);
                                order.setPs(data.getRemark());
                                orderService.update(order);
                            }
                        }
                    } else {
                        user.setIsreplacebank("否");
                        appUserService.updateValidValue(user);
                        Order order = new Order();
                        if (!"".equals(data.getTxn_ssn())) {
                            order.setTradeNo(data.getTxn_ssn());
                            order = orderService.queryForObject(order);
                            if (order != null) {
                                order.setStatus(3);
                                orderService.update(order);
                            }
                        }
                    }

                }
				/*//给用户生成token，并将token塞到缓存中，以验证token是否失效
				Token token = appUserService.getToken(user.getId());
				user.setToken(token.getToken());*/
                returnObject.setData(user);
                returnObject.setStatus("ok");

                user = appUserService.findAppUserById(user.getId());
                request.getSession().setAttribute(GlobalStatic.PCUSER, user);
            } else {
                returnObject.setMessage("验证码错误");
                returnObject.setStatus("no");
            }

        } catch (ParameterErrorException e) {
            String errorMessage = e.getLocalizedMessage();
            logger.error(errorMessage);
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("参数缺失");
        } catch (PhoneNotExistException e) {
            String errorMessage = e.getLocalizedMessage();
            logger.error(errorMessage);
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage("用户名或密码错误");
        } catch (Exception e) {
            String errorMessage = e.getLocalizedMessage();
            logger.error(errorMessage);
            e.printStackTrace();
            returnObject.setStatus(ReturnDatas.ERROR);
            returnObject.setMessage(MessageUtils.ADD_FAIL);
        }
        return returnObject;
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


    private CommonHandler realNameCertificationCommonHandler = new CommonHandler();

    /**
     * 富有用户注册
     */
    @RequestMapping("FYUserReg")
    @ResponseBody
    public Object fyUserReg(AppUser user, RegReqData reqData, HttpSession session) {

        Map<String, String> paramMap = new HashMap<String, String>();
        RegReqData data = new RegReqData();

        data.setVer(ConfigReader.getConfig("ver"));
        data.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
        try {
            data.setMchnt_txn_ssn(DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        data.setCust_nm(user.getRealName());
        data.setCertif_tp("0");
        data.setCertif_id(user.getIdCard());
        data.setMobile_no(user.getPhone());
        data.setCity_id(reqData.getCity_id());
        data.setParent_bank_id("0" + reqData.getParent_bank_id());
//		data.setBank_nm(reqData.getBank_nm());
        data.setCapAcntNo(user.getBankNum());

        try {
            CommonRspData rsp = FuiouService.reg(data);
            if (!"0000".equals(rsp.getResp_code())) {
                throw new RuntimeException("对不起注册失败，原因：" + rsp.getResp_desc());
            }

            if (user.getId() != null) {
                user.setPhone(null);
                user.setIsIdCard("是");
                user.setBankId(Integer.parseInt(reqData.getParent_bank_id()));
                user.setCardTime(new Date());
                Map<String,Object> map = appUserService.queryForObject(new Finder("SELECT name FROM t_bank_area WHERE Code=:code").setParam("code",reqData.getCity_id()));
                user.setCityId(Integer.parseInt(reqData.getCity_id()));
                user.setCityName(String.valueOf(map.get("name")));
                appUserService.updateValidValue(user);
                realNameCertificationCommonHandler.handle(user, baseSpringrainService);
            }

            return ReturnDatas.getSuccessReturnDatas();
        } catch (RuntimeException e) {
            e.printStackTrace();
            return new ReturnDatas(ReturnDatas.ERROR, e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
    }

    /**
     * 获取省市县
     *
     * @param code 父级区域代码
     */
    @RequestMapping("regions/list")
    @ResponseBody
    public Object getRegions(HttpServletRequest req, Integer code) {
        Finder finder = new Finder("SELECT * FROM t_bank_area WHERE parentCode = :code");
        Page page = newPage(req);
        finder.setParam("code", code != null ? code.toString() : "-1");

        try {
            List<Map<String, Object>> list = appUserService.queryForList(finder);
            ReturnDatas ret = new ReturnDatas(ReturnDatas.SUCCESS, "", list);
            return ret;
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
    }

    /**
     * 获取银行
     */
    @RequestMapping("banks/list")
    @ResponseBody
    public Object getBanks(HttpServletRequest req) {
        try {
            List<Bank> banks = companyStateService.findListDataByFinder(null, null, Bank.class, new Bank());
            return new ReturnDatas(ReturnDatas.SUCCESS, "", banks);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
    }

    /**
     * 获取省市县
     *
     * @param code 父级区域代码
     */
    @RequestMapping("appRegions/list")
    @SecurityApi
    @ResponseBody
    public Object getAppRegions(HttpServletRequest req, Integer code) {
        Finder finder = new Finder("SELECT * FROM t_bank_area WHERE parentCode = :code");
        Page page = newPage(req);
        finder.setParam("code", code != null ? code.toString() : "-1");

        try {
            List<Map<String, Object>> list = appUserService.queryForList(finder);
            ReturnDatas ret = new ReturnDatas(ReturnDatas.SUCCESS, "", list);
            return ret;
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
    }

    /**
     * 获取银行
     */
    @RequestMapping("appBanks/list")
    @SecurityApi
    @ResponseBody
    public Object getAppBanks(HttpServletRequest req) {
        try {
            List<Bank> banks = companyStateService.findListDataByFinder(null, null, Bank.class, new Bank());
            return new ReturnDatas(ReturnDatas.SUCCESS, "", banks);
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
    }


    /**
     * 获取2018世界杯竞猜数据
     */
    @RequestMapping("/worldcup/2018/guess_info/list")
    @ResponseBody
    public Object getWorldCup2018GuessInfo(HttpServletRequest req) {
        AppUser appUser = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

        try {
            if (appUser == null) {
                throw new RuntimeException();
            }

            Finder finder = new Finder("SELECT tt.startTime, tt.isWinner, tt.matchTeams, ugi.* FROM (")
                    .append(" SELECT GROUP_CONCAT(t.chineseName separator ' vs ') matchTeams, m.startTime, si.isWinner, si.matchId")
                    .append(" FROM (t_world_cup_2018_team t, t_world_cup_2018_match m, t_world_cup_2018_score_info si)")
                    .append(" WHERE si.matchId = m.id AND t.id = si.teamId AND m.startDate < DATE_FORMAT(NOW(), '%Y%-%m-%d') GROUP BY m.id) tt")
                    .append(" INNER JOIN t_world_cup_2018_user_guess_info ugi ON ugi.matchId = tt.matchId AND ugi.userId = :uId")
                    .append(" ORDER BY ugi.guessTime DESC")
                    .setParam("uId", appUser.getId());
            finder.setEscapeSql(false);
            Page page = newPage(req);
            List<?> list = companyStateService.queryForList(finder, page);
            ReturnDatas rt = new ReturnDatas(ReturnDatas.SUCCESS, "", list);
            rt.setPage(page);
            return rt;
        } catch (Exception e) {
            e.printStackTrace();
            return ReturnDatas.getErrorReturnDatas();
        }
    }

    /**
     * 用户风险等级录入
     */
    @RequestMapping("/setRiskRating")
    @ResponseBody
    public ReturnDatas setRiskRating(String riskRating, Integer id) throws Exception {

        ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
        AppUser appUser = new AppUser();
        Map<String, Object> map = new HashMap<>();
        if (id == null) {
            throw new RuntimeException();
        }
        Finder finderRiskrating = new Finder("select riskrating from t_app_user where id=:userId");
        finderRiskrating.setParam("userId", id);
        map = appUserService.queryForObject(finderRiskrating);
        if (map.get("riskrating") == null || map.get("riskrating") == " ") {
            Finder finder = new Finder("update t_app_user set riskrating=:riskrating where id=:userId");
            finder.setParam("userId", id);
            finder.setParam("riskrating", riskRating);
            appUserService.update(finder);
        } else {
            returnDatas.setMap(map);
            returnDatas.setMessage("您已经完成测评!");
        }
        return returnDatas;
    }

    /**
     * 验证码
     * @return
     */
    @RequestMapping("/getYanZhengMa")
    @ResponseBody
    public ReturnDatas getYanZhengMa(HttpServletRequest request){
        ReturnDatas returnDatas = ReturnDatas.getSuccessReturnDatas();
        if(request.getSession().getAttribute(GlobalStatic.DEFAULT_CAPTCHA_PARAM).equals(request.getParameter("code"))){
            returnDatas.setStatus("ok");
        }else{
            returnDatas.setMessage("验证码错误");
            returnDatas.setStatus("no");
        }
        return returnDatas;
    }

	@RequestMapping("/userCode")
	@ResponseBody
	public AppUser userCode(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception{
		String userCode = request.getParameter("userCode");
		Finder finder = new Finder("SELECT * FROM t_app_user WHERE userCode=:userCode").setParam("userCode",userCode);
		AppUser user = appUserService.queryForObject(finder,AppUser.class);
		return user;
	}


}
