package com.cz.yingpu.system.web;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cz.yingpu.system.pc.listener.CommonRechargeBalanceEventListener;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.fuyou.ConfigReader;
import com.cz.yingpu.system.entity.FYStatusCode;
import com.cz.yingpu.system.entity.Order;
import com.cz.yingpu.system.entity.UserAccountHistory;
import com.cz.yingpu.system.fuyoudata.AppTransRspData;
import com.cz.yingpu.system.fuyoudata.P2p500405RspData;
import com.cz.yingpu.system.fuyoudata.WebRegRspData;
import com.cz.yingpu.system.fuyoudata.WtWithdrawRspData;
import com.cz.yingpu.system.service.FuiouRspParseService;
import com.cz.yingpu.system.service.IAppUserService;
import com.cz.yingpu.system.service.IFYStatusCodeService;
import com.cz.yingpu.system.service.IOrderService;
import com.cz.yingpu.system.service.IUserAccountHistoryService;
import com.cz.yingpu.system.service.IUserService;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by lenovo on 2017/3/15.
 */
@Controller
@RequestMapping(value="/system/fuiouResp")
public class FuiouResponseControler extends BaseController {

    @Resource
    private FuiouRspParseService fuiouRspParseService;
    @Resource
    private IUserService userService;
    
    @Resource
    private IAppUserService appUserService;
    
    @Resource
    private IUserAccountHistoryService userAccountHistoryService;
    
    @Resource 
    private IOrderService	orderService;
    
    @Resource
    private IFYStatusCodeService fYStatusCodeService;

    @Resource
	private CommonRechargeBalanceEventListener commonRechargeBalanceEventListener;

    /**
     * 富友注册回调接受接口
     * @param request
     * @throws Exception
     */
    @RequestMapping("/appWebResp/json")
    public void  appWebResp(HttpServletRequest request,HttpServletResponse response) throws Exception{
        if(0!=request.getParameterMap().size()){
            WebRegRspData regRspData  = FuiouRspParseService.appWebRegRspParse(request);
            System.out.println(regRspData.createSignValue());
            if("0000".equals(regRspData.getResp_code())){
                //改变开通富友状态
//                userService.changUser(Integer.parseInt(regRspData.getUser_id_from()));
                response.sendRedirect(ConfigReader.getConfig("page_notify_url"));
            }else{
                System.out.println("----------------------->"+regRspData.getResp_code());
            }
        }else {
            response.setStatus(200);
            response.sendRedirect(ConfigReader.getConfig("page_failure_url"));
        }


    }

    /**
     * 富友充值回调接受接口
     * @param request
     * @throws Exception
     */
    @RequestMapping("/appTransRspParse/json")
    public void  appTransRspParse(HttpServletRequest request,HttpServletResponse response) throws Exception{
        System.out.println("富友前台回调");
        System.out.println(request.getParameterMap().size());
        if(0!=request.getParameterMap().size()){
            AppTransRspData appTransRspData  = FuiouRspParseService.appTransRspParse(request);
            System.out.println(appTransRspData.createSignValue());
            if("0000".equals(appTransRspData.getResp_code())){
                //返回结果进行保存，并需要查询余额，并跳转到成功页面
                response.sendRedirect(ConfigReader.getConfig("page_notify_url"));
            }else{
                String failureDesc = new String(appTransRspData.getResp_desc().getBytes("ISO-8859-1"), "UTF-8");
                response.sendRedirect(ConfigReader.getConfig("page_failure_url")+"?failureDesc="+ failureDesc);
                System.out.println("----------------------->"+appTransRspData.getResp_code());
            }
        }else {
            response.setStatus(200);
            response.sendRedirect(ConfigReader.getConfig("page_failure_url"));
        }

    }

