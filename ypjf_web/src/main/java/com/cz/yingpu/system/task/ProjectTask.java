package com.cz.yingpu.system.task;

import com.cz.yingpu.frame.common.BaseLogger;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.fuyou.ConfigReader;
import com.cz.yingpu.system.entity.*;
import com.cz.yingpu.system.fuyoudata.CommonRspData;
import com.cz.yingpu.system.fuyoudata.TransferBmuReqData;
import com.cz.yingpu.system.service.*;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Michael on 2017/4/24.
 */
@Component
public class ProjectTask extends BaseLogger{


    @Resource
    private IProjectService projectService ;
    @Resource
    private ISignConfigService signConfigService ;
    @Resource
    private ISysSysparamService sysSysparamService ;
    @Resource
    private IAppUserService appUserService ;
    @Resource
    private IUserSignHisService userSignHisService ;
    @Resource
    private IUserProjectService userProjectService;
    @Resource
    private FuiouService fuiouService;
    @Resource
    private IOrderService orderService;
    @Resource
    private IUserAccountHistoryService userAccountHistoryService;
    @Resource
    private JPushService jPushService;

    /**
     * 项目上线
     */
    @Scheduled(cron = "00 */1 * * * ?")
    public void online() {
        logger.info("**************项目上线定时任务***************");
        List<Project> list = null ;
        try {
            Finder finder = new Finder("select * from ").append(Finder.getTableName(Project.class)) ;
            finder.append(" where status = :status  and  NOW() > startTime ") ;
            finder.setParam("status",1) ;
//            finder.setParam("financingAmount",0.0) ;
            list = projectService.queryForList(finder,Project.class) ;

            if(list != null && list.size()>0){
                Iterator<Project> iter = list.iterator() ;
                Project project = null ;
                while (iter.hasNext()){
                    project = iter.next() ;
                    project.setStatus(2);
                }
                projectService.update(list) ;
            }
        } catch (Exception e) {
            e.printStackTrace();

        }

    }

    /**
     * 流标
     * @throws Exception
     */
    @Scheduled(cron = "00 */10 * * * ?")
    public void loseBid() throws  Exception{

        logger.info("**************项目流标定时任务***************");
        List<Project> list = null ;
        try {
            Finder finder = new Finder("select * from ").append(Finder.getTableName(Project.class)) ;
            finder.append(" where status = :status and financingAmount != :financingAmount and  DATEDIFF(NOW() ,endTitme) >-1 AND type = 1") ;
            finder.setParam("status",2) ;
            finder.setParam("financingAmount",0.0) ;
            list = projectService.queryForList(finder,Project.class) ;

            if(list != null && list.size()>0){
                Iterator<Project> iter = list.iterator() ;
                Project project = null ;
                while (iter.hasNext()){
                    project = iter.next() ;
                    project.setStatus(4);   //代表流标
                    //流标之后将用户的投资资金还给投资人
                    finder = new Finder("select * from t_user_project where projectId=:projectId ");
                    finder.setParam("projectId",project.getId());
                    List<Integer> userIds = new ArrayList<Integer>();
                    List<UserProject> userProjects = userProjectService.queryForList(finder,UserProject.class);
                    if(null!=userProjects && userProjects.size() > 0){
                        for (UserProject userProject:userProjects){
                            userIds.add(userProject.getUserId());
                            AppUser appUser = appUserService.findAppUserById(userProject.getUserId());
                            TransferBmuReqData transferBmuReqData = new TransferBmuReqData();
                            transferBmuReqData.setVer(ConfigReader.getConfig("ver"));
                            transferBmuReqData.setMchnt_cd(ConfigReader.getConfig("mchnt_cd"));
                            transferBmuReqData.setMchnt_txn_ssn(com.cz.yingpu.frame.util.DateUtils.setDateFormat(new Date(), "yyyyMMddHHmmss") + getRand());
                            transferBmuReqData.setOut_cust_no(ConfigReader.getConfig("mchnt_no"));
                            transferBmuReqData.setIn_cust_no(appUser.getPhone());
                            transferBmuReqData.setAmt(new BigDecimal(userProject.getMoney()).multiply(new BigDecimal(100)).setScale(0,BigDecimal.ROUND_HALF_UP).toString());
                            Order order = new Order();
                            order.setUserId(appUser.getId());
                            order.setTradeNo(transferBmuReqData.getMchnt_txn_ssn());
                            order.setCreateTime(new Date());
                            order.setMoney(userProject.getMoney());
                            order.setType(13);
                            order.setStatus(1);
                            order.setProjectId(project.getId());
                            order = orderService.findOrderById(Integer.parseInt(orderService.save(order).toString()));
                            UserAccountHistory userAccountHistory = new UserAccountHistory();
                            userAccountHistory.setUserId(appUser.getId());
                            userAccountHistory.setMoney(userProject.getMoney());
                            userAccountHistory.setType(9);
                            userAccountHistory.setTradeNo(transferBmuReqData.getMchnt_txn_ssn());
                            userAccountHistory.setStatus(1);
                            userAccountHistory.setCreatetime(new Date());
                            userAccountHistory.setOrderId(order.getId());
                            userAccountHistory.setProjectId(project.getId());
                            userAccountHistory = userAccountHistoryService.findUserAccountHistoryById(Integer.parseInt(userAccountHistoryService.save(userAccountHistory).toString()));
                            //与富友通信,进行转账
                            CommonRspData commonRspData = FuiouService.transferBmu(transferBmuReqData);
                            if ("0000".equals(commonRspData.getResp_code())) {//成功
                                order.setStatus(2);
                                order.setPs(commonRspData.getResp_desc());
                                orderService.update(order,true);
                                userAccountHistory.setStatus(2);
                                userAccountHistory.setRemarkers(commonRspData.getResp_desc());
                                userAccountHistoryService.update(userAccountHistory,true);
                                userProject.setStatus(3);
                                userProject.setProjectStatus(4);
                                userProjectService.update(userProject,true);
                            }else {//失败
                                order.setStatus(3);
                                order.setPs(commonRspData.getResp_desc());
                                orderService.update(order,true);
                                userAccountHistory.setStatus(3);
                                userAccountHistory.setRemarkers(commonRspData.getResp_desc());
                                userAccountHistoryService.update(userAccountHistory,true);
                            }
                        }
                        //给用户推送消息
                        jPushService.notify(3,project.getId(),userIds,project.getName());

                    }
                }
                projectService.update(list) ;
            }
        } catch (Exception e) {
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




}
