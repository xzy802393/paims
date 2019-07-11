<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="../../../css/reset.css"/>
		
		<link rel="stylesheet" type="text/css" href="css/huodong.css"/>
		<link rel="stylesheet" type="text/css" href="../../../css/common.css"/>
		<link rel="shortcut icon" href="../../../img/logo1.icon"/>
		<title></title>
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../../../head3.html" class="iframe-head" width="100%" height="110px" scrolling="no"  style="border:0px;display: block;"></iframe>	
		
		<!--主体-->
		<div id="content">
			<div id="banner">
				<div class="banner">
					<div class="title"><img src="img/bannerTitle.png" ></div>
				</div>
				<div class="text">
					<p>2019年4月1日起，用户投资年化每满800，即可砸金蛋一次。邀请好友注册实名认证之后可获得300年化。获奖记录可在“我的账户—我的奖励—抽奖奖励”中查看。</p>
					<p>活动时间：2019年4月1日到2019年4月30日</p>
				</div>
				
			</div>
			<div id="jiangpinZS">
				<div class="title">
					<h1><div class="miaoshu">奖品展示</div></h1>
				</div>
				<ul class="jiangpin">
					<li class="items clearFix">
						<div class="item">
							<img src="img/5.jpg" >
							<p class="p1">京东E卡（电子卡）</p>
							<p class="p2"><span>￥</span>5</p>
						</div>
						<div class="item">
							<img src="img/10.jpg" >
							<p class="p1">京东E卡（电子卡）</p>
							<p class="p2"><span>￥</span>10</p>
						</div>
						<div class="item">
							<img src="img/20.jpg" >
							<p class="p1">京东E卡（电子卡）</p>
							<p class="p2"><span>￥</span>20</p>
						</div>
					</li>
					<li class="items clearFix">
						<div class="item">
							<img src="img/30.jpg" >
							<p class="p1">京东E卡（电子卡）</p>
							<p class="p2"><span>￥</span>30</p>
						</div>
						<div class="item">
							<img src="img/50.jpg" >
							<p class="p1">京东E卡（电子卡）</p>
							<p class="p2"><span>￥</span>50</p>
						</div>
						<div class="item">
							<img src="img/100.jpg" >
							<p class="p1">京东E卡（电子卡）</p>
							<p class="p2"><span>￥</span>100</p>
						</div>
					</li>
					<li class="items clearFix">
						<div class="item">
							<img src="img/zhijin.png" >
							<p class="p1">心相印抽纸 3层120抽*18包</p>
							<p class="p2"><span>￥</span>39.80</p>
						</div>
						<div class="item">
							<img src="img/iphone.png" >
							<p class="p1">Apple iPhone XS 64GB </p>
							<p class="p2"><span>￥</span>8699.00</p>
						</div>
						<div class="item">
							<img src="img/ipad.png" >
							<p class="p1">Apple iPad Pro 11英寸</p>
							<p class="p2"><span>￥</span>7699.00</p>
						</div>
					</li>
				</ul>
				<div class="touzi">
					<h1><div class="miaoshu"><a href="/yingpu/pc/project/list?backUrl=/yingpu/pc/active-19/19-3/huodong/index.jsp">立即投资</a></div></h1>
				</div>
			</div>
			<div id="active">
				<div class="cishu">
					<h1><div class="miaoshu">剩余<span class="num">0</span>次开奖机会</div></h1>
				</div>
				<ul class="main">
					
					<li class="list">
						<div class="box">
							<div class="listL">
								<img src="img/dan1.png" alt="" class="dan1" style="display: block;">
								<img src="img/chuizi.png" alt="" class="chui" style="display: none;">
								<div class="sui1" style="display: none;">
									<img src="" alt="" class="jiang">
								</div>
							</div>
							<div class="listR">
								<img src="img/dan1.png" alt="" class="dan1" style="display: block;">
								<img src="img/chuizi.png" alt="" class="chui" style="display: none;">
								<div class="sui1" style="display: none;">
									<img src="" alt="" class="jiang">
								</div>
							</div>
						</div>
						
					</li>
					<li class="list">
						<div class="box">
							<div class="listL">
								<img src="img/dan2.png" alt="" class="dan1" style="display: block;">
								<img src="img/chuizi.png" alt="" class="chui" style="display: none;">
								<div class="sui1" style="display: none;">
									<img src="" alt="" class="jiang">
								</div>
							</div>
							<div class="listR">
								<img src="img/dan2.png" alt="" class="dan1" style="display: block;">
								<img src="img/chuizi.png" alt="" class="chui" style="display: none;">
								<div class="sui1" style="display: none;">
									<img src="" alt="" class="jiang">
								</div>
							</div>
						</div>
					</li>
					<li class="list">
						<div class="box">
							<div class="listL">
								<img src="img/dan3.png" alt="" class="dan1" style="display: block;">
								<img src="img/chuizi.png" alt="" class="chui" style="display: none;">
								<div class="sui1" style="display: none;">
									<img src="" alt="" class="jiang">
								</div>
							</div>
							<div class="listR">
								<img src="img/dan3.png" alt="" class="dan1" style="display: block;">
								<img src="img/chuizi.png" alt="" class="chui" style="display: none;">
								<div class="sui1" style="display: none;">
									<img src="" alt="" class="jiang">
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div id="bottom">
				<div class="shuoming">
					<div class="box">
						<h3>活动说明</h3>
						<div class="text">
							<p>1、用户获奖后，可与九趣贷官方客服取得联系，安排后续发货对奖，请您保持通讯畅通。</p>
							<p>2、虚拟奖品以电子验证码，赠送等方式兑换；实物奖品均由第三方发货，九趣贷不负责售后质量问题。如用户提供的收货地址、收货人联系方式错误，损失由用户自行承担。</p>
							<p>3、所有礼物不支持现金折现。请在活动结束前，及时使用您的抽奖机会。</p>
							<p>温馨提示：年化投资金额=实际投资金额/12*标的期限（月份）</p>
						</div>
					</div>
					
				</div>
				
			</div>	
		</div>	
			
		<div id="tankuang">
			<div class="content1" id="prize">
				<div class="bg">
					<div class="prize">
						<p class="jiang">京东 E 卡</p>
						<p class="money">价值:￥<span class="nums"></span></p>
					</div>
				</div>
			</div>
			<div class="content2" id="nothing">
				<div class="bg"></div>
			</div>
		</div>
		
		<!--底部导航-->
		<!-- <iframe src="../../../footer.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe> -->
		<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/huodong.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
            function isLogin() {
                return !!'${pcuser.phone}';
            }
            function getEncodedCurrentURL() {
                return encodeURIComponent(location.href);
            }

            function showLoginPrompt() {
                layer.alert('很抱歉，登录后才可参加此活动，请先登录!', {title: '温馨提示', btn: ['登录', '取消']}, function () {
                    location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
                }, function () {

                });
            }
		</script>

	</body>
</html>
