<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

    String[][] status = {
            {"", ""},
            {"敬请期待", "invest-btn orange", ""},
            {"立即投资", "invest-btn", ""},
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"/>
    <title>营普金服-首页</title>
    <link rel="stylesheet" type="text/css" href="css/common1.css"/>
    <link rel="stylesheet" type="text/css" href="css/swiper-3.4.2.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/index.css"/>

    <style type="text/css">
        html {
            position: relative;
        }

        .fix {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 13;
            background: #fff;
            display: none;
            color: #000;
        }

        .fix #header .bottom .left a,
        .fix #header .bottom .right a {
            color: #000;
        }

        .fix #header {
            max-width: 1920px;
            min-width: 1200px;
            height: 78px;
            border: none;
            margin: 0 auto;
        }


    </style>
</head>
<body>
<div class="fix">
    <div id="header">
        <div class="bottom clearFix">
            <div class="left">
                <a href="javascript:tiaozhuan('index');"><img src="images/logofu.png" alt="营普金服" class="logo"></a>
                <img src="images/logoRightfu.png" alt="介绍" class="logoRight">
            </div>
            <div class="right">
                <ul class="nav clearFix">
                    <li><a href="javascript:tiaozhuan('index');">首页</a></li>
                    <li><a href="javascript:tiaozhuan('project/list');">我要出借</a></li>
                    <li><a href="javascript:tiaozhuan('borrow');">我要借款</a></li>
                    <li><a href="javascript:tiaozhuan('html/safe/safe.html?index=3');">安全保障</a></li>
                    <li class="xiala"><a href="javascript:tiaozhuan('infomation/aboutUs/platform_intro.html');">信息披露<img src="images/pull.png" alt="下拉菜单" class="pull"></a>
                        <%--<ul>--%>
                            <%--<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/aboutUs/message.html');">信披声明</a></li>--%>
                            <%--<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/aboutUs/platform_intro.html');">平台简介</a></li>--%>
                            <%--<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/operation_data.html');">运营数据</a></li>--%>
                            <%--<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/list');">公告动态</a></li>--%>
                            <%--<li  class="pulllist"><a href="javascript:tiaozhuan('active_center');">活动中心</a></li>--%>
                            <%--<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/lend_process.jsp');">产品中心</a></li>--%>
                            <%--<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/list2');">风险教育</a></li>--%>
                            <%--<li  class="pulllist"><a href="javascript:tiaozhuan('infomation/aboutUs/contacts_us.html');">联系我们</a></li>--%>
                        <%--</ul>--%>
                    </li>
                    <li><a href="javascript:tiaozhuan('pointsmall/points_mall.jsp');">营普客栈</a></li>
                    <li><a href="javascript:tiaozhuan('pc/myaccount/account');">我的账户</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</div>

