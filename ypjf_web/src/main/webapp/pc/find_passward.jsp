<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${param.type == 'change' ? '修改密码' : '找回密码'}</title>
<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
<link rel="stylesheet" type="text/css" href="css/reset.css"/>
<link rel="stylesheet" type="text/css" href="css/common.css"/>
<link rel="stylesheet" type="text/css" href="css/login.css"/>
</head>
<body>
	<div class="top">
		<div class="center">
			<div class="logo left">
				<a href="/">
					<img src="img/logo.png"/>
				</a>					
			</div>
			<!-- <p class="wel left">免费注册营普金服账号，已有账号请  <a href="login.jsp">登录</a></p> -->
		</div>
	</div>
	<div class="find-passward-contain">
		<div class="center">
			<div class="find-passward-box">
				<div class="find-passward-t">
					<h4>${param.type == 'change' ? '修改密码' : '找回密码'}</h4>
					${param.type == 'change' ? '' : '<p><span></span> 温馨提示：请输入手机号，找回密码！</p>'}
				</div>
				<div class="find-passward-form">
					<form action="" method="post" id="findPassward" onsubmit="return false;">
						<input type="hidden" name="id" value="${pcuser.id}" />
						<div class="msg">
							<span class="tit">手机号码</span>
							
							<input type="type" name="phone" 
							<c:if test="${not empty pcuser.phone}">
								value="${pcuser.phone}" readOnly="readOnly"
							</c:if>
							 id="tel" placeholder="请输入您的手机号码" />
							
						</div>
						<div class="msg">
							<span class="tit">设置新密码</span>
							<input type="password" name="password" id="tel" placeholder="请输入6-16位字母和数字" />
						</div>
						<div class="msg">
							<span class="tit">确认新密码</span>
							<input type="password" name="oldpassword" id="tel" placeholder="请输入6-16位字母和数字" />
						</div>
						<div class="vert">
							<div class="msg left">
								<span class="tit">图片验证码</span>							
								<input type="text" name="pic_code"  placeholder="请输入图片验证码" />	
							</div>
							<div class="vcode left">
								<img src="" id="pic-code" onclick="loadPicCode()" />
							</div>						 
						</div>
					
						<div class="vert clearfix">
							<div class="msg left">
								<span class="tit">短信验证码</span>							
								<input type="text" name="code"  placeholder="请输入短信验证码" />	
							</div>
							<div class="vcode left">
								<input type="button" id="send" value="发送验证码">
							</div>						 
						</div>
						<input type="submit" value="确认修改" class="sure-btn"/>
						<p class="go-index"><a href="/">返回首页</a></p>
					</form>
				</div>
			</div>
			
		</div>
	</div>
	<div class="bottom">
		<div class="footer-bottom">			
			<div class="footer-bottom-pic">
				<a href="#"><img src="img/footer-cxwz.png"/></a>
				<a href="#"><img src="img/footer-kxwz.png"/></a>
				<a href="#"><img src="img/footer-hyyz.png"/></a>
				<a href="#"><img src="img/footer-qyxy.png"/></a>
				<a href="#"><img src="img/footer-360.png"/></a>
				<!--<a href="#"><img src="img/footer-wljc.png"/></a>-->
			</div>
			<div class="footer-bottom-txt">
				<p>Copyright  2019 9qudai.com All Rights Reserved | 九趣贷（www.9qudai.com）运营主体为九九金融信息服务有限公司</p>
				<p>jiuqudai@163.com   | 地址：西安市雁塔区沣惠南路18号唐沣国际B座1402室</p>
				<!--<p>© 2016-2017上海营夏财富投资管理有限公司 All rights reserved | 沪ICP备15044282号-1</p>-->
				<p>市场有风险，投资需谨慎</p>
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		map = {
				code : {
					action : 'SMS',
					passed : false
				},
				pic_code : {
					action : 'Pic',
					passed : false
				}
			};
		
	
		$(function(){
			$("#findPassward .msg input").focus(function(){
				$("#findPassward .msg").removeClass("focus");
				$(this).parent().addClass("focus");
			});
		});
		window.onload=function(){
		    var send=document.getElementById('send'),
		        times=60,
		        timer=null;
		    send.onclick=function(){
		        // 计时开始 
		      
		      	if (!sendCode()) {
		      		return;
		      	}
		    };
		};
		
		
		function countdown() {
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
		
		
		function sendCode() {
			if (!/\d{11}/.test($('input[name=phone]').val())) {
				layer.alert('手机号码必须为11位数字！');
				return;
			}
			
			if (!$('[name=pic_code]').val()) {
				layer.alert('请输入图片验证码！');
				return;
			}
			
			if (!map['pic_code']['passed']) {
				layer.alert('您输入的图片验证码不正确！');
				return;
			}
			
			$.post('<%=basePath%>pc/send/json', {
				phone : $('input[name=phone]').val(),
				type : 4,
				code : $('[name=pic_code]').val()
			}, function(data) {
				if (data.status != 'success') {
					layer.alert(data.message);
					if (data.status == 'shixiao') {
						loadPicCode();
					}
					return;
				}

				countdown();
				layer.msg('短信已发送至您的手机');
			}, 'json');
			
			return true;
		}
		
		
		function loadPicCode() {
			$.get('<%=basePath%>app/loan/getCaptcha/json', {}, function(data) {
				if (data.data) {
					$('#pic-code').attr('src', 'data:image/jpeg;base64,' + data.data);
					map['pic_code']['passed'] = false;
				}
			}, 'json');
		}
		
		
		$(document).on('keyup', '[name=code], [name=pic_code]', function() {
			$this = $(this);
			$.post('check' + map[$(this).attr('name')]['action'] + 'Code', {
				code : $(this).val(),
				phone : $('[name=phone]').val()
			}, function(data) {
				if (data.status == 'success') {
					map[$this.attr('name')]['passed'] = true;
				}
			}, 'json');
		});
		
		
		$(document).on('submit', 'form', function(e) {
			var mustFields = [
				'phone', 'password', 'oldpassword', 'pic_code', 'code'
			];
			
			var emptyField = '';
			$(mustFields).each(function(k, v) {
				if (!$('input[name=' + v + ']').val()) {
					emptyField = $('input[name=' + v + ']').prev().html();
					return false;
				}
			});
			
			if (!!emptyField) {
				layer.alert('请输入' + emptyField + '！');
				return;
			}
			
			if (!/\d{11}/.test($('input[name=phone]').val())) {
				layer.alert('手机号码必须为11位数字！');
				return;
			}
			
			if ($('input[name=password]').val() != $('input[name=oldpassword]').val()) {
				layer.alert('两次密码不一致！');
				return;
			}
			
			if ($('input[name=password]').val().length < 6 || $('input[name=password]').val().length > 20) {
				layer.alert('密码长度必须为6-20位！');
				return;
			}
			
			findPassword();
			return false;
		});
		
		
		function findPassword() {
			var valid = true;
			for (var k in map) {
				valid = valid && map[k]['passed'];
				if (!map[k]['passed']) {
					var codeType = k == 'code' ? '短信' : '图片';
					layer.alert(codeType + '验证码输入有误！');
					return;
				}
			}
			
			if (valid) {
				$('.sure-btn').attr('disabled', 'disabled');
				var regLayer = layer.load(1, { shade : [ 0.4, '#fff' ] });
				$.post('doFindPassword', $("form").serialize(), function(data) {
					$('.sure-btn').removeAttr('disabled');
					layer.close(regLayer);
					$.get('logout', {}, function() {});
					if (data.status == 'success') {
						var index = layer.confirm('恭喜您${param.type == "change" ? "修改密码" : "找回密码"}成功，是否登录？', function() {
							location.href = 'login';
						}, function() {
							location.href = 'index';
						});
						return;
					}
					
					layer.alert('对不起，找回密码失败，请稍后再试！');
				}, 'json');
			}
		}
		
		
		loadPicCode();
		
		
	</script>
</body>
</html>