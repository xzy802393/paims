<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.gargoylesoftware.htmlunit.javascript.host.Console" %>
<%@page language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String url = basePath + request.getServletPath() + "?" + request.getQueryString();
    String encodeUrl = URLEncoder.encode(url, "UTF-8");
    request.setAttribute("isLogin", request.getSession().getAttribute("pcuser") != null);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=1220"/>
   <title>九趣贷 — 贷快乐，更带梦想</title>
   <link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
   
    <base href="<%=basePath%>pc/my-invest/" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="../css/common.css"/>
    <link rel="stylesheet" type="text/css" href="../css/account.css"/>
    <link rel="stylesheet" type="text/css" href="css/deposit.css"/>
    <link rel="stylesheet" type="text/css" href="css/amazeui.chosen.css"/>
    <link rel="stylesheet" type="text/css" href="../css/login.css"/>
    <link rel="stylesheet" type="text/css" href="../css/zhifu-password.css"/>

    <!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
    <style>
        .agreement {
            padding-top: 26px;
        }

        .agreement #agreeText {
            vertical-align: middle;
        }

        .agreement lable {
            vertical-align: middle;
        }

        .agreement lable a {
            color: #239AFB;
        }
        .deposit-main .deposit-fun p { height: auto; }
    </style>
</head>
<body>
<!--顶部-->

