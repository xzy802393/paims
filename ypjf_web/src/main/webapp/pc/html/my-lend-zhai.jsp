<%@ page language="java" import="java.util.*, java.util.regex.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>九趣贷 — 贷快乐，更带梦想</title>
    <link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
    <link rel="stylesheet" type="text/css" href="../css/common3.css"/>
    <link rel="stylesheet" type="text/css" href="../css/my-lend.css"/>

</head>
<body>
<!-- 导航 -->
<iframe src="/yingpu/pc/head3.html?index=1" class="iframe-headfu" width="100%" height="110px" scrolling="no"
        style="border:0px;display: block;z-index:1000"></iframe>
<!-- banner -->
<div id="banner"style="background: #665ed7"><img src="/yingpu/pc/img/banner3.jpg" ondragstart="return false" oncontextmenu="return false"></div>
<!-- 项目名nav -->
<div id="title">
    <ul class="nav clearFix">
        <li><span><a href="javascript:tzurl('/project/findProject')">新手专享</a></span></li>
        <li><span><a href="../my-invest/zhiTou.jsp">X快享智能投标</a></span></li>
        <li><span><a href="javascript:tzurl('/project/list')">散标</a></span></li>
        <li><span class="active">债权转让</span></li>
    </ul>
</div>
<div id="content">
    <ul class="xiangmu">
        <!-- 新手专享 -->
        <li id="tab" class="tab1" style="display: none;">
            <!-- 按钮区域 -->
            <!-- <div class="btn">
                <div class="leiXing">
                    <dt>项目类型：</dt>
                    <dd class="active">全部</dd>
                    <dd>新手标</dd>
                </div>
                <div class="qiXian">
                    <dt>项目期限：</dt>
                    <dd class="active">全部</dd>
                    <dd>1个月</dd>
                    <dd>3个月</dd>
                </div>
            </div> -->
            <!-- 项目列表区域 -->
        </li>
        <!-- 智投 -->
        <li id="tab" class="tab2" style="display: none;"></li>
        <!-- 散标 -->
        <li id="tab" class="tab3" style="display: none;">
            <!-- 按钮区域 -->
            <ul class="btn">
                <li class="leiXing">
                    <dt>项目类型：</dt>
                    <dd class="active">全部</dd>
                    <dd>消费贷</dd>
                    <dd>车融贷</dd>
                    <dd>房融贷</dd>
                    <dd>商企贷</dd>
                </li>
                <li class="qiXian">
                    <dt>项目期限：</dt>
                    <dd class="active">全部</dd>
                    <dd>1-3月</dd>
                    <dd>6-12月</dd>
                    <dd>12个月以上</dd>
                </li>
                <li class="nianHuaLv">
                    <dt>年化利率：</dt>
                    <dd class="active">全部</dd>
                    <dd>7%以上</dd>
                    <dd>9%以上</dd>
                    <dd>12%以上</dd>
                </li>
                <li class="huanKuanfs">
                    <dt>还款方式：</dt>
                    <dd class="active">全部</dd>
                    <dd>按月付息</dd>
                    <dd>到期还本</dd>
                    <dd>到期还本还息</dd>
                    <dd>等额本息</dd>
                </li>
            </ul>
            <!-- 项目列表区域 -->
                <!-- 新版 -->

        </li>
        <!-- 债券转让 -->
        <li id="tab" class="tab4" style="display: block;">
            <!-- 按钮区域 -->
            <ul class="btn">
                <li class="qiXian">
                    <dt>项目期限：</dt>
                    <dd data="{deadline: ''}" class="active">全部</dd>
                    <dd data="{deadline:'0-6'}">6个月内</dd>
                    <dd data="{deadline:'6-12'}">6-12个月</dd>
                    <dd data="{deadline:'12-99'}">12个月以上</dd>
                </li>
                <li class="huanKuanfs">
                    <dt>排序方式：</dt>
                    <dd data="{sort: ''}" class="active">全部</dd>
                    <dd data='{sort:"rate"}'>原标利率</dd>
                    <dd data='{sort:"deadline"}'>项目期限</dd>
                    <dd data='{sort:"premium"}'>溢折价</dd>
                </li>
            </ul>
            <!-- 项目列表区域 -->
            <ul class="list">
                <c:if test="${empty data.data}">
                    <span style="display: block; font-size: 22px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>
                </c:if>
                <c:forEach items="${data.data}" var="list">
                    <li class="items">
                        <p class="names">${list.name}</p>
                        <div class="item">
                            <div class="a1">
                                <p class="p1 nhl"><span class="numNHL num">
                                    <fmt:formatNumber value="${list.estimatedAnnualRate * 100}" pattern="##0.00" /></span>%
                                </p>
                                <p class="text">原标利率</p>
                            </div>
                            <div class="a1">
                                <p class="p1 qX"><span class="numQX num">${list.deadLine}</span>个月</p>
                                <p class="text">原标期限</p>
                            </div>
                            <div class="a1">
                                <p class="p2 syqx">
                                    <fmt:formatNumber value="${list.holdDays / 30}" pattern="###0" />个月${list.holdDays % 30}天
                                </p>
                                <p class="text">剩余期限</p>
                            </div>
                            <div class="a1">
                                <p class="p2 bj"><span class="benjin" benjin="${list.investmentAmount + list.assignedAmount}"></span>元</p>
                                <p class="text">债权本金</p>
                            </div>
                            <div class="a1">
                                <p class="p2 zqlx" id="zqlx"><span class="interest" interest="${list.debtInterest}"></span>元</p>
                                <p class="text">当月债权利息</p>
                            </div>
                            <div class="a1">
                                <p class="p2 zqze"><span class="zhaiquansum" zhaiquansum="${list.investmentAmount + list.assignedAmount}"></span>元</p>
                                <p class="text">债权总额</p>
                            </div>
                            <div class="a1">
                                <p class="p2 syje"><span class="shengyumoney" shengyumoney="${list.investmentAmount}"></span></p>
                                <p class="text">剩余承接金额</p>
                            </div>
                            <div class="a1">
                                <p class="p2 hkrq">${fn:substring(list.nextInterest, 0, 10)}</p>
                                <p class="text">下个回款时期</p>
                            </div>
                            <div class="a1">
                                <div style="position: relative;">
                                    <canvas id="${list.id}" percent="${(list.assignedAmount) / (list.investmentAmount + list.assignedAmount)}" style="position: absolute;left:38px;top:17px;" width="46" height="46"></canvas>
                                </div>
                            </div>
                            <div class="a1">
                                <a href="/yingpu/pc/project/debt/receive/confirm?id=${list.itemId}" class="btnCJ">立即承接</a>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </li>
    </ul>
    <div class="record-page" style="display:block;">
        <div class="record-page-list">
            <a href="javascript:void(gogogo('home'))" class="on">首页</a>
            <a href="javascript:void(gogogo('prev'))">上一页</a>
            <c:set var="page" value="${data.page}" />
            <c:forEach var="index" begin="${page.pageIndex + 4 > page.pageCount ?
										(page.pageCount - 4 < 1 ? 1 : page.pageCount - 4) : page.pageIndex}"
                       end="${page.pageCount < page.pageIndex + 4 ? page.pageCount : page.pageIndex + 4}" step="1">
                <a href="javascript:void(goURLByCondition({pageIndex : '${index}'}))" class="${page.pageIndex == index ? 'active' : ''}">${index}</a>
            </c:forEach>
            <a href="javascript:void(gogogo('next'))">下一页</a>
        </div>
    </div>
