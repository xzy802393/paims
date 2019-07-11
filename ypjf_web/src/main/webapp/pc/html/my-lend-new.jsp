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
<iframe src="/yingpu/pc/head3.html?index=1" class="iframe-headfu" width="100%" scrolling="no" height="110px" style="border:0px;display: block;z-index:1000"></iframe>
<!-- banner -->
<div id="banner" style="background:#ff4749;"><img src="/yingpu/pc/img/banner0.jpg" ondragstart="return false" oncontextmenu="return false"></div>
<!-- 项目名nav -->
<div id="title">
    <ul class="nav clearFix">
        <li><span class="active">新手专享</span></li>
        <li><span><a href="../my-invest/zhiTou.jsp">X快享智能投标</a></span></li>
        <li><span><a href="javascript:tzurl('/project/list');">散标</a></span></li>
        <li><span><a href="javascript:tzurl('/project/findZhai');">债权转让</a></span></li>
    </ul>
</div>
<div id="content">
    <ul class="xiangmu">
        <!-- 新手专享 -->
        <li id="tab" class="tab1" style="display: block;">
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
            <ul class="list" id="newShou">
                <c:if test="${empty newProject}">
                    <li class="item" style="height: 279px;">
                        <span style="display: block; font-size: 22px;margin: auto;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>
                    </li>
                </c:if>

                <c:if test="${not empty newProject}" >
                <c:forEach items="${newProject}" var="p">
                    <li class="item">
                        <div class="a1">
                                <p class="name">新手专享-优选体验</p>
                            <%--<p class="name">${p.name}</p>--%>

                        </div>
                        <div class="a1">
                            <p class="p1 nhl"><span class="numNHL num"><fmt:formatNumber type="number"
                                                                                         value="${p.estimatedAnnualRate*100}"
                                                                                         pattern="0.00"
                                                                                         maxFractionDigits="2"/></span>%
                            </p>
                            <p class="text">预期年化收益率</p>
                        </div>
                        <div class="a1">
                            <p class="p1 qX"><span class="numQX num">${p.deadLine}</span>个月</p>
                            <p class="text">借款期限</p>
                        </div>
                        <div class="a2">
                            <div class="box">
                                <p class="progress">
                                    <span class="boxKuang"><span class="jindu" totalAmount="${p.totalAmount}" financingAmount="${p.financingAmount}"></span></span>
                                </p>
                                <p class="text">剩余额度：<span class="shengyuED"><span class="sz" surplusValue="${p.financingAmount}"></span>元</span></p>
                            </div>
                        </div>
                        <div class="a1">
                                <%--<a href="#" class="btnCJ">立即出借</a>--%>
                            <a href="${isLogin ?
                                        ((p.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(p.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (p.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(p.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}"
                               class="btnCJ">${status[p.status][0]}</a>
                        </div>
                    </li>
                </c:forEach>
                </c:if>
            </ul>
    </ul>
    <div class="record-page" style="display:none;">
        <div class="record-page-list">
            <a href="javascript:void(gogogo('home'))" class="on">首页</a>
            <a href="javascript:void(gogogo('prev'))">上一页</a>
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
<script type="text/javascript">
    jisuan();
    numbee();
    function tzurl(url) {
        top.location.href = '/yingpu/pc' + url;
    }

    function jisuan() {
        $('.jindu').each(function (e) {
            var totalAmount = $(this).attr('totalAmount');
            var financingAmount = $(this).attr('financingAmount');
            $(this).css("width", (totalAmount-financingAmount) / totalAmount * 100 + "%");
        });
    }
    function numbee(){
        $('.sz').each(function (e) {
            var Amount = $(this).attr('surplusValue');
            var value = commafy(returnFloat(Amount));
            // console.log(value);
            $(this).html(value);
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
<script type="text/javascript">
	// 标列表添加阴影
	biaoshade();
	function biaoshade(){
		var lisliebiao = $('#newShou .item');
		// console.log(lisliebiao)
		lisliebiao.hover(function(){
			$(this).css({'box-shadow':'0px 0px 2px 1px #d0d0d0'});
			$(this).find('.item').css('border-bottom','none');
			
		},function(){
			$(this).css({'box-shadow':'none'});
			// $(this).find('.item').css('border-bottom','1px solid #d0d0d0');
			
		});
	};
    function viewWithoutInvestPrompt() {
        layer.alert('您未投资该项目，无法查看此项目详情！');
    }

    function viewEndedProjectPrompt() {
        layer.alert('此项目已还款！');
    }

    function viewWithoutLoginPrompt() {
        layer.alert('您尚未登录，无法查看此项目详情！');
    }
	
</script>
</body>
</html>