    /**
     * 富友充值回调接受接口
     * @param request
     * @throws Exception
     */
    @RequestMapping("/webP2PRechRspParse/json")
    public void  webP2PRechRspParse(HttpServletRequest request, HttpServletResponse response) throws Exception{

		if(0!=request.getParameterMap().size()){
			P2p500405RspData p2p500405RspData  = FuiouRspParseService.p2p500405RspParse(request);

			boolean isSuccess = "0000".equals(p2p500405RspData.getResp_code());
			Order order = new Order();
			if (p2p500405RspData.getMchnt_txn_ssn() != null && StringUtils.isNotBlank(p2p500405RspData.getMchnt_txn_ssn())) {
				order.setTradeNo(p2p500405RspData.getMchnt_txn_ssn());
				if (null != (order = orderService.queryForObject(order))) {
					order.setStatus(isSuccess ? 2 : 3);
					order.setPs(p2p500405RspData.getResp_desc());
					orderService.updateValidValue(order);
				}

				UserAccountHistory uas = new UserAccountHistory();
				uas.setTradeNo(p2p500405RspData.getMchnt_txn_ssn());
				if (null != (uas = orderService.queryForObject(uas))) {
					uas.setStatus(isSuccess ? 2 : 3);
					uas.setRemarkers(p2p500405RspData.getResp_desc());
					orderService.updateValidValue(uas);
				}
			}

			if("0000".equals(p2p500405RspData.getResp_code())){
				commonRechargeBalanceEventListener.onRechargeSuccess(order, p2p500405RspData);
				//返回结果进行保存，并需要查询余额，并跳转到成功页面
				response.sendRedirect(ConfigReader.getConfig("pc_page_notify_url")+"?type=2");
			}
			else {
				commonRechargeBalanceEventListener.onRechargeFailure(order, p2p500405RspData);

				String failureDesc = p2p500405RspData.getResp_desc();
				//new String(p2p500405RspData.getResp_desc().getBytes("ISO-8859-1"), "UTF-8");
				response.sendRedirect(ConfigReader.getConfig("page_failure_url")+"?type=2&failureDesc="
						+ URLEncoder.encode(failureDesc, "UTF-8"));
				System.out.println("----------------------->"+p2p500405RspData.getResp_code());
			}
		}
		else {
			response.setStatus(200);
			response.sendRedirect(ConfigReader.getConfig("page_failure_url")+"?type=2");
		}
    }
    
    
    /**
     * pc网页提现回调接受接口
     * @param request
     * @throws Exception
     */
    @RequestMapping("/withdrawRsp/json")
    public void  withdrawRsp(HttpServletRequest request,HttpServletResponse response) throws Exception{
        System.out.println("富友前台回调");

        if(0 != request.getParameterMap().size()){
        	String respDesc = request.getParameter("resp_desc");
        	String phone = request.getParameter("login_id");
        	String amt = request.getParameter("amt");
        	WtWithdrawRspData data = new WtWithdrawRspData();
        	UserAccountHistory history = new UserAccountHistory();
        	Order order = new Order();
        	Integer id = appUserService.findAppUserByphone(phone).getId();
        	double money = new BigDecimal(amt).divide(new BigDecimal(100f)).doubleValue();
        	
        	BeanUtils.populate(data, request.getParameterMap());
        	order.setTradeNo(data.getMchnt_txn_ssn());
        	List<Order> orders = orderService.findListDataByFinder(null, null, Order.class, order);
        	
        	FYStatusCode fyCode = new FYStatusCode();
        	fyCode.setCode(data.getResp_code());
        	List<FYStatusCode> fyCodes = fYStatusCodeService.findListDataByFinder(null, null, FYStatusCode.class, fyCode);
        	String respInfo = fyCodes != null && fyCodes.size() != 0 ? fyCodes.get(0).getInfo() : respDesc;
        	if (orders != null && orders.size() != 0) {
        		Order ord = orders.get(0);
        		order.setId(ord.getId());
	        	order.setStatus("0000".equals(data.getResp_code()) ? 2 : 3);
	        	order.setPs(respInfo);
	        	orderService.updateValidValue(order);
        	}
        	
        	history.setTradeNo(data.getMchnt_txn_ssn());
        	List<Order> historys = orderService.findListDataByFinder(null, null, Order.class, history);
        	if (historys != null && historys.size() != 0) {
        		history.setId(historys.get(0).getId());
        		history.setStatus("0000".equals(data.getResp_code()) ? 2 : 3);
            	userAccountHistoryService.updateValidValue(history);
        	}

            if("0000".equals(data.getResp_code())){
                //返回结果进行保存，并需要查询余额，并跳转到成功页面
            	System.out.println("----------------------->"+data.getResp_code());
				response.sendRedirect(ConfigReader.getConfig("pc_page_notify_url")+"?type=3");
            }else{
                String failureDesc = new String(respDesc.getBytes("ISO-8859-1"), "UTF-8");
				response.sendRedirect(ConfigReader.getConfig("page_failure_url")+"?type=3&failureDesc="
						+ URLEncoder.encode(failureDesc, "UTF-8"));
                System.out.println("----------------------->"+data.getResp_code());
            }
        } else {
            response.setStatus(200);
			response.sendRedirect(ConfigReader.getConfig("page_failure_url")+"?type=3");
        }

    }
    
