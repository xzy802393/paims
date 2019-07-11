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
		
		
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		<style type="text/css">
			.site-map{
				width: 100%;
				height: auto;
			}
			.site-map .map-list{
				width: 1198px;
				margin: 40px auto;
				border: 1px solid #ddd;
			}
			.site-map .map-list dl{
				width: 100%;
				line-height: 30px;
				overflow: hidden;
				clear: both;
				color: #333;
				height: 60px;
				line-height: 60px;				
			}
			.site-map .map-list dl:nth-child(odd){
				background: #F5F5F5;
			}
			.site-map .map-list dl dt{
				font-size: 16px;
				margin-left: 30px;
			
			}
			.site-map .map-list dl dt,.site-map .map-list dl dd{
				float: left;
				margin-right: 30px;
			}
			.site-map .map-list dl dd a{
				font-size: 14px;
			}
			.site-map .map-list dl dd a:hover{
				font-size: 14px;
				color: #ff7f01;
				text-decoration: underline;
			}
		</style>
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		<!--主体-->
		<div class="center">
			<div class="info-center">
				<div class="info-nav">
					<p>当前位置   &gt; <a href="/yingpu/pc/index">首页</a> &gt; <a class="now">网站地图</a></p>
				</div>
				<div class="site-map">
				
					<div class="map-list">
						<dl>
							<dt>网站首页</dt>
							<dd><a href="/yingpu/pc/index">首页</a></dd>
						</dl>
						<dl>
							<dt>我要出借</dt>
							<dd><a href="/yingpu/pc/project/findProject">新手专享</a></dd>
							<!-- <dd><a href="/yingpu/pc/my-invest/zhiTou.jsp">X快享智能投标</a></dd> -->
							<dd><a href="/yingpu/pc/project/list">散标</a></dd>
							<!-- <dd><a href="/yingpu/pc/project/findZhai">债权转让</a></dd> -->
						</dl>
						<dl>
							<dt>我要借款</dt>
							<dd><a href="/yingpu/pc/html/my-borrow/borrow.html">我要借款</a></dd>
						</dl>
						<dl>
							<dt>信息披露</dt>
							<dd><a href="../infomation/aboutUs/platform_intro.html">平台简介</a></dd>
							<!-- <dd><a href="../infomation/operation_data.html">运营数据</a></dd> -->
							<dd><a href="../infomation/list">公告动态</a></dd>
							<!-- <dd><a href="../active_center">活动中心</a></dd> -->
							<dd><a href="../infomation/lend_process.jsp">产品中心</a></dd>
							<dd><a href="../infomation/list2">风险教育</a></dd>
							<dd><a href="/yingpu/pc/infomation/aboutUs/contacts_us.html">联系我们</a></dd>
						</dl>
						<dl>
							<dt>常见问题</dt>
							<dd><a href="../infomation/help.html">帮助中心</a></dd>
							<!-- <dd><a href="../html/appload.jsp">APP下载</a></dd> -->
							<dd><a href="/yingpu/pc/infomation/Novice_boot.html">新手引导</a></dd>
							<dd><a class="help" href="javascript:;" onclick="doyoo.util.openChat('g=10075903');return false;">在线客服</a></dd>
						</dl>
						
					</div>
				</div>
			</div>
		</div>
		
		
		<!--客服悬浮条-->
		<!-- <iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		 -->
		<!--底部导航-->
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;position: absolute;top: 552px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" charset="utf-8" src="http://lead.soperson.com/20003063/10087323.js"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		<script type="text/javascript">
			 $(function(){
				var timer = setInterval(function(){
					$('#doyoo_panel').css({"top":"-180px","display":"none"});
					$('#talk99_message').hide();
					$("#doyoo_f_chat").css("cssText", "display:none !important;");
				},0);
				setTimeout(function(){
					clearInterval(timer);
				},5000);
				
			});	
				
			var $this;
			$('ul').on('mouseover', 'li', function() {
				$(this).parents('.main').find('img').attr('src', $(this).attr('pic'));
			})
			.find('li:eq(0)').trigger('mouseover');
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
