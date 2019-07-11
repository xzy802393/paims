package com.cz.yingpu.system.task;

import com.cz.yingpu.frame.common.BaseLogger;
import com.cz.yingpu.frame.util.DateUtils;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.Order;
import com.cz.yingpu.system.service.*;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/2 0002.
 */
@Component
public class PartnerTask extends BaseLogger {

    @Resource
    private IOrderService orderService;
    @Resource
    private IAppUserService appUserService;
    @Resource
    private IUserProjectService userProjectService;
    @Resource
    private IPartnerUserService partnerUserService;


    /**
     * 合伙人分钱
     */
    @Scheduled(cron = "00 40 00 1 * ?")
    public void partnerFenxiao() throws  Exception{
        Finder finder = new Finder("select * from t_app_user where isPartner in (3,6) ");
//        finder.setParam("isPartner","(3,6)");
        List<AppUser> appUsers = appUserService.queryForList(finder,AppUser.class);
        if(null!=appUsers&&appUsers.size()>0){
            for (AppUser appUser : appUsers){
                String month = DateUtils.convertDate2String("yyyy-MM", org.apache.commons.lang.time.DateUtils.addMonths(new Date(),-1));
                Map<String,Object> map = appUserService.fenxiaoTotalList(appUser.getId(),month);
                Double money = Double.parseDouble(map.get("percent").toString());
                if(money>0){
                    Order order = new Order();
                    order.setUserId(appUser.getId());
                    order.setStatus(1);
                    order.setType(14);
                    order.setCreateTime(new Date());
                    order.setMoney(money);
                    orderService.save(order);
                }
            }
        }
    }

    /**
     * 合伙人生效
     */
    @Scheduled(cron = "00 50 00 1 * ?")
    public void setPartner() throws  Exception{
        //合伙人申请成功或后台设置生效定时
        Finder finder = new Finder("select * from t_app_user where isPartner=:isPartner ");
        finder.setParam("isPartner","5");
        List<AppUser> appUsers = appUserService.queryForList(finder,AppUser.class);
        if(null != appUsers){
            for (AppUser appUser : appUsers){

                appUser.setIsPartner("3");
                appUser.setPartnerStartTime(new Date());
                partnerUserService.getFenxiaoList(appUser.getId());
                appUserService.update(appUser,true);
            }
        }
        //取消合伙人的生效定时
        finder = new Finder("select * from t_app_user where isPartner=:isPartner ");
        finder.setParam("isPartner","6");
        appUsers = appUserService.queryForList(finder,AppUser.class);
        if(null != appUsers){
            for (AppUser appUser : appUsers){
                appUser.setIsPartner("4");
                appUser.setPartnerStartTime(null);
                appUser.setPartnerCancelTime(new Date());
                partnerUserService.cancelParent(appUser.getId());
                appUserService.update(appUser,true);
            }
        }

    }

}
