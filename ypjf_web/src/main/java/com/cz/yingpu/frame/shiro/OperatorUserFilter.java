package com.cz.yingpu.frame.shiro;

import java.net.URLEncoder;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.springframework.stereotype.Component;

import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.system.entity.AppUser;


/**
 * 前台用户的 过滤器，主要设置登陆界面
 * @author dongchuang
 *
 */


@Component("operatoruser")
public class OperatorUserFilter extends AccessControlFilter {
	
	public OperatorUserFilter(){
		
		
		//跳转到登录界面
		
	}
	

	@Override
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse response, Object mappedValue) throws Exception {
		HttpServletRequest httpServletRequest=(HttpServletRequest)request;
		HttpServletResponse  httpServletResponse =(HttpServletResponse)response;

		if(httpServletRequest.getRequestURL().indexOf("wap.yingpuwealth.com")>-1){
			httpServletResponse.setStatus(403);
			httpServletRequest.getInputStream().close();
			httpServletResponse.getOutputStream().close();
			//httpServletResponse.sendRedirect("/yingpu/pc/error.jsp");
			return false;
		}
		
		return false;
	}

	@Override
	protected boolean onAccessDenied(ServletRequest request,
			ServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpServletRequest httpServletRequest=(HttpServletRequest)request;
		HttpServletResponse  httpServletResponse =(HttpServletResponse)response;
		Subject subject = SecurityUtils.getSubject(); 
		Session session = subject.getSession(); 
		if(httpServletRequest.getRequestURL().indexOf("wap.yingpuwealth.com")>-1){
			httpServletResponse.setStatus(403);
			httpServletRequest.getInputStream().close();
			httpServletResponse.getOutputStream().close();
			//httpServletResponse.sendRedirect("/yingpu/pc/error.jsp");
			return false;
		}
		
		String backUrl = httpServletRequest.getRequestURL().toString();
		 AppUser u=(AppUser) session.getAttribute(GlobalStatic.OPERATORUSER);
		 if(u==null){
			 String url=httpServletRequest.getRequestURI();
				String urls[]={
						"login"
				};

				for (int i = 0; i < urls.length; i++) {
					if( url.indexOf(urls[i])>-1){
						//httpServletRequest.getRequestDispatcher("/pc/login").forward(httpServletRequest, httpServletResponse);
						return true;
					
					}
				}
				
			/*	String param = "";
				if (!url.endsWith("logout")) {
					param = "?backUrl="+URLEncoder.encode(backUrl, "utf-8");
				}
				*/
				httpServletResponse.sendRedirect("/yingpu/operator/login.html");
				//	 WebUtils.issueRedirect(request, response, "/yingpu/pc/login"); 
			return false;
		 }
		return true;
	}
}
