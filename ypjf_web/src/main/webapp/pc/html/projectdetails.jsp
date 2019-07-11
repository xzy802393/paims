<%@ page language="java" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=1220"/>
    <title>九趣贷 — 贷快乐，更带梦想</title>
    <link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
    <link rel="stylesheet" type="text/css" href="./css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="./css/common.css"/>
    <link rel="stylesheet" type="text/css" href="./css/jquery.lineProgressbar.css"/>
    <link rel="stylesheet" type="text/css" href="./css/swiper-3.4.2.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/invest_project.css"/>
    <link rel="stylesheet" type="text/css" href="./css/zhifu-password.css"/>

    <link rel="stylesheet" type="text/css" href="./myaccount/css/account_all.css"/>
    <link rel="stylesheet" type="text/css" href="./css/products-intro.css"/>
    <script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
    <style type="text/css">
        .lianjie {
            color: #e44f00;
            text-decoration: underline;
        }

        .project-msg ul li:first-child {
            position: relative;
        }

        .project-msg ul li:first-child .add-interest {
            position: absolute;
            right: -20px;
            top: 35px;
            padding: 0 5px;
            font-size: 12px;
            color: #fff;
            background: #FFA24D;
            border-radius: 10px;
            height: 20px;
            line-height: 20px;
        }
    </style>
