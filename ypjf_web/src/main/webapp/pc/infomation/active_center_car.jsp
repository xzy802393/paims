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
		<title>营普金服-我要投资</title>
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="../css/active_center.css"/>
		<link rel="stylesheet" type="text/css" href="css/active_car.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>	
		
		<!--主体-->
		<div class="active-main">
			<!--banner-->
			<div class="active-banner car">
				<!--<div class="active-banner-txt">
					<p>轻松投 欢乐投</p>
					<p>更多玩法更有趣！</p>
				</div>				-->
			</div>
			
			<!--活动内容-->
			<div class="center">
				<div class="active-center">
					<div class="active-nav">
						<p>当前位置   &gt; <a href="/">首页</a> &gt; <a href="aboutUs/platform_intro.html">信息披露</a> &gt; <a href="#" class="now">活动中心</a></p>
					</div>
					
					<!--活动项目-->
					<div class="active-project">
						<div class="tab-menu" id="menu">
							<ul class="clearfix">
								<li class="active">车贷融</li>
								<li>房贷融</li>
								<li>优企融</li>
							</ul>
						</div>
						
						<div class="tab-main" id="content">
							<!--车贷-->
							<div class="item active-car">
								<div class="des">
									<p><span>车抵押</span> 车抵押贷款业务为借款人提供相关信用咨询、车辆评估、抵押借款、协议管理、回款管理等多方面的服务，借款人以自行车辆为抵押物获得出借资金，公司安排专业人员对抵押车辆进行GPS安装。在合同期间，借款人仍可正常使用该车辆。质押贷款中，由营普金服为借款人妥善保管车辆。</p>
								</div>
								
								<div class="process">
									<ul class="clearfix">
										<li>
											<p>审查借款资料，核实产权</p>
											<p class="num">1</p>
											<p>资料核实</p>
										</li>
										<li>
											<p>车辆估值</p>
											<p>2</p>
											<p>核查车辆情况，评估价值</p>
										</li>
										<li>
											<p>审查借款资料，核实产权</p>
											<p>1</p>
											<p>资料核实</p>
										</li>
									</ul>
								</div>
							</div>
							
							
							
							
						</div>
						
						
						
					</div>
				</div>
			</div>	
		</div>	
			
		<!--底部导航-->
		
		<iframe src="../footer.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
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
