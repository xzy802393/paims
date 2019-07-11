<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>营普金服—参股商业银行的互联网金融服务平台</title>
<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" >
<link rel="shortcut icon" href="img/logo1.icon"/>
<link rel="stylesheet" type="text/css" href="css/reset.css"/>
<link rel="stylesheet" type="text/css" href="css/common.css"/>
<link rel="stylesheet" type="text/css" href="css/login.css"/>
<script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
	<div class="top">
		<div class="center">
			<div class="logo left">
				<a href="javascript:location.href='index';">
					<img src="img/logo.png"/>
				</a>					
			</div>
			<p class="wel left">免费注册九趣贷账号，已有账号请  <a href="login">登录</a></p>
			<div class="go-index right" style="height:120px;line-height:120px;">
				<a href="javascript:location.href='index';" style="font-size:16px;color:#ff7f01;">返回首页</a>
			</div>
		</div>
	</div>
	<div class="rejister-contain">
		<div class="center">
			<div class="rejister-box clearfix">
				
				<div class="rejister-form left">
					<!--注册之前-->
					<form id="reg" action="" method="post" onsubmit="return false;">
						<div class="msg">
							<span class="tit">手机号码</span>
							<input type="text" name="phone" id="tel" placeholder="请输入您的手机号码" onkeyup="checkPhone()"/>
						</div>
						<div class="msg">
							<span class="tit">设置密码</span>
							<input type="password" name="password" placeholder="请输入6-16位字母和数字" />
						</div>
						<div class="msg">
							<span class="tit">确认密码</span>
							<input type="password" name="confirm_password" placeholder="请输入6-16位字母和数字" />
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
						<div class="msg visit-code">
							<span class="tit">邀请码</span>
							<input type="text" name="inviteCode" placeholder="请输入邀请人的手机号码" />
							<span class="chioce">选填</span>
						</div>
						<div class="account-control">
							<input type="checkbox" name="agree" id="" value="" checked="checked"/>
							<label for="agree">我已阅读并同意<span onclick="viewLicense()" style="cursor: pointer;">《九趣贷用户注册协议》</span></label>
						</div>
						<input type="submit" value="立即注册" class="rejister-btn" id="register"/>
					</form>
				
					<!--注册成功弹出以下对话框-->
					<div class="rejister-ok" id="">
						<p><span class="ok"></span>恭喜您注册成功！</p>
						<!--<p>开通富友账户，开始理财!</p>-->
						<p>
							<a class="active" onclick="showFYRegister();" style="width: 296px;height: 45px;display: block;background: #ff8e06;margin: 0 auto;line-height: 45px;color: #fff;font-size: 16px;cursor: pointer;border-radius: 4px;">立即开通富友支付金账户，开始理财！</a>
							<!--<a href="html/account.jsp">暂不开通</a>-->
						</p>
						<p class="tip">资金交易由第三方富友支付全程托管，安全放心。</p>
						
					</div>
				
				</div>

				<div class="rejister-img left">
					<img src="img/rejister-img.jpg"/>
				</div>
			</div>
			
		</div>
	</div>
	
	<!--开通富友账户弹出层-->
	<div id="fade" class="black-overlay"></div>
	<div class="open-fuyou" id="openFuyou">
		<div class="open-fuyou-tit">
			<p>开通富友金账户</p>
			<span class="close" onclick="$('#openFuyou').hide();$('#fade').hide();"></span>
		</div>
		<div class="open-fuyou-form">
			<p>为了您的资金安全，继续投资请开通第三方托管账户<a href="#">富友金账户</a></p>
			<form id="fy" action="" method="post" onsubmit="return false;">
				<input id="userId" name="id" value="${pcuser.id}" type="hidden" />
				<input id="phone" name="phone" value="${pcuser.phone}" type="hidden" />
				
				<label><span>真实姓名</span><input name="realName" type="text" value="" placeholder="请输入真实姓名"/></label>
				<label><span>身份证号</span><input name="idCard" type="text" value="" placeholder="请输入身份证号"/></label>
				<label><span>银行卡号</span><input name="bankNum" type="text" value="" placeholder="请输入您的银行卡号"/></label>
				<p class="tip"><span>*</span>请绑定持卡人为本人的储蓄卡</p>
				<label><span>开户银行</span>
					<select name="parent_bank_id" class="bank">
						<option value="">请选择</option>
					</select>
				</label>
				<label><span>开户省市</span>
					<select name="province" class="province">
						<option value="">请选择省份</option>
					</select>
					<select name="city_id" class="city">
						<option value="">请选择城市</option>
					</select>
				</label>
				
				<!--<input type="submit" class="open-fuyou-btn" value="开通富友金账户"/>-->

				<input type="submit" class="open-fuyou-btn" disabled="disabled" value="开通富友金账户"/>

			</form>
		</div>
	</div>
	
		
	<!--开通富友账户成功,弹出对话框-->
	<!--开通富友账户成功,弹出对话框-->
	<div class="open-fuyou-ok" id="openFuyou-ok">
		<div class="open-fuyou-tit">
			<p>开通富友金账户</p>
			<span class="close" onclick="location.href = 'html/account.jsp';"></span>
		</div>
		<div class="open-fuyou-txt">
			<img src="img/rejister-ok.png"/>
			<p class="open-ok">开通成功</p>
			<%--<p>您的富友账户余额：<span>0.00元</span></p>--%>
			<p>下面进行风险评估，提前规避投资风险，合理配置资产。</p>
			<a style="display: block;width: 170px;height: 43px;background: red;color: white;margin: 16px auto;text-align: center;font-size: 18px;line-height: 42px;" href="/yingpu/pc/login?backUrl=/yingpu/pc/html/account/fengxian-ceping.html">进行风险测评</a>
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
		
	</script>
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/queryString.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/utils.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$("body").keydown(function () {
			if (event.keyCode == "13") {//keyCode=13是回车键
				$(".rejister-btn").click();
				console.log('1');
			}
		});
		var isPhoneExists = false;
	
		useLoadingShade();
		$(function(){
			$("#rejister .msg input").focus(function(){
				$("#rejister .msg").removeClass("focus");
				$(this).parent().addClass("focus");
			});
		});

		window.onload=function(){
		    var send=document.getElementById('send'),
		        timer=null;
		    
		        send.onclick=function(){
		        	sendCode();
		        // 计时开始 
		      	console.log("2");
//		      	if (!sendCode()) {
//		      		return;
//		      	}
		    };
		    
		};
		
		function viewLicense() {
			var idxs = [19, 18], idx = 0;
			layer.open({
				type : 2,
				content : '<%=basePath%>pc/myaccount/announce/content?id=' + idxs[idx] + '&type=contractsample',
				area: ['50%', '80%']
			});
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
		
		
		function showFYRegister() {
			loadRegions('province', 0);
			loadBanks();
			$('#fade').show();$('#openFuyou').show();$('#openFuyou form').show();
		}
		
		
		var inviteCode = queryString('code');
		if (!!inviteCode) {
			$('input[name=inviteCode]').val(inviteCode);
		}
		
		//select的默认颜色
			
		$(function () {
			var unSelected = "#999";
			var selected = "#333",
				curOption;
			$("select").css("color", unSelected);
			$("option").css("color", selected);
			
			$(document).on("change", "select", function () {
				if ($(this).val()) {
					$(this).css("color", selected);					
				}
				else {
					$(this).css("color", unSelected);
				}
			});
		})
			
		
		
		function sendCode() {
			if (!/\d{11}/.test($('#reg input[name=phone]').val())) {
				layer.alert('手机号码必须为11位数字！');
				return;
			}
			
			if (isPhoneExists) {
				layer.alert('您输入的手机号已存在！');
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
				phone : $('#reg input[name=phone]').val(),
				type : 1,
				code : $('[name=pic_code]').val()
			}, function(data) {
				if (data.status != 'success') {
					layer.msg(data.message);
					if (data.status == 'shixiao') {
						loadPicCode();
					}
					return;
				}
				
				layer.msg('短信已发送至您的手机，请注意查收！');
				countdown();
			}, 'json');
			
			return true;
		}
		
		
		function checkPhone() {
			cancelLoadingShade();
			$.get('<%=basePath%>pc/myaccount/checkPhone', { phone : $(event.target || event.srcElement).val() }, function(data) {
				useLoadingShade();
				if (data.status == 'error') {
					layer.msg('该手机号已存在！');
					isPhoneExists = true;
					return;
				}
				
				isPhoneExists = false;

			});
		}
		
		
		function loadPicCode() {
			cancelLoadingShade();
			$.get('<%=basePath%>app/loan/getCaptcha/json', {}, function(data) {
				if (data.data) {
					$('#pic-code').attr('src', 'data:image/jpeg;base64,' + data.data);
					map['pic_code']['passed'] = false;
				}

				useLoadingShade();
			}, 'json');
		}
		
		
		function register() {
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
				$('.rejister-btn').attr('disabled', 'disabled');
				var regLayer = layer.load(1, { shade : [ 0.4, '#fff' ] });
				$.post('doRegister', $("#reg").serialize(), function(data) {
					$('.rejister-btn').removeAttr('disabled');
					layer.close(regLayer);
					if (data.status == 'success') {
						$('#userId').val(data.data.userId);
						$('#phone').val(data.data.phone);
						onRegSuccess();
						return;
					}
					
					loadPicCode();
					layer.alert(data.message || '对不起，注册失败，请稍后再试！');
				}, 'json');
			}
		}
		
		
		function onRegSuccess() {
			$('form').hide();
			$('.rejister-ok').show();
		}
		
		
		$('.rejister-form').on('submit', 'form', function(e) {
			var mustFields = [
				'phone', 'password', 'confirm_password', 'pic_code', 'code'
			];
			
			var emptyField = '';
			if (isPhoneExists) {
				layer.alert('您输入的手机号已存在！');
				return;
			}
			
			$(mustFields).each(function(k, v) {
				if (!$('#reg input[name=' + v + ']').val()) {
					emptyField = $('#reg input[name=' + v + ']').prev().html();
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
			
			if ($('#reg input[name=password]').val() != $('#reg input[name=confirm_password]').val()) {
				layer.alert('两次密码不一致！');
				return;
			}
			
			if ($('#reg input[name=password]').val().length < 6 || $('#reg input[name=password]').val().length > 20) {
				layer.alert('密码长度必须为6-20位！');
				return;
			}
			
			register();
			return false;
		});
		
		$(document).on('keyup', '[name=code], [name=pic_code]', function() {
			$this = $(this);
			cancelLoadingShade();
			$.post('check' + map[$(this).attr('name')]['action'] + 'Code', {
				code : $(this).val(),
				phone : $('#reg [name=phone]').val()
			}, function(data) {
				if (data.status == 'success') {
					map[$this.attr('name')]['passed'] = true;
				}
				
				useLoadingShade();
			}, 'json');
		});
		
		
		$('#openFuyou form').on('change blur keyup', 'input, select', function() {
			var $btn = $('#openFuyou form').find('[type=submit]');
			if (formChecker()) {
				$btn.removeAttr('disabled').addClass('open-fuyou-btn').addClass('active');
			}
			else {
				$btn.attr('disabled', 'disabled').removeClass('active');
			}
		});
		
		
		$('#openFuyou').on('submit', 'form', function() {
			var emptyFields = $(this).find('input,select').filter(function() {
				if ($(this).attr('type') != 'hidden' && !$(this).val()) {
					return true;
				}
			});
			
			if (emptyFields.size()) {
				var prompt = ['请填写', '请选择'][$(emptyFields[0]).attr('type') == 'input' ? 0 : 1]
					+  ( $(emptyFields[0]).attr('name') == 'city_id' ? 
							 $(emptyFields[0]).prev().prev().html() :
								 $(emptyFields[0]).prev().html() ) + "！"		
								 
				layer.alert(prompt);
				return;
			}
			
			if (!/^\d{17}(?:\d|[a-zA-Z])$/.test($('input[name=idCard]').val())) {
				layer.alert('身份证号码必须为18位！');
				return;
			}
			
			if (!/\d{16,19}/.test($('input[name=idCard]').val())) {
				layer.alert('银行卡号必须为16~19位数字！');
				return;
			}
			
			var index = layer.load(2, { shade : [0.5, '#fff'] });
			$.post('FYUserReg', $(this).serialize(), function(data) {
				layer.close(index);
				if (data.status == 'success') {
					onFYRegSuccess();
					return;
				}
				
				layer.alert(data.message || '对不起，开通富友金账户失败，请稍后再试！');
			});
			
		});
		
		
		function formChecker() {
			var emptyFields = $('#openFuyou form').find('input,select').filter(function() {
				if ($(this).attr('type') != 'hidden' && !$(this).val()) {
					return true;
				}
			});

			return emptyFields.size() == 0;
		}
		
		
		function onFYRegSuccess() {
			$('#openFuyou').hide();
			$('#openFuyou-ok').show();
		}
		
		
		$('.province').change(function() {
			loadRegions('city_id', $(this).val());
		});
		
		
		function loadRegions(type, code) {
			$.get('regions/list', { code : code }, function(data) {
				var tpl = '';

				$.each(data.data || [], function(k, v) {
					tpl += '<option value="' + v.code + '">' + v.name + '</option>';
				});

				var opt = $('[name=' + type + ']');
				opt.find('option[value!=""]').remove();
				opt.append(tpl);
				
			}, 'json');
		}
		
		
		function loadBanks() {
			$.get('banks/list', { }, function(data) {
				var tpl = '';

				$.each(data.data || [], function(k, v) {
					tpl += '<option value="' + v.bankId + '">' + v.name + '</option>';
				});

				var opt = $('[name=parent_bank_id]');
				opt.find('option[value!=""]').remove();
				opt.append(tpl);
			}, 'json');
		}
		
		loadPicCode();
	</script>
</body>
</html>