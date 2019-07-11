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
		<link rel="shortcut icon" href="../../../img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="../../../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../../../css/common.css"/>
		<!--<link rel="stylesheet" type="text/css" href="../Jun.css"/>-->
		<!--<link rel="stylesheet" type="text/css" href="../../../css/animate.css"/>-->
		<link rel="stylesheet" type="text/css" href="css/invite.css"/>
		<!--<link rel="stylesheet" type="text/css" href="../../../css/animate.css"/>-->
	
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../../../head3.html" class="iframe-head" width="100%" height="110px" scrolling="no"  style="border:0px;display: block;"></iframe>	
		
		<!--主体-->
		<div id="content">
			<div class="header">
				<img src="img/inviteTitle.png" >
				<p class="text">老用户邀请好友在营普金服注册成为新用户，新用户投资成功后，老用户可额外获得新用户投资预期收益的10%奖励，奖励额度不设上限，永久有效。</p>
			</div>
			<div class="bodyer">
				<div id="invite">
					<div class="press">
						<h1>邀请流程</h1>
					</div>
					<ul class="invite_list">
						<li>
							<h1>壹</h1>
							<h1>老用户A邀请好朋友B</h1>
							<h1>
								<img src="img/1.png">
							</h1>
							<h1>老用户A</h1>
						</li>
						<li>
							<img src="img/jiantou.png">
						</li>
						<li>
							<h1>贰</h1>
							<h1>新用户B通过链接注册并投资成功 </h1>
							<h1>
								<img src="img/2.png">
							</h1>
							<h1>新用户B</h1>
						</li>
						<li>
							<img src="img/jiantou.png">
						</li>
						<li>
							<h1>叁</h1>
							<h1>新用户B获得1888元新人注册红包 </h1>
							<h1>
								<img src="img/3.png">
							</h1>
							<h1>新人注册红包</h1>
						</li>
						<li>
							<img src="img/jiantou.png">
						</li>
						<li>
							<h1>肆</h1>
							<h1>老用户A额外获得B投资预期收益的10%现金奖励 </h1>
							<h1>
								<img src="img/4.png">
							</h1>
							<h1>现金奖励</h1>
						</li>
					</ul>
					<div class="now">
						<h1><a href="/yingpu/pc/myaccount/myrewards">立即邀请</a></h1>
					</div>
				</div>
			</div>
			<div class="footer">
				<div class="rules">
					<h1>邀请规则</h1>
				</div>
				<div class="ruleText">
					<p>1.新用户可以通过朋友的邀请链接注册，也可以在注册时在邀请码一栏填写邀请人的电话号码。</p> 
					<p>2.不是通过邀请链接注册、没有填写邀请均不能认定为邀请关系，老用户无法享受邀请奖励，新用户注册奖励不变。</p>
					<p>3.老用户可以在登录APP后，通过APP首页“邀请豪礼”，将自己的邀请链接分享给更多好友。也可以将自己注册的电话号码告诉好友，方便好友注册时填写邀请码。</p>
					<p>4.新用户注册投资成功后，老用户享受新用户投资预期收益10%的现金奖励，系统自动结算；奖励为平台额外发放，新用户收益不受影响。如有任何疑问欢迎咨询在线客服或拨打免费客服电话：400-969-1811，竭诚为您服务！</p>
					<p>以上活动在法律许可的范围内，最终解释权归营普金服所有。</p>
				</div>
			</div>
		</div>
		
		<!--客服悬浮条-->
		<iframe src="../../../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../../../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../../../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<!--底部导航-->
        <iframe src="../../../footer.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		<!--加载js文件-->
		<script src="../../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../../.././layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
// 			$(function(){
// 				$(window).scroll(function(){
// 					$(".iframe-head").show();
// 				});
// 			});
// 
// 			function qiandao(){
// 				var a='${not empty pcuser}';
// 			if(a=="true"){
// 					location.href='../../myaccount/mysignrewards';
// 				}else{
// 					layer.alert('请先登录',function(){
// 						location.href='../../login.jsp';
// 					});
// 				}
// 			}
// 				
// 			function visit(){
// 				var a='${not empty pcuser}';
// 				if(a=="true"){
// 					location.href='../../../myaccount/myrewards';
// 				}else{
// 					layer.alert('请先登录',function(){
// 						location.href='../../../login.jsp';
// 					});
// 				}
// 			}
	    </script>

		
	</body>
</html>