<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no" style="border:0px;"></iframe>
<!--主体-->
<div class="account-box">
    <div class="center">

        <!--右边主体部分-->
        <div class="deposit-main">
            <h3>购买</h3>
            <div class="deposit-fun clearfix">
                <p class="deposit-num">购买金额 <input type="number" readonly id="czje" value="${param.amount}" maxlength="10"/> <span>元</span></p>
                <!-- <p class="account-balance">账户余额 <span>0.00</span> 元，充值后余额 <span>0.00</span> 元</p> -->
                <p class="quan" style="padding-top:25px;">使用卡券
                    <select style="margin-left:18px; margint-top: 30px; width: 300px;" data-placeholder="请选择优惠券" class="demo" multiple>
                        <c:if test="${empty data.userCards}">
                            <option amount="0" value="0">不使用卡券</option>
                        </c:if>
                        <c:forEach items="${data.userCards}" var="card">
                            <option amount="${card.limitMoney}" value="${card.money}" id="${card.id}">
                                ${card.money}元卡券（${card.endTime} 到期）
                            </option>
                        </c:forEach>
                    </select>
                    <span style="display: inline-block;padding-left:20px;">实际抵扣:<span class="jine"> 0 </span> 元</span>
                </p>
                <p class="pay-style">支付方式
                    <a class="q-payment active" id="ye"
                       onclick="$(this).parent().find('a').removeClass('active');$(this).addClass('active')"><img
                            src="../img/balance-pay.jpg"/></a>
                    <a class="q-payment" id="kj"
                       onclick="$(this).parent().find('a').removeClass('active');$(this).addClass('active')"><img
                            src="../img/account/deposit-style-1.png"/></a>
                    <a class="e-pay" id="wy"
                       onclick="$(this).parent().find('a').removeClass('active');$(this).addClass('active')"><img
                            src="../img/account/deposit-style-2.png"/>网银支付</a>
                </p>

                <!--已添加银行卡时显示银行卡和查看充值限额表-->
                <!--没有添加银行卡时显示添加银行卡，查看充值限额，*为了您的资金安全，请先完成等等-->
                <p class="bank left" id="khyh" style="display: none;">开户银行


                    <c:choose>
                        <c:when test="${pcuser.bankNum!=null}">
                            <a class="active"><span class="bank-icon"
                                style="background:url(${bank.logo}) no-repeat center;background-size:cover;"></span>${bank.name}（${bank.banknum})</a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void($('#bindBank').show())"><span class="add"></span>添加认证银行卡</a>
                        </c:otherwise>
                    </c:choose>

                    <a href="javascript:xiane();" class="look-for">查看充值限额表</a>
                </p>

                <div class="choose-bank clearfix" id="chooseBank" style="display: none;">
                    <div class="title left">
                        选择银行
                    </div>

                    <div class="bank-list left" id="bankList">
                        <ul class="clearfix">
                            <li data-value="0801020000"><a class="active"><img src="../img/yh_logo/gongshang.png"/></a>
                            </li>
                            <li data-value="0801030000"><a class=""><img src="../img/yh_logo/nonghang-1.png"/></a></li>
                            <li data-value="0801050000"><a class=""><img src="../img/yh_logo/jianhang-2.png"/></a></li>
                            <li data-value="0803050000"><a class=""><img src="../img/yh_logo/mingsheng.png"/></a></li>
                            <li data-value="0801000000"><a class=""><img src="../img/yh_logo/youzheng-16.png"/></a></li>
                            <li data-value="0803030000"><a class=""><img src="../img/yh_logo/guangda-18.png"/></a></li>
                            <li data-value="0803040000"><a class=""><img src="../img/yh_logo/huaxia-4.png"/></a></li>
                            <li data-value="0803080000"><a class=""><img src="../img/yh_logo/zhaoshang-15.png"/></a>
                            </li>
                            <li data-value="0804184930"><a class=""><img
                                    src="../img/yh_logo/luoyangshangye-14.png"/></a></li>
                            <li data-value="0801040000"><a class=""><img src="../img/yh_logo/zhonghang.png"/></a></li>
                            <li data-value="0803010000"><a class=""><img src="../img/yh_logo/jiaotong-13.png"/></a></li>
                            <li data-value="0803100000"><a class=""><img src="../img/yh_logo/pufa-12.png"/></a></li>
                            <li data-value="0803090000"><a class=""><img src="../img/yh_logo/xingye-11.png"/></a></li>
                            <li data-value="0803020000"><a class=""><img src="../img/yh_logo/zhongxin-10.png"/></a></li>
                            <li data-value="0804031000"><a class=""><img src="../img/yh_logo/beijing-9.png"/></a></li>
                            <li data-value="0803060000"><a class=""><img src="../img/yh_logo/guangdong-8.png"/></a></li>
                            <li data-value="0804105840"><a class=""><img src="../img/yh_logo/pingan-7.png"/></a></li>
                            <li data-value="0803160000"><a class=""><img src="../img/yh_logo/zheshang-6.png"/></a></li>
                            <li data-value="0803202220"><a class=""><img src="../img/yh_logo/xinhuicunzheng-5.png"/></a>
                            </li>
                        </ul>
                        <!--中国工商银行(0801020000)
                        中国农业银行(0801030000)
                        中国建设银行(0801050000)
                        中国民生银行(0803050000)
                        中国邮政(0801000000)
                        中国光大银行(0803030000)
                        华夏银行(0803040000)
                        招商银行(0803080000)
                        洛阳市商业银行(0804184930)
                        中国银行(0801040000)
                        交通银行(0803010000)
                        上海浦东发展银行(0803100000)
                        兴业银行(0803090000)
                        中信银行(0803020000)
                        北京银行(0804031000)
                        广东发展银行(0803060000)
                        平安银行(0804105840)
                        浙商银行(0803160000)
                        鑫汇村镇银行(0803202220)-->
                    </div>
                </div>
                <p class="tip left" style="display: none;">*为了您的资金安全，请先完成<a href="#">实名认证</a>和<a href="#">绑定银行卡</a></p>

                <!-- <div class="deposit-btn">
                    <button class="active" onclick="javascript:chongzhi();">充值</button>  每次充值额需大于等于100元
                </div> -->
                <div class="deposit-btn">
                    <button class="tijiao active" style="width:126px;">您未同意协议</button>
                </div>
                <div class="agreement">
                    <input type="checkbox" name="" id="agreeText" value="agree">
                    <lable for="agreeText">我已阅读并同意<a href="javascript:void(viewLicense(1));" class="lianjie">《X智投服务协议书》</a>、<a href="javascript:void(viewLicense(2));" class="lianjie">《X智投产品说明书》</a>、<a
                            href="javascript:void(viewLicense(0));" class="lianjie">《出借风险提示及禁止性说明书》</a>
                    </lable>
                </div>
                <p class="deposit-tip"><span>*</span> 根据国家相关规定：不支持使用信用卡充值</p>
            </div>

            <div class="reminders">
                <p>温馨提示： </p>
                <p>1、如果在充值过程中遇到问题请致电：400-969-1811，客服竭诚为您服务；</p>
                <p>2、如果超出支付限额，可以拆分整体投资金额多次充值； </p>
                <p>3、单次充值金额需大于或等于100元； </p>
                <p>4、充值服务0手续费，账户金额提现0手续费； </p>
                <p>5、请使用借记卡充值，信用卡无法充值； </p>
                <p>6、银行卡余额不足需要先补充金额后再次充值； </p>
                <p>7、开通网银方法：（1）携带本人身份证到银行柜台办理。（2）登录网上银行办理；</p>
                <p>8、如果存在银行卡状态异常情况，请联系银行做取消挂失或补卡处理； </p>
                <p>9、每日的充值限额依据各银行限额为准，请注意您的银行卡充值限制，以免造成不便。</p>
            </div>
        </div>
    </div>
    <!--充值遇到问题的弹框-->
    <div id="tankuang" class="deposit-alert" style="display:none;">
        <div class="alert-tit" id="">
            <p>充值提示</p>
        </div>
        <div class="alert-main">
            <p class="icon"><span></span>请您在新打开的第三方支付页面上完成，完成前请不要关闭此窗口</p>
            <div class="alert-btn">
                <p>完成充值后请根据您的情况点击下面的按钮</p>
                <input class="btn" type="button" onclick="location.href='/yingpu/pc/html/account';" id="" value="充值遇到问题"/>
                <input class="red" type="button" onclick="location.href='/yingpu/pc/html/account/Xzhitou.jsp';" name="" id="" value="已完成充值"/>
            </div>
            <p>如果【快捷充值】提示“未开通支付功能”，请前往银联开通</p>
        </div>
    </div>


    <div id="xiane" style="display:none;">
        <div id="magicdomid121" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="bold:true color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-weight:bold;font-family:微软雅黑;font-size:10pt;">银行</span>
        </div>
        <div id="magicdomid122" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="bold:true color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-weight:bold;font-family:微软雅黑;font-size:10pt;">快速充值/委托充值</span>
        </div>
        <div id="magicdomid123" class="ace-line gutter-noauthor emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;font-family:inherit;border:none !important;">
            <span class="bold:true color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-weight:bold;font-family:微软雅黑;font-size:10pt;">（APP签约）</span>
        </div>
        <div id="magicdomid124" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="bold:true color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-weight:bold;font-family:微软雅黑;font-size:10pt;">手机快捷充值</span>
        </div>
        <div id="magicdomid125" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">工行</span>
        </div>
        <div id="magicdomid126" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，40万/日（单日仅限5笔成功交易），50万/月</span>
        </div>
        <div id="magicdomid127" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日（单日仅限5笔成功交易），100万/月</span>
        </div>
        <div id="magicdomid128" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">农行</span>
        </div>
        <div id="magicdomid129" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，30万/日，50万/月（单日仅限6笔成功交易）</span>
        </div>
        <div id="magicdomid130" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，20万/日（单日仅限6笔成功交易），100万/月</span>
        </div>
        <div id="magicdomid131" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">建行</span>
        </div>
        <div id="magicdomid132" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，10万/日，50万/月</span>
        </div>
        <div id="magicdomid133" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，10万/日，100万/月</span>
        </div>
        <div id="magicdomid134" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">中行</span>
        </div>
        <div id="magicdomid135" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span>
        </div>
        <div id="magicdomid136" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，10万/日，100万/月</span>
        </div>
        <div id="magicdomid137" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">邮储</span>
        </div>
        <div id="magicdomid138" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span>
        </div>
        <div id="magicdomid139" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span>
        </div>
        <div id="magicdomid140" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">招行</span>
        </div>
        <div id="magicdomid141" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，20万/日，50万/月</span>
        </div>
        <div id="magicdomid142" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，20万/日，100万/月</span>
        </div>
        <div id="magicdomid143" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">兴业</span>
        </div>
        <div id="magicdomid144" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，50万/月</span>
        </div>
        <div id="magicdomid145" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，100万/月</span>
        </div>
        <div id="magicdomid146" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">广发</span>
        </div>
        <div id="magicdomid147" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span>
        </div>
        <div id="magicdomid148" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span>
        </div>
        <div id="magicdomid149" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">平安</span>
        </div>
        <div id="magicdomid150" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span>
        </div>
        <div id="magicdomid151" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span>
        </div>
        <div id="magicdomid152" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">中信</span>
        </div>
        <div id="magicdomid153" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">1万/笔，2万/日,2万/月</span>
        </div>
        <div id="magicdomid154" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">1万/笔，2万/日,2万/月</span>
        </div>
        <div id="magicdomid155" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">华夏</span>
        </div>
        <div id="magicdomid156" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span>
        </div>
        <div id="magicdomid157" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span>
        </div>
        <div id="magicdomid158" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">光大</span>
        </div>
        <div id="magicdomid159" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，50万/月</span>
        </div>
        <div id="magicdomid160" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，100万/月</span>
        </div>
        <div id="magicdomid161" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">浦发</span>
        </div>
        <div id="magicdomid162" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，30万/日，50万/月</span>
        </div>
        <div id="magicdomid163" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万元/笔，20万/日，100万/月</span>
        </div>
        <div id="magicdomid164" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">民生</span>
        </div>
        <div id="magicdomid165" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span>
        </div>
        <div id="magicdomid166" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span>
        </div>
        <div id="magicdomid167" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt"
                  style="font-family:微软雅黑;font-size:10pt;">交行</span>
        </div>
        <div id="magicdomid168" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，50万/月</span>
        </div>
        <div id="magicdomid169" class="ace-line gutter-noauthor text-align-type-center emptyGutter"
             style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:inherit;border:none !important;">
            <span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，100万/月</span>
        </div>
        <div>
            <br/>
        </div>

    </div>