    /**
     * pc网页提现回调接受接口
     * @param request
     * @throws Exception
     */
    @RequestMapping("/chongzhiRsp/json")
    public void chongzhiRsp(HttpServletRequest request,HttpServletResponse response) throws Exception{
        System.out.println("富友前台回调");
        System.out.println(request.getParameterMap().size());
        if(0 != request.getParameterMap().size()){
        	String respDesc = request.getParameter("resp_desc");
        	String phone = request.getParameter("login_id");
        	String amt = request.getParameter("amt");
        	WtWithdrawRspData data = new WtWithdrawRspData();
        	UserAccountHistory history = new UserAccountHistory();
        	
        	BeanUtils.populate(data, request.getParameterMap());
        	history.setTradeNo(data.getMchnt_txn_ssn());
        	List<Order> historys = orderService.findListDataByFinder(null, null, Order.class, history);
        	if (historys != null && historys.size() != 0) {
        		history.setId(historys.get(0).getId());
        		history.setStatus("0000".equals(data.getResp_code()) ? 2 : 3);
            	userAccountHistoryService.updateValidValue(history);
        	}
        	
        	Order order = new Order();
        	order.setTradeNo(data.getMchnt_txn_ssn());
        	List<Order> orders = orderService.findListDataByFinder(null, null, Order.class, order);
        	
        	FYStatusCode fyCode = new FYStatusCode();
        	fyCode.setCode(data.getResp_code());
        	List<FYStatusCode> fyCodes = fYStatusCodeService.findListDataByFinder(null, null, FYStatusCode.class, fyCode);
        	String respInfo = fyCodes != null && fyCodes.size() != 0 ? fyCodes.get(0).getInfo() : respDesc;
        	
        	if (orders != null && orders.size() != 0) {
        		Order ord = orders.get(0);
	        	order.setPs(respInfo);
        		order.setId(ord.getId());
	        	order.setStatus("0000".equals(data.getResp_code()) ? 2 : 3);
	        	orderService.updateValidValue(order);
        	}
        	
            if("0000".equals(data.getResp_code())){
                //返回结果进行保存，并需要查询余额，并跳转到成功页面
            	System.out.println("----------------------->"+data.getResp_code());
            	
            }else{
                String failureDesc = respInfo.length() == 0 ? new String(respDesc.getBytes("ISO-8859-1"), "UTF-8") : respInfo;
//                response.sendRedirect(ConfigReader.getConfig("page_failure_url")+"?failureDesc="+ failureDesc);
                System.out.println("----------------------->"+data.getResp_code());
               
            }
        }else {
            response.setStatus(200);
           // response.sendRedirect(ConfigReader.getConfig("page_failure_url"));
        }

    }
    

    /**
     * 富友网页版注册回调接受接口
     * @param request
     * @throws Exception
     */
    @RequestMapping("/webRegResp/json")
    public void  webRegResp(HttpServletRequest request,HttpServletResponse response) throws Exception{
        if(0!=request.getParameterMap().size()){
            WebRegRspData regRspData  = FuiouRspParseService.appWebRegRspParse(request);
            System.out.println(regRspData.createSignValue());
            if("0000".equals(regRspData.getResp_code())){
                userService.changUser(Integer.parseInt(regRspData.getUser_id_from()));
                response.sendRedirect(ConfigReader.getConfig("admin_notify_url"));
            }else{
                System.out.println("----------------------->"+regRspData.getResp_code());
            }
            
        }else {
            response.setStatus(200);
            response.sendRedirect(ConfigReader.getConfig("admin_notify_url"));

        }


    }
}
