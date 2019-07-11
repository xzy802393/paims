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
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="css/account_common.css"/>
		<link rel="stylesheet" type="text/css" href="css/myrewards.css"/>
		

		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" width="100%" height="110" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">
					<!--<div class="account-nav-name">
						<div class="account-pic">
							<img src="../img/account/account-pic.png"/>
						</div>
						<p class="name">赵丹红</p>
					</div>-->
					<iframe src="account_sidebar.html" width="100%" height="850" scrolling="no"  style="border:0px;"></iframe>
				</div>
				<!--右边主体部分-->
				
				<!--邀请奖励-->
				<div class="coupons left">
					<h3>我的优惠券</h3>
					<div class="coupons-item">
						<ul class="clearfix">
							<li class="list">
								<p>未使用优惠券</p>
								<p><span class="num true">${data.wcount.count}</span>张</p>
							</li>
							<li><span class="line"></span></li>
							<li class="list">
								<p>未使用优惠券总额</p>
								<p><span class="num true">${data.wtotol.totol == null ? '0.00' :data.wtotol.totol}</span>元</p>
							</li>
							<li><span class="line"></span></li>
							<li class="list">

								<p>已使用优惠券总额</p>
								<p><span class="num">${data.ytotol.totol == null ? '0.00' :data.ytotol.totol}</span>元</p>
							</li>
							<li><span class="line"></span></li>
							<!-- <li class="list">
								<p>已过期优惠券</p>
								<p><span class="num">${data.wcount.count}</span>张</p>
							</li> -->
						</ul>
					</div>
					
					<!--代金券加息券-->
					<div class="coupons-contain">
						<h4><a href="javascript:;" onclick="qiehuan(1);" class="active">代金券</a>&nbsp;&nbsp; | &nbsp;&nbsp;<a href="javascript:;" onclick="qiehuan(2);">加息券</a>
							| &nbsp;&nbsp;<a href="javascript:;" onclick="qiehuan(3);">抵扣率劵</a><%--| &nbsp;&nbsp;<a href="javascript:;" onclick="qiehuan(3);">红包雨</a>--%>
						</h4>
						<div class="tab-menu" id="menu">
							<ul class="clearfix">
								<li class="active">未使用</li>
								<li>已使用</li>
								<li>已过期</li>						
							</ul>
						</div>
						<div class="coupons-box">
							<ul class="clearfix" id="cardinfo">
							<!-- 	<li class="coupons-img">
									<p class="coupons-style">代金券</p>
									<div class="coupons-txt clearfix">
										<div class="coupons-txt-l">
											<p>注册红包</p>
											<p>满10000元可用</p>
											<p>限投1个月及以上项目</p>
										</div>
										<div class="coupons-txt-r">
											<p>￥<span class="money">15</span></p>	
										</div>
									</div>
									<p class="deadline">有效期：2017年9月1日-2017年9月31日</p>
								</li>
								<li class="coupons-img jiaxi">
																<div class="coupons-txt clearfix">
										<div class="coupons-txt-l">
											<p>注册红包</p>
											<p>满10000元可用</p>
											<p>限投1个月及以上项目</p>
										</div>
										<div class="coupons-txt-r">
											<p>￥<span class="money">300</span></p>	
										</div>
									</div>
									<p class="deadline">有效期：2017年9月1日-2017年9月31日</p>
								</li>
								<li class="coupons-img guoqi">
								
									<div class="coupons-txt clearfix">
										<div class="coupons-txt-l">
											<p>注册红包</p>
											<p>满10000元可用</p>
											<p>限投1个月及以上项目</p>
										</div>
										<div class="coupons-txt-r">
											<p>￥<span class="money">5</span></p>	
										</div>
									</div>
									<p class="deadline">有效期：2017年9月1日-2017年9月31日</p>
								</li>
								-->
								<!--<li class="coupons-img djysy">
								
									<div class="coupons-txt clearfix">
										<div class="coupons-txt-l">
											<p>注册红包</p>
											<p>满10000元可用</p>
											<p>限投1个月及以上项目</p>
										</div>
										<div class="coupons-txt-r">
											<p>￥<span class="money">5</span></p>	
										</div>
									</div>
									<p class="deadline">有效期：2017年9月1日-2017年9月31日</p>
								</li>
								
								<li class="coupons-img jxysy">
								
									<div class="coupons-txt clearfix">
										<div class="coupons-txt-l">
											<p>注册红包</p>
											<p>满10000元可用</p>
											<p>限投1个月及以上项目</p>
										</div>
										<div class="coupons-txt-r">
											<p>￥<span class="money">5</span></p>	
										</div>
									</div>
									<p class="deadline">有效期：2017年9月1日-2017年9月31日</p>
								</li>-->
								
								
								
								
							</ul>
							
								<!--页码-->
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
					<div class="rewards-tip">
						<p class="title">优惠券使用规则</p>
						<p>优惠券分为代金券和加息券了两种。</p>
						<p>代金券使用后，项目到期还款后，金额可以提现。</p>
						<p>每张优惠券仅可使用一次，如项目流标，使用的优惠券会返还给用户。</p>
						<p>使用优惠券请参照券面规则使用。</p>
						<p>使用过程中遇到问题，请联系客服400-151-6636。</p>	
					</div>

				</div>
			</div>
		</div>
		<!--客服悬浮条-->
		<!--客服悬浮条-->
		<!-- <iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		 -->
		
		
		<!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/Ecalendar.jquery.min.js" type="text/javascript"></script>
	<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		var status=1,type=1;
		$(function(){
			// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
			//投资记录切换
			$("#menu li").each(function(){
				$(this).click(function(){
					$("#menu li").removeClass("active");
					$(this).addClass("active");
					guoqi=false;
					if($(this).text()=='未使用'){
						status=1;
						pageIndex=1;
					}else if($(this).text()=='已使用'){
						status=2;
						pageIndex=1;
					}else{
						status=3;
						pageIndex=1;
					}
					loadList();

				})
			})
			loadList();
		});
	
	function qiehuan(t){
		$(event.target).parent().find('a').removeClass("active");
		$(event.target).addClass("active");

		if(t==1){
			type=1;
			pageIndex=1;
		}else if(t==2){
			type=2;
			pageIndex=1;
		}else{
			type=3;
			pageIndex=1;
		}
		loadList();
	}
	
	function loadList(){
				$.post('../myaccount/usercard/list/json',{pageIndex:pageIndex,type:type,status:status,pageSize:6},function(data){
				var dat=data;

					pageIndex = pageIndex
					pageCount = data.page.pageCount;
					pageSize=data.page.pageSize;
					data=data.data;
					var html='';
				if(data==undefined){
					$('#cardinfo').empty();
					$('#cardinfo').append('<span style="display: block; text-align: center; width:888px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>');
					generatePaginationNav(pageIndex, dat.page.pageCount, '#page-nav-btn');
					return false;
				}
					$.each(data,function(i,o){
						
							if(status==1&&o.type==1){
								html+='<li class="coupons-img">';
							}else if(status==1&&o.type==2){
								html+='<li class="coupons-img jiaxi">';
							}else if(status==2&&o.type==1){
								html+='<li class="coupons-img djysy">';
							}else if(status==2&&o.type==2){
								html+='<li class="coupons-img jxysy">';
							}else if(status==3){
								html+='<li class="coupons-img guoqi">';
							}else if(status==1&& o.type==3){
                                html+='<li class="coupons-img dikoulv">';
							}else if(status == 2 && o.type==3){
                                html+='<li class="coupons-img dklysy">';
							}
						
						/*	html+='<p class="coupons-style">'+(o.type==1 ? '代金券' : '加息券')+'</p>';*/
							html+='<div class="coupons-txt clearfix">';
							html+='<div class="coupons-txt-l">';
							html+='<p>'+o.name+'</p>';
							html+='<p>满'+o.limitMoney+'元可用</p>';
							html+='<p>限投'+o.deadLine+'个月及以上项目</p>';
							html+='</div>';
							html+='<div class="coupons-txt-r">';
							if(o.type==1){
								html+='<p>￥<span class="money">'+o.money+'</span></p>';
							}else if(o.type ==2){
								html+='<p><span class="money">'+accMul(o.rate,100)+'%</span></p>';
							}else if(o.type ==3){
                            html+='<p><span class="money">'+accMul(o.dikouRate,100)+'%</span></p>';
						}
							
							html+='</div></div>';
							html+='<p class="deadline">有效期：'+new Date(o.startTime).Format('yyyy年MM月dd日')+'到'+new Date(o.endTime).Format('yyyy年MM月dd日')+'</p>';
							html+='</li>';

					});
				$('#cardinfo').empty();
				$('#cardinfo').append(html);		
				generatePaginationNav(pageIndex, dat.page.pageCount, '#page-nav-btn');					
									
								
 
				});
			}

	</script>
	
	</body>
</html>
