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
    <meta name="viewport" content="width=1220"/>
    <title>营普金服—参股商业银行的互联网金融服务平台</title>   
    <!--<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">-->
    <meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
    <meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
    <link rel="shortcut icon" href="../../img/logo1.icon"/>
    <link rel="stylesheet" type="text/css" href="../../css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/common.css"/>
    <!--<link rel="stylesheet" type="text/css" href="../infomation/css/Nov_activity.css"/>-->
    <link rel="stylesheet" type="text/css" href="css/dragonboat.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/animate.css"/>
    <link rel="stylesheet" href="css/media.css" />
    <script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>

<!--顶部-->

<iframe src="../../head.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;display:block;"></iframe>

<!--主体-->
<div class="banner">
    <img src="img/dragonboat/bannerText.png"/>
    <div class="bannerText">
        <h2 style="text-align: center;color:#3B90B4;margin: 40px 0">活动日期：2018年6月6日到6月30日</h2>
        <p>
            冠军队将按照每队投资总年化金额和距离排名来选出，再按排名分别选出冠军，亚军，季军，殿军。每个队员将按照所对应小队赢得的奖品，按照个人投资年化总金额在该小队所占的总年化百分比瓜分大奖。
        </p>
        <p>投资年化每满800元，投资人所划龙舟小队可前行八十米。</p>
        <p>邀请好友成功注册（实名认证并绑定银行卡后）点击龙舟上方点赞小按钮呐喊助威，龙舟可前行十米（被邀请人将自动归入邀请人的龙舟中）。</p>
    </div>
</div>
<div class="zhandui" id="zhan" style="z-index: 100;background: #8DDBD8;width: 100%;height: 100rem;text-align:center;display: block;">
    <div>
        <img src="img/dragonboat/long1.png" alt="梦之队" style="width:31%"/>
        <img src="img/dragonboat/long2.png" alt="腾飞队"/>
    </div>
    <div>
        <img src="img/dragonboat/long3.png" alt="神龙队"/>
        <img src="img/dragonboat/long4.png" alt="远征队" style="width:32%"/>
    </div>
