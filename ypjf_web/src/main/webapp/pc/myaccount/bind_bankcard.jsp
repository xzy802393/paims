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
		<title>营普金服—参股商业银行的互联网金融服务平台</title>
		<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
		<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
		<link rel="shortcut icon" href="../img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="../css/account.css"/>
		<link rel="stylesheet" type="text/css" href="css/bind_bankcard.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		<style>
		.open-fuyou-ok .open-fuyou-tit .close {
		    display: inline-block;
		    position: absolute;
		    width: 21px;
		    height: 21px;
		    background: url(../img/tip-close.png) no-repeat center;
		    margin-top: -35px;
		    margin-left: 220px;
		    cursor: pointer;
		}
		</style>
	</head>
	<body>
		<!--顶部-->
		
		
		
		
		<!--遮罩层-->
		<!--遮罩层-->
		<div id="fade" class="black-overlay"></div>
		<div class="open-fuyou" id="openFuyou" style="margin-top: -20%;">
			<div class="open-fuyou-tit">
				<p>开通富友金账户<span class="close" onclick="$(parent.document).find('#bindBank').hide();"></span></p>
				
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
					<input type="submit" class="open-fuyou-btn" value="开通富友金账户"/>
				</form>
			</div>
		</div>	
		
		<!--开通富友账户成功,弹出对话框-->
		<!--开通富友账户成功,弹出对话框-->
		<div class="open-fuyou-ok" id="openFuyou-ok" style="margin-top: -15%;">
			<div class="open-fuyou-tit">
				<p>开通富友金账户</p>
				<span class="close" onclick="closeSuccess()"></span>
			</div>
			<div class="open-fuyou-txt">
				<img src="../img/rejister-ok.png"/>
				<p class="open-ok">开通成功</p>
				<p>您的富友账户余额：<span>0.00元</span></p>
			</div>
		</div>
		
		
		<!--加载js文件-->
	<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$(function(){
			$("#fade").height($(document).parent().height());
		});


		
		function sendCode() {
			if (!/\d{11}/.test($('#reg input[name=phone]').val())) {
				layer.alert('手机号码必须为11位数字！');
				return;
			}
			
			$.post('<%=basePath%>pc/send/json', {
				phone : $('#reg input[name=phone]').val(),
				type : 1
			}, function(data) {
				if (data.status != 'success') {
					layer.alert(data.message);
					return;
				}
				
				layer.msg('短信已发送至您的手机');
			}, 'json');
			
			return true;
		}
		
		
		function loadPicCode() {
			$.get('<%=basePath%>app/loan/getCaptcha/json', {}, function(data) {
				if (data.data) {
					$('#pic-code').attr('src', 'data:image/jpeg;base64,' + data.data);
				}
			}, 'json');
		}
		
		
		function register() {
			var valid = true;
			for (var k in map) {
				valid = valid && map[k]['passed'];
				if (!map[k]['passed']) {
					layer.alert('验证码输入有误！');
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
					layer.alert('对不起，开通失败，请稍后再试！');
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
			$.post('<%=basePath%>pc/check' + map[$(this).attr('name')]['action'] + 'Code', {
				code : $(this).val(),
				phone : $('#reg [name=phone]').val()
			}, function(data) {
				if (data.status == 'success') {
					map[$this.attr('name')]['passed'] = true;
				}
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
			$.post('../FYUserReg', $(this).serialize(), function(data) {
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
			$.get('<%=basePath%>pc/regions/list', { code : code }, function(data) {
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
			$.get('<%=basePath%>pc/banks/list', { }, function(data) {
				var tpl = '';

				$.each(data.data || [], function(k, v) {
					tpl += '<option value="' + v.bankId + '">' + v.name + '</option>';
				});

				var opt = $('[name=parent_bank_id]');
				opt.find('option[value!=""]').remove();
				opt.append(tpl);
			}, 'json');
		}
		
		
		function closeSuccess() {
			$(parent.document).find('#bindBank').hide();
			parent.location.reload();
		}
		
		
		loadRegions('province', 0);
		loadBanks();
		loadPicCode();
	//	onFYRegSuccess();
		
	</script>
		
		

		
	</body>
</html>
