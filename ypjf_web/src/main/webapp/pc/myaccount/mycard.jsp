<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   


<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="css/account_common.css"/>
		<link rel="stylesheet" type="text/css" href="css/mycard.css"/>
		

		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" name="head" width="100%" height="110" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">
					<!--<div class="account-nav-name">
						<div class="account-pic">
							<img src="../img/account/account-pic.png"/>
						</div>
						<p class="name">赵丹红</p>
					</div>-->
					<iframe src="account_sidebar.html" width="100%" height="850" scrolling="no"  style="border:0px;"></iframe>
				</div>
				<!--右边主体部分-->
				
				<!--邀请奖励-->
				<div class="mycard left">
					<h3>我的银行卡</h3>
					
					<!--有银行卡的状态-->
					<div class="mycard-manage" style="display: none;">
						<p>银行卡已添加 <span>1</span> 张，最多能添加1张</p>
						<div class="mycard-box">
							<div class="mycard-tit clearfix">
								<p class="left" id="bank-name">****</p>
								<p class="right" id="">储蓄卡</p>
							</div>
							<div class="mycard-msg">
								<p>添加时间：<span id="add-time">2015-06-19</span></p>
								<p>当前状态：<span>添加成功</span></p>
								<p>尾号：<span id="card-last-num">3418</span></p>
								<p><a href="javascript:void(changeBankCard())">更换银行卡</a></p>
							</div>
						</div>
						
						<p class="tip">温馨提示：提现支持储蓄卡，且不需要开通网银</p>
					</div>
					
					<!--没有银行卡的状态-->
					<div class="mycard-manage none" onclick="$('#bindBank').show()">
						<p>银行卡已添加 <span>0</span> 张，最多能添加1张</p>
						<div class="mycard-box">
							<p>+</p>
							<p>添加银行卡</p>
						</div>
						
						<p class="tip">温馨提示：提现支持储蓄卡，且不需要开通网银</p>
					</div>
					
				</div>
			</div>
		</div>
		
		
		<!--绑定银行卡-->
		<!--绑定银行卡-->
		<iframe src="bind_bankcard.jsp" id="bindBank" width="100%" style="position: absolute;top: 0;left: 0;display: none;z-index: 10;" scrolling="no"></iframe>
		
		<!--客服悬浮条-->
		<!--客服悬浮条-->
		<!-- <iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
			 -->
		<!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/Ecalendar.jquery.min.js" type="text/javascript"></script>
	<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		
		function fmtDate(obj){
		    var date =  new Date(obj);
		    var y = 1900+date.getYear();
		    var m = "0"+(date.getMonth()+1);
		    var d = "0"+date.getDate();
		    return y+"-"+m.substring(m.length-2,m.length)+"-"+d.substring(d.length-2,d.length);
		}
		
		function changeBankCard() {
			window.open('changeBankCard');
		}
		
		function showView(profile) {
			if (profile.bankNum) {
				$('.mycard-manage:eq(1)').hide();
				$('.mycard-manage:eq(0)').show();

				$('#bank-name').html(profile.bankName);
				$('#add-time').html(fmtDate(profile.cardTime));
			//	console.log(profile.bankNum)
				$('#card-last-num').html(profile.bankNum && profile.bankNum.substr(-4));
			}
		}
		
		
		function loadProfile() {
            useLoadingShade();
			loadUserProfile().done(function(data) {
			    cancelLoadingShade();
				showView(data);
			});
		}
		
		
		$(function(){
			$("#bindBank").height($(document).height());
			
			if (gIsProfileLoaded) {
				showView(gUserProfile);
			}
			else{
				loadProfile();
			}
		});
		
		
	</script>
	
	</body>
</html>
