<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=1220"/>
    <title>营普金服—参股商业银行的互联网金融服务平台</title>
    <!--<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">-->
    <meta name="Description"
          content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
    <meta name="Keywords"
          content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
    <link rel="shortcut icon" href="../../img/logo1.icon"/>
    <link rel="stylesheet" type="text/css" href="../../css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/common.css"/>
    <!--<link rel="stylesheet" type="text/css" href="../infomation/css/Nov_activity.css"/>-->
    <link rel="stylesheet" type="text/css" href="css/Newyear_activity5.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/animate.css"/>

    <script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>

    <style>
        .cjBtn {
            color: #fff;
        }
    </style>
</head>
<body>

<!--顶部-->

<iframe src="../../head.html" class="iframe-head" width="100%" scrolling="no"
        style="border:0px;display: none;"></iframe>

<!--主体-->
<div class="content">
    <div class="section banner">
        <!--<div class="center">
            <div class="act-tit">
                <img src="img/img5/tit.png"/>
            </div>

            <div class="prize-des">
                <p>从2018年5月1日起，用户投资年化每满<span>800元</span>，即可获得1次摔碗赢奖品机会，</p>
                <p>将有机会摔到<span>跑步机</span>和<span>小米扫地机器人</span>等大奖，</p>
                <p>获奖记录可在“我的账户—我的奖励—抽奖奖励”中查看。</p>
            </div>
        </div>-->
    </div>
    <div class="section luckydraw">
        <div class="lucky-top center">
            <div class="list">
                <div class="prize-list" id="demo" style="overflow:hidden;width:210px;" align=center>
                    <table border=0 align=center cellpadding=1 cellspacing=1 cellspace=0>
                        <tr>
                            <td valign=top id=marquePic1>
                                <table width='100%' border='0' cellspacing='0'>
                                    <tr id="prizeList">
                                        <!--<td align=center><img src="img/img4/images/15yuan-e.png"
                                                              width=162 height=122 border=0></td>
                                        <td align=center><img src="img/img4/images/5yuan-e.png"
                                                              width=162 height=122 border=0></td>
                                        <td align=center><img src="img/img4/images/15yuan-e.png"
                                                              width=162 height=122 border=0></td>
                                        <td align=center><img src="img/img4/images/5yuan-e.png"
                                                              width=162 height=122 border=0></td>-->
                                    </tr>
                                </table>
                            </td>
                            <td id=marquePic2 valign=top></td>
                        </tr>
                    </table>
                </div>
                <div class="record-list">
                    <div id="scroll_div"
                         style="width:162px;height:45px;margin:0 auto;white-space: nowrap;overflow:hidden;">
                        <div id="scroll_begin" style="">
                            <!--	<span>用户13845678945,抽到iohoneX。</span><span>用户13845678945,抽到15元京东e卡。</span><span>用户13845678945,抽到30元京东e卡</span> -->
                        </div>
                        <div id="scroll_end" style="display: inline;"></div>
                    </div>
                </div>
            </div>

            <div class="luckydraw-num">
                <p>您剩余<span class="num"> 0</span>次抽奖机会!</p>
            </div>

            <!--<div class="qizi">
                <img src="img/img5/jiu.png"/>
            </div>-->
        </div>
        <div class="luckydraw-main">
            <div class="center">
                <ul class="luckydraw-box clearfix" id="luck">
                    <li class="prize prize1">
                        <img src="img/img5/jiugang.png"/>
                    </li>
                    <li class="prize prize2">
                        <img src="img/img5/jiugang.png"/>
                    </li>
                    <li class="prize prize3">
                        <img src="img/img5/jiugang.png"/>
                    </li>
                    <li class="prize prize4">
                        <img src="img/img5/jiugang.png"/>
                    </li>
                    <li class="prize prize5">
                        <img src="img/img5/jiugang.png"/>
                    </li>
                    <li class="prize prize6">
                        <img src="img/img5/jiugang.png"/>
                    </li>
                    <li class="prize prize7">
                        <img src="img/img5/jiugang.png"/>
                    </li>
                    <li class="prize prize8">
                        <img src="img/img5/jiugang.png"/>
                    </li>
                    <li class="prize prize9">
                        <img src="img/img5/jiugang.png"/>
                    </li>
                </ul>

                <div class="people">
                    <img src="img/img5/images/people_02.png"/>
                </div>

                <div class="wan">
                    <img src="img/img5/images/suiwan_02.png"/>
                </div>

            </div>

        </div>
        <div class="btn" style="margin-top: -20px;">
            <a href="../../project/list">立即投资</a>
        </div>
        
    </div>
    <div class="section instruction">
        <div class="act-des">
            <h5>活动说明:</h5>
            <dl>
                <dt>1、</dt>
                <dd>用户获奖后，可与营普金服客服取得联系，安排后续发货兑奖，请您保持通讯畅通。</dd>
            </dl>
            <dl>
                <dt>2、</dt>
                <dd>虚拟奖品以电子验证码、赠送等方式兑换；实物奖品均由第三方发货，营普金服不负责售后 质量问题。如用户提供的收货地址、收货人联系方式错误，损失由用户自行承担。
                </dd>
            </dl>
            <dl>
                <dt>3、</dt>
                <dd>所有礼物，不支持现金折现。请在活动结束前，及时使用您的抽奖机会。</dd>
            </dl>
            <div class="act-tip">
                <p>温馨提示：投资年化金额=投资本金/12×标的期限</p>
                <p>活动时间：2018年5月1日-2018年5月31日</p>
            </div>
        </div>
    </div>