</div>
</div>
<!--支付密码的弹框-->

<div class="zhifu-password" style="display: none;">
    <form action="" method="post" name="payPassword" id="form_paypsw">
        <div id="payPassword_container" class="alieditContainer clearfix" data-busy="0">
            <label for="i_payPassword" class="i-block">请输入6位支付密码</label>
            <div class="i-block clearfix" data-error="i_error">
                <div class="i-block six-password left">
                    <input class="i-text sixDigitPassword" id="payPassword_rsainput" type="password"
                           autocomplete="off" required="required" value="" name="payPassword_rsainput"
                           data-role="sixDigitPassword" tabindex="" maxlength="6" minlength="6"
                           aria-required="true">
                    <div tabindex="0" class="sixDigitPassword-box" style="width: 180px;">
                        <i style="width: 29px; border-color: transparent;" class=""><b
                                style="visibility: hidden;"></b></i>
                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                        <i style="width: 29px;"><b style="visibility: hidden;"></b></i>
                        <span style="width: 29px; left: 0px; visibility: hidden;" id="cardwrap"
                              data-role="cardwrap"></span>
                    </div>
                </div>
                <a class="forget-password left" href="myaccount/payment_password.jsp">忘记支付密码？</a>
            </div>

        </div>
        <input type="button" value="确认投资" onclick="javascript:touzi()">
    </form>
