<%@ page language="java" import="java.util.*, java.util.regex.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="../css/account.css"/>
		<link rel="stylesheet" type="text/css" href="css/security_settings.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" class="iframe-head" width="100%" height="110px" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">
					
					<iframe src="account_sidebar.html" width="100%" height="850px" scrolling="no"  style="border:0px;"></iframe>
					
				</div>
				<!--右边主体部分-->
				
				<div class="security_set left">
					<h3>安全设置</h3>
					<ul>
					<!-- 	<li class="list clearfix">
							<p class="tit">存管账户</p>
							<p class="des">重庆富民银行资金存管，保障您的资金安全</p>
							<p class="fun"><a href="#">开通</a></p>
						</li> -->
					<!-- 	<li class="list clearfix">
							<p class="tit">存管账户</p>
							<p class="des">重庆富民银行资金存管，保障您的资金安全</p>
							<p class="fun"><a href="#">开通</a></p>
						</li> -->
						
						
						<li class="list clearfix">
							<p class="tit">托管账户</p>
							<p class="des">富友支付，第三方托管，保障资金安全 </p>
							<p class="fun"><c:if test="${ empty pcuser.idCard}">
								<p class="fun"><a href="javascript:$('#bindBank').show()">未开通</a></p>
							</c:if>
							<c:if test="${ not empty pcuser.idCard}">
								<p class="fun"><a href="javascript:void(0);">已开通</a></p>
							</c:if></p>
						</li>
						
						<!-- <li class="list clearfix">
							<p class="tit">存管账户</p>
							<p class="des">内蒙古陕坝银行资金存管，资金隔离，安全合规 </p>
							<p class="fun"><a>开发中</a></p>
						</li> -->
						<li class="list clearfix">
							<p class="tit">实名认证</p>
							<p class="des">保障账户安全，只有完成实名认证才能投资</p>

							<c:if test="${ empty pcuser.idCard}">
								<p class="fun"><a href="javascript:$('#bindBank').show()">未认证</a></p>
							</c:if>
							<c:if test="${ not empty pcuser.idCard}">
								<p class="fun"><a href="javascript:void();">已认证</a></p>
							</c:if>
							
						</li>
						<li class="list clearfix">
							<p class="tit">登录密码</p>
							<p class="des">登陆九趣贷时需要输入的密码</p>
							<p class="fun"><a href="../findpassword?type=change">修改</a></p>
						</li>
						<li class="list clearfix">
							<p class="tit">交易密码</p>
							<p class="des">保障资金安全，请定期更换交易密码，建议您交易密码区别于登录密码</p>
							<p class="fun">
								<c:choose>
									<c:when test="${not empty pcuser.trading}">
										<a href="javascript:void(changeTradePassword())">修改密码</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:void(changeTradePassword())">立即设置</a>
									</c:otherwise>
								</c:choose>
							</p>
						</li>
						
						<!--支付密码-->
						<li class="list clearfix">
							<p class="tit">支付密码</p>
							<p class="des">输入支付密码是您确定投资的最后一步，请妥善保管。</p>
							<p class="fun">
								<c:choose>
									<c:when test="${not empty pcuser.trading}">
										<a href="javascript:void(changeTradePassword())">修改密码</a>
									</c:when>
									<c:otherwise>
										<a href="payment_password.jsp">立即设置</a>
									</c:otherwise>
								</c:choose>
							</p>
						</li>
						<li class="list clearfix">
							<p class="tit">手机号码</p>
							<p class="des">${fn:substring(pcuser.phone, 0, 3)}****${fn:substring(pcuser.phone, 7, 11)}</p>
							<!-- <p class="fun"><a href="#">查看</a></p> -->
						</li>
						<li class="list clearfix">
							<p class="tit">电子邮箱</p>
							<p class="des">获取账户资金变动通知和投资讯息，轻松梳理理财信息</p>
							<p class="fun"><a href="#">待开放</a></p>
						</li>
						<li class="list clearfix">
							<p class="tit">银行卡</p>
							<p class="des">提现时资金转入的银行卡账户</p>



							<c:if test="${ empty pcuser.idCard}">
								<p class="fun"><a href="javascript:$('#bindBank').show()">未绑定</a></p>
							</c:if>
							<c:if test="${ not empty pcuser.idCard}">
								<p class="fun"><a href="javascript:void(changeBankCard())">修改银行卡</a></p>
							</c:if>
							
						</li>
						<%--<li class="list clearfix">--%>
							<%--<p class="tit">风险承受能力</p>--%>
							<%--<p class="des">智能投顾，参与风险承受能力评估，获得最佳投资体验</p>--%>
							<%--<p class="fun"><a href="security_risk_assessment.html">立即评估</a></p>--%>
						<%--</li>--%>
						</li>
						
					</ul>
					
					
					
				</div>	
			</div>	
		</div>
		
		<!--客服悬浮条-->
		<!--客服悬浮条-->
		<!-- <iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		 --><!--底部导航-->

	<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>

	<iframe src="bind_bankcard.jsp" id="bindBank" width="100%" style="position: absolute;top: 0;left: 0;display: none;height:100%;z-index: 10;border: 0;" scrolling="no"></iframe>
		<!--加载js文件-->
	<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$(function(){
			$("#bindBank").height($(document).height());
		});
		
		function changeTradePassword() {
			window.open('changeTradePassword');
		}
		
		function changeBankCard() {
			window.open('changeBankCard');
		}

	</script>	
	</body>
</html>
