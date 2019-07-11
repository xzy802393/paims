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
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="css/info.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/common4.css"/>
		
		
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		<!--主体-->
		<div class="infomation">
			<!--banner-->
			<div class="infomation-banner risk">
								
			</div>
			
			<!--活动内容-->
			<div class="center">
				<div class="info-center">
					<div class="info-nav">
						<p>当前位置   &gt; <a href="/">首页</a> &gt; <a href="/yingpu/pc/infomation/aboutUs/platform_intro.html">信息披露</a> &gt; <a class="now">风险教育</a></p>

					</div>
					
					<!--风险教育-->
					<div class="risk-education">
						<div class="industry-news">
							<a name="news"></a>
							<h3>行业新闻</h3>
							<div class="main clearfix">
								<div class="image left">
									<img src=""/>
								</div>
								<div class="item left">
									<ul>
										<c:forEach items="${news}" var="a">
											<li pic="${a.pic}">
												<p><span class="icon"></span><a href="detail?id=${a.id}&type=news&list=2">${a.title}</a></p>
												<span class="time">${a.postTime}</span>
											</li>
										</c:forEach>
										
									</ul>
									<div class="more"><a href="announcement_lists.jsp?type=news">更多</a></div>
								</div>
							</div>
						</div>
					
						<div class="industry-laws" id="industryLaws">
							<a name="lawrule"></a>
							<h3>法律法规</h3>
							<div class="main clearfix">
								<div class="image left">
									<img src=""/>
								</div>
								<div class="item left">
									<ul>
										<c:forEach items="${lawrules}" var="a">
											<li pic="${a.pic}">
												<p><span class="icon"></span><a href="detail?id=${a.id}&type=lawrule&list=2">${a.title}</a></p>
												<span class="time">${a.postTime}</span>
											</li>
										</c:forEach>
									</ul>
									<div class="more"><a href="announcement_lists.jsp?type=lawrule">更多</a></div>
								</div>
							</div>
						</div>
					
						<div class="industry-contract">
							<a name="contractsample"></a>
							<h3>合同范本</h3>
							<div class="main clearfix">
								<div class="image left">
									<img src=""/>
								</div>
								<div class="item left">
									<ul>
										<c:forEach items="${contractsamples}" var="a">
											<li pic="${a.pic}">
												<p><span class="icon"></span><a href="detail?id=${a.id}&type=contractsample&list=2">${a.title}</a></p>
												<span class="time">${a.postTime}</span>
											</li>
										</c:forEach>
									</ul>
									<div class="more"><a href="announcement_lists.jsp?type=contractsample">更多</a></div>
								</div>
							</div>
						</div>
					
					</div>
					
					<div class="risk-assetment">
						<c:if test="${empty pcuser}">
								<a href="../login">风险测评</a>
						</c:if>

						<c:if test="${not empty pcuser}">
							<a href="../myaccount/security_risk_assessment.html">风险测评</a>
						</c:if>
						
					</div>
				</div>
			</div>	
		</div>	
		
		<!--客服悬浮条-->
		
		<!--客服悬浮条-->
		<!--悬浮条-->
		<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>

		<!--底部导航-->
		<iframe src="/yingpu/pc/footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;left: 0px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		<script type="text/javascript">
			
			var $this;
			$('ul').on('mouseover', 'li', function() {
				$(this).parents('.main').find('img').attr('src', $(this).attr('pic'));
			})
			.find('li:eq(0)').trigger('mouseover');
		</script>

		
	</body>
</html>