<div id="banner">
    <div class="banner">

        <!--顶部-->
        <iframe src="head1.html" class="iframe-head" width="100%" scrolling="no" style="border:0px;display: block;z-index:1000"></iframe>
        <div class="banner-list">
            <ul class="imgList" style="width: 500%;">

                <c:forEach items="${data.lunbo}" varStatus="i" var="o">
                    <li><a href="${o.item}"><img src="${o.image}"/></a></li>
                </c:forEach>
                <%--<li><a href="#"><img src="images/banner.jpg"></a></li>--%>

                <%--<li><a href="#"><img src="images/banner.jpg"></a></li>--%>

                <%--<li><a href="#"><img src="images/banner.jpg"></a></li>--%>

                <%--<li><a href="#"><img src="images/banner.jpg"></a></li>--%>

                <%--<li><a href="#"><img src="images/banner.jpg"></a></li>--%>

            </ul>
            <div class="btn">
                <span class="prev"><img src="images/prev.png" alt=""></span>
                <span class="next"><img src="images/next.png" alt=""></span>
            </div>

            <!--分页器
            <!-- <div style="width: 1200px;position: absolute;left: 50%;top:0;margin-left: -600px;z-index: 10;"> -->

            <!-- <ul class="indexList">


                <li class="">冬日温暖红包</li>

                <li class="indexOn">圣诞节抽奖</li>

                <li class="">邀请好友</li>

                <li class="">运营报告</li>

                <li class="">营普客栈</li>

            </ul> -->

            <!--登录之前-->
            <!--登录之前-->


            <div class="login-box" style="display: none;">
                <h4>预期年化收益率</h4>
                <p class="rate">7%-12%</p>
                <p class="active"><a href="../pc/register">注册就送1888元大礼包</a></p>
                <p class="login-btn">已有账户？<a href="../pc/login">立即登录</a></p>
            </div>


            <!--登录之后-->
            <!--登录之后-->
            <c:if test="${not empty pcuser}">
                <div class="login-ok-box">
                    <h4>尊敬的${pcuser.usercode}，您好<!-- <span id="wenhou"></span> --></h4>
                    <div class="yue">
                        <p>可用余额</p>
                        <p><span>${pcuser.caBalance}元</span></p>
                    </div>
                    <!-- <p class="deposit-btn"><a href="#">去充值</a></p> -->
                    <p class="myaccount"><a href="myaccount/account">进入我的账户</a></p>
                </div>
            </c:if>
            <!-- <div class="banner-announce">
                <p><span>广告</span>市场有风险，投资需谨慎</p>
            </div> -->


        </div>
    </div>
