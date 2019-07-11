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
		
	</head>
	<body>
	<!--顶部-->

	<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		<!--主体-->
		<div class="infomation">

			
			<!--活动内容-->
			<div class="center">
				<div class="info-center">
					<div class="info-nav">
						<p>当前位置   &gt; <a href="/">首页</a> &gt; <a href="/yingpu/pc/infomation/aboutUs/platform_intro.html">信息披露</a> &gt; <a href="#" class="now">公告列表</a></p>
					</div>
					
					<!--公告动态-->

					<div class="announcement" >
						<ul class="announce-list" id="info">
							<!-- <li class="clearfix">
								<a href="announce-details.jsp">
									<div class="pic left">
										<img src="../img/infomation/news-pic.jpg"/>
									</div>
									<div class="news right">
										<h6 class="title">中国互联网金融协会公布最新会员单位名单</h6>
										<span class="time">2017-11-14</span>
										<p class="content">3月18日，中国互联网金融协会官网公布了最新协会会员名单。最新名单显示，协会首批会员单位一共408家，2017年新加入成员13名。所有成员主要来自银行、证券、保险、基金、期货、信托，以及互联网金融领域的借贷、支付等机构，涵盖了传统金融和互联网金融各个领域的主体。此外还有金融的外围服务机构，如出版单位、金融科技公司、律师事务所等机构。会员名单中还有个人会员5位，分别是李东荣（中国互联网金融协会会长）、文海兴（来自银监会普惠金融部，任协会副主席）、刘洁（来自证监会创新业务监管部，任协会副主席）、何肖锋（来自保监会发展改革部，任协会副主席）、陆书春（中国互联网金融协会秘书长）。同日官网发布郑重声明。声明指出各会员不得以任何方式利用中国互联网金融协会为自身经营活动进行宣传，中国互联网金融协会将依法追究违规会员单位的法律责任。</p>
									</div>
								</a>
							</li>
							<li class="clearfix">
								<a href="announce-details.jsp">
									<div class="pic left">
										<img src="../img/infomation/news-pic.jpg"/>
									</div>
									<div class="news right">
										<h6 class="title">中国互联网金融协会公布最新会员单位名单</h6>
										<span class="time">2017-11-14</span>
										<p class="content">3月18日，中国互联网金融协会官网公布了最新协会会员名单。最新名单显示，协会首批会员单位一共408家，2017年新加入成员13名。所有成员主要来自银行、证券、保险、基金、期货、信托，以及互联网金融领域的借贷、支付等机构，涵盖了传统金融和互联网金融各个领域的主体。此外还有金融的外围服务机构，如出版单位、金融科技公司、律师事务所等机构。会员名单中还有个人会员5位，分别是李东荣（中国互联网金融协会会长）、文海兴（来自银监会普惠金融部，任协会副主席）、刘洁（来自证监会创新业务监管部，任协会副主席）、何肖锋（来自保监会发展改革部，任协会副主席）、陆书春（中国互联网金融协会秘书长）。同日官网发布郑重声明。声明指出各会员不得以任何方式利用中国互联网金融协会为自身经营活动进行宣传，中国互联网金融协会将依法追究违规会员单位的法律责任。</p>
									</div>
								</a>
							</li>
							<li class="clearfix">
								<a href="announce-details.jsp">
									<div class="pic left">
										<img src="../img/infomation/news-pic.jpg"/>
									</div>
									<div class="news right">
										<h6 class="title">中国互联网金融协会公布最新会员单位名单</h6>
										<span class="time">2017-11-14</span>
										<p class="content">3月18日，中国互联网金融协会官网公布了最新协会会员名单。最新名单显示，协会首批会员单位一共408家，2017年新加入成员13名。所有成员主要来自银行、证券、保险、基金、期货、信托，以及互联网金融领域的借贷、支付等机构，涵盖了传统金融和互联网金融各个领域的主体。此外还有金融的外围服务机构，如出版单位、金融科技公司、律师事务所等机构。会员名单中还有个人会员5位，分别是李东荣（中国互联网金融协会会长）、文海兴（来自银监会普惠金融部，任协会副主席）、刘洁（来自证监会创新业务监管部，任协会副主席）、何肖锋（来自保监会发展改革部，任协会副主席）、陆书春（中国互联网金融协会秘书长）。同日官网发布郑重声明。声明指出各会员不得以任何方式利用中国互联网金融协会为自身经营活动进行宣传，中国互联网金融协会将依法追究违规会员单位的法律责任。</p>
									</div>
								</a>
							</li> -->
						</ul>
						
					</div>
					
					<div class="page">
						<div class="page-list" id="pageList">
							<a onclick="go('home')">首页</a>
							<a onclick="go('prev')">上一页</a>
							<span id="page-nav-btn">
							</span>
							<a onclick="go('next')">下一页</a>
							<a onclick="go('tail')">尾页</a>
						</div>
					</div>
				</div>
			</div>	
		</div>	
		
		<!--客服悬浮条-->
		<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>

		<!--底部导航-->
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/queryString.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			
			
			var $this;var pageIndex=1;var type;
			$('ul').on('mouseover', 'li', function() {
				$(this).parents('.main').find('img').attr('src', $(this).attr('pic'));
			})
			.find('li:eq(0)').trigger('mouseover');
            type=queryString('type');
			loadList();
			
			if(type=='announce'){
				$('.now').text('公告列表');
			}else if(type=='companystate'){
				$('.now').text('动态列表');
			}else if(type=='news'){
				$('.now').text('新闻列表');
			}
			else if(type=='lawrule'){
				$('.now').text('法规列表');
			}
			else if(type=='contractsample'){
				$('.now').text('合同列表');
			}



			function loadList(){
				$('#info').css('height','600px');
					layer.load(2);
				$.post('../infomation/list/json',{pageIndex:pageIndex,pageSize:10,type:type},function(data){
					$('#info').css('height','auto');
					console.log(data);
				layer.closeAll();
				var	dat=data;
				pageIndex = dat.page.pageIndex;
				pageCount = data.page.pageCount;
				pageSize=data.page.pageSize;
					data=data.data;
					var html='';		
					if(data.length==0){
					  html+="<h4 style='align:center;'>暂无更多</h4>";
					}	
					$.each(data,function(i,o){
							html+='<li class="clearfix">';
							html+='<a href="detail?type='+type+'&id='+o.id+'">';
							html+='<div class="pic left">';
							if(type=='announce')	html+='<img src="'+o.icon+'"/>';else html+='<img src="'+o.pic+'"/>';
							html+='</div>';
							html+='<div class="news right">';
							html+='<h6 class="title">'+o.title+'</h6>';
							html+='<span class="time">'+   (o.postTime ==undefined || o.postTime == '' ? o.createTime : o.postTime) ==  undefined ? '' : (o.postTime ==undefined || o.postTime == '' ? o.createTime : o.postTime) +'</span>';
							html+='<p class="content">'+o.descr+'</p>';
							html+='</div>';
							html+='</a></li>';
					});
				$('#info').empty();
				$('#info').append(html);		
									
				generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');					

				});
			}
		</script>

		
	</body>
</html>
