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
	<title>营普金服—参股商业银行的互联网金融服务平台</title>
	<!--<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">-->
	<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
	<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
	<link rel="shortcut icon" href="../../img/logo1.icon"/>
	<link rel="stylesheet" type="text/css" href="../../css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="../../css/common.css"/>
	<!--<link rel="stylesheet" type="text/css" href="../infomation/css/Nov_activity.css"/>-->
	<link rel="stylesheet" type="text/css" href="css/activity1.css"/>
	<link rel="stylesheet" type="text/css" href="../../css/animate.css"/>
	<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>

<!--顶部-->

<iframe src="../../head.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;display:block;"></iframe>

<!--主体-->
<div class="content">
	<img src="img/title.png" alt="zhounianqing"/>
	<p class="p1">分为4个小队：A队-抖友队，B队-锻友队，C队-撸友队，D队-老铁队。</p>
	<p>1.冠军将按照每队投资总年化金额排名来选出，再按排名分别选出</p>
	<p>冠军5万，亚军3万，季军1万5，殿军5千。</p>
	<p>2.每个人员将按照所对应的小队赢得的京东卡，按照个人投资年化金额在本小队所占的总</p>
	<p>年化金额百分比瓜分大奖。</p>
</div>
<div class="sction">
	<div class="k1">
		<div class="d1">
			<img src="img/p1.png" alt=""/>
			<p>抖友队口号：确认过眼神，我遇见对的人。</p>
		</div>
		<div class="d2">
			<p class="total" style="color: #915113">年化总金额：<span id="douyou_annualized" style="color: #915113">0</span></p>
				<span class="onself1" style="color: #248F52">小队人数：<span id="douyou_user_num" style="color: #248F52">0</span></span>
				<span class="onself2" style="color: #C48F2A">个人年化金额：<span id="douyou_self_annualized" style="color: #C48F2A">0</span></span>
				<img src="img/join.png" alt="" style="z-index: 100;position: absolute;width: 99.5%;height: 100%;"/>
		</div>

		<!--<img src="img/zui1-bg.png" alt=""/>
		<p class="d1">抖友队口号：确认过眼神，我遇见对的人。</p>
		<div class="bg1">
			<p class="p1">
				<span class="span0">年化总金额：<span id="douyou_annualized">0</span></span>
				<span class="span1">小队人数：<span id="douyou_user_num">0</span></span>
			</p>
			<p class="p2">
				<span class="span2">个人年化金额：<span id="douyou_self_annualized">0</span></span>
			</p>
			<img src="img/zui1-img.jpg" alt="" style="display:block"/>
			<button type="button">加入该队</button>
		</div>-->

	</div>
	<div class="k2">
		<div class="d2">
			<p class="total" style="color: #915113">年化总金额：<span id="luyou_annualized" style="color: #915113">0</span></p>
				<span class="onself1" style="color: #248F52">小队人数：<span id="luyou_user_num" style="color: #248F52">0</span></span>
				<span class="onself2" style="color: #C48F2A">个人年化金额：<span id="luyou_self_annualized" style="color: #C48F2A">0</span></span>
			<img src="img/join.png" alt="" style="z-index: 100;position: absolute;width: 100%;height: 100%;"/>
		</div>
			<div class="d1" >
				<p>撸友队口号：大吉大利，带你吃鸡。</p>
				<img src="img/p2.png" alt=""/>
			</div>
		<!--<img src="img/zui2-bg.png" alt=""/>
		<p class="d2">撸友队口号：大吉大利，带你吃鸡。</p>
		<div class="bg2">

			<p class="p1">
				<span class="span0">年化总金额：<span id="luyou_annualized">0</span></span>
				<span class="span1">小队人数：<span id="luyou_user_num">0</span></span>
			</p>
			<p class="p2">
				<span class="span2">个人年化金额：<span id="luyou_self_annualized">0</span></span>
			</p>
			<img src="img/zui2-img.jpg" alt="" style="display:block"/>
			<button type="button">加入该队</button>
		</div>-->

	</div>
	<div class="k3">
		<div class="d1">
			<img src="img/p3.png" alt=""/><p>锻友队口号：滴！滴滴！快上车。</p>
		</div>
		<div class="d2">
			<p class="total" style="color: #915113">年化总金额：<span id="duanyou_annualized"style="color: #915113">0</span></p>
			<p class="total2">
				<span class="onself1" style="color: #248F52">小队人数：<span id="duanyou_user_num" style="color: #248F52">0</span></span>
				<span class="onself2" style="color: #C48F2A">个人年化金额：<span id="duanyou_self_annualized" style="color: #C48F2A">0</span></span>
				<img src="img/join.png" alt="" style="z-index: 100;position: absolute;width: 99%;height: 100%;"/>
			</p>
		</div>
		<!--<img src="img/zui3-bg.png" alt=""/>
		<p class="d3">锻友队口号：滴！滴滴！快上车。</p>
		<div class="bg3">

			<p class="p1">
				<span class="span0">年化总金额：<span id="duanyou_annualized">0</span></span>
				<span class="span1">小队人数：<span id="duanyou_user_num">0</span></span>
			</p>
			<p class="p2">
				<span class="span2">个人年化金额：<span id="duanyou_self_annualized">0</span></span>
			</p>
			<img src="img/zui3-img.jpg" alt="" style="display: block"/>
			<button type="button">加入该队</button>
		</div>-->
	</div>
	<div class="k4">
		<div class="d2">
				<p class="total" style="color: #915113">年化总金额：<span id="laotie_annualized" style="color: #915113">0</span></p>
				<span class="onself1" style="color: #248F52">小队人数：<span id="laotie_user_num" style="color: #248F52">0</span></span>
				<span class="onself2" style="color: #C48F2A">个人年化金额：<span id="laotie_self_annualized" style="color: #C48F2A">0</span></span>
			<img src="img/join.png" alt="" style="z-index: 100;position: absolute;width: 100%;height: 100%;"/>
		</div>
		<div class="d1">
			<p>老铁队口号：老铁！666。</p>
			<img src="img/p4.png" alt=""/>
		</div>
		<!--<img src="img/zui4-bg.png" alt=""/>
		<p class="d4">老铁队口号：老铁！666。</p>
		<div class="bg4">
			<p class="p1">
				<span class="span0">年化总金额：<span id="laotie_annualized">0</span></span>
				<span class="span1">小队人数：<span id="laotie_user_num">0</span></span>
			</p>
			<p class="p2">
				<span class="span2">个人年化金额：<span id="laotie_self_annualized">0</span></span>
			</p>
			<img src="img/zui4-img.jpg" alt="" style="display: block"/>
			<button type="button">加入该队</button>
		</div>-->
	</div>

