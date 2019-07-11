package com.cz.yingpu.frame.util;


import com.cz.yingpu.system.entity.ConfigBean;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.security.Security;
import java.util.Date;
import java.util.Properties;

/**
 * 邮件发送工具类
 * Created by Michael on 2017/8/28.
 */
@Component
public class MailUtil {

    @Autowired
    CacheManager cacheManager ;
    private static CacheManager staticCacheManager ;


    @PostConstruct
    public void  init(){
        staticCacheManager = this.cacheManager ;
    }

    private static String account  ;  // 发件人邮箱登录名
    private static String from  ;  // 发件人邮箱
    private static String pwd  ;  // 发件人邮箱密码



//    private  static String  from = "chuizikejirizhi@163.com" ;   //发件人邮箱
//    private  static String  to = "michael_wang90@163.com" ;   //收件人邮箱
////    private  static String  to = "594777427@qq.com" ;   //收件人邮箱
//    private  static String  pwd = "chuizikeji888" ;  //发件人密码
//    private  static String  userName = "chuizikejirizhi@163.com" ;  //发件人用户名
    private  static String host = "SMTP.163.com" ;   //发件人邮箱服务器


    /**
     * 发送html邮件
     * @param theme 主题
     * @param content 内容
     * @return
     * @throws Exception
     */
    public static String sendHtmlMail(String theme , String content) throws Exception {

        /******************首先活动发件箱以及收件箱等信息 *****************************/
        Cache cache = staticCacheManager.getCache(GlobalStatic.cacheKey) ;  // 发件人的缓存
        ConfigBean configBean = cache.get(GlobalStatic.configCache, ConfigBean.class);

        Cache reciverCache = staticCacheManager.getCache(GlobalStatic.ALARM_EMAIL) ;  // 收件人的缓存

        // 发件箱邮箱地址以及密码
        account = configBean.getAlarmEmailAccout() ;
        from = configBean.getAlarmEmailAddress() ;
        pwd = configBean.getAlarmEmailPwd() ;
        // 收件人以及抄送人
        String tos = reciverCache.get(GlobalStatic.ALARM_EMAIL_TO,String.class) ;
        String ccs = reciverCache.get(GlobalStatic.ALARM_EMAIL_CC,String.class) ;

        if (StringUtils.isBlank(tos))
            return  null;

        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
        // Get a Properties object
        Properties props = new Properties();
        props.setProperty("mail.smtp.host", host);
        props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
        props.setProperty("mail.smtp.socketFactory.fallback", "false");
        props.setProperty("mail.smtp.port", "465");
        props.setProperty("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.auth", "true");

        try {
            Session session = Session.getDefaultInstance(props, new Authenticator(){
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(account, pwd);
                }});
            Message message = new MimeMessage(session);

            // 设置发件人和收件人
            message.setFrom(new InternetAddress(from));
            String[] toArray = tos.split(";") ;
            Address to[] = new InternetAddress[toArray.length];
            for(int i=0;i< toArray.length;i++){
                to[i] = new InternetAddress(toArray[i]);
            }
            // 多个收件人地址
            message.setRecipients(Message.RecipientType.TO, to);  // 收件人
            if (StringUtils.isNotBlank(ccs)){                       // 抄送人
                String[] ccArray = ccs.split(";") ;
                Address cc[] = new InternetAddress[ccArray.length];
                for(int i=0;i< ccArray.length;i++){
                    cc[i] = new InternetAddress(ccArray[i]);
                }
                message.setRecipients(Message.RecipientType.CC,cc);
            }

            message.setSubject(theme); // 标题
            message.setSentDate(new Date());  // 发送时间

            //容器类，可以包含多个MimeBodyPart对象
            Multipart multipart = new MimeMultipart();
            //MimeBodyPart可以包装文本，图片，附件
            MimeBodyPart body = new MimeBodyPart();
            //HTML正文
            body.setContent(content, "text/html; charset=UTF-8");
            multipart.addBodyPart(body);

            //添加图片&附件
//            body = new MimeBodyPart();
//            body.attachFile(fileStr);
//            multipart.addBodyPart(body);

            //设置邮件内容
            message.setContent(multipart);
            //仅仅发送文本
            //message.setText(content);// 内容
            message.saveChanges();

            Transport.send(message);
            System.out.println("EmailUtil ssl协议邮件发送打印" +message.toString());
        }catch (Exception e){
            e.printStackTrace();
        }

        return  null ;
    }

    public static void main(String[] args) {
        MailUtil mailUtil = new MailUtil() ;
        try {
            mailUtil.sendHtmlMail("测试邮件","这是一个java测试邮件") ;
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
