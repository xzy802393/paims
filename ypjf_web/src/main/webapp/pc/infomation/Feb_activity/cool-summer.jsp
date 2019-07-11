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
		<link rel="shortcut icon" href="../../img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="../../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="cool_summer.css"/>
		<link rel="stylesheet" type="text/css" href="../../css/animate.css"/>
		<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../../head.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>	
		
		<!--主体-->
		<div class="main">
			<div class="banner">
				<div class="center">
					<img src="images/cool-summer/banner-tit.png"/>
					<p>活动期间，在营普金服注册的新用户可立即领取3456元红包优惠券；营普金服老用户也将获得由系统自动发放的3456元红包优惠券。登录“我的账户”，在“我的奖励-优惠劵”中查看，按照劵面指定规则使用即可。</p>
				</div>
				
			</div>
			<div class="section-one">
				<div class="tit title1">
					<img src="images/cool-summer/tit-1.png"/>
				</div>
				<ul class="center clearfix">
					<li class="list item">
						<img src="images/cool-summer/27.png"/>
						<p>最低投资5000元可用</p>
						<p>仅限<span>2</span>张</p>
					</li>
					<li class="list item">
						<img src="images/cool-summer/56.png"/>
						<p>最低投资10000元可用</p>
						<p>仅限<span>10</span>张</p>
					</li>
				</ul>
				<ul class="center clearfix">
					<li class="list task">
						<img src="images/cool-summer/108.png"/>
						<p>最低投资20000元可用</p>
						<p>仅限<span>5</span>张</p>
					</li>
					<li class="list task">
						<img src="images/cool-summer/158.png"/>
						<p>最低投资30000元可用</p>
						<p>仅限<span>3</span>张</p>
					</li>
					<li class="list task">
						<img src="images/cool-summer/258.png"/>
						<p>最低投资50000元可用</p>
						<p>仅限<span>3</span>张</p>
					</li>
				</ul>
				<div class="invest-btn">
					<a href="../../register"><img src="images/cool-summer/invest.png"/></a>
				</div>
			</div>
			
			<div class="section-two">
				<div class="tit title2">
					<img src="images/cool-summer/tit-2.png"/>
				</div>
				<ul class="center clearfix">
					<li class="list">
						<img src="images/cool-summer/12.png"/>
						<p>最低投资1000元可用</p>
						<p>仅限<span>1</span>张</p>
					</li>
					<li class="list">
						<img src="images/cool-summer/36.png"/>
						<p>最低投资3000元可用</p>
						<p>仅限<span>2</span>张</p>
					</li>
					<li class="list">
						<img src="images/cool-summer/58.png"/>
						<p>最低投资5000元可用</p>
						<p>仅限<span>5</span>张</p>
					</li>
					<li class="list">
						<img src="images/cool-summer/136.png"/>
						<p>最低投资10000元可用</p>
						<p>仅限<span>5</span>张</p>
					</li>					
				</ul>
				<div class="invest-btn">
					<a href="../../register"><img src="images/cool-summer/invest.png"/></a>
				</div>
			</div>
			<div class="section-three">
				<div class="instruction">
					<h5>活动说明</h5>
					<div class="des-bg">
						<dl style="">
							<dt>1、</dt>
							<dd>请在活动期限内参与活动，活动结束，相关优惠券也会同步失效。</dd>
						</dl>
						<dl>
							<dt>2、</dt>
							<dd>使用红包优惠券时，系统会自动按照抵扣数额减扣；每笔投资，仅能使用一张优惠券；优惠券不可叠加。</dd>
						</dl>
						<dl>
							<dt>3、</dt>
							<dd>天天存吧不能使用任何优惠券。优惠券不支持直接的现金折扣，用户可在投资到期后提现。</dd>
						</dl>
						<dl>
							<dt>4、</dt>
							<dd>如有任何疑问欢迎咨询在线客服或拨打免费客服电话：400-969-1811，竭诚为您服务！</dd>
						</dl>
						<dl>
							<dt>5、</dt>
							<dd>以上活动在法律许可的范围内，最终解释权归营普金服所有。</dd>
						</dl>						
					</div>
					<!--<p>借贷有风险  投资需谨慎</p>			-->
				</div>
			</div>
			
		</div>
	
		
		
		<!--客服悬浮条-->
		<iframe src="../../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<!--底部导航-->
		<iframe src="../../footer.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>		
		<!--加载js文件-->
		<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../.././layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			$(function(){
				$(window).scroll(function(){
					$(".iframe-head").show();
				});
			});

			function qiandao(){
				var a='${not empty pcuser}';
			if(a=="true"){
					location.href='../../myaccount/mysignrewards';
				}else{
					layer.alert('请先登录',function(){
						location.href='../../login.jsp';
					});
				}
			}
				
			function visit(){
				var a='${not empty pcuser}';
				if(a=="true"){
					location.href='../../myaccount/myrewards.jsp';
				}else{
					layer.alert('请先登录',function(){
						location.href='../../login.jsp';
					});
				}
			}
	    </script>

		
	</body>
</html>
