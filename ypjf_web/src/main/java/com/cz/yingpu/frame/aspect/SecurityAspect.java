package com.cz.yingpu.frame.aspect;


import com.cz.yingpu.frame.util.*;
import com.cz.yingpu.system.entity.ConfigBean;
import org.aopalliance.intercept.Joinpoint;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * 对app端返回数据进行加密
 * @author Michael
 *
 */
@Component
@Aspect
public class SecurityAspect {

	@Resource
	private CacheManager cacheManager ;

	//加密使用的私钥
//	private String privateKey = "";
	private String privateKey = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMXPSp9OoYmziCmh7gfDS6cIIkN23YSVHv2X4Xuk9Q3KPgKkV74s3xdmqPxc9XlZ5Sj8iyFycUm6znTxAgqHDeunzKH+X4Xvt3gKJDQoiKOBW+dg+bsIDp1Ci9J8r/dD3KSbHlcjFEGdI91rAXWQh+EVbIW2gvtI90LUuxUXKZdpAgMBAAECgYBYRFOMGs5CX/ZWfYd1t1O+yQZhDF10mAYoKunW/pjK+oAJNcRhfCxgiNLHKcPvzolPbMG4vxSGTfFqhVDf2bv/rX+0tx/1jGuSHf9GQ04FuTVvOM1qn7SxRft5xQayh6zTMoW5q+8aFN+otxvvTNRzC8ULjA6reFO5PdYfkko4AQJBAP+M71mMct1oJpObZ30a+JeDEbqgha1QNPkUQerZn9PHLKtfbn96pcZ3qRePeyPohXpt+7lOzz3smmOMjVPylUECQQDGKFuj1pH3F8LUihfBfF2AG1xV8l9LIfvI6vGYB+1+lgVn4GrHK1OZ8K5mzaDY7adyldkUeEgicG9aUnGy87ApAkEAm35g4QcRmWDXIDeOB9SScHaDIiCsViGYqfpGhaT3mD/4ESqXLKAvII0M6VYXomjIVw92/HFUrqQ56NrL38maQQJAIUWNfYj9oTuAHyfArWAwYt41NsknbvoZyLaKMjjCi8qsxbBMvXxs4SAkaGaGZ2YgA4Fdna5EjmPKjqPhK2b3YQJAIf+n1WxCSoOw0dYVBtjlBUo3lHtZsh92l/mcasZHgFcaFg+LGR803o+NUVJ0Mjh2EbHygqXAACYqUydcpga7+Q==";
	// 验签使用的公钥
	private String publicKey = "" ;


	@Pointcut("@annotation(com.cz.yingpu.frame.annotation.SecurityApi)")
	public void securityAop(){}



	@Before("securityAop() && args(joinpoint)")
	public void  securityBefore(Joinpoint joinpoint){

	}

	@AfterReturning(pointcut = "securityAop()",
			returning = "returnDatas")
	public void securityAfter(ReturnDatas returnDatas){

		if(returnDatas != null && returnDatas.getData() != null){
			//返回数据
			String result = JsonUtils.writeValueAsString(returnDatas.getData()) ;

			String encodeData = null;
			try {
				encodeData = Des3.encode(result);
			} catch (Exception e) {
//				// TODO Auto-generated catch block
				e.printStackTrace();
				returnDatas.setStatus(ReturnDatas.WARNING);
				returnDatas.setMessage("加密失败！");
			}
			returnDatas.setData(encodeData);
//			returnDatas.setData(result);
		}
	}

	@Autowired
    HttpServletRequest request;

