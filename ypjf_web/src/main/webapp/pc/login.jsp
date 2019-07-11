<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.net.URLDecoder"
    pageEncoding="UTF-8"%>
    
<%
String backUrl = request.getParameter("backUrl");
if (backUrl != null) {
	try {
		backUrl = URLDecoder.decode(backUrl, "utf-8");
	}
	catch(Exception e) {
		//e.printStackTrace();
	}
} else {
    /*if ((backUrl = request.getHeader("Referer")) != null) {
        if (!backUrl.contains("logout") && !backUrl.contains("login")
                && !backUrl.contains("head.html") && !backUrl.contains("head1.html")) {
            backUrl = URLDecoder.decode(request.getHeader("Referer"), "utf-8");
        }
	}*/
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>营普金服—参股商业银行的互联网金融服务平台</title>
<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
<meta http-equiv="X-UA-Compatible"content="IE=Edge" >
<link rel="shortcut icon" href="img/logo1.icon"/>
<link rel="stylesheet" type="text/css" href="css/reset.css"/>
<link rel="stylesheet" type="text/css" href="css/common.css"/>
<link rel="stylesheet" type="text/css" href="css/login.css"/>
</head>
<body>
	<div class="top">
		<div class="center">
			<div class="logo left" onclick="javascript:location.href='index';">
				<img src="/yingpu/pc/my-invest/img/logofu.png" style="cursor: pointer;"/>
			</div>
			<p class="wel left">欢迎来到九趣贷！请登录</p>
		</div>
	</div>
	<div class="login">
		<div class="center">
			<div class="login-box">
				<ul class="menu clearfix">
					<li class="menu-l left">登录九趣贷</li>
					<li class="menu-r on right" onclick="javascript:location.href='register';">注册领红包</li>
				</ul>
				<form action="" method="post" id="loginform">
					<div class="username">
						<input type="text" name="username" id="" placeholder="手机号码" autocomplete="on"/>
						<span class="user-icon"></span>
					</div>
					<div class="passward">
						<input type="password" name="password" id="" placeholder="密码" />
						<span class="passward-icon"></span>
						<!-- <span class="passward-eye"></span> -->
					</div>
					<div class="verification-code">
						<input type="text" id="vcode" placeholder="验证码" value="验证码" onfocus="this.value=''" onblur="if(this.value=='')this.value='验证码'"/>
						<span id="code" class="verification-pic" title="看不清，换一张" onclick="realodImg();"><img src="/yingpu/getCaptcha" id="yanzhengma" onclick="realodImg();"/></span>
					</div>
					<div class="account-control">
						<input type="checkbox" name="Remember me" id="jzzh" value="" checked="checked"/>
						<label for="Remember me">记住账号</label>
						<a href="findpassword">忘记密码？</a>
					</div>
					<input type="button" onclick="login();" value="登录" class="login-btn"/>
				</form>
			</div>
		</div>
	</div>
	<div class="bottom">
		<div class="footer-bottom">			
			<div class="footer-bottom-pic">
				<a><img src="img/footer-cxwz.png"/></a>
				<a><img src="img/footer-kxwz.png"/></a>
				<a><img src="img/footer-hyyz.png"/></a>
				<a><img src="img/footer-qyxy.png"/></a>
				<a><img src="img/footer-360.png"/></a>
				<!--<a href="#"><img src="img/footer-wljc.png"/></a>-->
			</div>
			<div class="footer-bottom-txt">
				<p>Copyright  2019 9qudai.com All Rights Reserved | 九趣贷（www.9qudai.com）运营主体为九九金融信息服务有限公司</p>
				<p>沪ICP备15044282号-1   | 地址：西安市雁塔区沣惠南路18号唐沣国际B座1402室</p>
				<!--<p>© 2016-2017上海营夏财富投资管理有限公司 All rights reserved | 沪ICP备15044282号-1</p>-->
				<p>市场有风险，投资需谨慎</p>
			</div>
		</div>
	</div>
</body>
<script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">


	$(function(){
				$('input[name="username"]').val(localStorage.username);

	});
	//刷新验证码
			function realodImg(){
				$('#yanzhengma').attr('src','/yingpu/getCaptcha?data='+new Date().getTime());
			}


			function login(){
				if($('input[name="username"]').val()==null||$('input[name="username"]').val()==''){
					layer.alert('请填写用户名');
					return false;
				}
				if($('input[name="password"]').val()==null||$('input[name="password"]').val()==''){
					layer.alert('请填写密码');
					return false;
				}

				$.post('../pc/login/json',{phone:$('input[name="username"]').val(),password:$('input[name="password"]').val(),code:$('#vcode').val(),signCode:'aaa'},function(data){
					if(data.status=='ok'){
						if($('#jzzh').is(':checked')==true){
							localStorage.username=$('input[name="username"]').val();
						}
						sessionStorage.user=JSON.stringify(data.data);
					//	layer.alert("登录成功");
						location.href= !!'<%=backUrl == null ? "" : backUrl%>' ? '<%=backUrl%>' : '../pc/myaccount/account';
					}else{
						layer.alert(data.message);	
						realodImg();
						$('input[name="password"]').val('');
						$('input[name="username"]').focus();
					}
					
				});
			
			}
			
		$(document).ready(function(){
			$("body").keydown(function(e){
			var curKey = e.which;
			if(curKey == 13){
				$(".login-btn").click();
				console.log('1');
				}
			});
		});	
//		$("body").keydown(function () {
//			if (event.keyCode == "13") {//keyCode=13是回车键
//				$(".login-btn").click();
//				console.log('1');
//			}
//		});
 </script>


</html>