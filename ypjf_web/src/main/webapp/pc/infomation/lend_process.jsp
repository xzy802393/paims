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
		<link rel="stylesheet" type="text/css" href="../css/active_center.css"/>
		<link rel="stylesheet" type="text/css" href="css/lend_process.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/common4.css"/>

		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>

		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>	
		
		<!--主体-->
		<div class="active-main">
			<!--banner-->
			<div class="active-banner xiaofei" id="banner" style="background: #4973c9;" ondragstart="return false" oncontextmenu="return false">
				<!--<div class="active-banner-txt">
					<p>轻松投 欢乐投</p>
					<p>更多玩法更有趣！</p>
				</div>				-->
				<img src="../img/banner-xiaofei.jpg" >
			</div>
			
			<!--活动内容-->
			<div class="center">
				<div class="active-center">

					<div class="active-nav">
						<p>当前位置   &gt; <a href="/">首页</a> &gt; <a href="aboutUs/platform_intro.html">信息披露</a> &gt; <a  class="now">产品中心</a></p>
					</div>
					
					<!--活动项目-->
					<div class="active-project">
						<div class="tab-menu" id="menu">
							<ul class="clearfix">
								<li class="active" onclick="$('#banner').attr('class', 'active-banner xiaofei').css('background-color','#4973c9').find('img').attr('src','../img/banner-xiaofei.jpg');">消费贷</li>
								<li onclick="$('#banner').attr('class', 'active-banner car').css('background','url(../img/banner-carBg.jpg) repeat-x').find('img').attr('src','../img/banner-car.jpg');">车融贷</li>
								<li onclick="$('#banner').attr('class', 'active-banner house').css('background-color','#173156').find('img').attr('src','../img/banner-house.jpg');">房融贷</li>
								<li onclick="$('#banner').attr('class', 'active-banner company').css('background-color','#326fa8').find('img').attr('src','../img/banner-company.jpg');">商企贷</li>
								
							</ul>
						</div> 
						
						<div class="tab-main" id="content">
							<!--消费-->
							<div class="item active-xiaofei">
								<div class="des">
									<p><span>消费贷</span> 消费贷是为广大年轻消费者群体提供的一项满足个人日常消费、购置车辆、原料采购、资金周转、副业经营等一款产品。由平台对每个借款人进行严格的准入条件筛选及多层调查审核和资信评估审核，评定该借款项目真实，风险可控，予以作为借款标的在平台发布。</p>
								</div>
								
								<h3>消费贷办理流程</h3>
								<div class="process">
									<ul class="clearfix">
										<li>
											<p style="margin-left:-10px;">借款人提供真实有效的个人资料</p>
											<p class="num">1</p>
											<p class="tit">资料核实</p>								
										</li>
										<li>
											<p>提供有效财力及信用证明</p>
											<p class="num">2</p>
											<p class="tit" style="margin-top:-108px;">个人</br>信用核实</p>
										</li>
										<li>
											<p>风控人员终审，出具报告</p>
											<p class="num">3</p>
											<p class="tit">风控审核</p>								
										</li>
										<li>
											<p>说明相关协议，签订合同</p>
											<p class="num">4</p>
											<p class="tit">签订合同</p>
										</li>
										<li>
											<p>发布信息，进行融资</p>
											<p class="num">5</p>
											<p class="tit">发标融资</p>								
										</li>
										<li>
											<p>标满，给予放款</p>
											<p class="num">6</p>
											<p class="tit">满标放款</p>
										</li>
										<li>
											<p>合同借款结清</p>
											<p class="num">7</p>
											<p class="tit">还款</p>								
										</li>
									</ul>
								</div>
								
								<p class="more"><a href="../project/list">查看项目列表</a></p>
							</div>
							
							<!--车贷-->
							<div class="item active-car" style="display: none;">
								<div class="des">
									<p><span>车抵押</span> 车抵押贷款业务为借款人提供相关信用咨询、车辆评估、抵押借款、协议管理、回款管理等多方面的服务，借款人以自有车辆为抵押物获得出借资金，公司安排专业人员对抵押车辆进行GPS安装。在合同期间，借款人仍可正常使用该车辆。质押贷款中，由九趣贷为借款人妥善保管车辆。</p>
								</div>
								
								<h3>车抵押借款办理流程</h3>
								<div class="process">
									<ul class="clearfix">
										<li>
											<p>审查借款资料，核实产权</p>
											<p class="num">1</p>
											<p class="tit">资料核实</p>								
										</li>
										<li>
											<p>核查车辆情况，评估价值</p>
											<p class="num">2</p>
											<p class="tit">车辆估值</p>
										</li>
										<li>
											<p>风控人员终审，出具报告</p>
											<p class="num">3</p>
											<p class="tit">风控审核</p>								
										</li>
										<li>
											<p>说明相关协议，签订合同</p>
											<p class="num">4</p>
											<p class="tit">签订合同</p>
										</li>
										<li>
											<p>移交相关资料，办理质押</p>
											<p class="num">5</p>
											<p class="tit">手续质押</p>								
										</li>
										<li>
											<p>发布借款信息，满标放款</p>
											<p class="num">6</p>
											<p class="tit">发标融资</p>
										</li>
										<li>
											<p>合同借款结清，解除质押。</p>
											<p class="num">7</p>
											<p class="tit">还款解押</p>								
										</li>
									</ul>
								</div>
								
								<p class="more"><a href="../project/list">查看项目列表</a></p>
							</div>
							
							<!--房贷-->
							<div class="item active-house" style="display: none;">
								<div class="des">
									<p><span>赎楼贷款业务</span> 房产权利人在当前房贷尚未还清时，想要出卖房产、或因房产升值想要申请更大额度贷款，此时房产权利人向九趣贷贷款以偿清当前按揭/抵押贷款，赎出《房产证》，此类业务就是赎楼贷款业务。</p>
									<p>红本(《房屋所有权证》)抵押贷款业务</p>
									<p>红本抵押贷款是指房产权利人以房产为抵押物，申请贷款，用于各种消费、资金周转和经营性用途的业务。</p>
								</div>
								
								<h3>房抵押借款办理流程</h3>
								<div class="process">
									<ul class="clearfix">
										<li>
											
											<p class="num">1</p>
											<p class="tit">提出申请</p>								
										</li>
										<li>
											
											<p class="num">2</p>
											<p class="tit">确权</p>
										</li>
										<li>
											
											<p class="num">3</p>
											<p class="tit">尽调</p>								
										</li>
										<li>
											
											<p class="num">4</p>
											<p class="tit">委托协议</p>
										</li>
										<li>
											
											<p class="num">5</p>
											<p class="tit">司法公证</p>								
										</li>
										<li>
											
											<p class="num">6</p>
											<p class="tit">服务协议签订</p>
										</li>
										<li>
											
											<p class="num">7</p>
											<p class="tit">赎楼过户</p>								
										</li>
										<li>
											
											<p class="num">8</p>
											<p class="tit">还款</p>								
										</li>
									</ul>
								</div>
								
								<h3>赎楼贷交易流程</h3>
								<div class="process-house">
									<img src="../img/infomation/process-house.png"/>
								</div>
								
								<p class="more"><a href="../project/list">查看项目列表</a></p>
							</div>
							
							<!--企贷-->
							<div class="item active-company" style="display: none;">
								<div class="des">
									<p><span>商企贷</span> 专门针对小微企业法人或者企业股东，因短期的资金流通需求，通过股东会决议将股权、票据、应收货款等抵质押并办理登记手续，或者以自有房产，车辆等资产作为还款付息的保障，为小微企业解决短期资金周转需求。</p>
								</div>
								
								<h3>小微企业抵押借款办理流程</h3>
								<div class="process">
									<ul class="clearfix">
										<li>
											<p style="margin-left: -10px;">借款人提供企业基础资料</p>
											<p class="num">1</p>
											<p class="tit">借款发起</p>								
										</li>
										<li>
											<p style="margin-left: -30px;">尽职调查，收集资料，形成调研报告</p>
											<p class="num">2</p>
											<p class="tit">资料收集</p>
										</li>
										<li>
											<p style="margin-left: -30px;" >信用调查，核实财证，出具风控报告</p>
											<p class="num">3</p>
											<p class="tit">风控审核</p>								
										</li>
										<li>
											<p style="margin-left: -40px;">根据企业征信情况，核定企业授信额度</p>
											<p class="num">4</p>
											<p class="tit">授信额度</p>
										</li>
										<li>
											<p style="margin-left: -10px;">办理股权登记、质押</p>
											<p class="num">5</p>
											<p class="tit">股权质押</p>								
										</li>
										<li>
											<p style="margin-left: -10px;">投资人选择项目，进行投资</p>
											<p class="num">6</p>
											<p class="tit">投资认购</p>
										</li>
										<li>
											<p style="margin-left: -65px;">满标审核，通过第三方资金托管，转入借款企业</p>
											<p class="num">7</p>
											<p class="tit">满标放款</p>								
										</li>
										<li>
											<p>借款到期，还本付息</p>
											<p class="num">8</p>
											<p class="tit">签订合同</p>								
										</li>
									</ul>
								</div>
								
								<p class="more"><a href="../project/list">查看项目列表</a></p>
							</div>
						</div>
						
						
						
					</div>
				</div>
			</div>	
		</div>
		
		
		<!--悬浮条-->
		<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: block;"></iframe>
		<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>
		
		<!--底部导航-->

		<iframe src="/yingpu/pc/footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;left: 0px;"></iframe>

		

		<!--加载js文件-->
		<script src="/yingpu/pc/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		
		
		<script src="/yingpu/layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			
			
					var $li = $('#menu li');
					var $item = $('#content .item');
								
					$li.click(function(){
						var $this = $(this);
						var $t = $this.index();
						$li.removeClass();
						$this.addClass('active');
						$item.css('display','none');
						$item.eq($t).css('display','block');
					})
				
		
		</script>
		<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		
	</body>
</html>
