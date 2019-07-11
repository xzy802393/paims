
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>营普金服——参股商业银行的互联网金融服务平台</title>
		<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
		<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
		<link rel="shortcut icon" href="../img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="./css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="./css/common.css"/>
		<link rel="stylesheet" type="text/css" href="./css/active_center.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/common4.css"/>
		
		<script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="./head3.html?index=5" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		<!--主体-->
		<div class="active-main">
			<!--banner-->
			<div class="active-banner">
				<div class="active-banner-txt">
					<!-- <p>轻松投 欢乐投</p>
					<p>更多玩法更有趣！</p> -->
				</div>				
			</div>
			
			<!--活动内容-->
			<div class="center">
				<div class="active-center">
					<div class="active-nav">
						<p>当前位置   &gt; <a href="/">首页</a> &gt; <a href="./infomation/aboutUs/platform_intro.html">信息披露</a> &gt; <a href="#" class="now">活动中心</a></p>
					</div>
					
					<!--活动项目-->
					<div class="active-project">
						<div class="active-tab">
							<ul class="menus-tab clearfix">
								<li><a href="javascript:;" class="on" >全部</a></li>
								<li><a href="javascript:;" >进行中</a></li>
								<li><a href="javascript:;" >已结束</a></li>
							</ul>
						</div>
						<div class="active-content">
							<ul class="clearfix" id="info">
								
								<!-- 

								<li>
									<div class="active-pic">
										<img src="./img/active-1.png"/>
									</div>
									<div class="active-text">
										<p>全民挖金节</p>
										<p>长期有效</p>
										<p>全民挖金节 撸起袖子干起来</p>
									</div>
									<div class="active-btn">
										<a href="">立即参与</a>
									</div>
								</li>
								
								<li>
									<div class="active-pic">
										<img src="./img/active-2.png"/>
									</div>
									<div class="active-text">
										<p>营普金服代言人计划</p>
										<p>长期有效</p>
										<p>邀好友得双蛋 再送0.5%-1%返现</p>
									</div>
									<div class="active-btn">
										<a href="">立即参与</a>
									</div>
								</li>
								
								<li>
									<div class="active-pic">
										<img src="./img/active-3.png"/>
									</div>
									<div class="active-text">
										<p>高温加息0.5%-1%</p>
										<p>长期有效</p>
										<p>全民挖金节 撸起袖子干起来</p>
									</div>
									<div class="active-btn">
										<a href="javascript:return false;" onclick="return false;" class="over">活动已结束</a>
									</div>
								</li>
								<li>
									<div class="active-pic">
										<img src="./img/active-4.png"/>
									</div>
									<div class="active-text">
										<p>新用户大礼包</p>
										<p>长期有效</p>
										<p>注册就送688元大礼包 预期年化收益率6%-12%</p>
									</div>
									<div class="active-btn">
										<a href="">立即参与</a>
									</div>
								</li>
								
								<li>
									<div class="active-pic">
										<img src="./img/active-5.png"/>
									</div>
									<div class="active-text">
										<p>新手专享标</p>
										<p>长期有效</p>
										<p>新用户在注册后30天内可以投资新手专享标，享受短期限、高效益的新用户福利！</p>
									</div>
									<div class="active-btn">
										<a href="">立即参与</a>
									</div>
								</li>
								
								<li>
									<div class="active-pic">
										<img src="./img/active-6.png"/>
									</div>
									<div class="active-text">
										<p>中秋国庆欢乐大礼包</p>
										<p>长期有效</p>
										<p>2017.9.1-2017.9.8 6%加息天天领</p>
									</div>
									<div class="active-btn">
										<a href="javascript:return false;" onclick="return false;" class="over">活动已结束</a>
									</div>
								</li> -->
							</ul>
						
						
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
			</div>	
		</div>	
		
		<%--<!--客服悬浮条-->--%>
		<%--<iframe src="xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>--%>
		<%--<iframe src="jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>--%>
		<%--<script src="js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>--%>

		<!--客服悬浮条-->
		<!--悬浮条-->
		<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>

		<!--底部导航-->
		<iframe src="/yingpu/pc/footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;left: 0px;"></iframe>
		
		<!--加载js文件-->
		<script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="./js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="./js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="./js/utils.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>

		<!--<script src="./js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="./js/first.js" type="text/javascript" charset="utf-8"></script>-->
		<script type="text/javascript">
				//location.href='';
		</script>

		<script type="text/javascript">
		var type; 
			$(document).ready(function(){				
						
				//右边滚动条
				$('#investors-list').slimScroll({  
	                height: '748px'  
	            });
	            loadList(1);
			})
			$("ul.menus-tab li").on("click",function () {
        if($(this).text()=='全部'){
						type=1;
				}else if($(this).text()=='进行中'){
						type=2;
				}else{
						type=3;
				}
				console.log(type);
                loadList();
                pageIndex=1;
                pageCount=1;
                // $("ul.menus-tab li a").addClass("on").siblings().removeClass("on");
								$("ul.menus-tab li a").removeClass("on");
                $(this).children().addClass('on');
			});

			function qiehuan(type){
//				if($(event.target).text()=='全部'){
//						type=1;
//				}else if($(event.target).text()=='进行中'){
//						type=2;
//				}else{
//						type=3;
//				}
				loadList();
				pageIndex=1;
				pageCount=1;
//				$(event.target).parent().siblings().children().removeClass('on');
//				$(event.target).addClass('on');
			}
			function loadList(){

				$.post('../system/activity/web/list/json',{pageIndex:pageIndex,pageSize:6,type:type},function(data){
				var 	dat=data;
				pageIndex = dat.page.pageIndex;
				pageCount = data.page.pageCount;
				pageSize=data.page.pageSize;
					data=data.data;
					var html='';		
					if(data.length==0){
					  html+="<h4 style='align:center;'>暂无活动</h4>";
					}	
					$.each(data,function(i,o){
							html+='<li>	<div class="active-pic">';
							html+='<img src="'+o.pcimg+'" onclick="location.href=\''+o.pcurl+'\';"/></div>';
							html+='<div class="active-text">';
							html+='<p>'+o.name+'</p>';
							if(o.isCq=='是'){
								html+='<p>长期有效</p>';
							}else{
								html+='<p style="border:0px;"></p>';
							}
							html+='<p>'+o.miaoshu+'</p></div>';
							html+='<div class="active-btn">';
								if(o.endtime>new Date()){
										html+='<a href="'+o.pcurl+'" target="_blank">立即参与</a>';
									}else{
										if(o.isCq=='是'){
											html+='<a href="'+o.pcurl+'">立即参与</a>';
										}else{
											html+='	<a href="javascript:return false;" onclick="return false;" class="over">活动已结束</a>';
										}
										
										
									}
						
							html+='</div></li>';

					});
					$('#info').empty();
				$('#info').append(html);		
									
				generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');					
									
								

				});
			}
		</script>

		
	</body>
</html>
