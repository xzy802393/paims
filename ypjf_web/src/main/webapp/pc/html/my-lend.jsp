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
<iframe src="/yingpu/pc/head3.html?index=1" class="iframe-headfu" width="100%" height="110px" scrolling="no" style="border:0px;display: block;z-index:1000"></iframe>
<!-- banner -->
<div id="banner"style="background:#2e6dd7;"><img src="/yingpu/pc/img/banner2.jpg" ondragstart="return false" oncontextmenu="return false"></div>
<!-- 项目名nav -->
<div id="title">
    <ul class="nav clearFix">
        <li><span><a href="javascript:tzurl('/project/findProject')">新手专享</a></span></li>
        <li><span><a href="../my-invest/zhiTou.jsp">X快享智能投标</a></span></li>
        <li><span class="active">散标</span></li>
        <li><span><a href="javascript:tzurl('/project/findZhai');">债权转让</a></span></li>
    </ul>
</div>
<div id="content">
    <ul class="xiangmu">
        <!-- 新手专享 -->
        <li id="tab" class="tab1" style="display:none;">
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
            <ul class="list">
                <c:forEach items="${list}" var="p">
                    <li class="item">
                        <div class="a1">
                                <%--<p class="name">新手专享-优选体验</p>--%>
                            <p class="name"><a href="${isLogin ?
                                        ((p.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(p.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (p.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(p.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}">${p.name}</a></p>

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
                                    <span class="boxKuang"><span class="jindu" totalAmount="${p.totalAmount}"
                                                                 financingAmount="${p.financingAmount}"></span></span>
                                </p>
                                <p class="text">剩余额度：<span class="shengyuED"><span
                                        class="sz">${p.financingAmount}</span>万元</span></p>
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
            </ul>
        </li>
        <!-- 智投 -->
        <li id="tab" class="tab2" style="display: none;"></li>
        <!-- 散标 -->
        <li id="tab" class="tab3" style="display: block;">
            <!-- 按钮区域 -->
            <ul class="btn">
                <li class="leiXing">
                    <dt>项目类型：</dt>
                    <dd><a href="javascript:void(goURLByCondition({categoryId : ''}))" class="${empty param.categoryId ? 'active' : ''}">全部</a></dd>
                    <%--<c:forEach items="${categories}" var="c">--%>
                    <%--</c:forEach>--%>
                    <dd><a class="${param.categoryId == categories[3].id ? 'active' : ''}" href="javascript:void(goURLByCondition({categoryId : '${categories[3].id}'}))">${categories[3].name}</a></dd>
                    <dd><a class="${param.categoryId == categories[0].id ? 'active' : ''}" href="javascript:void(goURLByCondition({categoryId : '${categories[0].id}'}))">${categories[0].name}</a></dd>
                    <dd><a class="${param.categoryId == categories[2].id ? 'active' : ''}" href="javascript:void(goURLByCondition({categoryId : '${categories[2].id}'}))">${categories[2].name}</a></dd>
                    <dd><a class="${param.categoryId == categories[1].id ? 'active' : ''}" href="javascript:void(goURLByCondition({categoryId : '${categories[1].id}'}))">${categories[1].name}</a></dd>
                </li>
                <li class="qiXian">
                    <dt>项目期限：</dt>
                    <%--<dd><a href="javascript:void(goURLByCondition({deadLine : ''}))" class="${empty param.deadLine ? 'active' : ''}">全部</a></dd>--%>
                    <%--<c:forEach items="${deadlines}" var="d">--%>
                        <%--<c:if test="${d.deadline != 0}">--%>
                            <%--<dd><a class="${param.deadLine == d.deadline ? 'active' : ''}" href="javascript:void(goURLByCondition({deadLine : '${d.deadline}'}))">${d.deadline}个月</a></dd>--%>
                        <%--</c:if>--%>
                    <%--</c:forEach>--%>
                    <dd><a href="javascript:void(goURLByCondition({deadLine : ''}))" class="${empty param.deadLine ? 'active' : ''}">全部</a></dd>
                    <dd><a data="{deadLine:'1-3'}">1-3月</a></dd>
                    <dd><a data="{deadLine:'6-12'}">6-12月</a></dd>
                    <dd><a data="{deadLine:'12'}">12个月以上</a></dd>
                </li>
                <li class="nianHuaLv">
                    <dt>年化利率：</dt>
                    <dd><a href="javascript:void(goURLByCondition({estimatedAnnualRate : ''}))" class="${empty param.estimatedAnnualRate ? 'active' : ''}">全部</a></dd>
                    <dd><a data="{estimatedAnnualRate : '0.07-1'}">7%以上</a></dd>
                    <dd><a data="{estimatedAnnualRate : '0.09-1'}">9%以上</a></dd>
                    <dd><a data="{estimatedAnnualRate : '0.12-1'}">12%以上</a></dd>
                </li>
                <li class="huanKuanfs">
                    <dt>还款方式：</dt>
                    <dd><a href="javascript:void(goURLByCondition({repayment : ''}))" class="${empty param.repayment ? 'active' : ''}">全部</a></dd>
                    <c:forEach items="${repayment}" var="r">
                        <dd><a class="${param.repayment == r.id ? 'active' : ''}" href="javascript:void(goURLByCondition({repayment : '${r.id}'}))">${r.repay}</a></dd>
                    </c:forEach>
                    <%--<dd>按月付息</dd>--%>
                    <%--<dd>到期还本</dd>--%>
                    <%--<dd>到期还本还息</dd>--%>
                    <%--<dd>等额本息</dd>--%>
                </li>
            </ul>
            <!-- 项目列表区域 -->
            <ul class="list" id="san">
                <!-- 新版 -->
                <c:forEach items="${list}" var="san">
                <li class="items">
                    <%--<p class="names">消费贷</p>--%>
                    <p class="names"><a href="${isLogin ?
                                        ((san.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(san.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (san.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(san.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}">${san.name}</a></p>
                    <div class="item">
                        <div class="a1">
                            <p class="p1 nhl"><span class="numNHL num"><fmt:formatNumber type="number" value="${san.estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
                            <p class="text">预期年化收益率</p>
                        </div>
                        <div class="a1">
                            <p class="p1 qX"><span class="numQX num">${san.deadLine}</span>个月</p>
                            <p class="text">借款期限</p>
                        </div>
                        <div class="a1">
                            <p class="p3 zongE"><span class="benjin" benjin="${san.totalAmount}"></span></p>
                            <p class="text">项目总额</p>
                        </div>
                        <div class="a1">
                            <p class="p3 fangShi">${san.repayment}</p>
                            <p class="text">还款方式</p>
                        </div>
                        <div class="a2">
                            <div class="box">
                                <p class="progress">
                                    <span class="boxKuang"><span class="jindu" totalAmount="${san.totalAmount}" financingAmount="${san.financingAmount}"></span></span>
                                </p>
                                    <p class="text">剩余额度：<span class="shengyuED"><span class="sz" surplusValue="${san.financingAmount}"></span>元</span></p>
                            </div>
                        </div>
                        <div class="a1">
                            <%--<a href="#" class="btnCJ">立即出借</a>--%>
                                <a href="${isLogin ?
                                        ((san.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(san.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (san.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(san.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}"
                                   class="btnCJ">${status[san.status][0]}</a>
                        </div>
                    </div>
                </li>
                </c:forEach>
            </ul>

        </li>
    </ul>
    <%--翻页--%>
    <div class="record-page" style="display:block;">
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
    benjin();
    numbee();
    jisuan();
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
    function benjin(){
        $('.benjin').each(function (e) {
            $(this).html(commafy(returnFloat($(this).attr('benjin'))));
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
<script>
    var conditions = {
            categoryId : '',
            deadLine : '',
            estimatedAnnualRate : '',
            totalAmount : '',
            pageIndex : 1
        },
        baseUrl = '<%=basePath%>pc/project/list';


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
    });
</script>
<script type="text/javascript">
    $(document).ready(function(){
        $('.progress-bar').each(function(e){
            var totalAmount=$(this).attr('totalAmount');
            var financingAmount=$(this).attr('financingAmount');
            var yitouzi=accAdd(totalAmount,-financingAmount);

            $(this).LineProgressbar({
                percentage:  accMul(100,accDiv(yitouzi,totalAmount).toFixed(4)),
                fillBackgroundColor: '#ff7f01',
                height: '12px',
                radius: '6px'
            });
        });

        $('[data]').each(function() {
            var data = eval('(' + $(this).attr('data') + ')');
            for (var k in data) {
                if (conditions[k] == data[k]) {
                    $(this).addClass('active');
                }
            }

            $(this).click((function(d) {
                return function() { goURLByCondition(d) };
            })(data));

        });

        // console.log($('#san .items').size());
        if ($('#san .items').size() == 0) {
            $('<div style="width: 100%; height: 200px; text-align: center;margin-top: 5%; margin-bottom: 5%; margin-left: -50px;">'
                + '<p style="color: gray; font-size: 1.2rem; ">'
                + '<span style="display: block; font-size: 22px; margin-left: 20%;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>'
                + '</p></div>').insertAfter('#san');
            $('.record-page').hide();
        }
    })
</script>
<script type="text/javascript">
	// 标列表添加阴影
	biaoshade();
	function biaoshade(){
		var lisliebiao = $('#san .items');
		// console.log(lisliebiao)
		lisliebiao.hover(function(){
			$(this).css({'box-shadow':'0px 0px 2px 1px #d0d0d0'});
			$(this).find('.item').css('border-bottom','none');
			
		},function(){
			$(this).css({'box-shadow':'none'});
			// $(this).find('.item').css('border-bottom','1px solid #d0d0d0');
			
		});
	};
	
</script>
</body>
</html>
