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
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/><link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="../css/account.css"/>
		<link rel="stylesheet" type="text/css" href="css/security_settings.css"/>
		<link rel="stylesheet" type="text/css" href="css/payment-password.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">
					
					<iframe src="account_sidebar.html" width="100%" height="850" scrolling="no"  style="border:0px;"></iframe>
					
				</div>
				<!--右边主体部分-->
				
				<div class="security_set left">
					<h3>支付密码</h3>
						<div class="payment-password">
							<div class="set-step clearfix" id="setStep">
								<div class="step active">
									<span class="step1">1</span>
									<p>身份验证</p>
								</div>
								<i class="line"></i>
								<div class="step">
									<span class="step2">2</span>
									<p>设置支付密码</p>
								</div>
								<i class="line"></i>
								<div class="step">
									<span class="step3">3</span>
									<p>设置成功</p>
								</div>
							</div>
							<div class="step-content" id="content">
								<div class="step-list sfyz clearfix" >
									<form action="" method="post">
										<div class="msg">
											<span class="tit">手机号码：</span>
											<input type="text" name="phone" id="tel"/>
										</div>
									
										<div class="vert clearfix">
											<div class="msg left">
												<span class="tit">图片验证码：</span>							
												<input type="text" class="img-code" name="pic_code" id="imgCode"/>	
											</div>
											<div class="vcode pic left">
												<img src="../img/account/images/txyzm-eg_03.png" onclick="loadPicCode();" id="pic-code"/>
											</div>
											<div class="change left">
												<a href="javascript:void(loadPicCode())">换一张</a>
											</div>
										</div>
									
										<div class="vert clearfix">
											<div class="msg left">
												<span class="tit">短信验证码：</span>							
												<input type="text" class="msg-code" name="code"  id="smscode" />	
											</div>
											<div class="vcode left">
												<input type="button" id="send" onclick="sendCode()" value="发送验证码">
											</div>						 
										</div>
										<input type="button" class="next-step" id="nextStep" value="下一步"/>
									</form>
								</div>
								<div class="step-list szzfmm clearfix" style="display: none;">
									<form action="" method="post">
										<div class="msg">
											<span class="tit">设置密码：</span>
											<input type="password" name="password"  maxlength="6" onKeyUp="if(this.value.length>6){this.value=this.value.substr(0,6)};this.value=this.value.replace(/[^\d]/g,'');" placeholder="仅限六位数字" />
										</div>
										<div class="msg">
											<span class="tit">确认密码：</span>
											<input type="password" name="confirm_password" maxlength="6" onKeyUp="if(this.value.length>4){this.value=this.value.substr(0,6)};this.value=this.value.replace(/[^\d]/g,'');" placeholder="仅限六位数字" />
										</div>
										<input type="button" class="next-step" id="complete" style="margin-top: 50px;" value="完成设置"/>
									</form>
								</div>
								<div class="step-list szcg clearfix" style="display: none;">
									<p><span class="ok"></span> 支付密码设置成功！</p>
									<a href="../project/list">立即投资</a>
								</div>
							</div>
						</div>
					
					
					
				</div>	
			</div>	
		</div>
		
		<!--客服悬浮条-->
		<!--客服悬浮条-->
		<%--<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>--%>
		<%--<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>--%>
		<%--<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>--%>
		<!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
	

			<!--加载js文件-->

		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
		
			$(function(){
				$("#nextStep").on('click',function(){
					if(checksmscode(this)){
					
					}
				});
				$("#complete").on('click',function(){
					if($('#password').val()==null&&$('#password').val()==''){
							layer.msg('请输入密码！');
							$('#password').focus();
							return false;
						}
					if($('#confirm_password').val()==null&&$('#confirm_passwordconfirm_password').val()==''){
						layer.msg('请输入确认密码！');
						$('#confirm_password').focus();
						return false;
					}
					if($('input[name="confirm_password"]').val()!=$('input[name="password"]').val()){
						layer.msg('两次输入的密码不一致');
						return false;
					}
					 var ind=	layer.load(2);
					$.get('/yingpu/pc/setuppassword', {phone:$('#tel').val(),password:$('input[name="confirm_password"]').val(),code:$('#smscode').val()}, function(data) {
						layer.close(ind);
						if (data.status=='success') {
							$('#complete').parents(".szzfmm").hide();
								$("#content .szcg").show();
								$("#setStep").find(".step").eq(2).addClass("active");
								$("#setStep").find(".line").eq(1).addClass("over");
								
						}else{
							layer.msg(data.message);
						}
					
					}, 'json');

					
					
				});
				
				loadPicCode();
			});
			
			
			function loadPicCode() {
				console.log('aaaaaaaaaaaa');
		    var ind=	layer.load(2);
			$.get('/yingpu/app/loan/getCaptcha/json', {}, function(data) {
				layer.close(ind);
				if (data.data) {
					$('#pic-code').attr('src', 'data:image/jpeg;base64,' + data.data);
					
				}
			
			}, 'json');
		}
		
		function countdown() {
			var send=document.getElementById('send'),
			timer=null;
		   	var times=60,
		   	   	timer = setInterval(function(){
	    		send.value = times+"秒后重试";
				send.setAttribute('disabled','disabled');
				times--;
				if(times <= 0){
					send.value = "发送验证码";
					send.removeAttribute('disabled');
					times = 60;
					clearInterval(timer);
				}
		    }, 1000);
		}
		function sendCode(){
			if($('#tel').val()==null&&$('#tel').val()==''){
				layer.msg('请输入手机号！');
				$('#tel').focus();
				return false;
			}
			if($('#imgCode').val()==null&&$('#imgCode').val()==''){
				layer.msg('请输入图形验证码！');
				$('#imgCode').focus();
				return false;
			}
			  var ind=	layer.load(2);
			$.get('/yingpu/pc/sendphone/json', {phone:$('#tel').val(),code:$('#imgCode').val(),type:6}, function(data) {
				layer.close(ind);
				if (data.status=='success') {
						layer.msg('短信已发送至您的手机，请注意查收！');
						countdown();
				}else{
					layer.msg(data.message);
				}
			
			}, 'json');
		}

		function checksmscode(a){
			  var ind=	layer.load(2);
			$.get('/yingpu/pc/checkSMSCodePhone', {phone:$('#tel').val(),code:$('#smscode').val()}, function(data) {
				layer.close(ind);
				if (data.status=='success') {
					$(a).parents(".sfyz").hide();
					$("#content .szzfmm").show();
					$("#setStep").find(".step").eq(1).addClass("active");
					$("#setStep").find(".line").eq(0).addClass("over");
						return true;
					
				}else{
					layer.msg('短信验证码不正确');
					return false;
				}
			
			}, 'json');
		}
//		function changeTradePassword() {
//			window.open('changeTradePassword');
//		}
//		
//		function changeBankCard() {
//			window.open('changeBankCard');
//		}

	</script>	
	</body>
</html>
