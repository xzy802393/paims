<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
		<link rel="stylesheet" type="text/css" href="css/Novice_boot.css"/>
		
		
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head.html?num=7" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>	
		
		<!--主体-->
		<div class="novice-boot">
			<div class="b-head">
			</div>
			<div class="b-main">
				<div class="center">
					<div class="yp-who">
						<div class="who-pic clearfix">
							<span class="who-l left"></span>
							<span class="who-r right"></span>
						</div>
						<div class="who-txt">
							<h3>营普金服是谁?</h3>
							<p>营普金服，上海营夏财富投资管理有限公司旗下互联网借贷信息中介平台，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。平台通过严格的项目甄选及风控机制，为投资人提供优质优选项目，以专业的风险评估为客户提供专业的理财规划，根据其投资偏好制定出专属的理财投资方案。服务小微，助力实体经济。</p>
						</div>
					</div>
					<div class="yp-why">
						<img src="../img/novice_boot/b-2.png"/>
					</div>
					<div class="yp-style">
						<img src="../img/novice_boot/b-3.png"/>
					</div>
					<div class="yp-how">
						<div class="how-tit">
							<img src="../img/novice_boot/b-4.1.png"/>
						</div>
						<div class="how-main">
							<div class="how-step clearfix" id="howStep">
								<div class="step active">
									<span class="step1"></span>
									<p>注册</p>
								</div>
								<i class="sanjiao"></i>
								<div class="step">
									<span class="step2"></span>
									<p>认证绑卡</p>
								</div>
								<i class="sanjiao"></i>
								<div class="step">
									<span class="step3"></span>
									<p>充值</p>
								</div>
								<i class="sanjiao"></i>
								<div class="step">
									<span class="step4"></span>
									<p>投资</p>
								</div>
								<i class="sanjiao"></i>
								<div class="step">
									<span class="step5"></span>
									<p>收益</p>
								</div>
							</div>
							<div class="step-content" id="content">
								<div class="step-list zhuce clearfix">
									<div class="step-txt left">
										<i class="sanjiao"></i>
										<p>注册领取1888 元红包</p>
										<a href="../rejister.jsp">立即注册</a>
									</div>
									<div class="step-pic left">
										<img src="../img/novice_boot/h-step1.png"/>
									</div>
								</div>
								<div class="step-list renzhen clearfix" style="display: none;">
									<div class="step-txt left">
										<i class="sanjiao"></i>
										<p>实名认证绑卡</p>
										<!--<a href="#">立即注册</a>-->
										<span>手机号、身份证实名认证、银行卡绑定</span>
									</div>
									<div class="step-pic left">
										<img src="../img/novice_boot/h-step-2.png"/>
									</div>
								</div>
								<div class="step-list chongzhi clearfix" style="display: none;">
									<div class="step-txt left">
										<i class="sanjiao"></i>
										<p>银行卡充值</p>
										<!--<a href="#">立即注册</a>-->
										<span>开启赚钱之旅</span>
									</div>
									<div class="step-pic left">
										<img src="../img/novice_boot/h-step-3.png"/>
									</div>
								</div>
								<div class="step-list touzi clearfix" style="display: none;">
									<div class="step-txt left">
										<i class="sanjiao"></i>
										<p>享11.0%新手专享标</p>
										<!--<a href="#">立即注册</a>-->
										<span>最高可投50000元</span>
									</div>
									<div class="step-pic left">
										<img src="../img/novice_boot/h-step-2.png"/>
									</div>
								</div>
								<div class="step-list shouyi clearfix" style="display: none;">
									<div class="step-txt left">
										<i class="sanjiao"></i>
										<p>投资回款，赚取收益</p>
										<!--<a href="#">立即注册</a>-->
										<span>个人账户查看收益</span>
									</div>
									<div class="step-pic left">
										<img src="../img/novice_boot/h-step-5.png"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="yp-product">
						<div class="pro-tit">
							<img src="../img/novice_boot/our_product-bg.png"/>
						</div>
						<!--<div class="pro-main">
							
							
						</div>-->
					</div>
				</div>
				<div class="pro-main">
					<div class="pro-type">
						<ul class="clearfix">
							<li><img src="../img/novice_boot/pro-cdr.png"/></li>
							<li><img src="../img/novice_boot/pro-fdr.png"/></li>
							<li><img src="../img/novice_boot/pro-yqr.png"/></li>
						</ul>
						<div class="ewm">
							<img src="../img/novice_boot/pro-ewm.png"/>
							<p>扫描下载营普金服APP</p>
						</div>
						
					</div>
					<p class="tip">理财有风险 投资需谨慎</p>
				</div>
			</div>
			
		</div>
		
		
		<!--客服悬浮条-->
		<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		
		<!--底部导航-->
		<iframe src="../footer.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		<script type="text/javascript">
			window.onload = function()
				{
					var $span = $('#howStep .step span');
					var $list = $('#content .step-list');
				
					$span.click(function(){
						var $this = $(this);
						var $t = $this.parent().index();
						$span.parent().nextAll().removeClass('active');						
						$this.parent().prevAll().addClass('active');
						$this.parent().addClass('active');
//						$span.parent().prev().addClass('over');
						$list.css('display','none');
						$list.eq($t/2).css('display','block');
					});
	
				}
				
			
		</script>
		
		<!--在线客服-->
		
		<!--<script>
			$(function(){
				var timer = setInterval(function(){
					$('#doyoo_panel').hide();
					$('#talk99_message').hide();
				},10);
				setTimeout(function(){
					clearInterval(timer);
				},5000);
				
			});	
		</script>-->
				
	</body>
</html>
