package com.cz.yingpu.frame.util;

import com.alibaba.druid.support.json.JSONUtils;
import com.google.gson.Gson;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.http.HttpEntity;
//import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;


public class SMSUtil {
	
//	public static final String serviceURL = "http://sdk.entinfo.cn:8060/z_mdsmssend.aspx";
	public static final String serviceURL = "http://114.55.88.173:9988/sms.aspx";
//	public static final String userid = "78";
//	public static final String password = "CJKFC123";
//	public static final String account = "CJKFC";
	
	
	
	//发送验证码的请求路径URL http://web.xbysp.com/sms.aspx
   // private static final String SERVER_URL="https://api.netease.im/sms/sendcode.action";
	private static final String SERVER_URL="https://api.netease.im/sms/sendcode.action";

    private static final String NETEASE_SMS_SEND_TEMPLATE_API = "https://api.netease.im/sms/sendtemplate.action";
   
    //网易云信分配的账号，请替换你在管理后台应用下申请的Appkey
    private static final String
    
            APP_KEY="fe698e1854d7894a67e23ebf94511df3";
    //网易云信分配的密钥，请替换你在管理后台应用下申请的appSecret
    private static final String APP_SECRET="a513a2e165e7";
    //随机数
    private static final String NONCE="0123456789";
    //短信模板ID
    private static final String TEMPLATEID ="3139274";
    //手机号
    private static final String MOBILE="18792546455";
    //验证码长度，范围4～10，默认为4
    private static final String CODELEN="4";
    
