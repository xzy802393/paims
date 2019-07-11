<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>-->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>营普金服—参股商业银行的互联网金融服务平台</title>
		<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
		<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
		<link rel="shortcut icon" href="../img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="../../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="css/nav-bar.css"/>
		<link rel="stylesheet" type="text/css" href="css/yingpu_events.css"/>
		<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="nav-bar.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../../head.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>	
		
		<div class="nar-bar" id="navBar">
			
		</div>
		<!--主体-->
		<div class="aboutUs">
			<div class="banner"></div>
			
			<div class="yingpu">
				<div class="center">
					<div class="nav-bar">
						<p>当前位置   &gt; <a href="/">首页</a> &gt; <a href="platform_intro.jsp">返回上一页</a> &gt; <a class="now">营普大事件</a></p>
					</div>
					<div class="events-content">
						<div class="title">
							<h3>营普金服大事记</h3>
							<p class="chang"></p>
							<p class="duan"></p>
						</div>
						<div class="timelist">
							<div class="line"></div>
							<ul>
								<div class="year">
									<p>2017</p>
									<p>YEAR</p>
								</div>
								<li class="list-right">
									<span class="event color1">营普金服PC站全新上线</span>
									<span class="time">2017-11-07</span>
									<span class="yuan"></span>
								</li>
								<li class="list-left">
									<span class="yuan"></span>
									<span class="time">2017-10</span>
									<span class="event color2">与重庆富民银行签订资金存管协议</span>
								</li>
								<li class="list-right">
									<span class="event color3">持股许昌魏都农村商业银行</span>
									<span class="time">2017-09-21</span>
									<span class="yuan"></span>
								</li>
								<li class="list-left">
									<span class="yuan"></span>
									<span class="time">2017-09-13</span>
									<span class="event color4">在线成交额突破1万元</span>
								</li>
								<li class="list-right">
									<span class="event color5">营普金服注册用户突破10000人、APP全新改版上线</span>
									<span class="time">2017-05</span>
									<span class="yuan"></span>
								</li>
								<div class="year">
									<p>2016</p>
									<p>YEAR</p>
								</div>
							
								<li class="list-left">
									<span class="yuan"></span>
									<span class="time">2016-12</span>
									<span class="event color6">营普金服注册用户突破5000人</span>
								</li>
								<li class="list-right">
									<span class="event color7">营普金服开展“拥抱监管，安全合规”自我整改活动</span>
									<span class="time">2016-09</span>
									<span class="yuan"></span>
								</li>
								<li class="list-left">
									<span class="yuan"></span>
									<span class="time">2016-07</span>
									<span class="event color1">受邀出席沪上新政解读探讨会，追寻合规发展更进一步</span>
								</li>
								<li class="list-right">
									<span class="event color2">完成2000万元实缴资本验资</span>
									<span class="time">2016-06-12</span>
									<span class="yuan"></span>
								</li>
								<li class="list-left">
									<span class="yuan"></span>
									<span class="time">2016-05-08</span>
									<span class="event color3">营普金服上线试运营</span>
								</li>
							</ul>
						</div>
						
						
						
					</div>
				</div>
				
			</div>
		</div>
		
		
		<!--客服悬浮条-->
		<iframe src="../../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<!--底部导航-->
		
		<iframe src="../../footer.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../js/idangerous.swiper.min.js" type="text/javascript" charset="utf-8"></script>
	
		<script type="text/javascript">
			
			$(function(){
				$(".timelist").eq(0).animate({
					height:'850px'
				},3000);
			});
		</script>
			
	</body>
</html>