	@Around("securityAop()")
	public Object around(ProceedingJoinPoint proceedingJoinPoint){
		Object object = null ;
		Object[] args = proceedingJoinPoint.getArgs() ;

		Map<String,String[]> paramMap = new HashMap(request.getParameterMap()) ;

		if(!paramMap.containsKey("signCode")){  //说明是非法请求
			return new ReturnDatas(ReturnDatas.ERROR, "非法请求") ;
		}else {
			try {
				String[] sign = (String[])paramMap.get("signCode") ;
				String singStr = StringUtils.join(sign) ;
//				singStr = singStr.replace("~2B~","+") ;


//				//获取私钥 和 公钥
				Cache cacheConfig = cacheManager.getCache(GlobalStatic.cacheKey) ;
				ConfigBean configBean = cacheConfig.get(GlobalStatic.configCache,ConfigBean.class);
//                privateKey = configBean.getApiRSAPriKey() ;
//				publicKey  = configBean.getApiRSASignPubKey() ;

				//解密

//				String params= SecureRSA.decrypt(sign[0], privateKey, "UTF-8") ;   //私钥
//				String params= SecureRSA.decrypt(singStr, privateKey, "UTF-8") ;   //私钥

//				JSONObject json = JSONObject.fromObject(params) ;
				//验证时间戳，防止爬虫请求
//				if(!json.containsKey("T")){
//					return new ReturnDatas(ReturnDatas.ERROR, "非法请求") ;
//				}else {

//					Long T = json.getLong("T") ;
//					Date legalTime = DateUtils.addMinutes(new Date(), -10) ;
					/*if(T < Double.valueOf(DateFormatUtils.format(legalTime, "yyyyMMddHHmmss"))) {  //说明请求时间差超过10分钟，不是合法的
						return new ReturnDatas(ReturnDatas.ERROR, "通讯超时") ;
					}*/
//					//校验token时间
//					if (json.containsKey("token") && StringUtils.isNotBlank(json.getString("token") )){
//						String token = json.getString("token") ;
//						if (json.containsKey("sessionId") && StringUtils.isNotBlank(json.getString("sessionId") )){
//							Cache cache = cacheManager.getCache(GlobalStatic.tokenCacheKey);
//							String userId = json.getString("sessionId") ;
//       			 			Token cacheToken = cache.get("token_"+userId, Token.class) ;
//       			 			if (cacheToken == null){
//								return new ReturnDatas(ReturnDatas.LOGIN, "请登录") ;
//							}else {
//       			 				if (!token.equals(cacheToken.getToken())){
//       			 					return new ReturnDatas(ReturnDatas.LOGIN, "非法请求") ;
//								}
//								Date expired = cacheToken.getExpired() ;  //失效时间
//								if (expired.before(new Date())){  //已失效
//									cache.evict("token_"+userId);
//									return new ReturnDatas(ReturnDatas.LOGIN, "请登录") ;
//								}else{  //代表正常用户，此时要延长失效时间
//									//更新最后操作时间
//									cacheToken.setLastOperate(new Date());
//
//									cacheToken.setExpired(new Date(cacheToken.getLastOperate().getTime() + Integer.valueOf(configBean.getTokenTimeout()) * 60 * 1000));
//									//更新token缓存
//									cache.put("token_"+userId,cacheToken);
//								}
//							}
//						}else {
//							return new ReturnDatas(ReturnDatas.LOGIN, "请登录") ;
//						}
//					}

//					//取得密文
//					String ciphertext = json.getString("sign") ;
//					// 解密后需要验签
//					paramMap.remove("signCode") ;
//					Map<String, Object> sortMap = new TreeMap<String, Object>();  // 使用sortedMap进行key排序
//					sortMap.putAll(paramMap);
//
//					StringBuffer plaintext = new StringBuffer() ;  // 明文数据
//					Iterator iterText = sortMap.entrySet().iterator();
//					Map.Entry entryText ;
//					while (iterText.hasNext()){
//						entryText = (Map.Entry) iterText.next();
//						Object key = entryText.getKey();
//						Object val = entryText.getValue();
//						plaintext.append(key + "=" + ((String[])val)[0]);
//						if (iterText.hasNext()){
//							plaintext.append("&");
//						}
//					}
//					if(! AlipaySignature.rsaCheckContent(plaintext.toString(),ciphertext,publicKey,"utf-8")){
//						return new ReturnDatas(ReturnDatas.ERROR, "非法请求") ;
//					}


					try {
						object = proceedingJoinPoint.proceed() ;
					} catch (Throwable e) {
						// TODO Auto-generated catch block
						// 发送警告邮件！！
						String message = "" ;
						Class superClass = e.getClass().getSuperclass() ;
						if (e instanceof Exception && e.getCause() == null && superClass == Throwable.class  ){
							message = e.getMessage() ;
						}else {   // 抛出error以及系统异常
							StringBuffer paramSB = new StringBuffer() ;
							Iterator iter = paramMap.entrySet().iterator();
							Map.Entry entry ;
							while (iter.hasNext()){
								entry = (Map.Entry) iter.next();
								Object key = entry.getKey();
								Object val = entry.getValue();
								paramSB.append("<div style='text-indent:15px;'><span style='color:red ;'>"+key.toString() + "</span>:" + ((String[])val)[0] + "</div><br>") ;
							}

							StackTraceElement[] elems = e.getStackTrace();
							StringBuffer exceptionInfo = new StringBuffer("<html><body>") ;
							exceptionInfo.append("<h3>请求url：</h3>") ;
							exceptionInfo.append(request.getRequestURI()) ;
							exceptionInfo.append("<h3>入参：</h3>") ;
							exceptionInfo.append(paramSB.toString()) ;
							exceptionInfo.append("<h3>" + e.toString() + "</h3>") ;
							for (StackTraceElement element:
									elems) {
								exceptionInfo.append("<div style='text-indent:15px;'>" +
										element.getClassName() +"."+
										element.getMethodName() +
										"(<span style='color:red ;'>" +
										element.getFileName() +":"+element.getLineNumber() + "</span>)" +
										"</div><br>") ;
							}
							exceptionInfo.append("</body></html>") ;

							MailThreadClazz thread = new MailThreadClazz(configBean.getAlarmEmailSubject() + "(时间："+ DateFormatUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss")+")",exceptionInfo.toString()) ;
							thread.start();

							e.printStackTrace();
							message = "内部错误！";
						}
						return new ReturnDatas(ReturnDatas.ERROR, message) ;
					}

//				}

			}
//			catch ( BadPaddingException e){
//				e.printStackTrace();
//				return new ReturnDatas(ReturnDatas.ERROR, "非法请求") ;
//			}
			catch (Throwable e) {
//				// TODO Auto-generated catch block
				e.printStackTrace();
				return new ReturnDatas(ReturnDatas.ERROR, "请求出错") ;
			}
		}

		return object ;
	}


	/**
	 * 一个多线程的内部类，用来执行邮件的发送
	 */
	private  class MailThreadClazz extends Thread {
		public MailThreadClazz(String theme, String content) {
			super();
			this.content= content ;
			this.theme = theme ;
		}

		public String theme ;
		public String content;

		public void run(){
			try {
				MailUtil.sendHtmlMail(theme,content) ;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