</head>
<body>
<!--顶部-->
<iframe src="./head3.html?index=1" class="iframe-head" width="100%" scrolling="no" style="border:0px;"></iframe>
<!--主体-->
<div class="invest-main">
    <div class="center">
        <!--项目情况-->
        <div class="clearfix">
            <!--项目情况左上部分-->
            <div class="invest-project left">
                <h3> ${data.project[0].name}</h3>
                <c:if test="${data.project[0].categoryId==13}">
                    <img src="./img/invest-project_che.png"/>
                </c:if>
                <c:if test="${data.project[0].categoryId==14}">
                    <img src="./img/invest-project_qi.png"/>
                </c:if>
                <c:if test="${data.project[0].categoryId==15}">
                    <img src="./img/invest-project_fang.png"/>
                </c:if>
                <c:if test="${data.project[0].categoryId==17}">
                    <img src="./img/invest-project_wu.png"/>
                </c:if>

                <div class="project-msg left">
                    <ul class="clearfix">
                        <li>
                            <p>预期年化收益率</p>
                            <p class="large"><fmt:formatNumber type="number"
                                                               value="${data.project[0].estimatedAnnualRate*100}"
                                                               pattern="0.00" maxFractionDigits="2"/> %</p>
                            <%--<span class="add-interest">加息0.5%</span>--%>
                        </li>
                        <li>
                            <p>借款额度</p>
                            <p class="large"><fmt:formatNumber type="number"
                                                               value="${data.project[0].totalAmount/10000}"
                                                               pattern="0.00" maxFractionDigits="2"/> 万元</p>
                        </li>
                        <li>
                            <p>借款期限</p>
                            <p class="large">${data.project[0].deadLine}个月</p>
                        </li>
                    </ul>
                    <div class="progress clearfix">
                        <p class="left">项目进度</p>

                        <div totalAmount="${data.project[0].totalAmount}"
                             financingAmount="${data.project[0].financingAmount}" class="progress-bar left"></div>
                    </div>
                    <div class="project-txt clearfix">

                        <p class="time">发标时间：<span time="${data.project[0].createTime}"></span></p>
                        <p class="sum">起投金额：${data.project[0].limitMoney}元</p>
                        <p class="rate">计息方式： 满标放款开始计息</p>
                        <p class="repay">还款方式：${data.project[0].repaymentName}</p>
                    </div>
                </div>
            </div>

            <!--项目投资 右上部分-->
            <div class="invest-operation left">
                <ul>
                    <li class="">
                        <p>我的可用金额:</p>
                        <span><fmt:formatNumber type="number"
                                                value="${ pcuser.caBalance =='' || pcuser.caBalance ==null ? '0.00' : pcuser.caBalance }"
                                                pattern="0.00" maxFractionDigits="2"/>元</span>
                    </li>
                    <li class="">
                        <p>项目可投额度:</p>
                        <span>${data.project[0].financingAmount}元</span>
                    </li>
                    <li class="" style="height: 42px;line-height: 42px;">
                        <input type="number" name="" class="invest-money" deadLine="${data.project[0].deadLine}"
                               estimatedAnnualRate="${data.project[0].estimatedAnnualRate+data.project[0].interestAdd}"
                               min="${data.project[0].limitMoney}"
                               max="${data.project[0].financingAmount<pcuser.caBalance ? data.project[0].financingAmount : pcuser.caBalance}"
                               step="1" placeholder="请输入您要投资的金额" id="amount" value="${data.project[0].limitMoney}"
                               onFocus="if(value==defaultValue){value='';this.style.color='#000'}"
                               onBlur="if(!value){value=defaultValue;this.style.color='#aaa'}" style="color:#aaa"/>
                        <span>元</span>
                    </li>
                    <li class="">
                        <p>预期收益：</p>
                        <span id="yuqishouyi">元</span>
                    </li>
                    <li class="coupon-use">


                        <p class="title">使用优惠券 <input type="checkbox" id="isshiyong"/>


                            <span id="shiyong">
									<!-- 	<c:if test="${empty data.usercard}">无可用优惠券</c:if> -->
                                <!-- <c:if test="${not empty data.usercard}">不使用优惠券</c:if> -->
									</span></p>

                        <c:if test="${not empty data.usercard}">
                            <div class="coupon-box" style="display:none; position: absolute; top: 180px; left: 0px; overflow: hidden;">
                                <div class="coupon-box-t" style="position: absolute; bottom: 0px;">
                                    <input type="radio" name="mold" id="zuigao" value="highest" checked="checked"/>最高面额
                                    <input type="radio" name="mold" id="jijiang" value="lately"/>即将到期
                                    <input type="button" name="" id="" value="取消"
                                               onclick="$(this).parent().parent().hide();$('#isshiyong').click();"/>
                                    <input type="submit" value="确定" onclick="queding();"/>
                                </div>
                                <div class="coupon-box-list" style="margin-top: 0px; padding-bottom: 30px; height: 270px; overflow: scroll; ">

                                    <c:forEach items="${data.usercard}" varStatus="i" var="o">

                                        <c:if test="${i.index==1}">
                                            <p ccc="card" name="${o.name}" type='${o.type==1 ? "抵现券" : "加息券"}'
                                               limitmoney='<fmt:formatNumber value="${o.limitMoney}" pattern="###########0" />' rate="${o.rate}" money="${o.money}"
                                               endTime="<fmt:formatDate value='${o.endTime}' pattern='yyyy-MM-dd'/>">
                                                <input type="radio" name="list" id="" value="" checked="checked"
                                                       dataid="${o.id}"/><span class="coupon-jian" ></span>
                                            </p>
                                        </c:if>

                                        <c:if test="${i.index!=1}">
                                            <p ccc="card" name="${o.name}" type='${o.type==1 ? "抵现券" : "加息券"}'
                                               limitmoney='<fmt:formatNumber value="${o.limitMoney}" pattern="###########0" />'
                                                rate="${o.rate}" money="${o.money}"
                                               endTime="<fmt:formatDate value='${o.endTime}' pattern='yyyy-MM-dd'/>">
                                                <input type="radio" name="list" id="" value="" checked="checked"
                                                       dataid="${o.id}"/>
                                            </p>
                                        </c:if>

                                    </c:forEach>

                                </div>
                            </div>
                        </c:if>
                    </li>
                    <li class="" style="height: 52px;">


                        <c:if test="${data.project[0].status==2}">
                            <a href="javascript:void(0)" onclick="dianjitouzi();" class="invest-btn">立即投资</a>
                        </c:if>
                        <c:if test="${data.project[0].status!=2}">
                            <a href="javascript:;" class="invest-btn">${data.isproject}</a>
                        </c:if>
                    </li>
                    <li class="agree">
                        <input type="checkbox" name="" id="agreeText" value="agree" checked="checked"/>
                        <lable for="agreeText">我已阅读并同意<a href="javascript:void(viewLicense(0));" class="lianjie">《网络借贷风险和禁止性行为提示书》</a>、<a
                                href="javascript:void(viewLicense(1));" class="lianjie">《资金来源合法承诺书》</a></lable>
                    </li>

                    <!--<c:if test="${empty pcuser}">
								<li class="lr">
								<a href="login" class="on">立即登录</a>
								<a href="#">免费注册</a>
								</li>

							</c:if>-->

                </ul>
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


        <script type="text/javascript">
            $(function () {
                $(".coupon-box-list p input").change(function () {
                    $(".coupon-box-list p").find("span").removeClass("coupon-jian");
                    $(":checked").parent().find("span").addClass("coupon-jian");
                });

            });
        </script>


        <!--tab切换页-->
        <div class="project-tab">
            <div class="tab-menu" id="menu">
                <ul class="clearfix">
                    <li class="active">项目信息</li>
                    <li>安全保障</li>
                    <li>投资记录</li>
                </ul>
            </div>

            <div class="tab-main" id="content">

                <!--项目信息部分的内容-->
                <div class="item project-info" id="item1">
                    <div class="info-five">
                        <h3>产品介绍</h3>

                        <c:if test="${data.project[0].categoryId==13}">
                            <div class="lend-process">
                                <div class="zhonglei active-car">
                                    <div class="des">
                                        <p><span>车贷融</span>
                                            车抵押贷款业务为借款人提供相关信用咨询、车辆评估、抵押借款、协议管理、回款管理等多方面的服务，借款人以自有车辆为抵押物获得出借资金，公司安排专业人员对抵押车辆进行GPS安装。在合同期间，借款人仍可正常使用该车辆。质押贷款中，由营普金服为借款人妥善保管车辆。
                                        </p>
                                    </div>

                                    <h4>车抵押借款办理流程</h4>
                                    <div class="process">
                                        <ul class="clearfix">
                                            <li>
                                                <p>审查借款资料，核实产权</p>
                                                <p class="num">1</p>
                                                <p class="tit">资料核实</p>
                                            </li>
                                            <li>
                                                <p>核查车辆情况，评估价值</p>
                                                <p class="num">2</p>
                                                <p class="tit">车辆估值</p>
                                            </li>
                                            <li>
                                                <p>风控人员终审，出具报告</p>
                                                <p class="num">3</p>
                                                <p class="tit">风控审核</p>
                                            </li>
                                            <li>
                                                <p>说明相关协议，签订合同</p>
                                                <p class="num">4</p>
                                                <p class="tit">签订合同</p>
                                            </li>
                                            <li>
                                                <p>移交相关资料，办理质押</p>
                                                <p class="num">5</p>
                                                <p class="tit">手续质押</p>
                                            </li>
                                            <li>
                                                <p>发布借款信息，满标放款</p>
                                                <p class="num">6</p>
                                                <p class="tit">发标融资</p>
                                            </li>
                                            <li>
                                                <p>合同借款结清，解除质押。</p>
                                                <p class="num">7</p>
                                                <p class="tit">还款解押</p>
                                            </li>
                                        </ul>
                                    </div>

                                </div>
                            </div>


                        </c:if>
                        <c:if test="${data.project[0].categoryId==15}">
                            <div class="lend-process">
                                <div class="zhonglei active-house">
                                    <div class="des">
                                        <p><span>房贷融</span>
                                            房产权利人在当前房贷尚未还清时，想要出卖房产、或因房产升值想要申请更大额度贷款，此时房产权利人向营普金服贷款以偿清当前按揭/抵押贷款，赎出《房产证》，此类业务就是赎楼贷款业务。
                                        </p>
                                        <p>红本(《房屋所有权证》)抵押贷款业务</p>
                                        <p>红本抵押贷款是指房产权利人以房产为抵押物，申请贷款，用于各种消费、资金周转和经营性用途的业务。</p>
                                    </div>

                                    <h4>房抵押借款办理流程</h4>
                                    <div class="process">
                                        <ul class="clearfix">
                                            <li>

                                                <p class="num">1</p>
                                                <p class="tit">提出申请</p>
                                            </li>
                                            <li>

                                                <p class="num">2</p>
                                                <p class="tit">确权</p>
                                            </li>
                                            <li>

                                                <p class="num">3</p>
                                                <p class="tit">尽调</p>
                                            </li>
                                            <li>

                                                <p class="num">4</p>
                                                <p class="tit">委托协议</p>
                                            </li>
                                            <li>

                                                <p class="num">5</p>
                                                <p class="tit">司法公证</p>
                                            </li>
                                            <li>

                                                <p class="num">6</p>
                                                <p class="tit">服务协议签订</p>
                                            </li>
                                            <li>

                                                <p class="num">7</p>
                                                <p class="tit">赎楼过户</p>
                                            </li>
                                            <li>

                                                <p class="num">8</p>
                                                <p class="tit">还款</p>
                                            </li>
                                        </ul>
                                    </div>
                                    <h5 style="text-align: center;font-size: 16px;font-weight: normal;">赎楼贷交易流程</h5>
                                    <div class="process-house">
                                        <img style="width: 1180px;" src="img/infomation/process-house.png"/>
                                    </div>
                                </div>


                            </div>
                        </c:if>
                        <c:if test="${data.project[0].categoryId==14}">
                            <div class="lend-process">
                                <div class="zhonglei active-company">
                                    <div class="des">
                                        <p><span>优企融</span>
                                            专门针对小微企业法人或者企业股东，因短期的资金流通需求，通过股东会决议将股权、票据、应收货款等抵质押并办理登记手续，或者以自有房产，车辆等资产作为还款付息的保障，为小微企业解决短期资金周转需求。
                                        </p>
                                    </div>

                                    <h4>小微企业抵押借款办理流程</h4>
                                    <div class="process">
                                        <ul class="clearfix">
                                            <li>
                                                <p style="margin-left: 3px;">借款人提供企业基础资料</p>
                                                <p class="num">1</p>
                                                <p class="tit">借款发起</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -30px;">尽职调查，收集资料，形成调研报告</p>
                                                <p class="num">2</p>
                                                <p class="tit">资料收集</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -30px;">信用调查，核实财证，出具风控报告</p>
                                                <p class="num">3</p>
                                                <p class="tit">风控审核</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -40px;">根据企业征信情况，核定企业授信额度</p>
                                                <p class="num">4</p>
                                                <p class="tit">授信额度</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -10px;">办理股权登记、质押</p>
                                                <p class="num">5</p>
                                                <p class="tit">股权质押</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -10px;">投资人选择项目，进行投资</p>
                                                <p class="num">6</p>
                                                <p class="tit">投资认购</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -65px;">满标审核，通过第三方资金托管，转入借款企业</p>
                                                <p class="num">7</p>
                                                <p class="tit">满标放款</p>
                                            </li>
                                            <li>
                                                <p>借款到期，还本付息</p>
                                                <p class="num">8</p>
                                                <p class="tit">签订合同</p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </c:if>

                        <c:if test="${data.project[0].categoryId==17}">
                            <div class="lend-process">
                                <div class="zhonglei active-company">
                                    <div class="des">
                                        <p><span>物管贷</span>
                                            物管贷产品是为运行正常、营收平稳且有增长空间的物业管理公司提供融资服务。物业公司以自有资产、自有物业为抵押，由总公司或关联公司提供担保。借款用途一般为员工工资发放、软硬件设备升级改造、多种经营拓展资金周转等。借款周期一般在1-12个月；还款来源为周期性物业管理费按比例划拨、经营性商业项目、广告展演管理费、有偿物业服务收入。
                                        </p>
                                    </div>

                                    <h4>物管贷借款操作流程</h4>
                                    <div class="process">
                                        <ul class="clearfix">
                                            <li>
                                                <p style="margin-left: 3px;">物业管理公司提出借款申请</p>
                                                <p class="num">1</p>
                                                <p class="tit">借款发起</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -11px;">平台风控专员初审，准备资料</p>
                                                <p class="num">2</p>
                                                <p class="tit">资料收集</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -30px;">风控经理复审，安排尽调</p>
                                                <p class="num">3</p>
                                                <p class="tit">风控审核</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -6px;">项目通过，签订服务协议</p>
                                                <p class="num">4</p>
                                                <p class="tit">签订协议</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -10px;">办理抵押、担保、受让等手续</p>
                                                <p class="num">5</p>
                                                <p class="tit">质押手续</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: -10px;">项目上线筹集资金</p>
                                                <p class="num">6</p>
                                                <p class="tit">发标融资</p>
                                            </li>
                                            <li>
                                                <p style="margin-left: 3px;">贷后管理</p>
                                                <p class="num">7</p>
                                                <p class="tit">贷后管理</p>
                                            </li>
                                            <li>
                                                <p>项目到期还款</p>
                                                <p class="num">8</p>
                                                <p class="tit">到期还款</p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </c:if>

                    </div>

                    <div class="info-one">
                        <h3>项目介绍</h3>
                        <div class="info">
                            ${data.project[0].descr}


                        </div>

                    </div>
                    <!-- 	<div class="info-two">
								<h3>借款描述</h3>
								<div class="borrow">
									<p>${data.project[0].descr}</p>
								</div>
								
							</div> -->
                    <div class="info-five">
                        <h3>认证项目</h3>


                        <c:if test="${data.project[0].categoryId==13}">
                            <div class="symbol che">
                                <img src="./img/images/che-renzhen_03.png"/>
                            </div>
                        </c:if>
                        <c:if test="${data.project[0].categoryId==14}">
                            <div class="symbol qi">
                                <img src="./img/images/qi-renzhen_03.png"/>
                            </div>
                        </c:if>
                        <c:if test="${data.project[0].categoryId==15}">
                            <div class="symbol fang">
                                <img src="./img/images/fang-renzhen_03.png"/>
                            </div>
                        </c:if>
                        <c:if test="${data.project[0].categoryId==17}">
                            <div class="symbol fang">
                                <img src="./img/images/wu-renzhen_03.png"/>
                            </div>
                        </c:if>


                    </div>

                    <div class="info-three">
                        <h3>项目资料</h3>

                        <ul class="res-item clearfix" id="resItem">
                            <li class="active">项目实景</li>
                            <li>借款人证照</li>
                        </ul>


                        <div class="banner" id="banner">

                            <div class="banner-list">
                                <div class="swiper-container one">

                                    <div class="swiper-wrapper" id="jianjie" data="${data.project[0].images}">


                                    </div>
                                </div>
                                <!-- 如果需要导航按钮 -->
                                <div class="swiper-button-prev sjp"></div>
                                <div class="swiper-button-next sjn"></div>

                            </div>

                            <div class="banner-list" style="display: none;">
                                <div class="swiper-container two">
                                    <div class="swiper-wrapper" id="zhengzhao"
                                         data="${data.project[0].businessLicense}">
                                        <!--<div class="swiper-slide"><img src="../img/sfz.jpg"/></div>
                                        <div class="swiper-slide"><img src="../img/sfz.jpg"/></div>
                                        <div class="swiper-slide"><img src="../img/sfz.jpg"/></div>
                                        <div class="swiper-slide"><img src="../img/sfz.jpg"/></div>
                                           <div class="swiper-slide"><img src="../img/sfz.jpg"/></div>
                                        <div class="swiper-slide"><img src="../img/sfz.jpg"/></div>-->
                                    </div>
                                </div>
                                <!-- 如果需要导航按钮 -->
                                <div class="swiper-button-prev zjp"></div>
                                <div class="swiper-button-next zjn"></div>
                            </div>

                        </div>

                        <div class="carrousel">
                            <div class="wrapper">
                                <!--<span class="close"></span> -->
                                <img src="" alt="BINGOO"/>
                            </div>
                        </div>
                    </div>


                    <div class="info-four">
                        <h3>隐私保护</h3>
                        <div class="protection">
                            <p>根据国家法律法规及行业相关规范要求，营普金服对借款人隐私给予保护，对借款人部分信息进行了符合监管要求的脱敏处理。</p>
                        </div>
                    </div>


                </div>

                <!--安全保障部分的内容-->
                <div class="item project-insur" id="item2" style="display: none;">
                    <ul class="clearfix">
                        <li class="list">
                            <p class="pic"><span></span>项目筛选</p>
                            <p class="des">从个人征信、反欺诈、身份交叉验证、实地尽调、资产评估、还款能力评估等多个维度进行评估审核，风控委员会二次风控、一票否决制，从源头上把控项目质量。</p>
                        </li>

                        <li class="list">
                            <p class="pic"><span></span>足额足值</p>
                            <p class="des">借款人必须提供足额足值的抵（质）押物，并按照风控要求办理抵（质）押手续，而借款项目融资额度的抵押率一般在60%-80%，确保风险完全覆盖。</p>
                        </li>

                        <li class="list">
                            <p class="pic"><span></span>电子合同</p>
                            <p class="des">电子合同是受国家法律保护的债权证明，具有不可修改、合法、真实的特点，对借款人和投资人的权利、义务进行明晰，确保借贷两端的权益均受到保障。</p>
                        </li>

                        <li class="list">
                            <p class="pic"><span></span>交易安全</p>
                            <p class="des">个人账户通过实名认证、同卡进出、银行预留手机号验证等手段保证所有交易均为本人操作。营普金服对用户信息进行了加密传输，有效保障用户隐私信息不会外泄。</p>
                        </li>

                        <li class="list">
                            <p class="pic"><span></span>银行存管</p>
                            <p class="des">营普金服目前已经和重庆富民银行签订资金存管协议，实行自身资金与出借人和借款人资金的隔离管理，合规、安全，更进一步。</p>
                        </li>

                        <li class="list">
                            <p class="pic"><span></span>贷后管理</p>
                            <p class="des">项目放款后，资金用途不得改变，监控还款能力，还款提前电话通知和跟踪，确保成功还款；对有可能逾期或已逾期项目，启动逾期催收机制。</p>
                        </li>
                    </ul>
                </div>

                <!--投资记录部分的内容-->
                <div class="item project-record" id="item3" style="display: none;">
                    <table border="0" cellspacing="20" cellpadding="20">
                        <tr class="title">
                            <th>序号</th>
                            <th>投标人</th>
                            <th>投标金额（元）</th>
                            <th>投标时间</th>
                            <th>优惠券使用情况</th>
                            <th>投标端口</th>
                        </tr>

                        <tbody id="userprojectinfo"></tbody>
                    </table>

                    <!--投资记录翻页-->
                    <div class="record-page">
                        <!--页码-->
                        <div class="page">
                            <div class="page-list" id="pageList">
                                <a onclick="go('home')">首页</a>
                                <a onclick="go('prev')">上一页</a>
                                <span id="page-nav-btn">
										</span>
                                <a onclick="go('next')">下一页</a>
                                <a onclick="go('tail')">尾页</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!--tab切换-->
