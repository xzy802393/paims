<%@ page import="java.net.URLEncoder" %>
<%@page language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String url = basePath + request.getServletPath() + "?" + request.getQueryString();
    String encodeUrl = URLEncoder.encode(url, "UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8" />
   <title>九趣贷 — 贷快乐，更带梦想</title>
   <link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
   
    <link rel="stylesheet" type="text/css" href="my-invest/css/commonfu.css"/>
    <link rel="stylesheet" type="text/css" href="my-invest/css/my-invest.css"/>
    <link rel="stylesheet" type="text/css" href="my-invest/css/swiper-3.4.2.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/zhifu-password.css"/>
	
</head>
<body>
<!-- 导航 -->
<iframe src="head3.html" class="iframe-headfu" width="100%" scrolling="no"  style="border:0px;display: block;z-index:1000"></iframe>
<div id="content">
    <div class="nav-bar">
        <p>您当前所在的位置：<a href="/"> 九趣贷 </a> &gt; <a href="/yingpu/pc/project/list">我要出借</a> &gt; <a class="now">${data.project[0].name}</a></p>
    </div>
    <div class="content1 clearFix">
        <div class="left">
            <div class="box">
				<p class="title">
					<span class="name" style="display: block;">${data.project[0].name}</span>
					<span class="xiangmu-bianhao" style="display: block; color: #aaa;font-size: 12px;padding-top: 4px;">借款编号：${data.project[0].code}</span>
				</p>
                <ul class="xiangmu">
                    <li class="line1">
								<span class="nianhua">
									<p class="num1"><em class="shuzi"><fmt:formatNumber type="number" value="${data.project[0].estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></em>%</p>
									<p class="text">预期年化收益率</p>
								</span>
                        <span class="qixian">
									<p class="num"><em class="shuzi">${data.project[0].deadLine}</em>个月</p>
									<p class="text">借款期限</p>
								</span>
                        <span class="edu">
									<p class="num"><em class="shuzi"><fmt:formatNumber type="number" value="${data.project[0].totalAmount/10000}" pattern="0.00" maxFractionDigits="2"/></em>万元</p>
									<p class="text">借款额度</p>
								</span>
                    </li>
                    <li class="line6 clearFix">
                        <div class="sleft">
                            <p  class="progress"><span class="jindu" totalAmount="${data.project[0].totalAmount}" financingAmount="${data.project[0].financingAmount}"><span class="tuli"></span></span></p>
                            <p class="miaoshu">出借进度:<fmt:formatNumber type="number" value="${(data.project[0].totalAmount-data.project[0].financingAmount)/data.project[0].totalAmount *100}" pattern="0.00" maxFractionDigits="2"/>%</p >
                        </div>
                        <div class="sright">
                            <p>
                                <span class="zuo">募集时间：</span>
                                <span class="you" id="time"></span>
                            </p >
                            <p>
                                <span class="zuo">起息时间：</span>
                                <span class="you">满标后次日</span>
                            </p >
                            <p>
                                <span class="zuo">最低出借：</span>
                                <span class="you">500元</span>
                            </p >
                        </div>
                    </li>
                    <li class="line3">
                        <div class="a1">
                            <p>
                                <span class="zuo">项目类型：</span>
                                <span class="you">优企贷</span>
                            </p>
                            <p>
                                <span class="zuo">安全级别：</span>
                                <span class="xing">
                                            <c:set var="securityLevel" value='${(data.project[0].securityLevel == null ? "1" : data.project[0].securityLevel).replaceAll(\"[^\\\\d]*(\\\\d+(?:\\\\.\\\\d+)?)[^\\\\d]*\", \"$1\") * 1}'></c:set>
                                            <c:forEach end="${securityLevel}" begin="1" step="1" var="num">
                                                <img src="my-invest/img/xing-shi.png">
                                            </c:forEach>
                                            <c:if test="${securityLevel % 1 != 0}">
                                                <img src="my-invest/img/xing-kong.png">
                                            </c:if>
										</span>
                            </p>
                        </div>
                        <div class="a2">
                            <p>
                                <span class="zuo">还款方式：</span>
                                <span class="you">${data.project[0].repaymentName}</span>
                            </p>
                            <p>
                                <span class="zuo">出借人条件：</span>
                                <span class="you">${data.project[0].borrowerCondition}</span>
                            </p>
                        </div>
                        <div class="a3">
                            <p>
                                <span class="zuo">计息方式：</span>
                                <span class="you">满标后次日</span>
                            </p>
                            <p>
                                <span class="zuo">借款用户：</span>
                                <span class="you">JQDCJR****${fn:substring(data.borrower[0].legalPersonPhone, 9, 11)}</span>
                            </p>
                        </div>
                        <div class="a4">
                            <p>
                                <span class="zuo">回款时间：</span>
                                <span class="you">
                                    ${(data.project[0].repaymentTime == null ? "待定" : data.project[0].repaymentTime).toString().replace(".0", "")}
                                </span>
                            </p>
                            <p>
                                <span class="zuo">温馨提示：</span>
                                <span class="you">市场有风险，出借需谨慎</span>
                            </p>
                        </div>
                    </li>
                </ul>

            </div>
        </div>
        <div class="right">
            <div class="box">
                <p class="p1"><span class="keyong clearFix" id="money">
                            可用余额：
                            <c:choose>
                                <c:when test="${empty pcuser}">
                                    <a href="/yingpu/pc/login" class="login">登录</a>后可见</span>
                    </c:when>
                    <c:otherwise>
					<span>${pcuser.caBalance}</span>
                    <a href="/yingpu/pc/myaccount/deposit" class="chongzhi"><img src="my-invest/img/chongzhiBtn.png"></a></p>
                </c:otherwise>
                </c:choose>
				<p class="p3 clearFix"><span class="wenzi">当前剩余可出借金额：<span id="currentMoney">${data.project[0].financingAmount}</span></span></p>
				<p class="newMoney" style="display: none; color: red;font-size: 14px;"></p>
				<p class="p2"><span class="wenzi clearFix">出借金额：</span><span type="text" class="money"><span class="jian">-</span><span class="num"><input type="text" id="invest-money-input" value="${data.project[0].limitMoney}" onkeyup="inputMoneyjudge()"></span>元<span class="jia">+</span></span></p>
                <p class="p3 clearFix"><span class="wenzi">预期收益：</span><span class="money"><span class="num" id="yuqishouyi">10</span>元</span></p>
                <div class="p4">
                    <span class="wenzi">优惠券：</span>
                    <span class="value">
                                <c:choose>
                                    <c:when test="${empty pcuser}">
                                        无可用优惠券
                                    </c:when>
                                    <c:otherwise>
                                        不使用优惠券
                                    </c:otherwise>
                                </c:choose>
                            </span>
                    <div class="youhuiquan" style="display: none;">
                        <ul class="list">
                            <c:forEach items="${data.usercard}" varStatus="i" var="o">
								<c:if test="${o.type==1}">
									<li ccc="card" name="${o.name}" type="抵现劵" limitmoney='<fmt:formatNumber value="${o.limitMoney}" pattern="#######0"/>' rate="${o.rate}" money="${o.money}"
										endTime="<fmt:formatDate value='${o.endTime}' pattern='yyyy-MM-dd'/>">
										<input type="radio" name="coupon" value="${o.id}"><p class="quan">抵现劵 满${o.limitMoney}元，抵${o.money}</p>元&nbsp;<p class="coupon-expire" style="display:none;">${o.endTime.toString().replace("-", "").split(" ")[0]}到期</p></li>
									</li>
								</c:if>
								<c:if test="${o.type==2}">
									<li ccc="card" name="${o.name}" type="加息劵" limitmoney='<fmt:formatNumber value="${o.limitMoney}" pattern="#######0"/>' rate="${o.rate}" money="${o.money}"
										endTime="<fmt:formatDate value='${o.endTime}' pattern='yyyy-MM-dd'/>">
										<input type="radio" name="coupon" value="${o.id}"><p class="quan">加息劵 满${o.limitMoney}元,加息<span><fmt:formatNumber type="number" value="${o.rate*100}" pattern="0.00"/></span>%</p>&nbsp;<p class="coupon-expire" style="display:none;">${o.endTime.toString().replace("-", "").split(" ")[0]}到期</p></li>
									</li>
								</c:if>
								<c:if test="${o.type==3}">
									<li ccc="card" name="${o.name}" type="抵扣率劵" limitmoney='<fmt:formatNumber value="${o.limitMoney}" pattern="#######0"/>' rate="${o.rate}" money="${o.money}"
										endTime="<fmt:formatDate value='${o.endTime}' pattern='yyyy-MM-dd'/>">
										<input type="radio" name="coupon" value="${o.id}"><p class="quan">抵扣率劵 满${o.limitMoney}元,抵扣<span><fmt:formatNumber type="number" value="${o.dikouRate*100}" pattern="0.00"/></span>%</p>&nbsp;<p class="coupon-expire" style="display:none;">${o.endTime.toString().replace("-", "").split(" ")[0]}到期</p></li>
									</li>
								</c:if>
                                <%--<c:if test="${i.index==1}">--%>
                                    <%--<li ccc="card" name="${o.name}" type='${o.type==1 ? "抵现券" : "加息券"}' limitmoney='<fmt:formatNumber value="${o.limitMoney}" pattern="###########0" />' rate="${o.rate}" money="${o.money}"--%>
                                        <%--endTime="<fmt:formatDate value='${o.endTime}' pattern='yyyy-MM-dd'/>">--%>
                                        <%--<input type="radio" name="coupon" value="${o.id}"><p class="quan">${o.type==1 ? "抵现券" : "加息券"} 满${o.limitMoney}元抵${o.money} </p>&nbsp;<p class="coupon-expire" style="display: none;">${o.endTime.toString().replace("-", "").split(" ")[0]}到期</p></li>--%>
                                <%--</c:if>--%>
                            </c:forEach>
                        </ul>
                        <div class="btn">
                            <span class="high">最高面额</span>
                            <span class="daoqi">即将到期</span>
                        </div>
                    </div>

                </div>
                <p class="p5"><a href="javascript:void(0)" class="chujie" status="${data.project[0].status}">
                    <c:choose>
                        <c:when test="${data.project[0].status == 3}">
                            <c:set var="statusText" value="还款中" />
                        </c:when>
                        <c:when test="${data.project[0].status == 4}">
                            <c:set var="statusText" value="已结束" />
                        </c:when>
                        <c:when test="${data.project[0].status == 5}">
                            <c:set var="statusText" value="已满标"></c:set>
                        </c:when>
                    </c:choose>

                    <c:choose>
                        <c:when test="${data.project[0].status == 2}">
                            <img src="my-invest/img/btn-chujie.png" alt="">
                        </c:when>
                        <c:otherwise>
                            <button style="width: 100%; height: 100%; display: inline-block; border-radius: 5px; background: #ccc; color: #fafafa; line-height: 37px; border: none;" value="${statusText}">${statusText}</button>
                        </c:otherwise>
                    </c:choose>
                </a></p>
                <p class="p6 clearFix">
                    <input type="checkbox" name="" id="agreeText" value="agree" checked="checked">
                    <lable for="agreeText">已阅读并同意<a href="javascript:void(viewLicense(0));">《网络借贷风险和禁止性行为提示书》</a>、<a href="javascript:void(viewLicense(1));">《资金来源合法承诺书》</a>、<a href="javascript:void(viewLicense(2))">《九趣贷借贷服务协议》</a></lable>
                </p>
            </div>
        </div>
    </div>
    <div class="content2">
        <ul class="nav clearFix">
            <li class="active">借款人信息</li>
            <li>项目介绍</li>
            <li>平台优势</li>
            <li>出借记录</li>
        </ul>
        <ul class="tab">
            <li class="tab1">
                <div class="person-message">
                    <p class="title">借款人信息</p>
                    <ul class="neirong">
                        <li class="clearFix">
							<p class="p1"><span class="span1">姓名：</span><span class="span2">${fn:substring(data.borrowUser[0].name,0 ,1)}**</span></p>
                            <p class="p1"><span class="span1">性别：</span><span class="span2">${data.borrowUser[0].sex}</span></p>
                            <p class="p1"><span class="span1">年龄：</span><span class="span2">${data.borrowUser[0].age}</span></p>
                            <p class="p1"><span class="span1">学历：</span><span class="span2">${data.borrowUser[0].education}</span></p>
                            <p class="p1"><span class="span1">婚姻状况：</span><span class="span2">${data.borrowUser[0].marital}</span></p>
                        </li>
                        <li class="clearFix">
							<p class="p1"><span class="span1">证件号码：</span><span class="span2">${fn:substring(data.borrowUser[0].idNumber,0 ,3 )}*************${fn:substring(data.borrowUser[0].idNumber,16 ,18 )}</span></p>
                            <p class="p1"><span class="span1">户籍：</span><span class="span2">${data.borrowUser[0].address}</span></p>
                            <p class="p1"><span class="span1">主体性质：</span><span class="span2">${data.borrowUser[0].theMainProperties}</span></p>
                            <p class="p1"><span class="span1">所属行业：</span><span class="span2">${data.borrowUser[0].industryInvolved}</span></p>
                            <p class="p1"><span class="span1">工作性质：</span><span class="span2">${data.borrowUser[0].jobNature}</span></p>
                        </li>
                        <li class="clearFix">
                            <p class="p1"><span class="span1">月收入：</span><span class="span2">${data.borrowUser[0].monthlyIncome}元</span></p>
                            <p class="p1"><span class="span1">负债情况：</span><span class="span2">${data.borrowUser[0].debtSituation}</span></p>
                            <p class="p1"><span class="span1">借款用途：</span><span class="span2">${data.borrowUser[0].purposeOfLoan}</span></p>
                            <p class="p1"><span class="span1">征信报告：</span><span class="span2">${data.borrowUser[0].creditReport}</span></p>
                            <p class="p1"><span class="span1">征信情况：</span><span class="span2">${data.borrowUser[0].creditConditions}</span></p>
                        </li>
                        <li class="clearFix">
							<p class="p1"><span class="span1">联系方式：</span><span class="span2">${fn:substring(data.borrowUser[0].contactWay,0,3 )}******${fn:substring(data.borrowUser[0].contactWay,9,11 )}</span></p>
							<p class="p1"><span class="span1">还款来源：</span><span class="span2">${data.borrowUser[0].repayingSource}</span></p>
                            <p class="p1"><span class="span1">是否购房：</span><span class="span2">${data.borrowUser[0].whetherToBuy}</span></p>
                            <p class="p1"><span class="span1">是否购车：</span><span class="span2">${data.borrowUser[0].whetherTheCar}</span></p>
                            <p class="p1"><span class="span1">是否生育：</span><span class="span2">${data.borrowUser[0].whetherFertility}</span></p>
                        </li>
                        <li class="clearFix">
                            <p class="p1"><span class="span1">是否有社保：</span><span class="span2">${data.borrowUser[0].socialSecurity}</span></p>
                            <p class="p1"><span class="span1">其他借款信息：</span><span class="span2">${data.borrowUser[0].otherLoanInformation}</span></p>
                            <p class="p1"><span class="span1">是否续贷：</span><span class="span2">${data.borrowUser[0].refinance}</span></p>
                            <p class="p1"><span class="span1">居住地点：</span><span class="span2">${data.borrowUser[0].residentialAddress}</span></p>
                        </li>
                    </ul>
                    <div class="renzheng">
                        <img src="my-invest/img/renzhenglogo.png" >
                    </div>
                </div>
						<div class="wupin-message">
							<p class="title">企业信息</p>
							<ul class="neirong">
								<li class="clearFix">
									<p class="p1"><span class="span1">企业名称：</span><span class="span2">${data.borrowUser[0].enterpriseName}</span></p>
									<p class="p1"><span class="span1">证件号码：</span><span class="span2">${data.borrowUser[0].certificateNumber}</span></p>
									<p class="p1"><span class="span1">所属行业：</span><span class="span2">${data.borrowUser[0].enterpriseIndustryInvolved}</span></p>
									<p class="p1"><span class="span1">注册资本：</span><span class="span2">${data.borrowUser[0].registeredCapital}</span></p>
									<p class="p1"><span class="span1">注册地址：</span><span class="span2">${data.borrowUser[0].registeredAddress}</span></p>
								</li>
								<li class="clearFix">
									<p class="p1"><span class="span1">成立时间：</span><span class="span2">${data.borrowUser[0].establishmentDate}</span></p>
									<p class="p1"><span class="span1">经营收入：</span><span class="span2">${data.borrowUser[0].operationRevenue}</span></p>
									<p class="p1"><span class="span1">企业征信：</span><span class="span2">${data.borrowUser[0].enterpriseCreditInvestigation}</span></p>
								</li>
							</ul>
							<div class="renzheng">
								<img src="my-invest/img/renzhenglogo.png" >
							</div>
						</div>
						<div class="danbao">
							<p class="title">担保措施：${data.borrowUser[0].guaranteeMeasure}</p>
						</div>
						<div class="fengkongcuoshi">
							<p class="title">风控措施：</p>
							<ul class="neirong">
                                <li><pre>${data.borrowUser[0].riskControlMeasures}</pre></li>
                                <%--<li>1.借款企业尽职调查：该企业经营状况良好，资金流较好，相关证明文件真实齐全。</li>
                                <li>2.收账款账户监管：通过应收账款监管专户，对应收账款的归集及回收进行监管，保证本息足额、按时偿还。</li>
                                <li>3.该借款企业办公、生产场所进行了实地考查，对企业实际控制人进行了深入的了解，并进行严格的贷后跟踪审查。</li>
                                <li>4.个人提供无限连带责任担保。</li>--%>
							</ul>
						</div>
						<div class="moneysafe">
							<p class="title">资金安全措施：</p>
							<ul class="list clearFix">
								<li>
									<div class="top"><img src="my-invest/img/img1.png" alt=""></div>
									<p class="text">真实的项目背景</p>
								</li>
								<li>
									<div class="top"><img src="my-invest/img/img2.png" alt=""></div>
									<p class="text">严苛的项目筛选</p>
								</li>
								<li>
									<div class="top"><img src="my-invest/img/img3.png" alt=""></div>
									<p class="text">专业的贷后管理</p>
								</li>
								<li>
									<div class="top"><img src="my-invest/img/img4.png" alt=""></div>
									<p class="text">大数据风控体系保障</p>
								</li>
							</ul>
						</div>
						<div class="safe safe1">
							<p class="title">安全审核：</p>
							<ul class="list clearFix" >
								<li>
									<div class="zuo"><img src="my-invest/img/imgb1.png" alt=""></div>
									<div class="you">
										<p class="p1">二代身份证</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li>
									<div class="zuo"><img src="my-invest/img/imgb15.png" alt=""></div>
									<div class="you">
										<p class="p1">营业执照</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li>
									<div class="zuo"><img src="my-invest/img/imgb16.png" alt=""></div>
									<div class="you">
										<p class="p1">开户许可证</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li>
									<div class="zuo"><img src="my-invest/img/imgb17.png" alt=""></div>
									<div class="you">
										<p class="p1">机构信用代码证</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li>
									<div class="zuo"><img src="my-invest/img/a1.png" alt=""></div>
									<div class="you">
										<p class="p1">担保人验证</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li>
									<div class="zuo"><img src="my-invest/img/c8.png" alt=""></div>
									<div class="you">
										<p class="p1">资产负债表</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li>
									<div class="zuo"><img src="my-invest/img/c9.png" alt=""></div>
									<div class="you">
										<p class="p1">年度财务报表</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li>
									<div class="zuo"><img src="my-invest/img/c10.png" alt=""></div>
									<div class="you">
										<p class="p1">股东会决议</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li>
									<div class="zuo"><img src="my-invest/img/c11.png" alt=""></div>
									<div class="you">
										<p class="p1">企业征信</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li class="jingyingdiheshi">
									<div class="zuo"><img src="my-invest/img/c12.png" alt=""></div>
									<div class="you">
										<p class="p1">经营地核实</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li class="shujufengkong">
									<div class="zuo"><img src="my-invest/img/imgb13.png" alt=""></div>
									<div class="you">
										<p class="p1">大数据风控验证</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li>
									<div class="zuo"><img src="my-invest/img/imgb7.png" alt=""></div>
									<div class="you">
										<p class="p1">借款合同</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								
								<li >
									<div class="zuo"><img src="my-invest/img/imgb9.png" alt=""></div>
									<div class="you">
										<p class="p1">借款协议</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
								<li class="qita">
									<div class="zuo"><img src="my-invest/img/imgb14.png" alt=""></div>
									<div class="you">
										<p class="p1">其他借款信息</p>
										<p class="p2">通过审核</p>
									</div>
								</li>
							</ul>
						</div>
						<div class="huankuanlaiyuan">
							<p class="title">还款来源:</p>
							<ul class="neirong">
								<li class="clearFix">
                                    <pre><p class="p1"><span class="span1">${data.borrowUser[0].repaymentSourceDetails}</span></p></pre>
									<%--<p class="p1"><span class="span1">第一还款来源：</span><span class="span2">借款企业经营的回款及盈利。</span></p>
									<p class="p1"><span class="span1">第二还款来源：</span><span class="span2">借款企业公司固定资产及应收账款。</span></p>
									<p class="p1"><span class="span1">第三还款来源：</span><span class="span2">个人提供无限连带责任担保。</span></p>--%>
								</li>
							</ul>
						</div>
						<div class="zhengxin1">
							<p class="title">征信报告情况：</p>
							<ul class="neirong">

								<li>
                                    <p class="p1"><span class="span1">当前违约账户数：</span><span class="span2">${data.borrowUser[0].breakContractAccountNumber == null ? 0 : data.borrowUser[0].breakContractAccountNumber}个</span></p>
                                    <p class="p1"><span class="span1">当前违约金额：：</span><span class="span2">${data.borrowUser[0].breakContractAmount == null ? 0 : data.borrowUser[0].breakContractAmount}元</span></p>
                                    <p class="p1"><span class="span1">当前不良账户数：</span><span class="span2">${data.borrowUser[0].badnessAccountNumber == null ? 0 : data.borrowUser[0].badnessAccountNumber}个</span></p>
                                    <p class="p1"><span class="span1">当前不良金额：</span><span class="span2">${data.borrowUser[0].badnessAmount == null ? 0 : data.borrowUser[0].badnessAmount}元</span></p>
                                    <p class="p1"><span class="span1">账户状态说明：</span><span class="span2">${data.borrowUser[0].statusDescription}</span></p>
                                       <%-- <pre>${data.borrowUser[0].creditReportSituation}</pre>--%>
                                </li>
								<%--<li>2. 查询借款企业征信报告无不良记录</li>--%>
							</ul>
						</div>
						
						<div class="jiekuanren-shuoming">
							<p class="miaoshu">借款人说明：</p>
							<p class="titlefu">${data.borrowUser[0].introduction}</p>
						</div>
						<div class="jiekuan-history">
							<p class="title">借款记录：</p>
							<p class="titlefu">历史还清期数，待还款，历史逾期次数指该借款人所有借款的对应信息，不单指本标的借款信息</p>
							<ul class="neirong">
                                <li class="clearFix">
                                    <p class="p1"><span class="span1">借贷笔数：</span><span class="span2">${data.borrowUser[0].loanTimes}</span></p>
                                    <p class="p1"><span class="span1">历史还清期数：</span><span class="span2">${data.borrowUser[0].payOffPeriods}</span></p>
                                    <p class="p1"><span class="span1">待还款：</span><span class="span2">${data.borrowUser[0].toBeRepayPeriods}</span></p>
                                    <p class="p1"><span class="span1">历史逾期笔数：</span><span class="span2"></span>${data.borrowUser[0].overdueTimes}</p>
                                    <p class="p1"><span class="span1">逾期总金额：</span><span class="span2">${data.borrowUser[0].overdueAmount}</span></p>
                                </li>
							</ul>
						</div>
						<div class="jiekuan-qingkuang">
							<p class="title">借款人情况跟踪:</p>
							<ul class="neirong">
                                <li class="clearFix">
                                    <p class="p1"><span class="span1">借款人资金运用情况：</span><span class="span2">${data.borrowUser[0].fundUsedCondition}</span></p>
                                    <p class="p1"><span class="span1">借款人经营状况及财务状况：</span><span class="span2">${data.borrowUser[0].managementAndTreasureCondition}</span></p>
                                    <p class="p1"><span class="span1">借款人还款能力变化情况：</span><span class="span2">${data.borrowUser[0].repaymentAbilityChangeCondition}</span></p>
                                    <p class="p1"><span class="span1">借款人涉诉情况：</span><span class="span2">${data.borrowUser[0].accusedCondition}</span></p>
                                    <p class="p1"><span class="span1">借款人受行政处罚情况：</span><span class="span2">${data.borrowUser[0].criminalPunishmentCondition}</span></p>
                                </li>
							</ul>
						</div>
						<div class="fengxian-tishi">
							<p class="title">风险提示</p>
							<dl class="neirong">
								<dt>1.信用风险</dt>
								<dd>网络借贷信息中介机构（下称机构）不提供增信服务，不承担借贷违约风险。如借款人因经营不善、资金周转不灵或主观故意而出现无法或未能正常还款的情况，出借人需自行承担借贷风险，接受本息损失。</dd>
								<dt>2.延期风险</dt>
								<dd>借款人于借款到期日因自身原因无法按时足额还款，九趣贷将根据出借人的授权采用适当方式代表出借人向借款人进行追索（包括但不限于仲裁和诉讼），无论采取何种方式，在此过程中出借人均有可能延期收到出借本金和利息。</dd>
								<dt>3.交易失败的风险</dt>
								<dd>本次交易的促成需符合相关法律法规的规定和借款合同的约定，可能存在不能满足成立条件从而导致交易失败的风险。</dd>
								<dt>4.操作风险</dt>
								<dd>不可预测或无法控制的系统故障、设备故障、通讯故障、停电等突发事故将有可能给借出人造成一定损失。由于通信故障、系统故障以及其他不可抗力等因素的影响，可能导致借出人无法及时作出合理决策，造成借出人损失。</dd>
								<dt>5.经营风险</dt>
								<dd>机构承诺将按照相关法律法规的规定进行运营及管理，但可能存在因法律法规调整而无法保证符合相关法律和监管部门的要求的现象。如机构无法继续经营网络借贷信息中介业务或发生重大业务调整，或财产状况发生重大变化，则可能对出借人产生不利影响</dd>
								<dt>6.其他风险</dt>
								<dd>自然灾害、战争等无法避免或无法控制的因素的出现，将影响市场的正常运行，从而导致还款资金损失，甚至影响该借款的成立、运行、偿付等的正常进行；</dd>
							</dl>
							<p class="end">特别提示：前述风险提示不能穷尽全部风险及市场的全部情形。</p>
						</div>
					</li>
					<li class="tab2">
						<div class="box1fu">
							<p class="title">项目介绍</p>
							<p class="miaoshu">优企贷是一项专门针对小微企业法人或者企业股东，因企业发展或资金流通需求，通过股东会决议将股权、票据、应收货款等抵质押并办理登记手续，作为还款付息的保障，为小微企业解决资金周转需求。</p>
							<div class="liucheng">
								<img src="my-invest/img/youqidai.png" >
							</div>
						</div>
						
					</li>
					<li class="tab3">
						<p class="title">资金安全保障：</p>
						<ul class="detail">
							<li class="clearFix">
								<div class="left"><img src="my-invest/img/img2.png" ></div>
								<div class="right">
									<p class="p1">项目筛选</p>
									<p class="p2">从个人征信、反欺诈、身份交叉验证、实地尽调、资产评估、还款能力评估等多个维度进行评估审核，风控委员会二次风控、一票否决制，从源头上把控项目质量。</p>
								</div>
							</li>
							<li class="clearFix">
								<div class="left"><img src="my-invest/img/c2.png" ></div>
								<div class="right">
									<p class="p1">足额足值</p>
									<p class="p2">借款人必须提供足额足值的抵（质）押物，并按照风控要求办理抵（质）押手续，而借款项目融资额度的抵押率一般在60%-80%，确保风险完全覆盖。</p>
								</div>
							</li>
							<li class="clearFix">
								<div class="left"><img src="my-invest/img/c3.png" ></div>
								<div class="right">
									<p class="p1">电子合同</p>
									<p class="p2">电子合同是受国家法律保护的债权证明，具有不可修改、合法、真实的特点，对借款人和投资人的权利、义务进行明晰，确保借贷两端的权益均受到保障。</p>
								</div>
							</li>
							<li class="clearFix">
								<div class="left"><img src="my-invest/img/c4.png" ></div>
								<div class="right">
									<p class="p1">交易安全</p>
									<p class="p2">个人账户通过实名认证、同卡进出、银行预留手机号验证等手段保证所有交易均为本人操作。九趣贷对用户信息进行了加密传输，有效保障用户隐私信息不会外泄。</p>
								</div>
							</li>
							<li class="clearFix">
								<div class="left"><img src="my-invest/img/c5.png" ></div>
								<div class="right">
									<p class="p1">贷后管理</p>
									<p class="p2">项目放款后，资金用途不得改变，监控还款能力，还款提前电话通知和跟踪，确保成功还款；对有可能逾期或已逾期项目，启动逾期催收机制。</p>
								</div>
							</li>
							<li class="clearFix">
								<div class="left"><img src="my-invest/img/c6.png" ></div>
								<div class="right">
									<p class="p1">研发交易体系</p>
									<p class="p2">项目放款后，资金用途不得改变，监控还款能力，还款提前电话通知和跟踪，确保成功还款；对有可能逾期或已逾期项目，启动逾期催收机制。</p>
								</div>
							</li>
							<li class="clearFix">
								<div class="left"><img src="my-invest/img/c7.png" ></div>
								<div class="right">
									<p class="p1">技术团队</p>
									<p class="p2">技术团队来自第三方支付、知名大型科技公司，为账户信息、交易资金提供全方位技术支持。</p>
								</div>
							</li>
						</ul>
					</li>
					<li class="tab4">
						<div class="table">
							<table border="0" cellspacing="20" cellpadding="20">
								<tr class="title">
									<th>序号</th>
									<th>出借人</th>
									<th>出借金额</th>
									<th>优惠券</th>
									<th>出借方式</th>
									<th>加入时间</th>
								</tr>
								<tbody id="userprojectinfo"></tbody>
							</table>
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
					</li>
				</ul>
				<div class="line"><span class="left"></span>九趣贷您身边的理财顾问<span class="right"></span></div>
			</div>
		</div>

    <!--支付密码的弹框-->

    <div class="zhifu-password" style="display: none; text-align: left;">
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
		<!--底部-->
		<iframe src="./footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;display: block;"></iframe>

<!--悬浮条-->
<iframe src="xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
<iframe src="yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
<iframe src="jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>

<script src="my-invest/js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
<script src="my-invest/js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="js/utils.js" type="text/javascript" charset="utf-8"></script>
<script src="my-invest/js/my-invest.js" type="text/javascript" charset="utf-8"></script>
<script src="js/zhifu_password.js" type="text/javascript" charset="utf-8"></script>
<script src="../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="./newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
<script>
    $('body').data('estimatedAnnualRate', '${data.project[0].estimatedAnnualRate}');
    $('body').data('deadLine', '${data.project[0].deadLine}');
    $('body').data('limitMoney', '${data.project[0].limitMoney}');
    $('body').data('financingAmount', '${data.project[0].financingAmount}');
    $('body').data('isLogin', '${empty pcuser}');
    $('body').data('projectId', '${data.project[0].id}');
    $('body').data('caBalance', '${pcuser.caBalance}');
    $('body').data('tradPassword', '${pcuser.tradPassword}');
    $('body').data('isNew','${data.project[0].isNew}');
    $('body').data('starttime','${data.project[0].startTime}');
    $('body').data('status','${data.project[0].status}');
    function viewLicense(idx) {
        var idxs = [17, 18,20];
        layer.open({
            type: 2,
            content: '<%=basePath%>pc/myaccount/announce/content?id=' + idxs[idx] + '&type=contractsample',
            area: ['50%', '80%']
        });
    }

    loadList();
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
                html = '<span style="display: block; font-size: 22px; margin-top: 220px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
                $('#userprojectinfo').empty();
                $('.table').append(html);
                $('.record-page').css('display','none');
            }else{
                var len = data.length;

                $.each(data, function (i, o) {
                    html += '<tr>';
                    html += '<td>' + ((i + 1) + ((dat.page.pageIndex - 1) * 10)) + '</td>';
                    html += '<td>' + 'JQDCJR****'+o.userCode.substring(9, 12) + '</td>';
                    html += '<td>' + commafy(returnFloat(o.money)) + '</td>';
//							html+='<td>'+new Date(o.createTime).Format('yyyy-MM-dd hh:mm:ss')+'</td>';

                    if (o.cardType == null) {
                        html += '<td class="yuan5"><span>无</span></td>';
                    } else if (o.cardType == 1) {
                        html += '<td class="yuan5"><span>' + o.cardPrice + '元抵现券</span></td>';
                    } else if (o.cardType == 2) {
                        html += '<td class="yuan5"><span>' + (accMul(o.cardRate, 100)) + '%加息券</span></td>';
                    }else if(o.cardType ==3){
                        html += '<td class="yuan5"><span>' + (accMul(o.dikouRate, 100)) + '%抵扣率券</span></td>';
					}
                    html+='<td>手动出借</td>';
                    // if (o.investmentport == undefined){
                    //     html+='<td><img src="my-invest/img/telphone.png" class="tel"></td>';
                    // }else{
                    //     html+='<td><img src="my-invest/img/pc.png"  class="pc"></td>';
                    // }

                    // html += '<td>' + (o.investmentport == undefined ? 'APP' : o.investmentport) + '</td>';

                    html += '<td>' + new Date(o.createTime).Format('yyyy-MM-dd') + '</td></tr>';
                });
                $('#userprojectinfo').empty();
                $('#userprojectinfo').append(html);
                $('.record-page').css('display','none');
                generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
			}
        });
    }
    var yongmoney =commafy(returnFloat(${pcuser.caBalance}));
    $("#money span").text(yongmoney);
    $(".a2 .num").text(commafy(returnFloat($(".a2 .num").text())));


</script>
</body>
</html>
