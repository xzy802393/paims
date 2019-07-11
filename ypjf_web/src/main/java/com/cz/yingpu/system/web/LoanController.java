package com.cz.yingpu.system.web;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
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
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.Loan;
import com.cz.yingpu.system.entity.Order;
import com.cz.yingpu.system.entity.SignConfig;
import com.cz.yingpu.system.entity.SysSysparam;
import com.cz.yingpu.system.entity.UserSignHis;
import com.cz.yingpu.system.entity.UserYebHistory;
import com.cz.yingpu.system.entity.YebRate;
import com.cz.yingpu.system.service.IAppUserService;
import com.cz.yingpu.system.service.ILoanService;
import com.cz.yingpu.system.service.IOrderService;
import com.cz.yingpu.system.service.ISignConfigService;
import com.cz.yingpu.system.service.ISysSysparamService;
import com.cz.yingpu.system.service.IUserSignHisService;
import com.cz.yingpu.system.service.IUserYebHistoryService;
import com.cz.yingpu.system.service.IYebRateService;
import com.cz.yingpu.system.task.YebTask;

/**
 * 用户管理Controller,PC和手机浏览器用ACE自适应,APP提供JSON格式的数据接口
 *
 * @copyright {@link 9iu.org}
 * @author 9iu.org<Auto generate>
 * @version 2014-06-26 11:36:47
 * @see org.springrain.springrain.web.User
 */
@Controller
@RequestMapping(value = "/system/loan")
public class LoanController extends BaseController {
	@Resource
	private ILoanService loanService;
	
	 @Resource
	    private IAppUserService appUserService;
	    @Resource
	    private IUserYebHistoryService userYebHistoryService;
	    @Resource
	    private IYebRateService yebRateService;
	    
	    
	    
	    @Resource
	    private ISignConfigService signConfigService ;
	    @Resource
	    private IUserSignHisService userSignHisService;
	    @Resource
	    private IOrderService orderService;
	    @Resource
	    private ISysSysparamService sysSysparamService ;

