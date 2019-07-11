package com.cz.yingpu.system.task;

import com.cz.yingpu.frame.common.BaseLogger;


import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserYebHistory;
import com.cz.yingpu.system.entity.YebRate;
import com.cz.yingpu.system.service.*;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * Created by LENOVO on 2017/4/25.
 */
@Component
public class YebTask extends BaseLogger {

    @Resource
    private IOrderService orderService;
    @Resource
    private IUserAccountHistoryService userAccountHistoryService;
    @Resource
    private IAppUserService appUserService;
    @Resource
    private IUserYebHistoryService userYebHistoryService;
    @Resource
    private IYebRateService yebRateService;

    /**
     *余额宝收益
     */
    @Scheduled(cron = "00 10 00 * * ?")
    public void signMoney() throws  Exception{
        logger.info("********************余额宝收益***************************");
        Finder finder = new Finder("select * from t_yeb_rate where createDate like :date ");
        finder.setParam("date","%"+ com.cz.yingpu.frame.util.DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(new Date(), -1))+"%");
        YebRate yebRate = yebRateService.queryForObject(finder,YebRate.class);
        //计算余额宝的日利率
        BigDecimal dayRate = new BigDecimal(yebRate.getRate()).divide(new BigDecimal(365),5,BigDecimal.ROUND_HALF_UP);
        List<AppUser> appUsers = appUserService.queryForList(Finder.getSelectFinder(AppUser.class),AppUser.class);
        if(null != appUsers && appUsers.size() > 0){
			//计算用户的余额宝总金额，体验金+余额宝余额
			for (AppUser appUser :appUsers){
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
                if(dayMoney.doubleValue()>0){
                BigDecimal yebBalance = new BigDecimal("00");
                if(null!=appUser.getYebBalance()){
                    yebBalance = new BigDecimal(appUser.getYebBalance()).add(dayMoney);
                }else{
                    yebBalance = dayMoney;
                }
//                Finder userFinder = new Finder("select * from t_app_user where id =:id for update");
//                finder.setParam("id", appUser.getId());
//                appUser = appUserService.queryForObject(finder, AppUser.class);
                //构建订单
                UserYebHistory userYebHistory = new UserYebHistory();
                userYebHistory.setType(3);
                userYebHistory.setMoney(dayMoney.doubleValue());
                userYebHistory.setCreateTime(new Date());
                userYebHistory.setUserId(appUser.getId());
//              userYebHistory.setOrderId(order.getId());
                userYebHistory.setNowBalance(yebBalance.doubleValue());
                userYebHistory.setRate(yebRate.getRate());
//                userYebHistory.setTradeNo(order.getTradeNo());
                userYebHistoryService.saveorupdate(userYebHistory);
                appUser.setYebBalance(yebBalance.doubleValue());
                appUserService.update(appUser,true);
                }
            }
        }
    }

    /**
     *余额宝体验金设置为0
     */
    @Scheduled(cron = "00 00 01 * * ?")
    public void setQuota() throws  Exception{

        logger.info("***************************余额宝体验金设置为0************************");
        Finder finder = new Finder("select * from t_app_user where dateline like :date ");
        finder.setParam("date","%"+ com.cz.yingpu.frame.util.DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(new Date(), -7))+"%");
        List<AppUser> appUsers = appUserService.queryForList(finder,AppUser.class);
        if(null != appUsers && appUsers.size() > 0){
            for (AppUser appUser : appUsers){
                appUser.setQuota(0d);
                appUserService.update(appUser,true);
            }
        }
    }

    /**
     * 余额宝利率每天定时插入
     */
    @Scheduled(cron = "00 05 00 * * ?")
    public void  rate() {
        try {
            logger.info("***************************余额宝利率每天定时插入************************");
            Finder finder = new Finder("select * from ").append(Finder.getTableName(YebRate.class)) ;
            finder.append(" where DATEDIFF(NOW() ,createDate) = 1") ;
//            finder.setParam("createDate", com.cz.yingpu.frame.util.DateUtils.formatDate(new Date())) ;
            YebRate yesterday = yebRateService.queryForObject(finder,YebRate.class) ;
            //代表今天没有新的利率，要生成了就
            if(yesterday != null){
                YebRate today = new YebRate() ;
                today.setRate(yesterday.getRate());
                today.setCreateDate(new Date());
                yebRateService.save(today) ;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     *余额宝体验金设置为0
     */
//    @Scheduled(cron = "00 15 16 * * ?")
    public void signMoney2() throws  Exception{
//        Date date = com.cz.yingpu.frame.util.DateUtils.convertString2Date("yyyy-MM-dd HH:mm:ss","2018-11-22 00:10:00");
//        logger.info("********************余额宝收益***************************");
//        Finder finder = new Finder("select * from t_yeb_rate where createDate like :date ");
//        finder.setParam("date","%"+ com.cz.yingpu.frame.util.DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(date, -1))+"%");
//        YebRate yebRate = yebRateService.queryForObject(finder,YebRate.class);
//        //计算余额宝的日利率
//        BigDecimal dayRate = new BigDecimal(yebRate.getRate()).divide(new BigDecimal(365),5,BigDecimal.ROUND_HALF_UP);
//        List<AppUser> appUsers = appUserService.queryForList(Finder.getSelectFinder(AppUser.class),AppUser.class);
//        if(null != appUsers && appUsers.size() > 0){
//            //计算用户的余额宝总金额，体验金+余额宝余额
//            for (AppUser appUser :appUsers){
//
//                BigDecimal yebMoney = new BigDecimal(appUser.getYebBalance()).add(new BigDecimal(appUser.getQuota()));
//                //上边的钱要减去T+1的钱
//                //查出来不符合T+1的钱
//                Finder finderExcept  = Finder.getSelectFinder(UserYebHistory.class,"sum(money) as money") ;
//                finderExcept.append(" where userId=:userId and type=:type and createTime between :startTime and :endTime ") ;
//                finderExcept.setParam("userId",appUser.getId()) ;
//                finderExcept.setParam("type",1) ;  //转入的钱
//                finderExcept.setParam("endTime", org.apache.commons.lang3.time.DateUtils.truncate(org.apache.commons.lang3.time.DateUtils.addDays(date,1),Calendar.DATE)) ;
//                Date searchDay = null ;  //判断标准
//                Calendar calendar = Calendar.getInstance();
//                calendar.setTime(new Date());
//                int weekday = calendar.get(Calendar.DAY_OF_WEEK) ;
//                Date startTime = null ;
//                switch (weekday){
//                    //周日：周五->周日  这三天转入的钱是无效的
//                    case 1:
//                        startTime = org.apache.commons.lang3.time.DateUtils.addDays(date,-2) ;
//                        //周一：周五->周一  这四天的钱是无效的
//                    case 2:
//                        startTime = org.apache.commons.lang3.time.DateUtils.addDays(date,-3) ;
//                        //周二->周六：今天和昨天是无效的
//                    default:
//                        startTime = org.apache.commons.lang3.time.DateUtils.addDays(date,-1) ;
//                }
//                finderExcept.setParam("startTime", org.apache.commons.lang3.time.DateUtils.truncate(startTime,Calendar.DATE)) ;
//                Map<String,Object> except = userYebHistoryService.queryForObject(finderExcept) ;
//                Double money = except.get("money") == null?0.0:(Double)except.get("money") ;
//                yebMoney = yebMoney.subtract(new BigDecimal(money)) ;
//
//                //计算余额宝的日收益
//                BigDecimal dayMoney = yebMoney.multiply(dayRate).setScale(2,BigDecimal.ROUND_HALF_UP);
//                dayMoney = dayMoney.divide(new BigDecimal(100)).setScale(2,BigDecimal.ROUND_HALF_UP) ;
//                if(dayMoney.doubleValue()>0){
//                    BigDecimal yebBalance = new BigDecimal("00");
//                    if(null!=appUser.getYebBalance()){
//                        yebBalance = new BigDecimal(appUser.getYebBalance()).add(dayMoney);
//                    }else{
//                        yebBalance = dayMoney;
//                    }
////					Finder userFinder = new Finder("select * from t_app_user where id =:id for update");
////					finder.setParam("id", appUser.getId());
////					appUser = queryForObject(finder, AppUser.class);
//                    //构建订单
//                    UserYebHistory userYebHistory = new UserYebHistory();
//                    userYebHistory.setType(3);
//                    userYebHistory.setMoney(dayMoney.doubleValue());
//                    userYebHistory.setCreateTime(date);
//                    userYebHistory.setUserId(appUser.getId());
////              userYebHistory.setOrderId(order.getId());
//                    userYebHistory.setNowBalance(yebBalance.doubleValue());
//                    userYebHistory.setRate(yebRate.getRate());
////                userYebHistory.setTradeNo(order.getTradeNo());
//                    userYebHistoryService.saveorupdate(userYebHistory);
//                    appUser.setYebBalance(yebBalance.doubleValue());
//                    appUserService.update(appUser,true);
//                }
//            }
//        }

    }

}