</div>

<!--绑定银行卡层-->

<!--绑定银行卡-->
<!--绑定银行卡-->
<iframe src="../myaccount/bind_bankcard.html" id="bindBank" width="100%"
        style="position: absolute;top: 0;left: 0;display: none;z-index: 10;" scrolling="no"></iframe>
<!--底部导航-->
<iframe src="../footer2.html" width="100%" scrolling="no" style="border:0px;height:326px;"></iframe>

<!--加载js文件-->
<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/queryString.js" type="text/javascript" charset="utf-8"></script>
<script src="../../layer-v3.0.3/layer/layer.js"></script>
<script src="../js/radialIndicator.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
<script src="js/amazeui.chosen.js" type="text/javascript" charset="utf-8"></script>

<script src="../js/zhifu_password.js" type="text/javascript" charset="utf-8"></script>
<script>$('body').data('tradPassword', '${pcuser.tradPassword}')</script>

<script type="text/javascript">

    useLoadingShade();
    $("#bindBank").height($(document).height());
    //资产分布图表
    $(function () {
        if (queryString('type') != null && queryString('type') != undefined && queryString('type') != '') {
            $('#tankuang').show();
        }
        $('#czje').keyup(function (e) {

            if ($('#czje').val() == '') {
                $('#yue').text('${pcuser.caBalance}');
            } else {

                $('#yue').text(accAdd('${pcuser.caBalance}', $('#czje').val()));

            }
        });

        $('.pay-style>a').click(function () {
            var type = $(this).attr('id');
            if (type == 'wy') {
                $('#khyh').hide();
                $('#chooseBank').show();
            } else if (type == 'kj')  {
                $('#khyh').show();
                $('#chooseBank').hide();
            }
            else {
                $('#chooseBank').hide();
                $('#khyh').hide();
            }

        });

        $("#bankList").on("click", "li", function () {
            $("#bankList").find("a").removeClass("active");
            $(this).find("a").addClass("active");
        })
    });

    function xiane() {

        layer.open({content: $('#xiane').html(), area: ['500px', '800px']});
    }

    function chongzhi() {
        var couponIdMap = {
            couponIdArr : $('.demo>option:selected').map(function(i, e) {
                return $(e).attr('id');
            }).get()
        };

        if ($('#czje').val() == '') {
            layer.alert('请输入充值金额');
            return false;
        }
        if ($('#czje').val() < 100) {
            layer.alert('充值金额必须大于100');
            return false;
        }
        if ('${pcuser.bankNum}' == null || '${pcuser.bankNum}' == '') {
            $('#bindBank').show();
            return false;
        }

        var paramString = '';
        if ($('.pay-style').find('a[class*=active]').attr('id') == 'kj') {
            paramString = 'money=' + discount($('.quan .jine').text()) + '&'
                    + decodeURIComponent($.param(couponIdMap)).replace(/\[\]/g, '')
                    + '&projectId=${param.projectId}&amount=${param.amount}&deadLine=${param.deadLine}'

        }
        else {
            paramString = 'money=' + discount($('.quan .jine').text())
                    + '&bank=' + $('#bankList').find('a[class="active"]').parent('li').attr('data-value')
                    + '&' + decodeURIComponent($.param(couponIdMap)).replace(/\[\]/g, '')
                    + '&projectId=${param.projectId}&amount=${param.amount}&deadLine=${param.deadLine}' ;
        }

        $.post('/yingpu/pc/si/invest/order/create?' + paramString, {
            type : $('.pay-style').find('a[class*=active]').attr('id')
        }, function(result) {
            if (result.status == 'success') {
                $('#tankuang').show();
                window.open(result.data);
            }
        });
    }

    function discount(amount) {
        return accAdd('${param.amount}', -amount);
    }

    function touzi() {
        var couponIdMap = {
            couponIdArr : $('.demo>option:selected').map(function(i, e) {
                return $(e).attr('id');
            }).get()
        };

        if (!$('body').data('tradPassword')) {
            layer.alert('您还没有设置支付密码', function () {
                location.href = '/yingpu/pc/myaccount/payment_password.jsp';
            });
            return false;
        }

        var str = decodeURIComponent($.param(couponIdMap)).replace(/\[\]/g, '')
                + '&projectId=${param.projectId}&amount=${param.amount}&deadLine=${param.deadLine}';

        $.post('/yingpu/pc/si/invest/balance/pay?' + str, {
            tradePassword: $('#payPassword_rsainput').val()
        }, function (data) {
            layer.closeAll();
            if (data.status == 'success') {
                layer.alert('投资成功！');
                setTimeout(function() {
                    location.href = '/yingpu/pc/html/account/Xzhitou.jsp';
                }, 800);
            } else {
                if (data.message == '您的支付密码已被锁定') {
                    var ind = layer.open({
                        'title': '错误提示', 'content': '您的支付密码已被锁定,请重置支付密码', 'btn': ['忘记密码'], 'yes': function () {

                            location.href = '/yingpu/pc/myaccount/payment_password.jsp';
                        }
                    });
                } else {
                    var ind = layer.open({
                        'title': '错误提示', 'content': data.message, 'btn': ['重新输入'], 'yes': function () {
                            layer.close(ind);
                            closezhifu();
                            openPasswordInput();
                        }, 'btn2': function () {
                            location.href = '/yingpu/pc/myaccount/payment_password.jsp';
                        }
                    });
                }

                closezhifu();
            }
        });
    }

    function closezhifu() {
        $('#payPassword_rsainput').val('')
        $('.sixDigitPassword-box').find('b').css({'visibility': 'hidden'});
        $('.sixDigitPassword-box').children('span').css('left', '0px');
        $('.sixDigitPassword-box').children('i').first().addClass('active');
        $('#payPassword_rsainput').focus();
    }
    function openPasswordInput() {
        layer.open({
            type: 1, //Page层类型
            area: ['446px', '220px'],
            title: false,
            shade: 0.6, //遮罩透明度
//						  ,maxmin: true //允许全屏最小化
            anim: 1, //0-6的动画形式，-1不开启
            content: $(".zhifu-password"),
            cancel: function () {
                closezhifu();

            }
        });
        $('#payPassword_rsainput').focus();
    }
