<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

	String[][] status = {
			{"", ""},
			{"敬请期待", "invest-btn orange", ""},
			{"立即出借", "invest-btn", ""},
			{"还款中", "invest-btn gray", "project-false ysk"},
			{"已还款", "invest-btn gray", "project-false yhk"},
			{"满标待审", "invest-btn green", ""}
	};


	String[] pTypes = {
			"", "", "", "", "", "", "", "", "", "", "", "", "",
			"che", "qi", "fang"
	};

	request.setAttribute("status", status);
	request.setAttribute("types", pTypes);
	request.setAttribute("isLogin", request.getSession().getAttribute("pcuser") != null);

%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8" />
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<meta name="Description" content="九趣贷 — 贷快乐，更带梦想"/>
		<meta name="Keywords" content="九趣贷,jiuqudai,九趣,jiuqu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" >
		<meta name="renderer" content="webkit">
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="newpc/css/common.css"/>
		<link rel="stylesheet" type="text/css" href="newpc/css/swiper-3.4.2.min.css"/>
		<link rel="stylesheet" type="text/css" href="newpc/css/indexfu.css"/>
		
		
		<style type="text/css">
			html{
				position: relative;
			}
			.fix{
				position: fixed;
				top:0;
				left:0;
				width:100%;
				z-index:13;
				background: #fff;
				display: none;
				color:#171717;
			}
			.fix #header .bottom .left a,
			.fix #header .bottom .right a{
				color:#171717;
				letter-spacing: 1px;
			}
			.fix #header{
			/* 	max-width: 1920px;
				min-width: 1200px; */
				width:100%;
				height: 58px;
				border:1px solid #eee;
				margin:0 auto;
			}
			.fix #header .bottom .right a:hover{
				font-weight:bold;
			}
			.fix #header .bottom .right .mac:hover{
				font-weight:bold;
				color:#537ce4;
			}
			.fix .kuangfix,
			.fix .kuangchujie{
				max-width: 1920px;
			  	min-width: 1200px;
				height:30px;
				background: #fff;
				margin:0 auto;
				display: none;
			}

			.fix .kuangfix ul,
			.fix .kuangchujie ul{
				width:1200px;
				margin:0 auto;

			}
			.fix .kuangfix ul li,
			.fix .kuangchujie ul li{
				float:left;
				/*width:76px;*/
				height:30px;
				padding:0 10px;
			}
			.fix .kuangfix ul li:nth-of-type(1),
			.fix .kuangchujie ul li:nth-of-type(1){
				padding-left:400px;
			}
			.fix .kuangfix ul li a,
			.fix .kuangchujie ul li a{
				display: block;
				color: #333;
			    font-size:14px;
			    line-height:30px;
			    padding: 0;
			}
			.fix .kuangfix ul li a:hover,
			.fix .kuangchujie ul li a:hover{
				color:#537ce4;
			}
			.hezuo .swiper-container-free-mode>.swiper-wrapper {
			    -webkit-transition-timing-function: linear; /*之前是ease-out*/
			    -moz-transition-timing-function: linear;
			    -ms-transition-timing-function: linear;
			    -o-transition-timing-function: linear;
			    transition-timing-function: linear;
			    margin: 0 auto;
			}
		</style>
	</head>
	<body>
		<div class="fix">
				<div id="header">
						<div class="bottom clearFix">
								<div class="left">
									<a href="javascript:tiaozhuan('index');"><img src="img/logofu.png" alt="九趣贷" class="logo"></a>
									<img src="img/logoRightfu.png" alt="介绍" class="logoRight">
								</div>
								<div class="right">
										<ul class="nav clearFix">
											<li><a href="javascript:tiaozhuan('index');">首页</a></li>
											<li><a href="javascript:tiaozhuan('project/findProject');">我要出借</a></li>
											<li><a href="javascript:tiaozhuan('html/my-borrow/borrow.html');">我要借款</a></li>
											<li><a href="javascript:tiaozhuan('html/safe/safe.html');">安全保障</a></li>
											<li class="xiala"><a href="javascript:tiaozhuan('html/aboutUs/platform_intro.html');">信息披露<img src="img/pull.png" alt="下拉菜单" class="pull"></a></li>
											<li style="float:right;padding-right:0;" id="zhanghu"><img class="person" src="/yingpu/pc/newpc/img/small-person.jpg" style="display: inline-block;width:17px;height:17px;padding-right:4px;margin-top:-2px;"><a href="javascript:tiaozhuan('myaccount/account');" class="mac">我的账户</a></li>
										</ul>
								</div>
						</div>
					</div>
					<div class="kuangfix" style="display: none;">
						<ul class="clearFix">
							<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/aboutUs/message.html');">信披声明</a></li>
							<li  class="pulllist"><a href="javascript:tiaozhuan('html/aboutUs/platform_intro.html');">平台简介</a></li>
							<!-- <li  class="pulllist"><a href="javascript:tiaozhuan('infomation/operation_data.html');">运营数据</a></li> -->
							<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/list');">平台动态</a></li>
							<!-- <li  class="pulllist"><a href="javascript:tiaozhuan('active_center');">活动中心</a></li> -->
							<li  class="pulllist"><a href="javascript:tzurl('/html/product-center/center.html');">产品中心</a></li>
							 <li  class="pulllist"><a href="javascript:tiaozhuan('infomation/list2');">风险教育</a></li>
							<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/aboutUs/contacts_us.html');">联系我们</a></li>
						</ul>
					</div> 
                   <div class="kuangchujie" style="display: none;">
                        <ul class="clearFix">
							<li  class="pulllist"><a href="javascript:tzurl('/project/findProject')">新手专享</a></li>
							<li  class="pulllist"><a href="javascript:tiaozhuan('my-invest/zhiTou.jsp');">X快享智能投标</a></li>
							<li  class="pulllist"><a href="javascript:tzurl('/project/list');">散标</a></li>
							<li  class="pulllist"><a href="javascript:tzurl('/project/findZhai');">债权转让</a></li>
                        </ul>
                    </div>
		</div>
		<div id="banner">
			<div class="banner">
				
				<!--顶部-->
				<iframe src="/yingpu/pc/newpc/head.html?index=0" class="iframe-head" width="100%" scrolling="no"  style="border:0px;display: block;z-index:1000"></iframe>
				<div class="banner-list">
					<%--<ul class="imgList" style="width: 500%;">
					
						&lt;%&ndash;<li><a href="#"><img src="img/banner.jpg"></a></li>&ndash;%&gt;
							<c:forEach items="${data.lunbo}" varStatus="i" var="o">
								<li><a href="${o.item}"><img src="${o.image}"/></a></li>
							</c:forEach>

						
					</ul> 
					<div class="btn">
						<span class="prev"><img src="img/prev.png" alt=""></span>
						<span class="next"><img src="img/next.png" alt=""></span>
					</div>--%>
						<div class="swiper-container">
							<div class="swiper-wrapper" >
								<%--<c:forEach items="${data.lunbo}" varStatus="i" var="lunbo">--%>
								<%--<div class="swiper-slide"><a href="${lunbo.item}"><img src="${lunbo.image}" alt=""></a></div>--%>
								<%--</c:forEach>--%>

								<!-- <div class="swiper-slide" style="background:#5a7bfc;"><a href="${data.lunbo[0].item}"><img src="${data.lunbo[0].image}" alt=""></a></div>
								<div class="swiper-slide" style="background:#594fe3;"><a href="${data.lunbo[1].item}"><img src="${data.lunbo[1].image}" alt=""></a></div>
								<div class="swiper-slide" style="background:#594fe3;"><a href="${data.lunbo[2].item}"><img src="${data.lunbo[2].image}" alt=""></a></div>
								<div class="swiper-slide" style="background:#594fe3;"><a href="${data.lunbo[3].item}"><img src="${data.lunbo[3].image}" alt=""></a></div> -->

								<!-- <c:forEach items="${data.lunbo}" varStatus="i" var="lunbo">
								<div class="swiper-slide"><a href="${lunbo.item}"><img src="${lunbo.image}" alt=""></a></div>
								</c:forEach> -->
								<%--<div class="swiper-slide" style="background:#5a7bfc;"><a href="#"><img src="img/banner2.jpg" alt=""></a></div>--%>
								<%--<div class="swiper-slide" style="background:#594fe3;"><a href="#"><img src="img/banner3.jpg" alt=""></a></div>--%>
								<%--<div class="swiper-slide" style="background:#594fe3;"><a href="#"><img src="img/banner4.jpg" alt=""></a></div>--%>
								<%--<div class="swiper-slide" style="background:#594fe3;"><a href="#"><img src="img/banner5.jpg" alt=""></a></div>--%>

								<div class="swiper-slide" style="background:#5140b3;"><a href="/yingpu/pc/infomation/Feb_activity/invite-friends-new/index.html"><img src="/yingpu/pc/newpc/img/banner-invite.jpg" alt=""  ondragstart="return false" oncontextmenu="return false"></a></div>
								<div class="swiper-slide" style="background:#021233;"><a href="/yingpu/pc/infomation/detail?id=34&type=companystate"><img src="/yingpu/pc/newpc/img/banner-xukezheng.jpg" alt="" ondragstart="return false" oncontextmenu="return false"></a></div>
								<div class="swiper-slide" style="background:#01032c;"><a href="/yingpu/pc/active-19/19-7/huodong/index.html"><img src="/yingpu/pc/newpc/img/banner-7-fanli.jpg" alt="" ondragstart="return false" oncontextmenu="return false"></a></div>
                                <div class="swiper-slide" style="background:#fc5c3c;"><a href="/yingpu/pc/active-19/19-6/hongbao/index.html"><img src="/yingpu/pc/newpc/img/banner-6-hongbao.jpg" alt=""  ondragstart="return false" oncontextmenu="return false"></a></div>
								<div class="swiper-slide" style="background:#fe4b47;"><a href="/yingpu/pc/pointsmall/points_mall.jsp"><img src="/yingpu/pc/newpc/img/banner-jiuqu.jpg" alt="" ondragstart="return false" oncontextmenu="return false"></a></div>
								<div class="swiper-slide" style="background:#27272f;"><a href="/yingpu/pc/html/level/level.html"><img src="/yingpu/pc/newpc/img/banner-vip.jpg" alt="" ondragstart="return false" oncontextmenu="return false"></a></div>
							</div>
						</div>
						<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div>
				</div>

				<!--分页器
				<!-- <div style="width: 1200px;position: absolute;left: 50%;top:0;margin-left: -600px;z-index: 10;"> -->
					
					<!-- <ul class="indexList">

					
						<li class="">冬日温暖红包</li>
					
						<li class="indexOn">圣诞节抽奖</li>
					
						<li class="">邀请好友</li>
					
						<li class="">运营报告</li>
					
						<li class="">营普客栈</li>
					
					</ul> -->
					
					<!--登录之前-->
					<!--登录之前-->

					<c:if test="${empty pcuser}">
						<div class="login-box">
							<h4>预期年化收益率</h4>
							<p class="rate">7%-15%</p>
							<p class="active"><a href="../pc/register">注册送新手特权福利</a></p>
							<p class="login-btn">已有账户？<a href="../pc/login">立即登录</a></p>
						</div>
					</c:if>
					<!--登录之后-->
					<!--登录之后-->
				<c:if test="${not empty pcuser}">
					<div class="login-ok-box">
						<h4>尊敬的${pcuser.userCode}，您好<!-- <span id="wenhou"></span> --></h4>
						<div class="yue">
							<p>可用余额</p>
							<%--<p><span>0.0元</span></p>--%>
							<p><span id="yue">${pcuser.caBalance}</span></p>
						</div>
						<!-- <p class="deposit-btn"><a href="#">去充值</a></p> -->
						<p class="myaccount"><a href="myaccount/account">进入我的账户</a></p>
					</div>
				</c:if>
					<div class="banner-tishi">
						<p>广告 <span class="xian"></span> 市场有风险，投资需谨慎</p>
					</div>
					
				</div>				
			</div>
		</div>
		<div id="content">
			<div id="piaofu">
				<div class="piaofuLayout" class="clearFix">
					<div class="piaofuleft">
						<img src="/yingpu/pc/newpc/img/duilianL.png" >
					</div>
					<div class="piaofucenter">
						<div class="content1">
							
							<div class="ceng">
								<ul class="xinxi clearFix">
									<li class="clearFix">
										<img src="/yingpu/pc/newpc/img/cunguan.png" alt="存管银行">
										<div class="wenben">
											<p class="text1">银行存管</p>
											<p class="text2">全民普惠，新金融倡导</p>
										</div>
										
									</li>
									<li class="clearFix">
										<img src="/yingpu/pc/newpc/img/anquan.png" alt="存管银行">
										<div class="wenben">
											<p class="text1">数据安全</p>
											<p class="text2">电子合同，保障合法权益</p>
										</div>
										
									</li>
									<li class="clearFix">
										<img src="/yingpu/pc/newpc/img/bank.png" alt="存管银行">
										<div class="wenben">
											<p class="text1">多样项目</p>
											<p class="text2">精选优质的标的产品</p>
										</div>
										
									</li>
									<li class="clearFix">
										<img src="/yingpu/pc/newpc/img/anquan2.png" alt="存管银行">
										<div class="wenben">
											<p class="text1">严格风控</p>
											<p class="text2">专业风控，甄选优质项</p>
										</div>
										
									</li>
									<li class="clearFix">
										<img src="/yingpu/pc/newpc/img/hegui.png" alt="存管银行">
										<div class="wenben">
											<p class="text1">合规透明</p>
											<p class="text2">标的资料信息透明</p>
										</div>	
									</li>
									<li class="clearFix">
										<img src="/yingpu/pc/newpc/img/yunying.png" alt="存管银行">
										<div class="wenben">
											<p class="text1">稳健运营</p>
											<p class="text2">多重保障措施确保运营安全</p>
										</div>
										
									</li>
								</ul>
							</div>
							<div class="annoce clearFix">
								<div class="left">
									<img src="img/laba.png" alt="公告">
									<p>平台公告</p>
								</div>
								<div class="center" id="annoceCenter">
									<ul class="clearFix">
										<li><a href="javascript:ggdea(${data.gonggao[0].id});">${data.gonggao[0].title}</a></li>
										<li><a href="javascript:ggdea(${data.gonggao[1].id});">${data.gonggao[1].title}</a></li>
										<li><a href="javascript:ggdea(${data.gonggao[2].id});">${data.gonggao[2].title}</a></li>
									</ul>
									<ul class="clearFix">
										<li><a href="javascript:ggdea(${data.gonggao[3].id});">${data.gonggao[0].title}</a></li>
										<li><a href="javascript:ggdea(${data.gonggao[4].id});">${data.gonggao[1].title}</a></li>
										<li><a href="javascript:ggdea(${data.gonggao[5].id});">${data.gonggao[2].title}</a></li>
									</ul>
									<ul class="clearFix">
										<li><a href="javascript:ggdea(${data.gonggao[6].id});">${data.gonggao[0].title}</a></li>
										<li><a href="javascript:ggdea(${data.gonggao[7].id});">${data.gonggao[1].title}</a></li>
										<li><a href="javascript:ggdea(${data.gonggao[8].id});">${data.gonggao[2].title}</a></li>
									</ul>
								</div>
								<div class="more">
									<a href="infomation/list?type=announce">查看更多</a>
								</div>
							</div>
							
						</div>
						<!-- 数据 -->
						<!-- <div class="content2">
							<ul class="data clearFix">
								<li>累计成交<span class="chengjiao"></span>元</li>
								<li>赚取收益<span class="shouyi"></span>元</li>
								<li>收获用户<span class="people"></span>人</li>
								<li>安全运营<span class="day"></span>天</li>
							</ul>
						</div> -->
						<!-- 新手专区，精彩活动，营普金服APP -->
						<div class="content3">
							<div class="box">
								<h3 class="title">新手专区<span>新注册用户，限一个月内使用新手专享，逾期作废！</span><span id="tishi" onmouseover="show('tishi')" onmouseout="hide()">!</span></h3>
								<ul class="neirong clearFix">
									<li>
										<div class="kuang">
											<p class="bt"><a  href="${isLogin ?
						                            ((data.xinren[0].status != 4) ?
						                                    '/yingpu/pc/projectdetails?projectid='.concat(data.xinren[0].id)
						                                    : 'javascript:void(viewEndedProjectPrompt())')
						                            : (data.xinren[0].status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(data.xinren[0].id)
						                                                 :'javascript:void(viewWithoutLoginPrompt())')}" class="btfu">${data.xinren[0].name}</a></p>
											<div class="zhong clearFix">
												<div class="left">
													<p class="p1"><span class="num"><fmt:formatNumber type="number" value="${data.xinren[0].estimatedAnnualRate*100}" pattern="0.0" maxFractionDigits="2"/></span>%</p>
													<p class="p2">预期年化收益率</p>
												</div>
												<div class="right">
													<p class="p1"><span class="num">${data.xinren[0].deadLine}</span>个月</p>
													<p class="p2">服务期限</p>
												</div>
											</div>
											<div class="xia clearFix">
												<div class="left">
													<p class="p3">出借进度：<fmt:formatNumber type="number" value="${(data.xinren[0].totalAmount-data.xinren[0].financingAmount)/data.xinren[0].totalAmount *100}" pattern="0.00" maxFractionDigits="2"/>%</p>
													<div class="progress">
														<span class="jindu"><span totalAmount="${data.xinren[0].totalAmount}" financingAmount="${data.xinren[0].financingAmount}" class="tuli"></span></span>
													</div>
												</div>
												<div class="right">
													<p class="chujie"><a href="${isLogin ?
						                            ((data.xinren[0].status != 4) ?
						                                    '/yingpu/pc/projectdetails?projectid='.concat(data.xinren[0].id)
						                                    : 'javascript:void(viewEndedProjectPrompt())')
						                            : (data.xinren[0].status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(data.xinren[0].id)
						                                                 :'javascript:void(viewWithoutLoginPrompt())')}"
																		 class="${status[data.xinren[0].status][1]}">${status[data.xinren[0].status][0]}</a></p>
												</div>
											</div>
										</div>
										
									</li>
									<li>
										<div class="kuang">
											<p class="bt"><a href="${isLogin ?
						                            ((data.xinrenThree[0].status != 4) ?
						                                    '/yingpu/pc/projectdetails?projectid='.concat(data.xinrenThree[0].id)
						                                    : 'javascript:void(viewEndedProjectPrompt())')
						                            : (data.xinrenThree[0].status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(data.xinrenThree[0].id)
						                                                 :'javascript:void(viewWithoutLoginPrompt())')}" class="btfu">${data.xinrenThree[0].name}</a></p>
											<div class="zhong clearFix">
												<div class="left">
													<p class="p1"><span class="num"><fmt:formatNumber type="number" value="${data.xinrenThree[0].estimatedAnnualRate*100}" pattern="0.0" maxFractionDigits="2"/></span>%</p>
													<p class="p2">预期年化收益率</p>
												</div>
												<div class="right">
													<p class="p1"><span class="num">${data.xinrenThree[0].deadLine}</span>个月</p>
													<p class="p2">服务期限</p>
												</div>
											</div>
											<div class="xia clearFix">
												<div class="left">
													<p class="p3">出借进度：<fmt:formatNumber type="number" value="${(data.xinrenThree[0].totalAmount-data.xinrenThree[0].financingAmount)/data.xinrenThree[0].totalAmount *100}" pattern="0.00" maxFractionDigits="2"/>%</p>
													<div class="progress">
														<span class="jindu"><span totalAmount="${data.xinrenThree[0].totalAmount}" financingAmount="${data.xinrenThree[0].financingAmount}" class="tuli"></span></span>
													</div>
												</div>
												<div class="right">
													<p class="chujie"><a href="${isLogin ?
						                            ((data.xinrenThree[0].status != 4) ?
						                                    '/yingpu/pc/projectdetails?projectid='.concat(data.xinrenThree[0].id)
						                                    : 'javascript:void(viewEndedProjectPrompt())')
						                            : (data.xinrenThree[0].status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(data.xinrenThree[0].id)
						                                                 :'javascript:void(viewWithoutLoginPrompt())')}"
																		 class="${status[data.xinrenThree[0].status][1]}">${status[data.xinrenThree[0].status][0]}</a></p>
												</div>
											</div>
										</div>
										
									</li>
									<li class="third">
										<div class="a1 clearFix">
											<img src="newpc/img/hbfu.png" alt="红包">
											<div class="wenben">
												<p class="text1">注册领新手福利</p>
												<p class="text2"><a href="javascript:tiaozhuan('register')">立即注册 GO!</a></p>
											</div>
										</div>
										<div class="a1 clearFix">
											<img src="newpc/img/xinshoubidu.png" alt="新手引导" style="width:34px;height:30px;padding-top:38px;">
											<div class="wenben">
												<p class="text1">新手引导</p>
												<p class="text2"><a href="javascript:tiaozhuan('infomation/Novice_boot.html');">点击查看 GO!</a></p>
											</div>
										</div>
									</li>
									<li class="four">
										<div class="bg">
											
											<img src="newpc/img/appbg.jpg" class="bag">
											
											<div class="text">
												<p class="pw">九趣贷</p>
												<p class="pa">手机APP</p>
												<p class="pa1">操作更便捷</p>
											</div>
											<img src="newpc/img/appa.jpg" alt="" class="app">
										</div>
										
									</li>
								</ul>
							</div>
							
						</div>
					</div>
					<div class="piaofuright">
						<img src="/yingpu/pc/newpc/img/duilianR.png" >
					</div>
				</div>
			</div>
			
			<!-- 智能投标 -->
			<!-- <div class="zhitou">
				<div class="box">
					<h3 class="title">智能投标</h3>
					<ul class="neirong clearFix">
						<li>
							<div class="a1">
								<div class="kuang">
									<p class="bt">${data.smart3[0].name}</p>
									<div class="zhong clearFix">
										<div class="left">
											<p class="p1"><span class="num"><fmt:formatNumber type="number" value="${data.smart3[0].interestRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
											<p class="p2">预期年化收益率</p>
										</div>
										<div class="right">
											<p class="p1"><span class="num">${data.smart3[0].deadLine}</span>个月</p>
											<p class="p2">服务期限</p>
										</div>
									</div>
									<div class="xia clearFix">
										<div class="left">
											<p class="p3">出借进度：<fmt:formatNumber type="number" value="${(data.smart3[0].totalAmount-data.smart3[0].remainsAmount)/data.smart3[0].totalAmount *100}" pattern="0.00" maxFractionDigits="2"/>%</p>
											<div class="progress">
												<span class="jindu"><span totalAmount="${data.smart3[0].totalAmount}" financingAmount="${data.smart3[0].remainsAmount}" class="tuli"></span></span>
											</div>
										</div>
										<div class="right">
											<p class="chujie"><a href="/yingpu/pc/my-invest/zhiTou.jsp?deadLine=${data.smart3[0].deadLine}">立即出借</a></p>
										</div>
									</div>
								</div>
							</div>
							<div class="a1">
								<div class="kuang">
									<p class="bt">${data.smart9[0].name}</p>
									<div class="zhong clearFix">
										<div class="left">
											<p class="p1"><span class="num"><fmt:formatNumber type="number" value="${data.smart9[0].interestRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
											<p class="p2">预期年化收益率</p>
										</div>
										<div class="right">
											<p class="p1"><span class="num">${data.smart9[0].deadLine}</span>个月</p>
											<p class="p2">服务期限</p>
										</div>
									</div>
									<div class="xia clearFix">
										<div class="left">
											<p class="p3">出借进度：<fmt:formatNumber type="number" value="${(data.smart9[0].totalAmount-data.smart9[0].remainsAmount)/data.smart9[0].totalAmount *100}" pattern="0.00" maxFractionDigits="2"/>%</p>
											<div class="progress">
												<span class="jindu"><span totalAmount="${data.smart9[0].totalAmount}" financingAmount="${data.smart9[0].remainsAmount}" class="tuli"></span></span>
											</div>
										</div>
										<div class="right">
											<p class="chujie"><a href="/yingpu/pc/my-invest/zhiTou.jsp?deadLine=${data.smart9[0].deadLine}">立即出借</a></p>
										</div>
									</div>
								</div>
							</div>
						</li>
						<li>
							<div class="a1">
								<div class="kuang">
									<p class="bt">${data.smart6[0].name}</p>
									<div class="zhong clearFix">
										<div class="left">
											<p class="p1"><span class="num"><fmt:formatNumber type="number" value="${data.smart6[0].interestRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
											<p class="p2">预期年化收益率</p>
										</div>
										<div class="right">
											<p class="p1"><span class="num">${data.smart6[0].deadLine}</span>个月</p>
											<p class="p2">服务期限</p>
										</div>
									</div>
									<div class="xia clearFix">
										<div class="left">
											<p class="p3">出借进度：<fmt:formatNumber type="number" value="${(data.smart6[0].totalAmount-data.smart6[0].remainsAmount)/data.smart6[0].totalAmount *100}" pattern="0.00" maxFractionDigits="2"/>%</p>
											<div class="progress">
												<span class="jindu"><span totalAmount="${data.smart6[0].totalAmount}" financingAmount="${data.smart6[0].remainsAmount}" class="tuli"></span></span>
											</div>
										</div>
										<div class="right">
											<p class="chujie"><a href="/yingpu/pc/my-invest/zhiTou.jsp?deadLine=${data.smart6[0].deadLine}">立即出借</a></p>
										</div>
									</div>
								</div>
							</div>
							<div class="a1">
								<div class="kuang">
									<p class="bt">${data.smart12[0].name}</p>
									<div class="zhong clearFix">
										<div class="left">
											<p class="p1"><span class="num"><fmt:formatNumber type="number" value="${data.smart12[0].interestRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
											<p class="p2">预期年化收益率</p>
										</div>
										<div class="right">
											<p class="p1"><span class="num">${data.smart12[0].deadLine}</span>个月</p>
											<p class="p2">服务期限</p>
										</div>
									</div>
									<div class="xia clearFix">
										<div class="left">
											<p class="p3">出借进度：<fmt:formatNumber type="number" value="${(data.smart12[0].totalAmount-data.smart12[0].remainsAmount)/data.smart12[0].totalAmount *100}" pattern="0.00" maxFractionDigits="2"/>%</p>
											<div class="progress">
												<span class="jindu"><span totalAmount="${data.smart12[0].totalAmount}" financingAmount="${data.smart12[0].remainsAmount}" class="tuli"></span></span>
											</div>
										</div>
										<div class="right">
											<p class="chujie"><a href="/yingpu/pc/my-invest/zhiTou.jsp?deadLine=${data.smart12[0].deadLine}">立即出借</a></p>
										</div>
									</div>
								</div>
							</div>
						</li>
						<li>
							<div class="a2">
								<div class="kuang">
								
									<p class="p1 clearFix"><span>九趣商城：</span><span>出借送银子礼品兑不停</span></p>
									<p class="p2"><a href="javascript:tiaozhuan('pointsmall/points_mall.jsp');">兑换奖品</a></p>
								</div>
								<div class="kuang">
									<p class="p1 clearFix" style="padding-top:42px;"><span>邀请好友：</span><span>老用户终身享好友预期收益的10%</span></p>
									<p class="p2"><a href="javascript:tiaozhuan('infomation/Feb_activity/invite-friends-new/index.html');">立即邀请</a></p>
								</div>
							</div>
						</li>
					</ul>
				</div>
				
			</div> -->
			<!-- 产品展示 -->
			<div class="content4 clearFix">
				<div class="box">
					<h3><span class="active">散标</span><!-- <em>/</em><span>债权转让</span> --></h3>
					<div class="tab tab1" style="display: block;">
						<ul class="left">
							<li class="list listC"><a href="javascript:xiaofeidai();"><p class="xiangMuList">消费贷</p></a></li>
							<li class="list"><a href="javascript:chedairong();"><p class="xiangMuList">车融贷</p></a></li>
							<li class="list"><a href="javascript:fangdairong();"><p class="xiangMuList">房融贷</p></a></li>
							<li class="list"><a href="javascript:shangqidai();"><p class="xiangMuList">商企贷</p></a></li>
						</ul>
						<ul class="right" id="project">
							<c:if test="${empty data.xiaofeidai}">
								<span style="display: block; font-size: 22px; margin-top: 220px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>
							</c:if>

						<c:if test="${not empty data.xiaofeidai}">
							<c:forEach items="${data.xiaofeidai}" varStatus="i" var="o">
							<li class="list">
								<div class="xiangmu">
									<p class="title"><a  href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="tfu">${o.name}</a></p>
									<div class="detail clearFix" >
										<div class="data">
											<p class="p1"><span class="num">${o.deadLine}</span>个月</p>
											<p class="wenben">借款期限</p>
										</div>
										<div class="nianhua">
											<p class="p2"><span class="num"><fmt:formatNumber type="number" value="${o.estimatedAnnualRate*100}" pattern="0.0" maxFractionDigits="2"/></span>%</p>
											<p class="wenben">预期年化收益率</p>
										</div>
										<div class="total">
											<p class="p1"><span class="num"><fmt:formatNumber type="number" value="${o.totalAmount/10000}" pattern="0.00" maxFractionDigits="1"/></span>万元</p>
											<p class="wenben">借款金额</p>
										</div>
										<div class="progress">
											<p class="jindutiao"><span class="jindu"><span totalAmount="${o.totalAmount}" financingAmount="${o.financingAmount}" class="tuli"></span></span></p>
											<p class="shengyu" surplusValue="${o.financingAmount}">剩余额度:元</p>
										</div>
										<div class="chujie">
											<p class="liji">
								<a href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}"
								class="${status[o.status][1]}">${status[o.status][0]}</a>
											</p>
										</div>
									</div>
								</div>
							</li>
							</c:forEach>
						</c:if>
						</ul>
					</div>
					<div class="tab" style="display: none;"></div>
					<div class="tab tab2" style="display: none;">
						<table border="0" cellspacing="" cellpadding="">
							<tr>
								<th>借款标题</th>
								<th>借款期限</th>
								<th>预期年化利率</th>
								<th>剩余借款期限</th>
								<th>转让总额</th>
								<th>剩余金额</th>
								<th>转让进度</th>
								<th>操作</th>
							</tr>
							<c:if test="${not empty data.zhaizhuan}">
							<c:forEach items="${data.zhaizhuan}" var="z">
							<tr>
								<td>${z.name}</td>
								<td class="text"><span class="num">${z.deadLine}</span>个月</td>
								<td class="text2"><span class="num"><fmt:formatNumber value="${z.estimatedAnnualRate * 100}" pattern="0.00"/></span>%</td>
								<td class="text"><span class="num"><fmt:formatNumber value="${z.holdDays / 30}" pattern="###0" /></span>个月${z.holdDays % 30}天</td>
								<td class="zhaimoney" zhaimoney="${z.investmentAmount + z.assignedAmount}"></td>
								<td class="surplusmoney" surplusmoney="${z.investmentAmount}"></td>
								<td style="position: relative;">
										<canvas id="${z.id}" percent="${(z.assignedAmount) / (z.investmentAmount + z.assignedAmount)}" style="position: absolute;left:38px;top:17px;" width="46" height="46"></canvas>
								</td>
                                <td class="chengjie"> <a href="/yingpu/pc/project/debt/receive/confirm?id=${z.itemId}">立即承接</a></td>
							</tr>
							</c:forEach>
							</c:if>
						</table>
						<c:if test="${empty data.zhaizhuan}">
							<span style="display: block; font-size: 22px; margin-top: 220px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>
						</c:if>
					</div>

				</div>
				
			</div>
			<!-- 动态和新闻 -->
			<div class="content5">
        <div class="gonggao  clearFix">
            <p class="title clearFix"><span class="a1">九趣动态</span><span class="a2">行业新闻<a href="infomation/list?type=companystate" class="more">查看更多</a></span></p >
			
            <div class="neirong clearFix">
                <div class="dongtai">
                    <div class="dongtaibox">
						<div class="swiper-container dongtailist">
							<div class="swiper-wrapper" >
								<c:forEach items="${data.companystate}" var="o">
								<div class="swiper-slide">
									<a href="infomation/detail?id=${o.id}&type=companystate" class="clearFix">
										<div class="img">
											<img src="${o.pic}" alt="">
										</div>
										<div class="totalText">
											<div class="totalTextBox">
												<p class="biaoti"><span class="bg"></span><span>${o.title}</span></p>
												<p class="time">发布时间：<span class="dateTime">${o.createDate}</span> </p>
												<p class="text">${o.descr}</p>
											</div>
											
										</div>
									</a>
								</div>
								</c:forEach>						
							</div>  
						</div><!-- 
						<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div> -->
						
						
						
                        <!-- <ul class="dongtailist clearFix">
							<c:forEach items="${data.companystate}" var="o">
                            <li class="listlie">
                                <a href="infomation/detail?id=${o.id}&type=companystate">
									<div class="img">
										<img src="${o.pic}" alt="">
									</div>
									<p class="biaoti">${o.title}</p>
									<p class="text">${o.descr}</p>
                                </a>
                            </li>
							</c:forEach>
                        </ul>
                        <div class="btn">
                            <span class="prev"><img src="img/dongtaibtnl.png" ></span>
                            <span class="next"><img src="img/dongtaibtnr.png" ></span>
                        </div> -->
                    </div>
                </div>
				<div class="news">
					<div class="newsbox">
						<div class="newsbox">
							<div class="swiper-container newslist">
									<div class="swiper-wrapper" >
										<c:forEach items="${data.news}" var="n">
										<div class="swiper-slide">
											<a  href="infomation/detail?id=${n.id}&type=news"  class="clearFix">
												<div class="img">
													<img src="${n.pic}" alt="">
												</div>
												<div class="totalText">
													<div class="totalTextBox">
														<p class="biaoti"><span class="bg"></span><span>${n.title}</span></p>
														<p class="time">发布时间：<span class="dateTime">${n.createDate}</span> </p>
														<p class="text">${n.descr}</p>

													</div>

												</div>
											</a>
										</div>
										</c:forEach>
									</div>  
							</div>
								<!-- <div class="swiper-button-next"></div>
								<div class="swiper-button-prev"></div> -->
						</div>
						
						
						
						<!-- <ul class="newslist clearFix">
							<c:forEach items="${data.news}" var="n">
							<li class="listlie">
								<a href="infomation/detail?id=${n.id}&type=news">
									<div class="img">
										<img src="${n.pic}" alt="">
									</div>
									<p class="biaoti">${n.title}</p>
									<p class="text">${n.descr}</p>
								</a>
							</li>
                            </c:forEach>
						</ul>
						<div class="btn">
							<span class="prev"><img src="img/dongtaibtnl.png" ></span>
							<span class="next"><img src="img/dongtaibtnr.png" ></span>
						</div> -->
					</div>
				</div>
			</div>
        </div>
    </div>
						
			<!-- 合作伙伴 -->
			<div class="content6">
				<div class="company">
					<h3>合作伙伴</h3>
					<div class="hezuo" >
						<div class="swiper-container">
							<div class="swiper-wrapper" >
								<%--<div class="swiper-slide"><a href="#"><img src="img/chuizi.png" alt=""  style="display: inline-block;margin-top:0px;"></a></div>--%>
								<div class="swiper-slide"><a href="https://www.fuiou.com/"><img src="img/fuyou.png" alt=""  style="display: inline-block;margin-top:6px;"></a></div>
								<div class="swiper-slide"><a href="http://www.wdzj.com/"><img src="img/wangdaizhijia.png" alt=""  style="display: inline-block;margin-top:5px;"></a></div>
								<div class="swiper-slide"><a href="http://www.p2peye.com/"><img src="img/wangdaitianyan.png" alt=""  style="display: inline-block;margin-top:6px;"></a></div>
								<div class="swiper-slide"><a href="http://www.chinagreentown.com/"><img src="img/luchengjituan.png" alt=""  style="display: inline-block;margin-top:4px;"></a></div>
								<div class="swiper-slide"><a href="https://www.tongdun.cn/"><img src="img/tongdunkeji.png" alt=""  style="display: inline-block;margin-top:0px;"></a></div>
								<div class="swiper-slide"><a href="https://www.qhee.com/"><img src="img/qianhaiguquan.png" alt=""  style="display: inline-block;margin-top:3px;"></a></div>
								<div class="swiper-slide"><a href="https://www.163yun.com/"><img src="img/wangyiyun.png" alt="" style="display: inline-block;margin-top:28px;"></a></div>
								<div class="swiper-slide"><a href="https://cloud.baidu.com/"><img src="/yingpu/pc/newpc/img/baiduyun.png" alt=""  style="display: inline-block;margin-top:16px;"></a></div>
								<div class="swiper-slide"><a href="http://www.yingpuwealth.com/"><img src="/yingpu/pc/newpc/img/yingpujinfu.png" alt=""  style="display: inline-block;margin-top:26px;"></a></div>
								<div class="swiper-slide"><a href="http://www.yingpufund.com/"><img src="/yingpu/pc/newpc/img/yingpukonggu.png" alt="" style="display: inline-block;margin-top:26px;"></a></div>
							</div>  
						</div>
					</div>
					
				</div>
			</div>
		</div>
		<!--底部-->
		<iframe src="../pc/footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;display: block;"></iframe>
	
		<!--悬浮条-->
		<iframe src="xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="../pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height: 100%; overflow-y: hidden;" ></iframe>
	
	<script src="newpc/js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="newpc/js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
	<script src="newpc/js/index.js" type="text/javascript" charset="utf-8"></script>
	<script src="newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
	<script src="newpc/js/progress.js" type="text/javascript" charset="utf-8"></script>
	<script src="newpc/js/fix.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
        // 环形进度条
        $('canvas[percent]').each(function(i, e) {
            var p1 = new Progress({
                el: e.id,//canvas元素id
                deg: $(e).attr('percent') * 100,//绘制角度
                timer: 1,//绘制时间
                lineWidth: 4,//线宽
                lineBgColor: '#feac94',//底圆颜色
                lineColor: '#fe4946',//动态圆颜色
                textColor: '#fd625e',//文本颜色
                fontSize: 12,//字体大小
                circleRadius: 23//圆半径
            });
        });
	</script>
	<script type="text/javascript">
		var tip_index = 0;
		function show(id) {
			tip_index = layer.tips("最高投资限额5万元", "#"+id+"", {
			  tips: [3, "#f93e25"]
			});
		};
		function hide(){
			 layer.close(tip_index);
		}
	</script>
	<script type="text/javascript">
        zhaiquanshengyu();

        //公告详情
        function ggdea(id) {
            location.href = 'infomation/detail?id=' + id + '&type=announce';
        }
        function tzurl(url) {
            top.location.href = '/yingpu/pc' + url;
        }
        //页面跳转
        function tiaozhuan(url) {
            // window.top.location.href = url;
            top.location.href='/yingpu/pc/'+url;
        }
        $('.chengjiao').text(commafy(parseFloat(${data.shuju[0].total}).toFixed(2)));
        $('.shouyi').text(commafy(parseFloat(${data.shuju[1].total}).toFixed(2)));
        $('.people').text(commafy(parseInt(${data.shuju[2].total})));
        $('.day').text(commafy(parseInt(${data.shuju[3].total})));


        //数据添加分隔符
        function commafy(num) {
            return num && num
                .toString()
                .replace(/(\d)(?=(\d{3})+\.)/g, function ($1, $2) {
                    return $2 + ',';
                });
        }
        function viewWithoutInvestPrompt() {
            layer.alert('您未投资该项目，无法查看此项目详情！');
        }

        function viewWithoutLoginPrompt() {
            layer.alert('您尚未登录，无法查看此项目详情！');
        }

        function viewEndedProjectPrompt() {
            layer.alert('此项目已还款！');
        }
        function chedairong(){
            var $parent = $('#project');
            var str = ``;
            str += `<c:if test="${empty data.chedairong}">
								<span style="display: block; font-size: 22px; margin-top: 220px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>
					</c:if>
					<c:if test="${not empty data.chedairong}">
					<c:forEach items="${data.chedairong}" varStatus="i" var="o">
				<li class="list">

					<div class="xiangmu">
						<%--<p class="title">车融贷20181201015</p>--%>
							<p class="title"><a  href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="tfu">${o.name}</a></p>
						<div class="detail clearFix" >
							<div class="data">
								<p class="p1"><span class="num">${o.deadLine}</span>个月</p>
								<p class="wenben">借款期限</p>
							</div>
							<div class="nianhua">
								<p class="p2"><span class="num">
									<fmt:formatNumber type="number" value="${o.estimatedAnnualRate*100}" pattern="0.0" maxFractionDigits="2"/></span>%</p>
								<p class="wenben">预期年化收益率</p>
							</div>
							<div class="total">
								<p class="p1"><span class="num">
									<fmt:formatNumber type="number" value="${o.totalAmount/10000}" pattern="0.00" maxFractionDigits="1"/></span>万元</p>
								<p class="wenben">借款金额</p>
							</div>
							<div class="progress">
								 <p class="jindutiao"><span class="jindu"><span totalAmount="${o.totalAmount}" financingAmount="${o.financingAmount}" class="tuli"></span></span></p>
								<p class="shengyu"surplusValue="${o.financingAmount}">剩余额度：元</p>
							</div>
							<div class="chujie">
								<p class="liji">
									<a href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="${status[o.status][1]}">${status[o.status][0]}</a>
								</p>
							</div>
						</div>
					</div>
				</li>
					</c:forEach>
				</c:if>`
            $parent.empty();
            $parent.append($(str));
            jisuan();
            numbee();
        }
        function fangdairong(){

            var $parent = $('#project');
            var str = ``;
            str += `<c:if test="${empty data.fangdairong}">
								<span style="display: block; font-size: 22px; margin-top: 220px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>
					</c:if><c:if test="${not empty data.fangdairong}">
					<c:forEach items="${data.fangdairong}" varStatus="i" var="o">
				<li class="list">

					<div class="xiangmu">
						<%--<p class="title">车融贷20181201015</p>--%>
							<p class="title"><a  href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}"  class="tfu">${o.name}</a></p>
						<div class="detail clearFix" >
							<div class="data">
								<p class="p1"><span class="num">${o.deadLine}</span>个月</p>
								<p class="wenben">借款期限</p>
							</div>
							<div class="nianhua">
								<p class="p2"><span class="num">
									<fmt:formatNumber type="number" value="${o.estimatedAnnualRate*100}" pattern="0.0" maxFractionDigits="2"/></span>%</p>
								<p class="wenben">预期年化收益率</p>
							</div>
							<div class="total">
								<p class="p1"><span class="num">
									<fmt:formatNumber type="number" value="${o.totalAmount/10000}" pattern="0.00" maxFractionDigits="1"/></span>万元</p>
								<p class="wenben">借款金额</p>
							</div>
							<div class="progress">
								 <p class="jindutiao"><span class="jindu"><span totalAmount="${o.totalAmount}" financingAmount="${o.financingAmount}" class="tuli"></span></span></p>
								<p class="shengyu" surplusValue="${o.financingAmount}">剩余额度：元</p>
							</div>
							<div class="chujie">
								<p class="liji">
									<a href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="${status[o.status][1]}">${status[o.status][0]}</a>
								</p>
							</div>
						</div>
					</div>
				</li>
					</c:forEach>
				</c:if>`
            $parent.empty();
            $parent.append($(str));
            jisuan();
            numbee();
        }
        function shangqidai(){
            var $parent = $('#project');
            var str = ``;
            str += `<c:if test="${empty data.youqirong}">
								<span style="display: block; font-size: 22px; margin-top: 220px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>
					</c:if><c:if test="${not empty data.youqirong}">
					<c:forEach items="${data.youqirong}" varStatus="i" var="o">
				<li class="list">

					<div class="xiangmu">
						<%--<p class="title">车融贷20181201015</p>--%>
							<p class="title"><a  href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="tfu">${o.name}</a></p>
						<div class="detail clearFix" >
							<div class="data">
								<p class="p1"><span class="num">${o.deadLine}</span>个月</p>
								<p class="wenben">借款期限</p>
							</div>
							<div class="nianhua">
								<p class="p2"><span class="num">
									<fmt:formatNumber type="number" value="${o.estimatedAnnualRate*100}" pattern="0.0" maxFractionDigits="2"/></span>%</p>
								<p class="wenben">预期年化收益率</p>
							</div>
							<div class="total">
								<p class="p1"><span class="num">
									<fmt:formatNumber type="number" value="${o.totalAmount/10000}" pattern="0.00" maxFractionDigits="1"/></span>万元</p>
								<p class="wenben">借款金额</p>
							</div>
							<div class="progress">
								 <p class="jindutiao"><span class="jindu"><span totalAmount="${o.totalAmount}"  financingAmount="${o.financingAmount}" class="tuli"></span></span></p>
								<p class="shengyu" surplusValue="${o.financingAmount}">剩余额度：元</p>
							</div>
							<div class="chujie">
								<p class="liji">
									<a href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="${status[o.status][1]}">${status[o.status][0]}</a>
								</p>
							</div>
						</div>
					</div>
				</li>
					</c:forEach>
				</c:if>`
            $parent.empty();
            $parent.append($(str));
            jisuan();
            numbee();
        }
        function xiaofeidai(){
            var $parent = $('#project');
            var str = ``;
            str += `<c:if test="${empty data.xiaofeidai}">
								<span style="display: block; font-size: 22px; margin-top: 220px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>
					</c:if><c:if test="${not empty data.xiaofeidai}">
					<c:forEach items="${data.xiaofeidai}" varStatus="i" var="o">
				<li class="list">

					<div class="xiangmu">
						<%--<p class="title">车融贷20181201015</p>--%>
							<p class="title"><a  href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="tfu">${o.name}</a></p>
						<div class="detail clearFix" >
							<div class="data">
								<p class="p1"><span class="num">${o.deadLine}</span>个月</p>
								<p class="wenben">借款期限</p>
							</div>
							<div class="nianhua">
								<p class="p2"><span class="num">
									<fmt:formatNumber type="number" value="${o.estimatedAnnualRate*100}" pattern="0.0" maxFractionDigits="2"/></span>%</p>
								<p class="wenben">预期年化收益率</p>
							</div>
							<div class="total">
								<p class="p1"><span class="num">
									<fmt:formatNumber type="number" value="${o.totalAmount/10000}" pattern="0.00" maxFractionDigits="1"/></span>万元</p>
								<p class="wenben">借款金额</p>
							</div>
							<div class="progress">
								 <p class="jindutiao"><span class="jindu"><span totalAmount="${o.totalAmount}"  financingAmount="${o.financingAmount}" class="tuli"></span></span></p>
								<p class="shengyu" surplusValue="${o.financingAmount}">剩余额度：元</p>
							</div>
							<div class="chujie">
								<p class="liji">
									<a href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="${status[o.status][1]}">${status[o.status][0]}</a>
								</p>
							</div>
						</div>
					</div>
				</li>
					</c:forEach>
				</c:if>`
            $parent.empty();
            $parent.append($(str));
            jisuan();
            numbee();
        }
        function jinduzhi(total, shengyu) {
            var num = (total - shengyu) / total * 100 + "%";
            return num;
        }
        function jisuan() {
            $('.tuli').each(function (e) {
                var totalAmount = $(this).attr('totalAmount');
                var financingAmount = $(this).attr('financingAmount');
                // console.log(totalAmount)
                // console.log(financingAmount)
                // jindu = financingAmount/ totalAmount * 100 + "%";
                // console.log(jindu);
                $(this).css("width",  (totalAmount-financingAmount) / totalAmount * 100 + "%");
            });
        }
        function numbee(){
            $('.shengyu').each(function (e) {
				var Amount = $(this).attr('surplusValue');
				var value = commafy(returnFloat(Amount));
				// console.log(value);
				$(this).html('剩余额度:'+value+"元");
            });
		}
        jisuan();
        numbee();
        function loadOnTopWindow(base) {
            $(base).on('click', 'a', function(e) {
                e = event || e;
                var href = $(this).attr('href');
                if (href && href.indexOf('javascript:') == -1) {
                    e.preventDefault();
                    top.window.location.href = href;
                }

                return true;
            });
        }

        $('#yue').text(commafy(returnFloat($('#yue').text()))+'元');

        loadOnTopWindow(document);
        function returnFloat(value){
            var value=Math.round(parseFloat(value)*100)/100;
            var s=value.toString().split(".");
            if(s.length==1){
                value=value.toString()+".00";
                return value;
            }
            if(s.length>1){
                if(s[1].length<2){
                    value=value.toString()+"0";
                }
                return value;
            }
        }
        function zhaiquanshengyu(){
            $('.zhaimoney').each(function (e) {
                var Amount = $(this).attr('zhaimoney');
                var value = commafy(returnFloat(Amount));
                $(this).html(value+"元");
            });
            $('.surplusmoney').each(function (e) {
                var Amount = $(this).attr('surplusmoney');
                var value = commafy(returnFloat(Amount));
                $(this).html(value+'元');
            });

        }
	</script>
	<script type="text/javascript">
		$('.fix #header .bottom .right li#zhanghu').hover(function(){
			$(this).find('.mac').css({'color':'#537ce4','font-weight':'bold'});
			$(this).find('.person').attr('src','img/small-person-lan.png');
			console.log($(this).find('.person').attr("src"))
		},function(){
			$(this).find('.mac').css({'color':'#1f1f1f','font-weight':'normal'});
			$(this).find('.person').attr('src','img/small-person.jpg')
		});
	</script>
	
	</body>
</html>