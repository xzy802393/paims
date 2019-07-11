<%@page language="java" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8" />
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="my-invest/css/commonfu.css"/>
		<link rel="stylesheet" type="text/css" href="my-invest/css/gongxinbao.css"/>
		<link rel="stylesheet" type="text/css" href="my-invest/css/swiper-3.4.2.min.css"/>
		<style>
			body{
				position: relative;
				left:0;
				top:0;
			}
			.iframe-headfu{
				position: absolute;
				left:0;
				top:0;
				z-index:1000;
			}
			#content{
				position: absolute;
				left:50%;
				top:110px;
				margin-left:-600px;
				z-index:1500;
			}
			 .iframe-foot{
                position: absolute;
                left:0;
                top:0px;
                z-index:1000;
            }
		</style>
	</head>
	<body>
		<!-- 导航 -->
		<iframe src="my-invest/headfu.html" class="iframe-headfu" width="100%" scrolling="no"  style="border:0px;display: block;z-index:1000"></iframe>
		<div id="content">
			<div class="nav-bar">
				<p>您当前所在的位置：<a href="/"> 九趣贷 </a> &gt; <a href="">我要出借</a> &gt; <a class="now">工薪宝1908108期 </a></p>
			</div>
			<div class="clearFix contentgxb">
				<div class="left">
					<div class="box">
						<p class="title">编号：<span class="name">工薪宝1908108期 </span></p>
						<ul class="xiangmu">
							<li class="line1">
								<span class="nianhua">
									<p class="num1"><em class="shuzi">11.00</em>%</p>
									<p class="text">预期年化收益率</p>
								</span>
								<span class="qixian">
									<p class="num"><em class="shuzi">12</em>个月</p>
									<p class="text">服务期限</p>
								</span>
								<span class="edu">
									<p class="num" style="text-align: center;"><em class="shuzi">8</em>号</p>
									<p class="text">每月出借日</p>
								</span>
							</li>
							<li class="line4">
								
								<div class="a4 clearFix">
									<p class="gxb">
										<span class="zuo">月出借金额：</span>
										<span class="you">500元-20,000元</span>
									</p>
									<p class="gxb">
										<span class="zuo">到期日：</span>
										<span class="you">2020年01月08日</span>
									</p>
									<p class="gxb">
										<span class="zuo">利息处理方式：</span>
										<span class="you">循环出借</span>
									</p>
								</div>
								
							</li>
							
						</ul>
						
					</div>
				</div>
				<div class="right">
					<div class="box">
						<p class="p1"><span class="keyong clearFix">可用余额：<a href="" class="login">登录</a>后可见</span><a class="chongzhi"><img src="my-invest/img/chongzhiBtn.png" ></a></p>
						<p class="p2"><span class="wenzi clearFix">出借金额：</span><span type="text" class="money"><span class="jian">-</span><span class="num"><input type="text" value="10000"></span> 元<span class="jia">+</span></span></p>
						<p class="p3 clearFix"><span class="wenzi">预期收益：</span><span class="money"><span class="num">170/200</span>人</span></p>
						
						<p class="p5"><a href="" class="chujie"><img src="my-invest/img/btn-shouquanchujie.png" alt=""></a></p>
						<p class="p6 clearFix">
							<input type="checkbox" name="" id="agreeText" value="agree" checked="checked">
							<lable for="agreeText">已阅读并同意<a href="javascript:void(viewLicense(0));">《网络借贷风险和禁止性行为提示书》</a>、<a href="javascript:void(viewLicense(1));">《资金来源合法承诺书》</a>、<a href="">《薪享190108期-1协议(范本》</a></lable>
						</p>
					</div>
				</div>
			</div>
			<div class="content2">
				<ul class="neirong clearFix">
					<li><img src="my-invest/img/gxb-zhu.png" alt=""></li>
					<li>
						<p class="p1">发挥时间力量，小钱积累梦想</p>
						<p class="p2">500-20,000元，每月固定出借金额到期退出后可攒6,000-240,000元</p>
					</li>
					<li>
						<p class="p1">每月出借，积少成多</p>
						<p class="p2">资金高度利用，利息循环出借扣费后年利率8%以上</p>
					</li>
					<li>
						<p class="p1">发挥时间力量，小钱积累梦想</p>
						<p class="p2">每日上午10.00开放</p>
					</li>
				</ul>
				
			</div>
		</div>
		<!--底部-->
		<iframe src="./footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;display: block;"></iframe>
		
		<script src="my-invest/js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="my-invest/js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="my-invest/js/my-invest.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			window.onload = function(){
				$('#content').mouseover(function(){
					$('#content').css('z-index','3000');
				})
				$('#content').mouseout(function(){
					$('#content').css('z-index','0');
				})
				console.log($('.iframe-headfu').contents().find('.xiala'))
				$('.iframe-headfu').contents().find('.xiala').mouseover(function(){
					$('.iframe-headfu').css('z-index','3000');
					$('.iframe-headfu').css('height','353px');
				})
				$('.iframe-headfu').contents().find('.xiala').mouseout(function(){
					$('.iframe-headfu').css('z-index','0');
					$('.iframe-headfu').css('height','110px');
				})
			}
				
			
		</script>
	</body>
</html>