</div>
<div class="sction" style="position: relative;display: none;">
    <div class="s1" style="position: relative">
        <div class="nhje" style="position: absolute;bottom: 4%;right: 3%;">
            <div class="d1">
                <p>年化总金额：<span>127.05</span></p>
                <p>个人年化金额：<span>0</span></p>
                <p>小队人数：<span>27</span></p>
            </div>
            <div class="d2">
                <p>年化总金额：<span>127.05</span></p>
                <p>个人年化金额：<span>0</span></p>
                <p>小队人数：<span>27</span></p>
            </div>
            <div class="d3">
                <p>年化总金额：<span>127.05</span></p>
                <p>个人年化金额：<span>0</span></p>
                <p>小队人数：<span>27</span></p>
            </div>
            <div class="d4">
                <p>年化总金额：<span>127.05</span></p>
                <p>个人年化金额：<span>0</span></p>
                <p>小队人数：<span>27</span></p>
            </div>
        </div>
        <img src="img/dragonboat/saichengzhibo.png" alt="赛程直播" style="width: 100%;"/>
        <img class="boat" src="img/dragonboat/xlong1.png" id="img_5" alt=""
             style="position: absolute;top: 32%;left: 7%;margin-top: 0;"/>
        <a href="javascript:void(0)" class="zan1" id="zan_5">
            <img src="img/dragonboat/zan1.png" id="zan" alt=""
                 style="position: absolute; top: 30%;left: 14%;margin-top: 0;width: 2%;"/>
        </a>
        <img src="img/dragonboat/biao.png" alt="" style="position: absolute; top: 43%;
    left: 17%;margin-top: 0;"/>
        <span clss="biao1"
              style="position: absolute; top: 43.7%;left: 19.8%;margin-top: 0;font-size: 0.8rem; width: 80px; ">0米</span>
        <img class="boat" src="img/dragonboat/xlong2.png" id="img_6" alt=""
             style="position: absolute;top: 49%;left: 7%;margin-top: 0;"/>
        <a href="javascript:void(0)" class="zan2" id="zan_6">
            <img src="img/dragonboat/zan2.png" alt=""
                 style="position: absolute; top: 48%;left: 8%;margin-top: 0;width: 2%;"/>
        </a>
        <img src="img/dragonboat/biao.png" alt="" style="position: absolute; top: 60%;

    left: 17%;margin-top: 0;"/>
        <span clss="biao2" style="position: absolute; top: 60.7%;left: 19.8%;margin-top: 0;font-size: 0.8rem;">0米</span>
        <img class="boat" src="img/dragonboat/xlong3.png" id="img_7" alt=""
             style="position: absolute;top: 66%;left: 7%;margin-top: 0;"/>
        <a href="javascript:void(0)" class="zan3" id="zan_7">
            <img src="img/dragonboat/zan3.png" alt=""
                 style="position: absolute; top: 65%;left: 12%;margin-top: 0;width: 5%;"/>
        </a>
        <img src="img/dragonboat/biao.png" alt="" style="position: absolute;     top: 78%;
    left: 17%;margin-top: 0;"/>
        <span clss="biao3" style="position: absolute; top: 78.7%;left: 19.8%;margin-top: 0;font-size: 0.8rem;">0米</span>
        <img class="boat" src="img/dragonboat/xlong4.png" id="img_8" alt=""
             style="position: absolute;top: 83%;left: 7%;margin-top: 0;"/>
        <a href="javascript:void(0)" class="zan4" id="zan_8">
            <img src="img/dragonboat/zan4.png" alt=""
                 style="position: absolute; top: 78%;left: 9.4%;margin-top: 0;width: 2%;"/>
        </a>
        <img src="img/dragonboat/biao.png" alt="" style="position: absolute;top: 96%;left: 17%;margin-top: 0;"/>
        <span clss="biao4" style="position: absolute; top: 96.7%;left: 19.8%;margin-top: 0;font-size: 0.8rem;">0米</span>
    </div>
    <div class="s2" style="width: 50%;margin: 40px auto;">
        <a href="/yingpu/pc/project/list"><img src="img/dragonboat/lijitouzi.png" alt="投资"/></a>
        <!--<a id="invite"  href="/yingpu/pc/infomation/generalize/generalize.html?code=${pcuser.phone}&amp;method=invite&amp;type=activity&amp;activityId=39">-->
        <a id="invite" href="javascript:void(0)">
            <img src="img/dragonboat/yaoqinghaoyou.png" alt="邀请" style="float: right"/></a>
    </div>
    <div class="s3" style="position: relative">
        <img src="img/dragonboat/king.png" alt="" style="position: absolute;top: 24.5%;left: 33%;margin-top: 0;width: 2%;z-index: 50;"/>
        <div class="guize">
            <p>冠军队将按照每队投资总年化金额和距离排名来选出，在按排名分别选出冠军， 亚军，季军，殿军。每个人员将按照所对应小队赢得的奖品，按照个人投资年化金额在本小队所占的总年化金额百分比瓜分大奖。</p>
            <p class="p1"><span>第一名:</span>龙舟成员将以个人投资年化占该小队总投资年化的百分比瓜分<span>5万元大奖</span></p>
            <p class="p2"><span>第二名:</span>龙舟成员将以个人投资年化占该小队总投资年化的百分比瓜分<span>3万元大奖</span></p>
            <p class="p3"><span>第三名:</span>龙舟成员将以个人投资年化占该小队总投资年化的百分比瓜分<span>1.5万元大奖</span></p>
            <p class="p4"><span>第四名:</span>龙舟成员将以个人投资年化占该小队总投资年化的百分比瓜分<span>5千元大奖</span></p>
        </div>
        <img src="img/dragonboat/huodongguize.png" alt="" style="width: 100%;margin: 2% auto;display: inherit;"/>
        <img src="img/dragonboat/footer.png" alt="" style="width: 100%;"/>
        <div class="shuoming">
        <dl>
            <dt>1、</dt>
            <dd>用户获奖后，可与营普金服取得联系，安排后续发货对奖，请你保持通讯畅通。</dd>
        </dl>
        <dl>
            <dt>2、</dt>
            <dd>虚拟奖品以电子验证码，赠送等方式兑换；实物奖品均由第三方发货，营普金服不负责售后质量问题。如用户提供的收货地址、收货人联系方式错误，损失由用户自行承担。</dd>
        </dl>
        <dl>
            <dt>3、</dt>
            <dd>所有礼物不支持现金折现。请在活动结束前，及时使用你的抽奖机会。</dd>
        </dl>
            <p style="text-align: center">温馨提示：年化投资金额=实际投资金额/12*标的期限（月份）</p>
            <p style="text-align: center">活动时间：2018年6月6日到2018年6月30日</p>
        </div>
    </div>