</div>
<div class="footer">
		<p class="p3"><span class="sp1" onclick="window.location.href='../../project/list'">立即投资</span></p>
		<div class="smmb">
			<p class="sp2">活动说明：</p>
			<p>1、用户获奖后，可与营普金服客服取得联系，安排后续发货兑奖，请您保持通讯通畅</p>
			<p>2、虚拟奖品以电子验证码、赠送等方式兑换；实物奖品均由第三方发货，营普金服不负责售后质量问题。如用户提供的收货地址、收货人联系方式错误，损失由用户自行承担。</p>
			<p>3、所有礼物，不支持现金折现。</p>
		</div>
</div>

<!--客服悬浮条-->
<!--<iframe src="../../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
<iframe src="../../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>-->
<script src="../../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
<script src="../../js/utils.js" type="text/javascript" charset="utf-8"></script>

<!--底部导航-->
<iframe src="../../footer.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>

<!--加载js文件-->
<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../../js/utils.js" type="text/javascript" charset="utf-8"></script>

<script src="../../.././layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
		$(".sction .k1 .d2 img").click(function(){
			join(1);
		});
		$(".sction .k2 .d2 img").click(function(){
			join(2);
		});
		$(".sction .k3 .d2 img").click(function(){
			join(3);
		});
		$(".sction .k4 .d2 img").click(function(){
			join(4);
		});
	})

	var teamCodes = {
            '抖友队' : 'douyou',
            '撸友队' : 'luyou',
            '段友队' : 'duanyou',
            '老铁队' : 'laotie'
        },
        fields = {
            totalAnnualized : 'annualized',
            userNum : 'user_num',
            self_annualized : 'self_annualized'
        },
        annualizeds = {
	        'douyou' : 1528193.58,
            'luyou' : 1613492.02,
            'duanyou' : 1406411.07,
            'laotie' : 1461531.25
        },
        startTimeStamp = new Date('2018-06-05 18:30').getTime();

	function isLogin() {
		return !!'${pcuser.phone}';
	}

	function getEncodedCurrentURL() {
		return encodeURIComponent(location.href);
	}

    function showLoginPrompt() {
        layer.alert('很抱歉，登录后才参加此活动，请先登录!', {title : '温馨提示', btn: ['登录', '取消']}, function () {
            location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
        }, function () {

        });
    }

	function loadTeams() {
	    var nowStamp = new Date().getTime(),
            spendTimeStamp = Math.max(0, nowStamp - startTimeStamp),
            spendMinutes = Math.floor(spendTimeStamp / 1000 / 60 / 30);

		// 加载小队列表
		$.get('/yingpu/pc/activity/20180501/activity_group/list/json', {}, function (data) {
			$.each(data.data || [], function(i, t) {
                for (var i in fields) {
					var field = fields[i];
                    if (i == 'totalAnnualized' && annualizeds.hasOwnProperty(teamCodes[t.groupName])) {
                        t[i] = (annualizeds[teamCodes[t.groupName]] + Math.min(8, spendMinutes) * 100000).toFixed(2);
                    }
					if (t[i]) {
                        $('#' + teamCodes[t.groupName] + '_' + field).html(t[i]);
                    }
				}
			});

			$(".sction .d2").find("img").hide();
		});
	}

	function loadUser() {
		// 加载用户信息
		$.get('/yingpu/pc/activity/20180501/user_info/list/json', {}, function (data) {
			if (data.status == 'success') {
				var info = data.data;
				if (info) {
					$('#' + teamCodes[info.groupName] + '_' + fields.self_annualized).html(info.annualized);
					loadTeams();
				}
			}
		});
	}

	// 加入小队
	function join(gId) {
		if (!isLogin()) {
			showLoginPrompt();
			return;
		}

		$.get('/yingpu/pc/activity/20180501/activity_group/join/json', {groupId: gId }, function (data) {
			if (data.status == 'success') {
				loadUser();
			}
			else {
				layer.msg(data.message);
			}
		});
	}

	useLoadingShade();
	loadUser();
</script>
</body>
</html>