</div>
<div id="content">
    <div class="anniu clearFix">
        <div class="left">
            <p><a href="javascript:tiaozhuan('../pc/project/list');" class="text1">我要出借</a></p>
            <p class="text2">产品丰富 安全保障</p>
        </div>
        <div class="right">
            <p><a href="javascript:tiaozhuan('./borrow');" class="text1">我要借款</a></p>
            <p class="text2">风控审核 源头把控</p>
        </div>
    </div>
    <div class="content1">
        <div class="annoce clearFix">
            <div class="left">
                <img src="images/laba.png" alt="公告">
                <p>平台公告</p>
            </div>
            <ul class="center clearFix">
                <li><a href="javascript:ggdea(${data.gonggao[0].id});">${data.gonggao[0].title}</a></li>
                <li><a href="javascript:ggdea(${data.gonggao[1].id});">${data.gonggao[1].title}</a></li>
                <li><a href="javascript:ggdea(${data.gonggao[2].id});">${data.gonggao[2].title}</a></li>
            </ul>
            <div class="more">
                <a href="infomation/list">查看更多</a>
            </div>
        </div>

        <ul class="xinxi clearFix">
            <li class="clearFix">
                <img src="img/cunguan.png" alt="存管银行">
                <div class="wenben">
                    <p class="text1">银行存管</p>
                    <p class="text2">全民普惠，新金融倡导</p>
                </div>

            </li>
            <li class="clearFix">
                <img src="images/anquan.png" alt="存管银行">
                <div class="wenben">
                    <p class="text1">数据安全</p>
                    <p class="text2">电子合同，保障合法权益</p>
                </div>

            </li>
            <li class="clearFix">
                <img src="images/bank.png" alt="存管银行">
                <div class="wenben">
                    <p class="text1">参股银行</p>
                    <p class="text2">法人参股商业银行</p>
                </div>

            </li>
            <li class="clearFix">
                <img src="images/anquan2.png" alt="存管银行">
                <div class="wenben">
                    <p class="text1">严格风控</p>
                    <p class="text2">专业风控，甄选优质项</p>
                </div>

            </li>
            <li class="clearFix">
                <img src="images/hegui.png" alt="存管银行">
                <div class="wenben">
                    <p class="text1">合规透明</p>
                    <p class="text2">标的资料信息透明</p>
                </div>

            </li>
            <li class="clearFix">
                <img src="images/yunying.png" alt="存管银行">
                <div class="wenben">
                    <p class="text1">稳健运营</p>
                    <p class="text2">两年稳健运营，信息透明</p>
                </div>

            </li>
        </ul>
    </div>
    <!-- 数据 -->
    <div class="content2">
        <ul class="data clearFix">
            <li>累计成交<span class="chengjiao"></span>元</li>
            <li>赚取收益<span class="shouyi"></span>元</li>
            <li>收获用户<span class="people"></span>人</li>
            <li>安全运营<span class="day"></span>天</li>
        </ul>
    </div>
    <!-- 新手专区，精彩活动，营普金服APP -->
    <div class="content3">
        <ul class="new clearFix">
            <li class="xinshou">
                <h5>新手专区：</h5>
                <div class="box1 clearFix">
                    <div class="xiangmu">
                        <p class="title">${data.xinren[0].name}</p>
                        <div class="neirong">
                            <p class="nianhua"><span class="num">
							<fmt:formatNumber type="number" value="${data.xinren[0].estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
                            <p class="p1">预期年化收益率</p>
                            <p class="p2">${data.xinren[0].deadLine}<span>个月</span></p>
                            <div class="progress">
                                <span class="jindu"><span totalAmount="${data.xinren[0].totalAmount}" financingAmount="${data.xinren[0].financingAmount}" class="tuli"></span></span>
                            </div>
                        </div>
                        <p class="chujie">
                            <a href="${isLogin ?
                                        ((data.xinren[0].status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(data.xinren[0].id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (data.xinren[0].status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(data.xinren[0].id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}"
                                             class="${status[data.xinren[0].status][1]}">${status[data.xinren[0].status][0]}</a>
                            <%--<a href="../pc/particular/chedairong.jsp">立即出借</a>--%>
                        </p>
                    </div>
                    <ul class="right clearFix">
                        <li class="clearFix">
                            <img src="images/hongbao.png" alt="红包">
                            <div class="wenben">
                                <p class="text1">注册领1888红包</p>
                                <p class="text2"><a href="javascript:tiaozhuan('register')">立即注册 GO!</a></p>
                            </div>
                        </li>
                        <li class="clearFix">
                            <img src="images/xinshoubidu.png" alt="新手引导">
                            <div class="wenben">
                                <p class="text1">新手引导</p>
                                <p class="text2"><a href="javascript:tiaozhuan('infomation/Novice_boot.jsp');">点击查看 GO!</a></p>
                            </div>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="active">
                <h5>精彩活动：</h5>
                <div class="box2">
                    <ul class="clearFix">
                        <li class="clearFix">
                            <img src="images/liwu.png" alt="礼物" class="left">
                            <div class="center">
                                <p class="p1">邀请好友：</p>
                                <p class="p2">老用户终身享好友预期收益的10%</p>
                            </div>
                            <div class="right">
                                <a href="javascript:tiaozhuan('infomation/Feb_activity/invite_friends/invite_friends.jsp');"><img src="images/invite.png" alt="邀请好友"></a>
                            </div>
                        </li>
                        <li class="clearFix">
                            <img src="images/yuanbao.png" alt="元宝" class="left">
                            <div class="center">
                                <p class="p1">营普客栈：</p>
                                <p class="p2">出借送银子礼品兑不停</p>
                            </div>
                            <div class="right">
                                <a href="javascript:tiaozhuan('pointsmall/points_mall.jsp');"><img src="images/duijiang.png" alt="营普客栈"></a>
                            </div>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="app">
                <h5>营普金服APP：</h5>
                <div class="box3">
                    <img src="images/app1.png" alt="app">
                </div>
            </li>
        </ul>
    </div>
    <!-- 产品展示 -->
    <div class="content4 clearFix">
        <div class="box">
            <h3>产品展示:</h3>
            <ul class="left">
                <li class="list listC"><a href="javascript:chedairong();"><p class="xiangMuList">车融贷</p></a></li>
                <li class="list"><a href="javascript:fangdairong();"><p class="xiangMuList">消费贷</p></a></li>
                <li class="list"><a href="javascript:fangdairong();"><p class="xiangMuList">房融贷</p></a></li>
                <li class="list"><a href="javascript:shangqidai();"><p class="xiangMuList">商企贷</p></a></li>
            </ul>
            <ul class="right" id="project">
                <c:if test="${not empty data.chedairong}">
                    <c:forEach items="${data.chedairong}" varStatus="i" var="o">
                        <li class="list">
                            <div class="xiangmu">
                                <p class="title">${o.name}</p>
                                <div class="detail clearFix">
                                    <div class="data">
                                        <p class="p1"><span class="num">${o.deadLine}</span>个月</p>
                                        <p class="wenben">借款期限</p>
                                    </div>
                                    <div class="nianhua">
                                        <p class="p2"><span class="num">
									<fmt:formatNumber type="number" value="${o.estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
                                        <p class="wenben">预期年化收益率</p>
                                    </div>
                                    <div class="total">
                                        <p class="p1"><span class="num">
									<fmt:formatNumber type="number" value="${o.totalAmount/10000}" pattern="0.00" maxFractionDigits=""/></span>万元</p>
                                        <p class="wenben">借款金额</p>
                                    </div>
                                    <div class="progress">
                                        <p class="jindutiao"><span class="jindu"><span totalAmount="${o.totalAmount}" financingAmount="${o.financingAmount}" class="tuli"></span></span></p>
                                        <p class="shengyu">剩余额度：<fmt:formatNumber type="number" value="${o.financingAmount/10000}" pattern="0.00" maxFractionDigits="2"/>万元</p>
                                    </div>
                                    <div class="chujie">
                                        <p class="liji">
                                            <a href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}"
                                               class="${status[o.status][1]}">${status[o.status][0]}</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </c:if>


                <%--<li class="list">
                    <div class="xiangmu">
                        <p class="title">车融贷20181201015</p>
                        <div class="detail clearFix" >
                            <div class="data">
                                <p class="p1"><span class="num">1</span>个月</p>
                                <p class="wenben">借款期限</p>
                            </div>
                            <div class="nianhua">
                                <p class="p2"><span class="num">7.00</span>%</p>
                                <p class="wenben">预期年化收益率</p>
                            </div>
                            <div class="total">
                                <p class="p1"><span class="num">10</span>万元</p>
                                <p class="wenben">借款金额</p>
                            </div>
                            <div class="progress">
                                <p class="jindutiao"><span class="jindu"><span class="tuli"></span></span></p>
                                <p class="shengyu">剩余额度：0万元</p>
                            </div>
                            <div class="chujie">
                                <p class="liji">
                                    <a href="#">立即出借</a>
                                </p>

                            </div>
                        </div>
                    </div>
                </li>
                <li class="list">
                    <div class="xiangmu">
                        <p class="title">车融贷20181201015</p>
                        <div class="detail clearFix" >
                            <div class="data">
                                <p class="p1"><span class="num">1</span>个月</p>
                                <p class="wenben">借款期限</p>
                            </div>
                            <div class="nianhua">
                                <p class="p2"><span class="num">7.00</span>%</p>
                                <p class="wenben">预期年化收益率</p>
                            </div>
                            <div class="total">
                                <p class="p1"><span class="num">10</span>万元</p>
                                <p class="wenben">借款金额</p>
                            </div>
                            <div class="progress">
                                <p class="jindutiao"><span class="jindu"><span class="tuli"></span></span></p>
                                <p class="shengyu">剩余额度：0万元</p>
                            </div>
                            <div class="chujie">
                                <p class="liji">
                                    <a href="#">立即出借</a>
                                </p>

                            </div>
                        </div>
                    </div>
                </li>
                <li class="list last">
                    <div class="xiangmu">
                        <p class="title">车融贷20181201015</p>
                        <div class="detail clearFix" >
                            <div class="data">
                                <p class="p1"><span class="num">1</span>个月</p>
                                <p class="wenben">借款期限</p>
                            </div>
                            <div class="nianhua">
                                <p class="p2"><span class="num">7.00</span>%</p>
                                <p class="wenben">预期年化收益率</p>
                            </div>
                            <div class="total">
                                <p class="p1"><span class="num">10</span>万元</p>
                                <p class="wenben">借款金额</p>
                            </div>
                            <div class="progress">
                                <p class="jindutiao"><span class="jindu"><span class="tuli"></span></span></p>
                                <p class="shengyu">剩余额度：0万元</p>
                            </div>
                            <div class="chujie">
                                <p class="liji">
                                    <a href="#">立即出借</a>
                                </p>

                            </div>
                        </div>
                    </div>
                </li>--%>
            </ul>
        </div>

    </div>
    <!-- 动态和新闻 -->
    <div class="content5">
        <div class="gonggao  clearFix">
            <p class="title"><span class="a1">营普动态:</span><span class="a2">行业新闻:<a href="infomation/list#announce" class="more">查看更多</a></span></p>
            <div class="neirong clearFix">
                <div class="dongtai">
                    <div class="dongtaibox">
                        <ul class="dongtailist clearFix">
                            <c:forEach items="${data.companystate}" var="o">
                            <li class="listlie">
                                <a href="infomation/detail?id=${o.id}&type=companystate">
                                <div class="img">
                                    <img src="${o.pic}" alt="">
                                </div>
                                <p class="biaoti">${o.title}</p >
                                <p class="text">${o.descr}</p >
                                </a>
                            </li>
                            </c:forEach>
                        </ul>
                        <div class="btn">
                            <span class="prev"><img src="images/dongtaibtnl.png" ></span>
                            <span class="next"><img src="images/dongtaibtnr.png" ></span>
                        </div>
                    </div>
                </div>

                <div class="news">
                    <div class="newsbox">
                        <ul class="newslist clearFix">
                            <c:forEach items="${data.news}" var="n">
                            <li class="listlie">
                                <a href="infomation/detail?id=${n.id}&type=news">
                                <div class="img">
                                    <img src="${n.pic}" alt="">
                                </div>
                                <p class="biaoti">${n.title}</p >
                                <p class="text">${n.descr}</p >
                                </a>
                            </li>
                            </c:forEach>
                        </ul>
                        <div class="btn">
                            <span class="prev"><img src="images/dongtaibtnl.png" ></span>
                            <span class="next"><img src="images/dongtaibtnr.png" ></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 合作伙伴 -->
    <div class="content6">
        <div class="company">
            <h3>合作伙伴：</h3>
            <div class="hezuo">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <%--<div class="swiper-slide"><a href="#"><img src="images/chuizi.png" alt=""  style="display: inline-block;margin-top:0px;"></a></div>--%>
                        <div class="swiper-slide">
                            <a href="https://www.fuiou.com/"><img src="images/fuyou.png" alt="" style="display: inline-block;margin-top:6px;"></a>
                        </div>
                        <div class="swiper-slide">
                            <a href="http://www.wdzj.com/"><img src="images/wangdaizhijia.png" alt="" style="display: inline-block;margin-top:5px;"></a>
                        </div>
                        <div class="swiper-slide">
                            <a href="http://www.p2peye.com/"><img src="images/wangdaitianyan.png" alt="" style="display: inline-block;margin-top:6px;"></a>
                        </div>
                        <div class="swiper-slide">
                            <a href="http://www.chinagreentown.com/"><img src="images/luchengjituan.png" alt="" style="display: inline-block;margin-top:4px;"></a>
                        </div>
                        <div class="swiper-slide">
                            <a href="https://www.tongdun.cn/"><img src="images/tongdunkeji.png" alt="" style="display: inline-block;margin-top:0px;"></a>
                        </div>
                        <div class="swiper-slide"><a href="https://www.qhee.com/">
                            <img src="images/qianhaiguquan.png" alt="" style="display: inline-block;margin-top:3px;"></a>
                        </div>
                        <div class="swiper-slide"><a href="https://www.163yun.com/">
                            <img src="images/wangyiyun.png" alt="" style="display: inline-block;margin-top:28px;"></a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!--底部-->
<iframe src="footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;display: block;"></iframe>

<!--悬浮条-->
<iframe src="xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no" style="border:0px;display: block;"></iframe>
<iframe src="yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
<iframe src="jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%"style="border:0px;display: none;"></iframe>

<script src="js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="js/index.js" type="text/javascript" charset="utf-8"></script>

<script src="js/utils.js" type="text/javascript" charset="utf-8"></script>
<script src="js/xuanfutiao1.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    //页面跳转
    function tiaozhuan(url) {
        // window.top.location.href = url;
        top.location.href='/yingpu/pc/'+url;
    }

    //问候语
    function wenhou() {
        var now = new Date(), hour = now.getHours()
        if (hour < 6) {
            return ("早点休息！明天的阳光更灿烂！ ")
        }
        else if (hour < 12) {
            return "早上好，一日之计在于晨！今天要努力哦！"
        }
        else if (hour < 18) {
            return "下午好，做一个微笑挂在嘴边，快乐放在心上的人！"
        }
        else if (hour < 24) {
            return "晚上好，夜色如黛，万家灯火，和家人在一起最最幸福！！"
        }
        else {
            return ""
        }
    }

    //公告详情
    function ggdea(id) {
        location.href = 'infomation/detail?id=' + id + '&type=announce';
    }

    $('.chengjiao').text(commafy(parseFloat(${data.shuju[0].total}).toFixed(2)));
    $('.shouyi').text(commafy(parseFloat(${data.shuju[1].total}).toFixed(2)));
    $('.people').text(commafy(parseInt(${data.shuju[2].total})));
    $('.day').text(commafy(parseInt(${data.shuju[3].total})));

    //数据添加分隔符
    function commafy(num) {
        return num && num
            .toString()
            .replace(/(\d)(?=(\d{3})+\.)/g, function ($1, $2) {
                return $2 + ',';
            });
    }

    function viewWithoutInvestPrompt() {
        layer.alert('您未投资该项目，无法查看此项目详情！');
    }

    function viewWithoutLoginPrompt() {
        layer.alert('您尚未登录，无法查看此项目详情！');
    }

    function viewEndedProjectPrompt() {
        layer.alert('此项目已还款！');
    }

    function chedairong() {
        var $parent = $('#project');
        var str = ``;
        str += `<c:if test="${not empty data.chedairong}">
					<c:forEach items="${data.chedairong}" varStatus="i" var="o">
				<li class="list">

					<div class="xiangmu">
						<%--<p class="title">车融贷20181201015</p>--%>
							<p class="title">${o.name}</p>
						<div class="detail clearFix" >
							<div class="data">
								<p class="p1"><span class="num">${o.deadLine}</span>个月</p>
								<p class="wenben">借款期限</p>
							</div>
							<div class="nianhua">
								<p class="p2"><span class="num">
									<fmt:formatNumber type="number" value="${o.estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
								<p class="wenben">预期年化收益率</p>
							</div>
							<div class="total">
								<p class="p1"><span class="num">
									<fmt:formatNumber type="number" value="${o.totalAmount/10000}" pattern="0.00" maxFractionDigits=""/></span>万元</p>
								<p class="wenben">借款金额</p>
							</div>
							<div class="progress">
								 <p class="jindutiao"><span class="jindu"><span totalAmount="${o.totalAmount}" financingAmount="${o.financingAmount}" class="tuli"></span></span></p>
								<p class="shengyu">剩余额度：${o.financingAmount}万元</p>
							</div>
							<div class="chujie">
								<p class="liji">
									<a href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="${status[o.status][1]}">${status[o.status][0]}</a>
								</p>
							</div>
						</div>
					</div>
				</li>
					</c:forEach>
				</c:if>`
        $parent.empty();
        $parent.append($(str));
        jisuan();
    }

    function fangdairong() {

        var $parent = $('#project');
        var str = ``;
        str += `<c:if test="${not empty data.fangdairong}">
					<c:forEach items="${data.fangdairong}" varStatus="i" var="o">
				<li class="list">

					<div class="xiangmu">
						<%--<p class="title">车融贷20181201015</p>--%>
							<p class="title">${o.name}</p>
						<div class="detail clearFix" >
							<div class="data">
								<p class="p1"><span class="num">${o.deadLine}</span>个月</p>
								<p class="wenben">借款期限</p>
							</div>
							<div class="nianhua">
								<p class="p2"><span class="num">
									<fmt:formatNumber type="number" value="${o.estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
								<p class="wenben">预期年化收益率</p>
							</div>
							<div class="total">
								<p class="p1"><span class="num">
									<fmt:formatNumber type="number" value="${o.totalAmount/10000}" pattern="0.00" maxFractionDigits=""/></span>万元</p>
								<p class="wenben">借款金额</p>
							</div>
							<div class="progress">
								 <p class="jindutiao"><span class="jindu"><span totalAmount="${o.totalAmount}" financingAmount="${o.financingAmount}" class="tuli"></span></span></p>
								<p class="shengyu">剩余额度：${o.financingAmount}万元</p>
							</div>
							<div class="chujie">
								<p class="liji">
									<a href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="${status[o.status][1]}">${status[o.status][0]}</a>
								</p>
							</div>
						</div>
					</div>
				</li>
					</c:forEach>
				</c:if>`
        $parent.empty();
        $parent.append($(str));
        jisuan();
    }

    function shangqidai() {
        var $parent = $('#project');
        var str = ``;
        str += `<c:if test="${not empty data.youqirong}">
					<c:forEach items="${data.youqirong}" varStatus="i" var="o">
				<li class="list">

					<div class="xiangmu">
						<%--<p class="title">车融贷20181201015</p>--%>
							<p class="title">${o.name}</p>
						<div class="detail clearFix" >
							<div class="data">
								<p class="p1"><span class="num">${o.deadLine}</span>个月</p>
								<p class="wenben">借款期限</p>
							</div>
							<div class="nianhua">
								<p class="p2"><span class="num">
									<fmt:formatNumber type="number" value="${o.estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
								<p class="wenben">预期年化收益率</p>
							</div>
							<div class="total">
								<p class="p1"><span class="num">
									<fmt:formatNumber type="number" value="${o.totalAmount/10000}" pattern="0.00" maxFractionDigits=""/></span>万元</p>
								<p class="wenben">借款金额</p>
							</div>
							<div class="progress">
								 <p class="jindutiao"><span class="jindu"><span totalAmount="${o.totalAmount}"  financingAmount="${o.financingAmount}" class="tuli"></span></span></p>
								<p class="shengyu">剩余额度：${o.financingAmount}万元</p>
							</div>
							<div class="chujie">
								<p class="liji">
									<a href="${isLogin ?
                                        ((o.status != 4) ?
                                                '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                : 'javascript:void(viewEndedProjectPrompt())')
                                        : (o.status == 2 ? '/yingpu/pc/projectdetails?projectid='.concat(o.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())')}" class="${status[o.status][1]}">${status[o.status][0]}</a>
								</p>
							</div>
						</div>
					</div>
				</li>
					</c:forEach>
				</c:if>`
        $parent.empty();
        $parent.append($(str));
        jisuan();
    }

    function jinduzhi(total, shengyu) {
        var num = (total - shengyu) / total * 100 + "%";
        return num;
    }

    function jisuan() {
        $('.tuli').each(function (e) {
            var totalAmount = $(this).attr('totalAmount');
            var financingAmount = $(this).attr('financingAmount');
            // console.log(totalAmount)
            // console.log(financingAmount)
            // jindu = financingAmount/ totalAmount * 100 + "%";
            // console.log(jindu);
            $(this).css("width",  financingAmount / totalAmount * 100 + "%");
        });
    }

    jisuan();

    function loadOnTopWindow(base) {
        $(base).on('click', 'a', function(e) {
            e = event || e;
            var href = $(this).attr('href');
            if (href && href.indexOf('javascript:') == -1) {
                e.preventDefault();
                top.window.location.href = href;
            }

            return true;
        });
    }

    loadOnTopWindow(document);

</script>

</body>
</html>