</div>
<div id="fade" class="black-overlay"></div>
<div class="rewards animated tada" id="rewards">
    <div class="rewards-content">
        <div class="close" onclick="$('#fade').hide();$('#rewards').hide();"></div>
        <div class="rewards-box clearfix">
            <!--<div class="text left">
                <p>恭喜您</p>
                <p>抽到<span>王者荣耀孙悟空限定皮肤</span></p>
                <p>获奖后，平台客服会在3个工作日内与您取得联系，安排后续发货兑奖，请您保持通讯畅通。</p>
            </div>
            <div class="pic left">
                <img src="../img/active-dec/zhizb.png"/>
            </div>-->
        </div>
    </div>
</div>

<!--客服悬浮条-->
<!--<iframe src="../../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
<iframe src="../../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>-->
<script src="../../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
<script src="../../js/utils.js" type="text/javascript" charset="utf-8"></script>

<!--底部导航-->
<iframe src="../../footer.html" width="100%" scrolling="no"
        style="border:0px;height:326px;"></iframe>

<!--加载js文件-->
<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../../.././layer-v3.0.3/layer/layer.js" type="text/javascript"
        charset="utf-8"></script>
<script src="js/modernizr.min.js" type="text/javascript" charset="utf-8"></script>
<script src="js/jquery.easing.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    //=======实现点击动作=======

    //加载奖品列表
    $.post('/yingpu/pc/prize/list/json', {activityId: 22}, function (data) {
        console.log(data);
        var html = '';
        $.each(data.data, function (i, o) {
            html += '<td align=center><img src="' + o.prizeicon + '" width=162 height=122 border=0></td>';
        });
        $('#prizeList').html(html);
        imgScroll();
    });


    function imgScroll() {
        var speed = 50
        marquePic2.innerHTML = marquePic1.innerHTML

        function Marquee() {
            if (demo.scrollLeft >= marquePic1.scrollWidth) {
                demo.scrollLeft = 0
            } else {
                demo.scrollLeft++
            }
        }

        var MyMar = setInterval(Marquee, speed)
        demo.onmouseover = function () {
            clearInterval(MyMar)
        }
        demo.onmouseout = function () {
            MyMar = setInterval(Marquee, speed)
        }
    }

    $.post('/yingpu/pc/prize/20180501/throwbowl/info/json', {activityId: 22}, function(data) {
        if (data.status == 'success') {
            var info = data.data || {};
            $('span.num').html(
            		Math.max(0, (info.totalDrawTimes || 0) - (info.usedDrawTimes || 0)));
        }
    });

    //加载最近抽奖记录
    $.post('/yingpu/pc/prize/randprizeHis/list/json', {
        pageIndex: 1,
        activityId: 22
    }, function (data) {
        console.log(data);
        var html = '';
        $.each(data.data || [], function (i, o) {
            html += '<span>用户' + o.phone.substring(0, 3) + '****' + o.phone.substring(7, 11) + '抽到' + o.prizename + '</span>';
        });
        $('#scroll_begin').html(html);
        ScrollImgLeft();
    });


    function ScrollImgLeft() {
        var speed = 40;
        var scroll_begin = document.getElementById("scroll_begin");
        var scroll_end = document.getElementById("scroll_end");
        var scroll_div = document.getElementById("scroll_div");
        scroll_end.innerHTML = scroll_begin.innerHTML;

        function Marquee() {
            if (scroll_end.offsetWidth - scroll_div.scrollLeft <= 0)
                scroll_div.scrollLeft -= scroll_begin.offsetWidth;
            else
                scroll_div.scrollLeft++;
        }

        var MyMar = setInterval(Marquee, speed);


        scroll_div.onmouseover = function () {
            clearInterval(MyMar);
        }
        scroll_div.onmouseout = function () {
            MyMar = setInterval(Marquee, speed);
        }
    }

    //点击抽奖
    //			$('.luckydraw-box .prize').on('click','img',function(){
    //				$(this).attr('src','img/img4/5-e.png');
    //			});

    //弹出奖品层
    $("#fade").height($(document).height());

    useLoadingShade();

    function getEncodedCurrentURL() {
        return encodeURIComponent(location.href);
    }

    function showLoginPrompt() {
        layer.alert('很抱歉，登录后才可以抽奖，请先登录!', {title : '温馨提示', btn: ['登录', '取消']}, function () {
            location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
        }, function () {

        });
    }

    function isLogin() {
        return !!'${pcuser.phone}';
    }


    $(document).ready(function () {

        $(".close").on('click',function(){
            $('.wan').css({top:'200px',left:'950px'}).show();
        })

        if (!isLogin()) {
            showLoginPrompt();
        }

        var click = false;
        gPrizes = {};
        window.onload = function () {
            var wanInit = 0;
            $("#luck .prize img").click(function () {
                var $this = $(this);

//		    		$("#luck .prize img").each(function(){
//		    			if($(this).attr('wsrc')){
//		    				$(this).attr('src',$(this).attr('wsrc'));
//		    			}
//		    		});
                if (!isLogin()) {
                    showLoginPrompt();
                    return;
                }

                var Num = $('span[class="num"]').html();
                if (Num <= 0) {
                    layer.alert('您当前的抽奖次数不足', function () {
                        layer.closeAll();
                    });
                    return;
                } else {

                    if (wanInit == 0) {
                        wanInit = $(".wan").offset();
                    } else {
                        $(".wan").offset(wanInit);
                    }
                    console.log(wanInit);
                    _Top = $(this).offset().top - wanInit.top;
                    _Left = $(this).offset().left - wanInit.left;
                    $('.wan').animate({top: _Top + 200, left: _Left + 750}, 200)
                }

                layer.load(2);
                $.post('/yingpu/pc/prize/20180501/throwbowl/json', {activityId: 22}, function (data) {
                    layer.closeAll();
                    data.prize = data.data;
                    if (data.status != 'success' && data.status != 'ok') {
                        layer.alert(data.message);
                        return false;
                    } else {
//							$this.attr('wsrc',$this.attr('src'));
//							$this.attr('src',data.data.prizeimg);
                        $("#fade").show();
                        $("#rewards").show();
                        var html = '';
                        if (data.prize.prizename.indexOf('谢谢参与') == -1) {
                            html += '<div class="text left">';
                            html += '	<p>恭喜您</p>';
                            html += '<p>抽到<span>' + data.prize.prizename + '</span></p>';
                            html += '<p>获奖后，平台客服会在3个工作日内与您取得联系，安排后续发货兑奖，请您保持通讯畅通。</p></div>';
                            html += '	<div class="pic left">';
                            html += '<img src="' + data.prize.prizeimg + '"/>	</div>';
                        } else {
                            html += '<div class="text left" style="margin-top: 17px;">';
                            html += '	<p>谢谢参与！</p>';
                            html += '<p style="font-size: 14px;"><br/>豆亲，您离神秘大礼就差一步了哦！加油加油</p>';
                            html += '<!--<p>获奖后，平台客服会在3个工作日内与您取得联系，安排后续发货兑奖，请您保持通讯畅通。</p>--></div>';
                            html += '	<div class="pic left">';
                            html += '<img src="' + data.prize.prizeimg + '"/>	</div>';
                        }
                        $('.rewards-box').html(html);
                        $('.luckydraw-num').html('<p>你剩余<span class="num">' + --Num + '</span>次抽奖机会！');
                        $('span[class=num]').html(Num);
                    }
                });
            });
        };
    });
    $(function () {
        $(window).scroll(function () {
            $('.iframe-head').show();
        });
    });
</script>
</body>
</html>
