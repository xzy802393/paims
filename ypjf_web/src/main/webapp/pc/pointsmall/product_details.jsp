	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		<link rel="stylesheet" type="text/css" href="css/points_mall.css"/>		
		<link rel="stylesheet" type="text/css" href="css/product_details.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/common4.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html?num=8" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		<!--主体-->
		<div class="mall">
			<div class="banner">
				<div class="center">
					<!--登录之前-->

                   
				</div>
			</div>
			
			<div class="mall-nav">
				<div class="center">
					<p class="cur-nav">您现在所在的位置：<a href="../index.jsp">首页</a> &gt; <a href="points_mall.jsp">九趣商城</a> &gt; 商品详情</p>
				</div>
			</div>
			<div class="main">
				<div class="product center clearfix">
					<div class="product-pic left">
						<img src="${goods.logo}"/>
					</div>
					<div class="product-des left">
						<div class="name">
							<p>${goods.goodsName} ( ${goods.goodsDesc} ) </p>
						</div>
						<div class="score">
							<p>所需银子：${goods.points}两</p>
                            <c:if test="${not empty pcuser}">
                                <p>可用银子：<span id="userIntegral"><fmt:formatNumber type="number" pattern="###############0.00"
                                        groupingUsed="false" value="${not empty pcuser.integral ? pcuser.integral : 0}" /></span>两</p>
                            </c:if>
							<p>已换购人数：${not empty buyerNumber ? buyerNumber : 0}人</p>
							<p class="choice">选择数量：
								<span><input type="button" value="-" id="minus"></span><span><input type="number" name="" id="num" value="1" /></span><span><input type="button" name="plus" id="plus" value="+" /></span>
								
								
						</div>
						<div class="btn">
							<a href="javascript:void(0)" id="conversion">立即兑换</a>
						</div>
					</div>
				</div>
				
				<div class="details center">
					<h4>商品详情</h4>
					<div class="tip">
						<p>【注意事项】 </p>
 						<dl>
 							<dt>1.</dt>
 							<dd>本商品以银子兑换、不开具发票，如您兑换本商品即视为您完全认可该规则。 </dd>
 						</dl>
 						<dl>
 							<dt>2.</dt>
 							<dd>银子兑换商品，如遇质量问题请致电京东商城进行售后处理。 </dd>
 						</dl>
 						<dl>
 							<dt>3.</dt>
 							<dd>若无质量问题，不支持退换货。如遇退货情况，所使用的银子不予返还。</dd>
 						</dl>
					</div>
					<div class="details-pic">
                         ${goods.detail}
					</div>
				</div>
			</div>
		</div>
		
		<!--客服悬浮条-->
		<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>
		<!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			$(function(){
				var num = $('#num');
				$('#minus').attr('disabled',true);
				$('#plus').click(function(){
					 // 给获取的val加上绝对值，避免出现负数
					num.val(Math.abs(parseInt(num.val()))+1);
					 if (parseInt(num.val())!=1){
					 	console.log('ceshi')
					  	 $('#minus').attr('disabled',false);
					 };
					if(parseInt(num.val())>=99){
						$("#plus").attr("disabled","disabled");
						layer.msg('数量不能超高99个');
					}else{
						$("#plus").removeAttr("disabled");
					}
				});
				$('#minus').click(function(){
					num.val(Math.abs(parseInt(num.val()))-1);
					$("#plus").removeAttr("disabled");
					if (parseInt(num.val())==1){
					 	$('#minus').attr('disabled',true);
					};
				})
				
			});

            function getEncodedCurrentURL() {
                return encodeURIComponent(location.href);
            }

			function showLoginPrompt() {
                layer.alert('很抱歉，登录后才可以购买商品，请先登录!', {title : '温馨提示', btn: ['登录', '取消']}, function () {
                    location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
                }, function () {

                });
            }

			$('#conversion').click(function() {
			    if (!'${pcuser.id}') {
			        showLoginPrompt();
                    return;
                }
                if('${goods.points}'*$('#num').val()>$("#userIntegral").html()){
                    layer.alert('很抱歉，银子不足!');
                    return;
                }
			    location.href = '/yingpu/pc/pointsmall/orderSubmit?goodsId=${param.goodsId}&goodsNum=' + $('#num').val();
            })

		</script>

		
	</body>
</html>
