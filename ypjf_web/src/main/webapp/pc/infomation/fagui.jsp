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
		<link rel="stylesheet" type="text/css" href="css/info1.css"/>
		
		
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
					
					<!--政策法规和平台协议-->
					<div class="risk-education">
						<div class="industry-laws" id="industryLaws">
							<a name="lawrule"></a>
							<h3>政策法规</h3>
							<div class="main">
								<div class="item">
									<ul>
										<c:forEach items="${lawrules}" var="a">
										<li pic="${a.pic}">
											<p><span class="icon"></span><a href="detail?id=${a.id}&type=lawrule&list=2">${a.title}</a></p>
											<span class="time">${a.postTime}</span>
										</li>
										</c:forEach>
									</ul>
									<div class="more"><a href="announcement_listfu.jsp?type=lawrule">更多</a></div>
								</div>
							</div>
						</div>

						<div class="industry-contract">
							<a name="contractsample"></a>
							<h3>平台协议</h3>
							<div class="main">
								<div class="item">
									<ul>
										<c:forEach items="${contractsamples}" var="a">
											<li pic="${a.pic}">
												<p><span class="icon"></span><a href="detail?id=${a.id}&type=contractsample&list=2">${a.title}</a></p>
												<span class="time">${a.postTime}</span>
											</li>
										</c:forEach>
									</ul>
									<div class="more"><a href="announcement_listfu.jsp?type=contractsample">更多</a></div>
								</div>
							</div>
						</div>

					</div>
					
					
				</div>
			</div>	
		</div>	
			
		<!--底部导航-->
		<iframe src="../footer2.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		<script type="text/javascript">
			$(document).ready(function(){				
				//表示项目进度的进度条
				$('#progressBar1').LineProgressbar({
				  percentage: 75,
				  fillBackgroundColor: '#ff8f3d',
				  height: '8' 
				});
				
				$('#progressBar2').LineProgressbar({
				  percentage: 0,
				  fillBackgroundColor: '#ff8f3d',
				  height: '8' 
				});
				
				$('#progressBar3').LineProgressbar({
				  percentage: 100,
				  fillBackgroundColor: '#ff8f3d',
				  height: '8' 
				});
				
				$('#progressBar4').LineProgressbar({
				  percentage: 100,
				  fillBackgroundColor: '#ff8f3d',
				  height: '8' 
				});
				
				$('#progressBar5').LineProgressbar({
				  percentage: 100,
				  fillBackgroundColor: '#ff8f3d',
				  height: '8' 
				});
				
				$('#progressBar6').LineProgressbar({
				  percentage: 75,
				  fillBackgroundColor: '#ff8f3d',
				  height: '8' 
				});
				
				$('#progressBar7').LineProgressbar({
				  percentage: 0,
				  fillBackgroundColor: '#ff8f3d',
				  height: '8' 
				});
				
				$('#progressBar8').LineProgressbar({
				  percentage: 100,
				  fillBackgroundColor: '#ff8f3d',
				  height: '8' 
				});
				
				
				//右边滚动条
				$('#investors-list').slimScroll({  
	                height: '748px'  
	            });
			})
		</script>

		
	</body>
</html>