	private String listurl = "/loan/loanList";
	
	
	/**
	 * 列表数据,调用listjson方法,保证和app端数据统一
	 *
	 * @param request
	 * @param model
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model, Loan loan)
			throws Exception {
		ReturnDatas returnObject = listjson(request, model, loan);
		Page p = newPage(request);
		model.addAttribute("pageIndex", p.getPageIndex() == null ? 1 : p.getPageIndex());
		model.addAttribute(GlobalStatic.returnDatas, returnObject);
		
		return listurl;
	}

	
	/**
	 * json数据,为APP提供数据
	 *
	 * @param request
	 * @param model
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model, Loan loan)
			throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		Page page = newPage(request);
		List<Loan> datas = loanService.findListDataByFinder(null, page,
				Loan.class, loan);
		returnObject.setQueryBean(loan);
		returnObject.setPage(page);
		returnObject.setData(datas);
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
	
	@RequestMapping("/bufa2/json")
	 public void signMoney() throws  Exception{
	        logger.info("***********************签到分钱*****************");
	        //查出当天的总金额
//	        Finder finder = new Finder("select * from t_sign_config where createDate like :date");
//	        finder.setParam("date","%"+ DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(new Date(), -1))+"%");
//	        SignConfig signConfig = signConfigService.queryForObject(finder,SignConfig.class);
	        try {
	            SignConfig signConfig = new SignConfig();
	            SysSysparam sysparam = new SysSysparam() ;
	            sysparam.setCode("signTotalAmount");
	            sysparam = sysSysparamService.queryForObject(sysparam) ;
	            signConfig.setMoney(Double.valueOf(sysparam.getValue()));
	          
	            //获取今天已签到人数
	            Finder finder = new Finder("select CONVERT(count(id),DECIMAL) sum from t_user_sign_his where createTime like :date  ");
	            finder.setParam("date","%"+com.cz.yingpu.frame.util.DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(new Date(), -1))+"%");
	            Map<String,Object> object = userSignHisService.queryForObject(finder);
	            //若是签到的总人数不是0，则进行分钱操作
	            if (object.containsKey("sum") && !"0".equals(object.get("sum").toString())){
	                signConfig.setTotalNumber(Integer.valueOf(object.get("sum").toString()));
	                BigDecimal everyMoney = new BigDecimal(signConfig.getMoney()).divide(
	                		new BigDecimal(signConfig.getTotalNumber()),2,BigDecimal.ROUND_HALF_UP
	                		) ;

	                //查出所有的签到用户
	                finder = new Finder("select * from t_user_sign_his where  isSend=:isSend and createTime like :date ");
	                finder.setParam("isSend","否");
	                finder.setParam("date","%"+ com.cz.yingpu.frame.util.DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(new Date(), -1))+"%");
	                List<UserSignHis> userSignHiss = userSignHisService.queryForList(finder,UserSignHis.class);
	                if(null!=userSignHiss && userSignHiss.size() > 0){
	                    for (UserSignHis userSignHis:userSignHiss){
	                        userSignHis.setMoney(everyMoney.doubleValue());
	                        userSignHis.setIsSend("是");
	                        userSignHisService.update(userSignHis,true);
//	                    	AppUser appUser = appUserService.findAppUserById(userSignHis.getUserId());
	                        AppUser appUser = appUserService.findById(userSignHis.getUserId(),AppUser.class);
	                        //构建订单
	                        Order order = new Order();
	                        order.setUserId(appUser.getId());
	                        order.setTradeNo(com.cz.yingpu.frame.util.DateUtils.setDateFormat(new Date(),"yyyyMMddHHmmss")+getRand());
	                        order.setCreateTime(new Date());
	                        order.setMoney(everyMoney.doubleValue());
	                        order.setType(11);
	                        order.setStatus(2);
	                        int orderId = Integer.parseInt(orderService.save(order).toString());
	                        UserYebHistory userYebHistory = new UserYebHistory();
	                        userYebHistory.setType(5);
	                        userYebHistory.setMoney(everyMoney.doubleValue());
	                        userYebHistory.setCreateTime(new Date());
	                        userYebHistory.setUserId(appUser.getId());
	                        userYebHistory.setOrderId(orderId);
	                        userYebHistory.setNowBalance(appUser.getYebBalance());
	                        userYebHistory.setTradeNo(order.getTradeNo());
	                        userYebHistoryService.saveorupdate(userYebHistory);
	                        BigDecimal yebBalance = new BigDecimal("00");
	                        if(null!=appUser.getYebBalance()){
	                            yebBalance = new BigDecimal(appUser.getYebBalance()).add(everyMoney);
	                        }else{
	                            yebBalance = everyMoney;
	                        }
	                        appUser.setYebBalance(yebBalance.doubleValue());
	                        appUserService.update(appUser,true);
	                    }
	                }
	            }
	        }catch (Exception e){
	            e.printStackTrace();
	        }


	    }
	
	@RequestMapping("/bufa/json")
	public @ResponseBody
	String bufa(HttpServletRequest request, Model model, Loan loan)
			throws Exception {
		  logger.info("********************余额宝收益***************************");
	        Finder finder = new Finder("select * from t_yeb_rate where createDate like :date ");
	        int day=Integer.parseInt(request.getParameter("day"));
	        finder.setParam("date","%"+ com.cz.yingpu.frame.util.DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(new Date(), -day))+"%");
	        YebRate yebRate = yebRateService.queryForObject(finder,YebRate.class);
	        //计算余额宝的日利率
	        BigDecimal dayRate = new BigDecimal(yebRate.getRate()).divide(new BigDecimal(365),5,BigDecimal.ROUND_HALF_UP);
	     
	        List<AppUser> appUsers = appUserService.queryForList(new Finder("select * from t_app_user where yebBalance >0"),AppUser.class);
	        if(null != appUsers && appUsers.size() > 0){
	            for (AppUser appUser :appUsers){
	                //计算用户的余额宝总金额，体验金+余额宝余额
	                BigDecimal yebMoney = new BigDecimal(appUser.getYebBalance()).add(new BigDecimal(appUser.getQuota()));
	                //上边的钱要减去T+1的钱
	                //查出来不符合T+1的钱
	                Finder finderExcept  = Finder.getSelectFinder(UserYebHistory.class,"sum(money) as money") ;
	                finderExcept.append(" where userId=:userId and type=:type and createTime between :startTime and :endTime ") ;
	                finderExcept.setParam("userId",appUser.getId()) ;
	                finderExcept.setParam("type",1) ;  //转入的钱
	                finderExcept.setParam("endTime",DateUtils.truncate(DateUtils.addDays(new Date(),1),Calendar.DATE)) ;
	                Date searchDay = null ;  //判断标准
	                Calendar calendar = Calendar.getInstance();
	                calendar.setTime(new Date());
	                int weekday = calendar.get(Calendar.DAY_OF_WEEK) ;
	                Date startTime = null ;
	                switch (weekday){
	                    //周日：周五->周日  这三天转入的钱是无效的
	                    case 1:
	                        startTime = DateUtils.addDays(new Date(),-2) ;
	                    //周一：周五->周一  这四天的钱是无效的
	                    case 2:
	                        startTime = DateUtils.addDays(new Date(),-3) ;
	                    //周二->周六：今天和昨天是无效的
	                    default:
	                        startTime = DateUtils.addDays(new Date(),-1) ;
	                }
	                finderExcept.setParam("startTime",DateUtils.truncate(startTime,Calendar.DATE)) ;
	                Map<String,Object> except = userYebHistoryService.queryForObject(finderExcept) ;
	                Double money = except.get("money") == null?0.0:(Double)except.get("money") ;
	                yebMoney = yebMoney.subtract(new BigDecimal(money)) ;

	                //计算余额宝的日收益
	                BigDecimal dayMoney = yebMoney.multiply(dayRate).setScale(2,BigDecimal.ROUND_HALF_UP);
	                dayMoney = dayMoney.divide(new BigDecimal(100)).setScale(2,BigDecimal.ROUND_HALF_UP) ;
	                BigDecimal yebBalance = new BigDecimal("00");
	                if(null!=appUser.getYebBalance()){
	                    yebBalance = new BigDecimal(appUser.getYebBalance()).add(dayMoney);
	                }else{
	                    yebBalance = dayMoney;
	                }
	                //构建订单
	                UserYebHistory userYebHistory = new UserYebHistory();
	                userYebHistory.setType(3);
	                userYebHistory.setMoney(dayMoney.doubleValue());
	                userYebHistory.setCreateTime(new Date());
	                userYebHistory.setUserId(appUser.getId());
//	                userYebHistory.setOrderId(order.getId());
	                userYebHistory.setNowBalance(yebBalance.doubleValue());
	                userYebHistory.setRate(yebRate.getRate());
//	                userYebHistory.setTradeNo(order.getTradeNo());
	                userYebHistoryService.saveorupdate(userYebHistory);

	                appUser.setYebBalance(yebBalance.doubleValue());
	                appUserService.update(appUser,true);
	            }
	        }
		return "ok";
	} 
	
	/**
	 * 
	 *新增/修改
	 * @param request
	 * @param model
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/update")
	public @ResponseBody
	ReturnDatas saveorupdate(Loan loan, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			//String id = loan.getId().toString();
			loan.setId(Integer.parseInt(request.getParameter("id")));
			loan.setRemark(request.getParameter("remark"));
			returnObject.setMessage(loanService.updateLoan(loan));
		} catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;
	}
	/**
	 * 
	 *新增
	 * @param request
	 * @param model
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/addd")
	public @ResponseBody
	ReturnDatas save(Loan loan, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			//String id = loan.getId().toString();
			
			returnObject.setMessage(loanService.saveLoan(loan));
			returnObject.setStatus("ok");
		} catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;
	}

	/**
	 * 
	 *删除
	 * @param request
	 * @param model
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete/json")
	public @ResponseBody
	ReturnDatas delete(Loan loan, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			//String id = loan.getId().toString();
			String id=request.getParameter("id");
			if (StringUtils.isBlank(id)) {
				return new ReturnDatas(ReturnDatas.ERROR, "删除失败,用户Id不能为空!");
			}

			returnObject.setMessage(loanService.deleteLoanById(id));
		} catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;
	}
	
	
	/**
	 * 
	 *删除
	 * @param request
	 * @param model
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/addRemark/json")
	public @ResponseBody
	ReturnDatas addRemark(Loan loan, HttpServletRequest request,HttpServletResponse response) throws Exception {
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			//String id = loan.getId().toString();
			Loan l = new Loan();
			String id=request.getParameter("id");
			String remark = request.getParameter("remark");
			
			if (StringUtils.isBlank(id)) {
				return new ReturnDatas(ReturnDatas.ERROR, "请求数据有误!");
			}
			
			if (StringUtils.isBlank(remark)) {
				return new ReturnDatas(ReturnDatas.ERROR, "备注不能为空！"); 
			}
			
			l.setId(Integer.parseInt(id));
			l.setRemark(remark);

			returnObject.setMessage(loanService.updateLoan(l));
		} catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;
	}
	
}