</script>
<script type="text/javascript">

    // 同意书与支付按钮同步
    $submit = $('.deposit-btn .tijiao');
    $agreement = $('.agreement #agreeText');
    var checked = true;

    // 支付按钮的点击
    $submit.on('click', function () {
        var text = $submit.html();
        // console.log(text);
        if (text == "确认支付") {
            if ($('.pay-style').find('a[class*=active]').attr('id') == 'ye') {
                openPasswordInput();
            }
            else {
                chongzhi();
            }
        } else {
            // 未提交
        }
    });

    // 协议同意与否
    $agreement.on('click', function () {
        if (checked) {
            $agreement.checked = true;
            $submit.html('确认支付');
            checked = !checked;
        } else {
            $agreement.checked = false;
            $submit.html('您未同意协议');
            checked = !checked;
        }
    });
    $(function(){
        $agreement.click();
    });




    // 使用优惠券的抵扣金额
    $('.quan select').change(function () {
        // 被选中的券
        var $select = $('.quan select option:selected');
        var selectTotal = 0, selectLimitMoney = 0;
        var investAmount = '${param.amount}' * 1;

        $select.each(function(i, e) {
            selectTotal += $(e).attr('value') * 1;
            selectLimitMoney += $(e).attr('amount') * 1;
        });

        var remainsAmount = investAmount - selectLimitMoney;
        $('.quan select option').removeAttr('disabled').filter(function(i, e) {
            return !e.selected && $(e).attr('amount') > remainsAmount;
        })
        .not($(this)).attr('disabled', true);

        $('.quan select').trigger('chosen:updated');
        $('.quan .jine').text(selectTotal);
    });

    $(function() {
        $('.demo').chosen({disable_search_threshold: 99});
    });

    function viewLicense(idx) {
        var idxs = [17,22,23];
        layer.open({
            type: 2,
            content: '<%=basePath%>pc/myaccount/announce/content?id=' + idxs[idx] + '&type=contractsample',
            area: ['50%', '80%']
        });
    }
</script>

</body>
</html>


