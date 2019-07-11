<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		<link rel="stylesheet" type="text/css" href="../css/appload.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/common4.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		<!--主体-->
		
		<div class="app-content">
		<div class="app-content-one">
			<div class="center clearfix">
				<div class="app-content-left mobile">
					<img src="../img/appload/mobile1.png"/>
				</div>
				<div class="app-content-right box">
					<p class="fabu"> 营 普 金 服  APP  全新发布</p>
					<p class="box-s"><span>投资</span>随时随地</p>
					<p class="box-s"><span>抢标</span>快人一步</p>
					<div class="app-content-one-load">
						<img src="../img/appload/ios.png" alt=""/>
						<img src="../img/appload/andriod.png" alt="" />
					</div>
					<div class="app-content-one-code">
						<img src="../img/app-code.png" title="扫一扫"/>
					</div>
				</div>
			</div>
		</div>
		
		<!--第二部分-->
		<div class="app-content-two">
			<div class="center clearfix">
				<div class="app-content-left">
					<div class="app-content-left-text">
						<p class="text-one">投资，随时随地更<span>随心</span></p>
						<p class="text-two">投资特别简单，充值提现特别方便</p>
					</div>
				</div>
				<div class="app-content-right">
					<img src="../img/appload/app-c.jpg" class="app-content-right-mobile"/>
				</div>
			</div>
		</div>
		<!--第三部分-->
		<div class="app-content-three">
			<div class="center clearfix">
				<div class="app-content-left">
					<img src="../img/appload/mobile.png" class="app-content-right-mobile"/>
				</div>
				<div class="app-content-right">
					<div class="app-content-right-text">
						<p class="text-one">手机抢标，快人一步</p>
						<p class="text-two">手机抢标不用输入验证码</p>
					</div>
				</div>
			</div>
		</div>
		
		<!--第四部分-->
		<div class="app-content-four"> 
			<div class="center clearfix">
				<div class="app-content-left">
					<div class="app-content-left-text">
						<p class="text-one">账户资产，一目<span>了然</span></p>
						<p class="text-two">比银行存折还要清晰简单</p>
					</div>
				</div>
				<div class="app-content-right">
					<img src="../img/appload/mobile3.png" class="app-content-right-mobile"/>
				</div>
			</div>
		</div>
		<!--第五部分-->
		<div class="app-content-five">
			<div class="app-content-five-center">
				<span class="app-content-five-left">扫一扫，即可下载营普金服APP</span>
				<img src="../img/app-code.png"/>
			</div>
		</div>
	</div>	
		<%--<!--客服悬浮条-->--%>
		<%--<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>--%>
		<%--<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>--%>
		<%--<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>--%>
		<!--悬浮条-->
		<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		
		<!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		
		

		
	</body>
</html>