<script type="text/javascript">
    window.onload = function () {
        var $li = $('#menu li');
        var $item = $('#content .item');

        $li.click(function () {
            var $this = $(this);
            var $t = $this.index();
            $li.removeClass();
            $this.addClass('active');
            $item.css('display', 'none');
            $item.eq($t).css('display', 'block');
        });


        var resL = $('#resItem li');
        var bannearS = $('#banner .banner-list');

        resL.click(function () {
            var $this = $(this);
            var $t = $this.index();
            resL.removeClass();
            $this.addClass('active');
            bannearS.css('display', 'none');
            bannearS.eq($t).css('display', 'block');
            //						bannearS.eq($t).find("swiper-slide n swiper-slide-duplicate").css('width', '100px');

        });
    }
</script>
<!--客服悬浮条-->

<iframe src="xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
<iframe src="jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
<script src="js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
<!--底部导航-->
<iframe src="footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;height:326px;"></iframe>

<!--加载js文件-->
<script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="./js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
<script src="./js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
<script src="./js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="./js/utils.js" type="text/javascript" charset="utf-8"></script>
<script src=".././layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="./js/jquery-validate.js" type="text/javascript"></script>
<script src="./js/zhifu_password.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $("body").keydown(function () {
        /*if (event.keyCode == "13") { //keyCode=13是回车键
            if($('.layui-layer-content').find('form[name="payPassword"]').size()<=0){
                $(".invest-btn").click();
            }else{
                touzi();
            }
        };*/
    });
    $(document).ready(function () {
        //表示项目进度的进度条
        $('.progress-bar').each(function (e) {
            var totalAmount = $(this).attr('totalAmount');
            var financingAmount = $(this).attr('financingAmount');
            var yitouzi = accAdd(totalAmount, -financingAmount);
            $(this).LineProgressbar({
                percentage: accMul(100, accDiv(yitouzi, totalAmount).toFixed(4)),
                fillBackgroundColor: '#f97c39',
                height: '14px',
                radius: '7px'
            });
        });

        $('span[time]').text($('span[time]').attr('time').substring(0, $('span[time]').attr('time').lastIndexOf(':')));
        $('p[ccc="card"]').each(function (e) {
            if ($(this).attr('type') == '抵现券') {
                $(this).append($(this).attr('type') + ' 满' + $(this).attr('limitmoney') +
                    '元抵' + $(this).attr('money') + ' <span class="ticket_date" style="float: none; vertical-align: unset;">' + $(this).attr('endTime') + '</span>到期');
            } else {
                $(this).append(($(this).attr('type')) + ' 满' + $(this).attr('limitmoney') +
                    '元加息' + (accMul($(this).attr('rate'), 100)) + '% <span class="ticket_date" style="float: none; vertical-align: unset;">' + $(this).attr('endTime') + '</span>到期');
            }


        });
        var dot = $('#jianjie').attr('data').split(';');
        for (i = 0; i <= dot.length; i++) {
            if (dot[i] != null && dot[i] != undefined && dot[i] != '') {
                $('#jianjie').append('<div class="swiper-slide"><img src="' + dot[i] + '"/></div>');
            }

        }
        dot = $('#zhengzhao').attr('data').split(';');
        for (i = 0; i <= dot.length; i++) {
            if (dot[i] != null && dot[i] != undefined && dot[i] != '') {
                $('#zhengzhao').append('<div class="swiper-slide"><img src="' + dot[i] + '"/></div>');
            }
        }
        $('#amount').keyup(function (e) {
            if ($('#amount').is(':focus')) {
                jisuan();
            }

        });

        loadList();


        //下面轮播图
        var swiper = new Swiper('.one', {
            //			        pagination: '.swiper-pagination',
            nextButton: '.sjn',
            prevButton: 'sjp',
            slidesPerView: 4,
            paginationClickable: true,
            spaceBetween: 0,
            loop: true,
            autoplay: 3000,
            autoplayDisableOnInteraction: false,
            observer: true,//修改swiper自己或子元素时，自动初始化swiper
            observeParents: true//修改swiper的父元素时，自动初始化swiper
        });

        var swiperT = new Swiper('.two', {
            //			        pagination: '.two .swiper-pagination',
            nextButton: '.zjn',
            prevButton: '.zjp',
            slidesPerView: 3,
            paginationClickable: true,
            spaceBetween: 0,
            loop: true,
            autoplay: 3000,
            autoplayDisableOnInteraction: false,
            observer: true,//修改swiper自己或子元素时，自动初始化swiper
            observeParents: true//修改swiper的父元素时，自动初始化swiper
        });

        //图片放大
        var carrousel = $(".carrousel");

        $('.swiper-wrapper').delegate('img', 'click', function (e) {

            var src = $(this).attr("src");
            var img = new Image();
            img.src = src;

            var realwidth = img.width;
            var realheight = img.height;
            var w, h;

//					 var $div=$('<div />').css({'height':'600','width':'800'});
            carrousel.children('.wrapper').css({
                'width': '854',
                'height': '600px',
                'padding': '20px',
                'background-color': 'white',
                'text-align': 'center'
            });
            if (realwidth > realheight) {
                w = 850;
                h = 600;
                /*	 h=600;
                     w=600/realheight*realwidth;*/

            } else {
//					 	 h=800;
//					 	 w=800/realheight*realwidth;
                /*  w=800;
                 h=800/realwidth*realheight;*/
                h = 600;
                w = 600 / realheight * realwidth;
            }


            carrousel.find("img").attr("src", src).css({'width': w, 'height': h, 'margin': 'auto'});

//					  var src = $(this).attr( "src" );
//					  carrousel.find("img").attr( "src", src );

            //判断图片是竖还是横
//					  if($(window).height()<790){
//					  	console.log("3");
//					  	$(".wrapper img").on("load",function(e){
//					  		if($(".wrapper img",this.contentDocument).height()>560){
//					   			console.log("4");
//					   			$(".wrapper img",this.contentDocument).css({"width":"54%","marginTop":"0"});
//					   		}else{
//					   			$(".wrapper img",this.contentDocument).css({"width":"70%","marginTop":"100px"});
//					   		}
//					  	}); 		
//					  }else{
//					   	$(".wrapper img").css("width","70%");
//					  }
            carrousel.fadeIn(0);
        });

        carrousel.each(function () {
            $(this).click(function (e) {
                carrousel.find("img").attr("src", '');
                carrousel.fadeOut(0);
            });
        });

//				$('.swiper-wrapper').delegate('img','click',function(e){
//						var theImage = new Image();
//						theImage.src = $(this).attr("src");
//					layer.open({'content':'<img src="'+$(this).attr('src')+'"/>',area:[theImage.width+'px', theImage.height+'px']});
//				});

        $('#zuigao').change(function () {
            if ($('#zuigao').is(':checked')) {
                sort(1);
                $('.ticket_date').hide();
            } else {

                $('.ticket_date').hide();
                sort(2);
            }
        });
        $('#jijiang').change(function () {
            if ($('#jijiang').is(':checked')) {
                sort(2);
                $('.ticket_date').show();
            } else {
                $('.ticket_date').hide();
                sort(1);
            }
        });


        $('#isshiyong').change(function () {

            if ('${empty data.usercard}' == 'false') {
                if ($(this).is(':checked')) {
                    $('.coupon-box').show();
                } else {
                    $('.coupon-box').hide();
                    $('#shiyong').text('不使用优惠券');
                }

            } else {
                $('#isshiyong').removeAttr('checked');
                layer.alert('暂无可用优惠券');
            }

        });


        // 对Date的扩展，将 Date 转化为指定格式的String
        // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
        Date.prototype.Format = function (fmt) { //author: meizz
            var o = {
                "M+": this.getMonth() + 1, //月份
                "d+": this.getDate(), //日
                "h+": this.getHours(), //小时
                "m+": this.getMinutes(), //分
                "s+": this.getSeconds(), //秒
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                "S": this.getMilliseconds() //毫秒
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
        $.fn.sortFunc = function (options) {
            //默认值parentEle为空,orderBy为正序
            var defaults = {
                parentEle: '',
                orderBy: 'asc',
                type: 'number',
                attr: 'money'
            };
            //如果调用时设置options，则用新值替换默认值
            var opts = $.extend(defaults, options);
            //正序排序(排序方法主要是通过将id值构造为Date对象进行比较)
            var asc = function (a, b) {

                if (opts.type == 'number') {
                    return $(a).attr(opts.attr) > $(a).attr(opts.attr) ? 1 : -1;
                }
                return new Date($(a).attr(opts.attr)) > new Date($(b).attr(opts.attr)) ? 1 : -1;
            };
            //倒序排序
            var desc = function (a, b) {
                if (opts.type == 'number') {
                    return $(a).attr(opts.attr) > $(a).attr(opts.attr) ? -1 : 1;
                }
                return new Date($(a).attr(opts.attr)) > new Date($(b).attr(opts.attr)) ? -1 : 1;
            };
            //如果parentEle值不为空或body,则先将其清空后重新最佳排序后内容
            if (opts && opts.parentEle != 'body' && opts.parentEle != '') {
                $(opts.parentEle).empty().append($(this).sort(
                    (opts.orderBy == "asc") ? asc : desc
                ));
            } else {
                //未设置parentEle时,避免元素显示错位，先为其包裹一个父元素
                //在完成排序及追加内容后，再移除父元素
                $(this).wrapAll("<div class='dundan'></div>");
                var sortEle = $(this).sort((opts.orderBy == "asc") ? asc : desc);
                $(".dundan").empty().append(sortEle).children().unwrap();
            }

        };


        $('.coupon-box-list').find('p').sortFunc({
            orderBy: "asc",
            type: "number",
            attr: "money"
        });

        $('.ticket_date').hide();

    })

    function dianjitouzi() {
        if ('${empty pcuser}' == 'true') {
            location.href = 'login';
            return false;
        }
        if (!$('#agreeText').is(':checked')) {
            layer.alert('请阅读并同意协议');
            return false;
        }

        if (parseFloat('${pcuser.caBalance}') < $('#amount').val()) {
            layer.alert('您账户余额不足');
            return false;
        }
        if ($('#amount').val() % 100 != 0) {
            layer.alert('投资金额必须为100的倍数');
            return false;
        }
        if ('${pcuser.tradPassword}' == null || '${pcuser.tradPassword}' == undefined || '${pcuser.tradPassword}' == '') {
            layer.alert('您还没有设置支付密码', function () {

                location.href = '/yingpu/pc/myaccount/payment_password.jsp';

            });
            return false;
        }
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


    function viewLicense(idx) {
        var idxs = [17, 18];
        layer.open({
            type: 2,
            content: '<%=basePath%>pc/myaccount/announce/content?id=' + idxs[idx] + '&type=contractsample',
            area: ['50%', '80%']
        });
    }


    function jisuan() {
        var estimatedAnnualRate = $('#amount').attr('estimatedAnnualRate');
        var deadLine = $('#amount').attr('deadLine');
        var amount = $('#amount').val();
        $('#yuqishouyi').text(accDiv(accMul(accMul(amount, estimatedAnnualRate), deadLine), 12).toFixed(2));

    }


    function sort(type) {

        if (type == 1) {
            $('.coupon-box-list').find('p').sortFunc({
                orderBy: "asc",
                type: "number",
                attr: "money"
            });
        } else {
            $('.coupon-box-list').find('p').sortFunc({
                orderBy: "asc",
                type: "data",
                attr: "endtime"
            });
        }

    }

    //加载投资列表
    function loadList() {

        $.post('../pc/userproject/list/json', {
            pageIndex: pageIndex,
            projectId: '${data.project[0].id}',
            pageSize: 10
        }, function (data) {
            var dat = data;

            pageIndex = dat.page.pageIndex;
            pageCount = data.page.pageCount;
            pageSize = data.page.pageSize;
            data = data.data;
            var html = '';

            if (data == undefined) {
                html = '<h3 style="align:center;">暂无投资记录</h3>';
            }


            var len = data.length;

            $.each(data, function (i, o) {
                html += '<tr>';
                html += '<td>' + ((i + 1) + ((dat.page.pageIndex - 1) * 10)) + '</td>';
                html += '<td>' + o.phone.substring(0, 3) + '****' + o.phone.substring(7, 11) + '</td>';
                html += '<td>' + o.money + '</td>';
//							html+='<td>'+new Date(o.createTime).Format('yyyy-MM-dd hh:mm:ss')+'</td>';
                html += '<td>' + new Date(o.createTime).Format('yyyy-MM-dd') + '</td>';
                if (o.cardType == null) {
                    html += '<td class="yuan5"><span>无</span></td>';
                } else if (o.cardType == 1) {
                    html += '<td class="yuan5"><span>' + o.cardPrice + '元抵现券</span></td>';
                } else if (o.cardType == 2) {
                    html += '<td class="yuan5"><span>' + (accMul(o.cardRate, 100)) + '%加息券</span></td>';
                }


                html += '<td>' + (o.investmentport == undefined ? 'APP' : o.investmentport) + '</td></tr>';
            });
            $('#userprojectinfo').empty();
            $('#userprojectinfo').append(html);

            generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');


        });
    }

    function touzi() {
        if ('${empty pcuser}' == 'true') {
            location.href = 'login';
        }

        if ($('#payPassword_rsainput').val().length != 6) {
            layer.alert('请输入6位支付密码');
            return false;
        }
        var cardid = '';
        if ($('#shiyong').attr('dataid') != undefined && $('#shiyong').attr('dataid') != '') {
            cardid = $('#shiyong').attr('dataid');
        }
        layer.load(2);
        $.post('../pc/userproject/touzi', {
            projectId: '${data.project[0].id}',
            money: $('#amount').val(),
            payType: '1',
            cardId: cardid,
            "investmentport": "PC",
            tradPassword: $('#payPassword_rsainput').val()
        }, function (data) {
            layer.closeAll();
            if (data.status == 'success') {
                layer.alert(data.message, function () {
                    location.reload();
                });
            } else {
                if (data.message == '您的支付密码已被锁定') {
                    var ind = layer.open({
                        'title': '错误提示', 'content': '您的支付密码已被锁定,请重置支付密码', 'btn': ['忘记密码'], 'yes': function () {

                            location.href = '/yingpu/pc/myaccount/payment_password.jsp';
                        }
                    });
                } else {
                    var ind = layer.open({
                        'title': '错误提示', 'content': data.message, 'btn': ['重新输入', '忘记密码'], 'yes': function () {
                            layer.close(ind);
                            closezhifu();
                            dianjitouzi();
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


    function queding() {
        $('input[name="list"]:checked').each(function (e) {
            if ($(this).is(':checked')) {
                if ($(this).parent().attr('type') == '抵现券') {
                    $('#shiyong').text($(this).parent().attr('type') + ' 满' + $(this).parent().attr('limitmoney') +
                        '元抵' + $(this).parent().attr('money'));
                    $('#shiyong').attr('dataid', $(this).attr('dataid'));
                } else {
                    $('#shiyong').text($(this).parent().attr('type') + (accMul($(this).parent().attr('rate'), 100)) + '%' + '满' + $(this).parent().attr('limitmoney') +
                        '元使用');
                    $('#shiyong').attr('dataid', $(this).attr('dataid'));
                }
            }
        });

        $('.coupon-box').hide();
    }

    $('.invest-money').keyup(function() {
        var value = $(this).val();
       $('.coupon-box-list>p').show().each(function(i, e) {
           if ($(e).attr('limitmoney') * 1 < value) {
               $(e).hide();
           }
       });
    });
</script>


</body>
</html>