    private static RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(15000).setConnectTimeout(15000)
			.setConnectionRequestTimeout(15000).build();
    @SuppressWarnings("deprecation")
	public static void main(String[] args) throws Exception {

		sendSms("15091335546",1,1.1,2.2,"1","48251");
    	/*SendSMSMulituser(new String[] { "18710929273" }, "3882059");*/

    }
    
    
    @SuppressWarnings("unchecked")
	public static String SendSMSMulituser(String[] mobile, String tid, String[] params) throws Exception {
    	Map<String, ?> map=new HashMap<>();
    	try {
    		HttpPost httpPost = new HttpPost(NETEASE_SMS_SEND_TEMPLATE_API);// 创建httpPost
    		  String curTime = String.valueOf((new Date()).getTime() / 1000L);
      		httpPost.addHeader("AppKey", APP_KEY);
            httpPost.addHeader("Nonce", NONCE);
            httpPost.addHeader("CurTime", curTime);
            httpPost.addHeader("CheckSum",  CheckSumBuilder.getCheckSum(APP_SECRET, NONCE, curTime));
            httpPost.addHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
    		// 创建参数队列
    		List<BasicNameValuePair> nameValuePairs = new ArrayList<>();
    		
    		
    		nameValuePairs.add(new BasicNameValuePair("templateid", tid));
    		nameValuePairs.add(new BasicNameValuePair("mobiles", new Gson().toJson(mobile).toString()));
    		if (params != null) {
    			nameValuePairs.add(new BasicNameValuePair("params", new Gson().toJson(params).toString()));
    		}
//    		nameValuePairs.add(new BasicNameValuePair("authCode", checkSum));
    		try {
    			httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs, "UTF-8"));
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    		CloseableHttpClient httpClient = null;
    		CloseableHttpResponse response = null;
    		HttpEntity entity = null;
    		String responseContent = null;
    		try {
    			// 创建默认的httpClient实例.
    			httpClient = HttpClients.createDefault();
    			httpPost.setConfig(requestConfig);
    			// 执行请求
    			response = httpClient.execute(httpPost);
    			entity = response.getEntity();
    			responseContent = EntityUtils.toString(entity, "UTF-8");
    		} catch (Exception e) {
    			e.printStackTrace();
    		} finally {
    			try {
    				// 关闭连接,释放资源
    				if (response != null) { 
    					response.close();
    				}
    				if (httpClient != null) {
    					httpClient.close();
    				}
    			} catch (IOException e) {
    				e.printStackTrace();
    			}
    		}
    		map = (Map<String, ?>) JSONUtils.parse(responseContent);
		} catch (Exception e) {
			e.printStackTrace();
			
		}
    	return map.get("code").toString();
    }
    
    
    @SuppressWarnings("unchecked")
	public static String SendSMS(String checkSum, String mobile, int type) throws Exception {
    	Map<String, String> map=new HashMap<>();
    	try {
    		HttpPost httpPost = new HttpPost(SERVER_URL);// 创建httpPost
    		  String curTime = String.valueOf((new Date()).getTime() / 1000L);
    		  String tid="";
      		if(type==1){
      			tid="3139274";
      		}else if(type==4){
      			tid="3144257";
      		}else if(type==3){
      			tid="3146238";
      		}else if(type==5){
      			tid="3145245";
      		}else if(type==6){
      			tid="4042117";
      		}    		
      		httpPost.addHeader("AppKey", APP_KEY);
            httpPost.addHeader("Nonce", NONCE);
            httpPost.addHeader("CurTime", curTime);
           // String checkSum = CheckSumBuilder.getCheckSum(APP_SECRET, NONCE, curTime);
            httpPost.addHeader("CheckSum",  CheckSumBuilder.getCheckSum(APP_SECRET, NONCE, curTime));
            httpPost.addHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
    		// 创建参数队列
    		List<BasicNameValuePair> nameValuePairs = new ArrayList<>();
    		
    		nameValuePairs.add(new BasicNameValuePair("templateid", tid));
    		nameValuePairs.add(new BasicNameValuePair("mobile", mobile));
    		nameValuePairs.add(new BasicNameValuePair("codeLen", CODELEN));
    		nameValuePairs.add(new BasicNameValuePair("authCode", checkSum));
    		try {
    			httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs, "UTF-8"));
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    		CloseableHttpClient httpClient = null;
    		CloseableHttpResponse response = null;
    		HttpEntity entity = null;
    		String responseContent = null;
    		try {
    			// 创建默认的httpClient实例.
    			httpClient = HttpClients.createDefault();
    			httpPost.setConfig(requestConfig);
    			// 执行请求
    			response = httpClient.execute(httpPost);
    			entity = response.getEntity();
    			responseContent = EntityUtils.toString(entity, "UTF-8");
    		} catch (Exception e) {
    			e.printStackTrace();
    		} finally {
    			try {
    				// 关闭连接,释放资源
    				if (response != null) { 
    					response.close();
    				}
    				if (httpClient != null) {
    					httpClient.close();
    				}
    			} catch (IOException e) {
    				e.printStackTrace();
    			}
    		}
    		map=(Map<String, String>) JSONUtils.parse(responseContent);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
    	return map.get("obj");
    }
    
	//发送短信
	public static String SendSMS(String userid , String account, String password , String mobile, String content) throws Exception {
		String smsUrl = serviceURL+"?action=send&password="+password+"&account="+account+"&userid="+userid+"&mobile="+mobile+"&content="+ URLEncoder.encode(content,"UTF-8");
		URL url = new URL(smsUrl);
 		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
 		conn.setConnectTimeout(5000);
 		conn.setRequestMethod("GET");
 		conn.setRequestProperty("Content-Type",
				"application/x-www-form-urlencoded,charset=UTF-8");
 		conn.setRequestProperty("Accept-Charset", "UTF-8");
 		conn.setRequestProperty("contentType", "UTF-8");
 		String json = "";
 		if (conn.getResponseCode() == 200) {
 			InputStream inStream = conn.getInputStream();
 			byte[] data = readInputStream(inStream);
 	 		 json = new String(data);
 		}
		System.out.println(smsUrl);
 		return json;
	}
	
	public  static String SendSMS1(){
		
		return "";
	}

	  public static byte[] readInputStream(InputStream instream) throws Exception {
	 		ByteArrayOutputStream outStream = new ByteArrayOutputStream();//读到的数据放到内存中
	 		byte []buffer = new  byte[1024];
	 		int len = 0;
	 		while((len = instream.read(buffer)) !=-1){
	 			outStream.write(buffer, 0, len);//往内存中写入数据
	 		}
	 		instream.close();
	 	 return outStream.toByteArray();
	 	}
	public static void sendsms(String phone, String authcode, int type) throws Exception {
		HttpClient httpClient = new HttpClient();
		PostMethod postMethod = new PostMethod("http://api.1cloudsp.com/api/v2/single_send");
		postMethod.getParams().setContentCharset("UTF-8");
		postMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,new DefaultHttpMethodRetryHandler());

		String accesskey = "Q6Yb5TnIBwax4ENH"; //用户开发key
		String accessSecret = "5rd7gejxUYZyMGe1xoRHbNCwNKNBQhNd"; //用户开发秘钥
		String tid="";
		if(type==1){
			tid="48250";
		}else if(type==3){
			tid="48251";
		}else if(type==4){
			tid="49133";
		}else if(type==6){
			tid="49134";
		}else if(type==5){
			tid="49135";
		}else if(type==7){
			tid="50187";
		}
		NameValuePair[] data = {
				new NameValuePair("accesskey", accesskey),
				new NameValuePair("secret", accessSecret),
				new NameValuePair("sign", "31836"),
				new NameValuePair("templateId", tid),
				new NameValuePair("mobile", phone),
				new NameValuePair("content", URLEncoder.encode(authcode, "utf-8"))//（示例模板：{1}您好，您的订单于{2}已通过{3}发货，运单号{4}）
		};
		postMethod.setRequestBody(data);
		postMethod.setRequestHeader("Connection", "close");
		int statusCode = httpClient.executeMethod(postMethod);