</div>

<!--邀请好友-->
<div class="invite" style="display: none;">
	<div class="invite-friends">
		<p>将您的邀请专属链接发送给您的好友</p>
		<div class="visit-link">
			<p class="link">http://www.yingpuwealth.com/yingpu/pc/infomation/generalize/generalize.html?code=${pcuser.phone}&amp;method=invite&amp;type=activity&amp;activityId=39</p>
		</div>
		<p class="copy-btn">复制链接</p>
	</div>
</div>

<!--团队投资记录-->
<div class="dragonboat-lists">	
	<table border="1" bordercolor="#a0c6e5" style="border-collapse:collapse;">
		<tr>
			<th>排名</th>
			<%--<th>用户姓名</th>--%>
			<th>用户</th>
			<th>投资额度</th>
			<th>投资年化</th>
			<th>小队总年化</th>
			<th>投资年化占比</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
		<tr>
			<td>1</td>
			<td>王**</td>
			<td>152****4105</td>
			<td>200000</td>
			<th>16666</th>
			<th>20</th>
		</tr>
	</table>
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
<script src="../../js/jquery.zclip/jquery.zclip.js"></script>
<script type="text/javascript">

    var teamInfo = {
            '梦之队' : {
                class : 'd1',
                id : 5
            },
            '腾飞队' : {
                class : 'd2',
                id : 6
            },
            '神龙队' : {
                class : 'd3',
                id : 7
            },
            '远征队' : {
                class : 'd4',
                id : 8
            }
        },
        activityId = 39,
        dragonBoatInfos = {};

    var MAX_DRAGON_BOAT_MOVE_DISTANCE = 550000,
        MAX_DRAGON_BOAT_VIEW_WIDTH = 1200,
        ACTUAL_WIDTH_PERCENT = 63;
        CALCULATION_SCALE = MAX_DRAGON_BOAT_VIEW_WIDTH / MAX_DRAGON_BOAT_MOVE_DISTANCE;

    function getDistanceInView(distance) {
        return distance * CALCULATION_SCALE;
    }

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

    function getMovePercent(dis) {
        return getDistanceInView(dis) / MAX_DRAGON_BOAT_VIEW_WIDTH
                * ACTUAL_WIDTH_PERCENT;
    }

    function showBoatView() {
        $.each(teamInfo, function(name, info) {
            var movePercent = getMovePercent(dragonBoatInfos[name]);

            console.log(movePercent);

            $('#img_' + info.id).css('left', function() {
                return (parseFloat($(this)[0].style.left.replace('%', ''))
                        + movePercent) + '%';
            }).next().find('img').css('left', function() {
                return (parseFloat($(this)[0].style.left.replace('%', ''))
                    + movePercent) + '%';
            }).end().next('img').css('left', function() {
                return (parseFloat($(this)[0].style.left.replace('%', ''))
                    + movePercent) + '%';
            }).next().css('left', function() {
                return (parseFloat($(this)[0].style.left.replace('%', ''))
                    + movePercent) + '%';
            }).html(dragonBoatInfos[name] + '米');
        });
    }

    function loadTeams() {
        // 加载小队列表
        $.get('/yingpu/pc/activity/201806/dragon_boat/info/json', {
            activityId : activityId
        }, function (data) {
            var infoContainers;
            $.each(data.data || [], function(i, t) {
                infoContainers = $('.' + teamInfo[t.groupName].class + ' span');
                infoContainers.eq(0).html(t.totalAnnualized || 0);
                infoContainers.eq(1).html(t.userAnnualized || 0);
                infoContainers.eq(2).html(t.userNum || 0);
                dragonBoatInfos[t.groupName] = t.moveDistance || 0;
            });

            showBoatView();
        });
    }

    function loadUserDetails(gId) {
    	return;
        // 加载小队列表
        $.get('/yingpu/pc/activity/201806/dragonboat/user/details/json', {
            groupId : gId
        }, function (data) {
            if (data.status == 'success') {
                var list = '';

                $.each(data.data || [], function(i, o) {
                    list += '<tr>' +
                        '<td>' + -~i + '</td>' +
                        /*'<td>' + (o.realName || '').substring(0, 1) + '**</td>' +*/
                        '<td>' + o.phone.substring(0, 3) + '****' + o.phone.substring(7, 11) + '</td>' +
                        '<td>' + o.investAmount + '</td>' +
                        '<td>' + o.annualized + '</td>' +
                        '<td>' + o.totalAnnualized + '</td>' +
                        '<td>' + ((parseFloat(o.annualizedPercent) || 0) * 100).toFixed(4) + '%</td>' +
                        '</tr>'
                });

                $('div.dragonboat-lists>table tr:gt(0)').remove();
                $('div.dragonboat-lists>table').append(list);

                var name;
                for (var i in teamInfo) {
                    var o = teamInfo[i];
                    if (o.id == gId) {
                        name = i;
                    }
                }

                layer.open({
                    type: 1, //Page层类型
                    title: [name + '投资记录', 'font-size:18px;text-align:center;'],
                    skin: 'layui-layer-rim',
                    area: ['893px', '600px'],
                    shade: 0.6, //遮罩透明度
                    content: $('.dragonboat-lists'),
                    end : function() {

                    }
                });
            }

        });
    }


    // 加入小队
    function join(gId, cb) {
        if (!isLogin()) {
            showLoginPrompt();
            return;
        }

        $.get('/yingpu/pc/activity/201806/dragon_boat/activity_group/join/json', {
            groupId: gId,
            actId : activityId
        }, function (data) {
            if (data.status == 'success') {
                loadTeams();
                cb && cb();
            }
            else {
                layer.msg(data.message);
            }
        });
    }

    function loadUser() {
        // 加载用户信息
        $.get('/yingpu/pc/activity/201806/dragonboat/userinfo/json', {activityId : activityId}, function (data) {
            if (data.status == 'success') {
                var info = data.data;
                if (!$.isEmptyObject(info)) {
                    loadTeams();
                    $(".zhandui").css({"display":"none" });
                    $(".sction").css({"display":"block"})
                }
            }
        });
    }

    function praise(gId) {
        $.get('/yingpu/pc/activity/201806/dragon_boat/cheerfor/json', {
            activityId : activityId,
            groupId : gId
        }, function (data) {
            if (data.status == 'success') {
                var movePercent = getMovePercent(data.data);

                $('#img_' + gId).css('left', function() {
                    return (parseFloat($(this)[0].style.left.replace('%', ''))
                        + movePercent) + '%';
                }).next().find('img').css('left', function() {
                    return (parseFloat($(this)[0].style.left.replace('%', ''))
                        + movePercent) + '%';
                }).end().next('img').css('left', function() {
                    return (parseFloat($(this)[0].style.left.replace('%', ''))
                        + movePercent) + '%';
                }).next().css('left', function() {
                    return (parseFloat($(this)[0].style.left.replace('%', ''))
                        + movePercent) + '%';
                }).html(function() {
                    return (parseInt($(this).html().replace('米', '')) + data.data) + '米';
                });
                layer.msg('助威成功！');
            }
            else {
                layer.msg(data.message || '');
            }
        });
    }

    useLoadingShade();
    $(".zhandui img").click(function(){
        if (!isLogin()) {
            showLoginPrompt();
            return;
        }

        join(teamInfo[$(this).attr('alt')].id, function() {
            $(".zhandui").css({"display":"none" });
            $(".sction").css({"display":"block"})
        });
    });

    $('[id^=zan_]').on('click', function() {
        var groupId = $(this).attr('id').substr(-1, 1);
        praise(groupId);
    });

	$("#invite").click(function(){
	 var inviteBox = layer.open({
			type: 1, //Page层类型
		    area: ['446px', '234px'],
		    title: false,
		    shade: 0.6, //遮罩透明度
//						  ,maxmin: true //允许全屏最小化
		    anim: 1, //0-6的动画形式，-1不开启
		    content: $(".invite")
		
		});
		
			 $('.copy-btn').zclip({
		        path: "/yingpu/pc/js/jquery.zclip/ZeroClipboard.swf",
		        copy: function(){
		        return $('.visit-link>p').text();
		        },
		        beforeCopy:function(){/* 按住鼠标时的操作 */
		            $('.link').css("color","orange");
		        },
		        afterCopy:function(){/* 复制成功后的操作 */
		           	layer.msg('复制成功');	
		        }
		    });
		
	})
	
	$('body').on('click','.boat',function(){
        loadUserDetails($(this).attr('id').substr(-1, 1));

	})
	
	
    loadUser();
    if (!isLogin()) {
        showLoginPrompt();
    }
</script>
</body>
</html>