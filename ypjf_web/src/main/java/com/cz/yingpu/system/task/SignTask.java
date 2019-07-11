package com.cz.yingpu.system.task;

import com.cz.yingpu.frame.common.BaseLogger;
import com.cz.yingpu.frame.util.DateUtils;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.*;
import com.cz.yingpu.system.service.*;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by LENOVO on 2017/4/25.
 */
@Component
public class SignTask extends BaseLogger {

    @Resource
    private ISignConfigService signConfigService ;
    @Resource
    private IUserSignHisService userSignHisService;
    @Resource
    private IOrderService orderService;
    @Resource
    private IAppUserService appUserService;
    @Resource
    private IUserYebHistoryService userYebHistoryService;
    @Resource
    private ISysSysparamService sysSysparamService ;

    /**
     *签到分钱
     */
    @Scheduled(cron = "00 30 00 * * ?")
    public void signMoney() throws  Exception{
        logger.info("***********************签到分钱*****************");
        //查出当天的总金额
//        Finder finder = new Finder("select * from t_sign_config where createDate like :date");
//        finder.setParam("date","%"+ DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(new Date(), -1))+"%");
//        SignConfig signConfig = signConfigService.queryForObject(finder,SignConfig.class);
        try {
            SignConfig signConfig = new SignConfig();
            SysSysparam sysparam = new SysSysparam() ;
            sysparam.setCode("signTotalAmount");
            sysparam = sysSysparamService.queryForObject(sysparam) ;
            signConfig.setMoney(Double.valueOf(sysparam.getValue()));
            //获取今天已签到人数
            Finder finder = new Finder("select CONVERT(count(id),DECIMAL) sum from t_user_sign_his where createTime like :date  ");
            finder.setParam("date","%"+DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(new Date(), -1))+"%");
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
                finder.setParam("date","%"+ DateUtils.convertDate2String("yyyy-MM-dd",org.apache.commons.lang.time.DateUtils.addDays(new Date(), -1))+"%");
                List<UserSignHis> userSignHiss = userSignHisService.queryForList(finder,UserSignHis.class);
                if(null!=userSignHiss && userSignHiss.size() > 0){
                    for (UserSignHis userSignHis:userSignHiss){
                        userSignHis.setMoney(everyMoney.doubleValue());
                        userSignHis.setIsSend("是");
                        userSignHisService.update(userSignHis,true);
//                    	AppUser appUser = appUserService.findAppUserById(userSignHis.getUserId());
                        AppUser appUser = appUserService.findById(userSignHis.getUserId(),AppUser.class);
                        //构建订单
                        Order order = new Order();
                        order.setUserId(appUser.getId());
                        order.setTradeNo(DateUtils.setDateFormat(new Date(),"yyyyMMddHHmmss")+getRand());
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
     * 一周免签
     */
    @Scheduled(cron = "00 01 00 * * ?")
    public void weekSign() {
        logger.info("***********************一周免签*****************");
        AppUser user = new AppUser();
        user.setIsWeekSign("是");
        try {
            //获得一周免签的用户
            List<AppUser> list = appUserService.findListDataByFinder(null,null,AppUser.class,user) ;
            //晚上零点执行的，肯定是设置一周免签的第二天
            if(list != null && list.size() > 0){
                List<UserSignHis> listInsert = new ArrayList<>() ;
                Iterator<AppUser> iter = list.iterator() ;

                UserSignHis his = null ;
                while (iter.hasNext()){
                    //可以覆盖掉上边命名的user
                    user = iter.next() ;
                    his = new UserSignHis() ;
                    his.setCreateTime(new Date());
                    his.setUserId(user.getId());
                    his.setIsSend("否");
                    his.setType(2);
                    listInsert.add(his);

                    //判断今天是否是一周免签最后一天
                    if(org.apache.commons.lang.time.DateUtils.isSameDay(user.getWeekSignEndTime(),new Date())){
                        user.setIsWeekSign("否");
                        user.setWeekSignEndTime(null);
                        appUserService.update(user) ;
                    }
                }
                //签到
                userSignHisService.save(listInsert) ;
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }


    /**
     * 签到总金额的变更
     */
    @Scheduled(cron = "00 01 00 * * ?")
    public  void  changeSignTotalMoney(){
        logger.info("********************8签到总金额的变更******************");
        try {

            Finder finder = new Finder("select * from ").append(Finder.getTableName(SignConfig.class));
            finder.append(" where  DATEDIFF(NOW() ,createDate) = 0") ;
            List<SignConfig> list = signConfigService.queryForList(finder,SignConfig.class) ;
            if (list != null && list.size()>0){
                SignConfig signConfig = list.get(list.size()-1) ;
                SysSysparam sysSysparam = new SysSysparam() ;
                sysSysparam.setCode("signTotalAmount");
                sysSysparam = sysSysparamService.queryForObject(sysSysparam) ;
                sysSysparam.setValue(signConfig.getMoney().toString());
                sysSysparamService.saveOrUpdate(sysSysparam) ;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }


}
