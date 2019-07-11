<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		<!--主体-->
		<div class="infomation">
			<!--banner-->
			<!--<div class="infomation-banner">
								
			</div>-->
			
			<!--活动内容-->
			<div class="center">
				<div class="info-center">
					<div class="info-nav">
						<p>当前位置   &gt; <a href="/">首页</a> &gt; <a href="aboutUs/platform_intro.html">信息披露</a> &gt; <a class="now">公告详情</a></p>
					</div>
					
					<!--公告详情-->
					<div class="announce-contain">
						<div class="tit">
							<h3>${announce.title}</h3>
							<p class="time">发布时间：
								<c:if test="${not empty announce.postTime}" >
									${fn:substring(announce.postTime, 0, 19)}
								</c:if>
							</p>
						</div>
						<div class="main">
							${announce.content}
						</div>
						<div class="pre-next">
							<ul class="clearfix">
								<li>上一篇：
									<c:choose>
										<c:when test="${not empty prev.announce}">
											<a href="detail?id=${prev.announce['id']}&type=${param.type}"> ${prev.announce['title']}</a>
										</c:when>
										<c:otherwise>
											<a>暂无更多</a>
										</c:otherwise>
									</c:choose>
								</li>
								<li>下一篇：
									<c:choose>
										<c:when test="${not empty next.announce}">
											<a href="detail?id=${next.announce['id']}&type=${param.type}"> ${next.announce['title']}</a>
										</c:when>
										<c:otherwise>
											<a>暂无更多</a>
										</c:otherwise>
									</c:choose>
								</li>
							</ul>
						</div>
						<div class="go-list">
							<%--<a href="${param.list == 2 ? 'list2' : 'list'}">返回列表</a>--%>
						</div>

					</div>

				</div>
			</div>	
		</div>	
		
		<!--客服悬浮条-->
		<!-- <iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		 --><!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		<script type="text/javascript">
			
			
			
		</script>

		
	</body>
</html>
