<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>营普金服-首页</title>
		<link rel="stylesheet" type="text/css" href="css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="css/common.css"/>
		<link rel="stylesheet" type="text/css" href="css/jquery.lineProgressbar.css"/>
		<link rel="stylesheet" type="text/css" href="css/swiper-3.4.2.min.css"/>
		<!--<link rel="stylesheet" type="text/css" href="css/idangerous.swiper.css"/>-->
		<link rel="stylesheet" type="text/css" href="css/first.css"/>
		
		<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		<div class="header">
			<div class="header-top">
				<div class="center">
					<div class="contact left">
						<p>服务热线：400-9690-900</p>
						<a href="#" class="tel"><img src="img/images/head-tel_03.png"/></a>
						<a href="#" class="weixin"><img src="img/images/head-weixin_03.png"/></a>
						<a href="#" class="weibo"><img src="img/images/head-weibo_03.png"/></a>
					</div>
					
					<div class="nav right">
						<ul class="nav-item clearfix">
							<li class="app"><a href="" class="org"><img src="img/head-phone.png"/> 手机APP</a></li>
							<li><a href="#" class="org"><img src="img/head-vip.png"/> 个人中心 <img class="pull" src="img/head-pull.png" /></a></li>
							<li><a href="#">帮助中心</a></li>
							<li><a href="#">活动中心</a></li>
							<li><a href="#" class="bold">登录</a></li>
							<li><a href="#" class="bold">注册</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="header-nav">
				<div class="center clearfix">
					<div class="logo left">
						<img src="img/logo.png"/>					
					</div>
					<div class="logo-text left">
						<p class="red">新金融倡导者</p>
						<p class="black">营创智慧金融，普享财富人生</p>
					</div>
					
					<div class="nav right">
						<ul class="nav-list">
							<li><a href="index.html" class="active">首页</a></li>
							<li><a href="html/invest.html">我要投资</a></li>
							<li><a href="#">我要借款</a></li>
							<li><a href="#">安全保障</a></li>
							<li><a href="#">信息披露</a></li>
							<li><a href="#" class="account"><img src="img/account.png"/> 我的账户</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!--主体-->
		<div class="main">
			<!--banner-->
			<div class="banner">
				<ul class="imgList">
					<li><a href="#"><img src="img/banner.jpg"/></a></li>
					<li><a href="#"><img src="img/banner.jpg"/></a></li>
					<li><a href="#"><img src="img/banner.jpg"/></a></li>
					<li><a href="#"><img src="img/banner.jpg"/></a></li>
					<li><a href="#"><img src="img/banner.jpg"/></a></li>
				</ul>
				
				<!--分页器-->
				
				
				
				<div style="width: 1200px;position: relative;left: 50%;margin-left: -600px;">
					
					<ul class="indexList">
						<li class="indexOn">银行存管</li>
						<li style="width: 120px;">注册送688元红包</li>
						<li>安全保障</li>
						<li>2016年运营报告</li>
						<li>投资送iphone8</li>
					</ul>
					<div class="login-box">
						<h4>预期年化收益率</h4>
						<p class="rate">6%-12%</p>
						<p class="active"><a href="#">注册就送688元大礼包</a></p>
						<p class="login-btn"><a href="#">立即登录</a></p>
					</div>
				
				</div>				
			</div>
			
			<!--主体部分-->
			
			<div class="center">
				<!--平台公告-->
				<div class="notice clearfix">
					<div class="notice-l left">						
						<div>
							<p class="icon"><span class="notice-icon"></span>平台公告：</p>
							<div class="scroll-ad" id="scrollAd">
								<a href="#">营普金服正式签约重庆富民银行银行存管</a>
								<a href="#">营普金服正式签约重庆富民银行银行存管</a>
								<a href="#">营普金服正式签约重庆富民银行银行存管</a>
								<a href="#">营普金服正式签约重庆富民银行银行存管</a>
							</div>
						</div>
					</div>
					<div class="notice-r right">
						<a href="#">更多 &gt;&gt;</a>
					</div>
				</div>
				
				<!--动态数据-->
				
				<div class="data">
					<ul class="data-item">
						<li class="list">
							<p class="num"><span id="data01">111,111,220.00</span><span class="small"> 元</span></p>
							<p class="des">累计成交</p>
						</li>
						<li class="center-line"><span class="line"></span></li>
						<li class="list">
							<p class="num"><span id="data02">325,678</span><span class="small"> 元</span></p>
							<p class="des">赚取收益</p>
						</li>
						<li class="center-line"><span class="line"></span></li>
						<li class="list">
							<p class="num"><span id="data03">123,45</span><span class="small"> 人</span></p>
							<p class="des">收获用户</p>
						</li>
						<li class="center-line"><span class="line"></span></li>
						<li class="list">
							<p class="num"><span id="data04">950</span><span class="small"> 天</span></p>
							<p class="des">安全运营</p>
						</li>
					</ul>
				</div>
				
				<!--广告图片-->
				<div class="ad-pic">
					<a href="#"><img src=""/></a>
					<a href="#" class="middle"><img src=""/></a>
					<a href="#"><img src=""/></a>
				</div>
				
				<!--平台性能图标-->
				<div class="pro-icon">
					<ul class="clearfix">
						<li>
							<a href="#">
								<img src="img/pro-icon-1.png"/>
								<h4>银行存管</h4>
								<p>全民普惠，新金融倡导者</p>
							</a>							
						</li>
						<li>
							<a href="#">
								<img src="img/pro-icon-2.png"/>
								<h4>安全保障</h4>
								<p>专业风控，甄选优质项目</p>
							</a>							
						</li>
						<li>
							<a href="#">
								<img src="img/pro-icon-3.png"/>
								<h4>智能投资</h4>
								<p>小额分散，有效控制风险</p>
							</a>							
						</li>
						<li>
							<a href="#">
								<img src="img/pro-icon-4.png"/>
								<h4>数据安全</h4>
								<p>电子合同，保障合法权益</p>
							</a>							
						</li>
					</ul>
				</div>
				
				<!--新手推荐-->
				<div class="novice">
					<div class="novice-rec left">
						<img class="transition3" src="img/novice-rec-pic.png"/>
						<h3>新手推荐</h3>
					</div>
					
					<!--可复用的项目情况-->
					<div class="project-bg left" style="height: 204px;">
						<div class="project left">
							<p class="project-title">
								<a href="#">【新手专享】
								    <span class="time">20170921-1</span>
								</a>
								<i>超短期，更灵活</i>
								<span class="jian"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar1" class="progress-bar"></div>							
							</div>
							<a href="html/invest_project.html" class="invest-btn left">立即投资</a>
						</div>
					<div class="novice-rec-pic left">
						
					</div>
					</div>
				</div>
				
				<!--车贷融-->
				
				<div class="car-loan">
					<div class="car-loan-f left">
						<img src="img/car-loan-bg.jpg"/>
						<h3>车贷融</h3>
						<div class="text-box">
							<p>100%足值实物</p>
							<p>双重评估审核</p>
							<a href="#" class="more-btn">更多项目</a>
						</div>
						<img src="img/car-loan-1.png" class="car-pic"/>
					</div>
					
					<!--可复用的项目情况-->
					<div class="project-bg left">
						
						<!--第一个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【车贷融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="che"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar2" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
						<!--竖线-->
						<span class="vertical-line left"></span>
						
						<!--第二个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【车贷融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="che"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar3" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
						<!--水平线-->
						<span class="level-line left"></span>
						<span class="level-line left"></span>
						
						<!--第三个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【车贷融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="che"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar4" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
						<!--竖线-->
						<span class="vertical-line left"></span>
						
						<!--第四个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【车贷融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="che"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar5" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
					</div>
					
				</div>
				
				<!--房贷融-->
			
				<div class="house-loan">
					<div class="house-loan-f left">
						<img src="img/house-loan-bg.jpg"/>
						<h3>房贷融</h3>
						<img src="img/house-loan-1.png" class="house-pic transition3" style="left: -10px;"/>
						<div class="text-box">
							<p>真实房源</p>
							<p>全程监管</p>
							<a href="#" class="more-btn">更多项目</a>
						</div>
						
						<img src="img/images/house-loan-2_02.png" class="house-bg"/>
					</div>
					
					<!--可复用的项目情况-->
					<div class="project-bg left">
						
						<!--第一个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【房贷融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="fang"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar6" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
						<!--竖线-->
						<span class="vertical-line left"></span>
						
						<!--第二个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【房贷融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="fang"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar7" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
						<!--水平线-->
						<span class="level-line left"></span>
						<span class="level-line left"></span>
						
						<!--第三个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【房贷融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="fang"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar8" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
						<!--竖线-->
						<span class="vertical-line left"></span>
						
						<!--第四个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【房贷融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="fang"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar9" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
					</div>
					
				</div>
				
				<!--优企融-->
				
				<div class="enterprise-loan">
					<div class="enterprise-loan-f left">
						<img src="img/enterprise-loan-bg.jpg" class="transition3"/>
						
						<h3>优企融</h3>
						<div class="text-box">
							<p>优选企业</p>
							<p>服务小微</p>
							<a href="#" class="more-btn">更多项目</a>
						</div>
												
					</div>
					
					<!--可复用的项目情况-->
					<div class="project-bg left">
						
						<!--第一个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【优企融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="qi"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar3-1" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
						<!--竖线-->
						<span class="vertical-line left"></span>
						
						<!--第二个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【优企融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="qi"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar3-2" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
						<!--水平线-->
						<span class="level-line left"></span>
						<span class="level-line left"></span>
						
						<!--第三个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【优企融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="qi"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar3-3" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
						<!--竖线-->
						<span class="vertical-line left"></span>
						
						<!--第四个项目-->
						<div class="project left">
							<p class="project-title">
								<a href="#">【优企融】
								    <span class="time">20170921-1</span>
								</a>
								<!--<i>超短期，更灵活</i>-->
								<span class="qi"></span>
								<span class="quan"></span>
							</p>
							<ul class="project-item clearfix">
								<li>
									<p><span class="large" id="rate">10</span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
								</li>
								<li>
									<p><span class="large" id="term">3</span><span class="small">个月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">20</span><span class="small">万元</span> </p>
									<p>借款额度</p>
								</li>
							</ul>
							<div class="project-schedule left">
								<div id="progressBar3-4" class="progress-bar"></div>							
							</div>
							<a href="" class="invest-btn left">立即投资</a>
						</div>
					</div>
					
				</div>
				
				<!--新闻公告-->
				
				<div class="news">
					<div class="news-item left">
						<div class="news-title">
							<span class="title">平台公告</span>
							<a href="#" class="more">更多&gt;&gt;</a>	
						</div>
						
						<div class="news-content clearfix">
							<img src="" style="width: 282px;height: 194px;float: left;"/>
							<ul class="news-list left">
								<li><a href="" class="red">营普金服正式签约重庆富民银行存管营普金服正式签约重庆富民银行存管...</a></li>
								<li><a href="">营普金服正式签约重庆富民银行存管营普金服正式签约重庆富民银行存管...</a></li>
								<li><a href="">营普金服正式签约重庆富民银行存管营普金服正式签约重庆富民银行存管...</a></li>
							</ul>
						</div>
						
					</div>
					<div class="news-item left">
						<div class="news-title">
							<span class="title">平台公告</span><span class="title2">行业新闻</span>
							<a href="#" class="more2">更多&gt;&gt;</a>	
						</div>
						
						<div class="news-content clearfix">
							<img src="" style="width: 282px;height: 194px;float: left;"/>
							<ul class="news-list left">
								<li><a href="" class="red">营普金服正式签约重庆富民银行存管营普金服正式签约重庆富民银行存管...</a></li>
								<li><a href="">营普金服正式签约重庆富民银行存管营普金服正式签约重庆富民银行存管...</a></li>
								<li><a href="">营普金服正式签约重庆富民银行存管营普金服正式签约重庆富民银行存管...</a></li>
							</ul>
						</div>	
					</div>
				</div>
				
				
				
			</div>
			
			<!--合作机构-->
			<div class="partner">
				<h3>合作机构</h3>
				<div class="swiper-container">
				    <div class="swiper-wrapper" >
				        <div class="swiper-slide"><img src="img/xiamen-bank.png"/></div>
				        <div class="swiper-slide"><img src="img/wangdaizhijian.png"/></div>
				        <div class="swiper-slide"><img src="img/wangdaitianyan.png"/></div>
				        <div class="swiper-slide"><img src="img/china-taiping.png"/></div>
				        <div class="swiper-slide"><img src="img/bairongjinfu.png"/></div>
				        <div class="swiper-slide"><img src="img/tongdunkeji.png"/></div>
				        <div class="swiper-slide"><img src="img/xiamen-bank.png"/></div>
				        <div class="swiper-slide"><img src="img/xiamen-bank.png"/></div>
				        <div class="swiper-slide"><img src="img/xiamen-bank.png"/></div>
				    </div>  
				</div>
				
				<!-- 如果需要导航按钮 -->
			    <div class="swiper-button-prev"></div>
			    <div class="swiper-button-next"></div>
			</div>
		</div>
		
		<!--底部导航-->
		<div class="footer">
			<div class="center clearfix">
				<div class="footer-nav left">
					<ul class="list">
						<li>关于营普
							<ul>
								<li><a href="#">平台简介</a></li>
								<li><a href="#">高管团队</a></li>
								<li><a href="#">运营报告</a></li>
							</ul>
						</li>
						<li>安全保障
							<ul>
								<li><a href="#">风控措施</a></li>
								<li><a href="#">银行存管</a></li>
								<li><a href="#">政策法规</a></li>
							</ul>
						</li>
						<li>帮助中心
							<ul>
								<li><a href="#">新手引导</a></li>
								<li><a href="#">常见问题</a></li>
								<li><a href="#">网站地图</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="line left"></div>
				<div class="footer-contact left">
					<p class="title">全国免费电话</p>
					<p class="num">400-969-1811</p>
					<p class="time">(工作时间:9:00-20:00)</p>
				</div>
				<div class="line left"></div>
				<div class="footer-code left">
					<ul>
						<li>营普金服服务号
							<img src=""/>
						</li>
						<li>营普金服APP
							<img src=""/>
						</li>
						<li>营普金服客服微信
							<img src=""/>
						</li>
					</ul>
				</div>
			</div>
			<div class="footer-bottom">
				<div class="footer-bottom-pic">
					<a href="#"><img src="img/footer-2.1.png"/></a>
					<a href="#"><img src="img/footer-2.2.png"/></a>
					<a href="#"><img src="img/footer-2.3.png"/></a>
				</div>
				<div class="footer-bottom-txt">
					<p>© 2016-2017上海营夏财富投资管理有限公司 All rights reserved | 沪ICP备15044282号-1</p>
					<p>市场有风险，投资需谨慎</p>
				</div>
			</div>
		</div>
		
		<!--加载js文件-->
		<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
	<!--<script src="js/idangerous.swiper.min.js" type="text/javascript" charset="utf-8"></script>-->
		<script src="js/countUp.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/first.js" type="text/javascript" charset="utf-8"></script>
		

		
	</body>
</html>