//		System.out.println("statusCode: " + statusCode + ", body: " + postMethod.getResponseBodyAsString());

	}

	public static void sendSms(String phone, int deadLine , Double money , Double financingAmount , String code ,String type) throws Exception {

		HttpClient httpClient = new HttpClient();
		PostMethod postMethod = new PostMethod("http://api.1cloudsp.com/api/v2/single_send");
		postMethod.getParams().setContentCharset("UTF-8");
		postMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,new DefaultHttpMethodRetryHandler());

		String accesskey = "Q6Yb5TnIBwax4ENH"; //用户开发key
		String accessSecret = "5rd7gejxUYZyMGe1xoRHbNCwNKNBQhNd"; //用户开发秘钥
		String content = "";
		if(type.equals("48250")){
			int random = (int)((Math.random()*9+1)*10000);
			content = random +"";
		}else if(type.equals("48251")){
			StringBuilder sb = new StringBuilder();
			sb.append(code).append("##").append(financingAmount).append("##").append(deadLine).append("##").append(money);
			content = sb.toString();
		}
		NameValuePair[] data = {
				new NameValuePair("accesskey", accesskey),
				new NameValuePair("secret", accessSecret),
				new NameValuePair("sign", "31836"),
				new NameValuePair("templateId", type),
				new NameValuePair("mobile", phone),
				new NameValuePair("content", URLEncoder.encode(content, "utf-8"))//（示例模板：{1}您好，您的订单于{2}已通过{3}发货，运单号{4}）
		};
		postMethod.setRequestBody(data);
		postMethod.setRequestHeader("Connection", "close");
		int statusCode = httpClient.executeMethod(postMethod);
		System.out.println("statusCode: " + statusCode + ", body: "
				+ postMethod.getResponseBodyAsString());
	}


	  
	  
	  

	/*public static void main(String[] args) throws Exception {
		SMSUtil smsUtil = new SMSUtil();
//		File file =
//		String status =  smsUtil.SendSMS("178", "yingpucaifu","yingpucaifu",
//				"18538036976,15638110867,15675874592,13552489405,13051958919,15574982687,18866718554,17603880567,15874184619,13552489381,13161635258,15100681603,13121672610,15714166111,15612833359,15978679728,15069546315,13667314388,15679453839,17773417392,13889330405,18673166626,15224202010,15942570778,13125240153,18684882955,18890693611,13322448884,15017473016,13310623051,15066536991,13011828472,15526447209,13077347312,15116285857,15106812712,13170949290,13161626569,15804067200,18842531447" ,
//				"【营普金服】尊敬的营普金服投资者您好，您所投资的D计划10008期已进行第三期还款，本息已到您的账户内，请您及时查收，期待您的再次投资！如有疑问，请联系客服：4009691811\n");
		String status =  SMSUtil.SendSMS("178", "yingpucaifu","yingpucaifu",
				"18538036976,15638110867,18089332255,13548583124,18650311737,13272317029,18570623033,13789293417,18163744136,15093179367",
				"【营普金服】尊敬的营普金服投资者您好，您所投资的D计划已进行第三期还款，本息已到您的账户内，请您及时查收，期待您的再次投资");

				System.out.println(status);
	}*/


}