</div>
<!--悬浮条-->
<iframe src="../xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
<iframe src="../yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>

<!-- 底部footer -->
<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;display: block;z-index:1000"></iframe>
<script src="../js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/progress.js" type="text/javascript" charset="utf-8"></script>
<script src="/yingpu/layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="../newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
<%--<script src="../js/my-lend.js" type="text/javascript" charset="utf-8"></script>--%>
<script>
    var conditions = {
            deadline : '',
            sort : ''
        },
        baseUrl = '<%=basePath%>pc/project/findZhai';


    String.prototype.contains = function() {
        if (!arguments.length) return false;

        var strs = arguments;
        for (var i = 0; i < strs.length; i++) {
            if (this.indexOf(strs[i]) == -1) {
                return false;
            }
        }
        return true;
    };


    function parseParam() {
        var param = {},
            str = arguments[0] || '';

        if (str && str.trim().length > 0 && (str.contains('&') || str.contains('='))) {
            var temp = str.contains('&') ? str.split('&') : [str];
            for (var i = 0; i < temp.length; i++) {
                arr = temp[i].split('=');
                param[arr[0]] = !!arr[1] ? decodeURIComponent(arr[1]) : null;
            }
        }

        return param;
    }


    function getURLParam(kvs) {
        var param = '';
        for (var k in conditions) {
            param += k + '=' + encodeURIComponent(conditions[k]) + '&';
        }

        return param.substring(0, param.length - 1);
    }


    function goURLByCondition(applyCdts) {
        if (!applyCdts.pageIndex) {
            applyCdts.pageIndex = 1;
        }
        for (var k in applyCdts) {
            if (applyCdts[k] == null) {
                continue;
            }

            conditions[k] = applyCdts[k];
        }

        /*if ('${isLogin}' != 'true') {
            layer.alert('对不起，登陆后才可以查看，请先登录!', { btn : ['登录', '取消'] }, function() {
                location.href = '/yingpu/pc/login?backUrl=' + encodeURIComponent(baseUrl + '?' + getURLParam(conditions));
            }, function() {

            });
            return;
        }*/

        goURL(baseUrl + '?' + getURLParam(conditions));
    }


    function goURL(url) {
        location.href = url;
    }


    function gogogo(act) {
        var pageCount = '${page.pageCount}' * 1,
            totalCount = '${page.pageIndex}' * 1;
        pageIndex = parseInt(pageIndex) || 1;
        switch(act) {
            case 'home':
            case 'tail':
                pageIndex = act == 'home' ? 1 : pageCount;
                break;

            case 'next':
            case 'prev':
                pageIndex += act == 'next' ? 1 : -1;
                break;
        }

        console.log(pageIndex)
        pageIndex = Math.max(1, Math.min(pageIndex, pageCount));

        goURLByCondition({ pageIndex : pageIndex });
    }

    function viewWithoutInvestPrompt() {
        layer.alert('您未投资该项目，无法查看此项目详情！');
    }

    function viewEndedProjectPrompt() {
        layer.alert('此项目已还款！');
    }

    function viewWithoutLoginPrompt() {
        layer.alert('您尚未登录，无法查看此项目详情！');
    }

    $(function(){
        var urlParams = parseParam(location.search.substring(1));
        for (var k in conditions) {
            if (!!urlParams[k]) {
                conditions[k] = urlParams[k];
            }
        }

        pageIndex = conditions.pageIndex || 1;
        $('.btn dd').click(function() {
            $(this).parent().find('dd').removeClass('active').eq($(this)).addClass('active');
            var data = eval('(' + $(this).attr('data') + ')');
            for (var k in data) {
                conditions[k] = data[k];
            }
           goURLByCondition({});
        });

        $('.btn dd').removeClass('active').each(function(i, e) {
            var data = eval('(' + $(e).attr('data') + ')');
            for (var k in conditions) {
                if (data && data[k] == conditions[k]) {
                    $(this).addClass('active');
                }
            }
        });
    });
</script>
<script type="text/javascript">
    jisuan();
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
    })


    function tzurl(url) {
        top.location.href = '/yingpu/pc' + url;
    }

    function jisuan() {
        $('.jindu').each(function (e) {
            var totalAmount = $(this).attr('totalAmount');
            var financingAmount = $(this).attr('financingAmount');
            $(this).css("width", (totalAmount-financingAmount) / totalAmount * 100 + "%");
        });
        $('.benjin').each(function (e) {
            $(this).html(commafy(returnFloat($(this).attr('benjin'))));
        });
        $('.interest').each(function (e) {
            $(this).html(commafy(returnFloat($(this).attr('interest'))));
        });
        $('.zhaiquansum').each(function (e) {
            $(this).html(commafy(returnFloat($(this).attr('zhaiquansum'))));
        });
        $('.shengyumoney').each(function (e) {
            $(this).html(commafy(returnFloat($(this).attr('shengyumoney'))));
        });
    }
    //数据添加分隔符
    function commafy(num) {
        return num && num
            .toString()
            .replace(/(\d)(?=(\d{3})+\.)/g, function ($1, $2) {
                return $2 + ',';
            });
    }
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

</script>
</body>
</html>
