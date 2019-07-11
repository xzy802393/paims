<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>-->
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
	<link rel="stylesheet" type="text/css" href="css/product_lists.css"/>
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

			<c:if test="${empty pcuser}">
				<div class="login-box" style="display: ;">
					<h4>预期年化收益率</h4>
					<p class="rate">6%-12%</p>
					<p class="active"><a href="../pc/register">注册就送3999元大礼包</a></p>
					<p class="login-btn">已有账户？<a href="../login">立即登录</a></p>
				</div>
			</c:if>
			<!--登录之后-->
			<c:if test="${not empty pcuser}">
				<div class="login-ok-box">
					<h4>尊敬的${pcuser.phone}<!-- <span id="wenhou"></span> --></h4>
					<div class="yue">
						<p>您的可用银子</p>

						<p><span>${not empty pcuser.integral ? pcuser.integral : "0"}</span></p>
					</div>

					<p class="myaccount"><a href="javascript:void(0)">立即签到</a></p>
					<ul class="sign-in">
						<li class="sign-days">签到记录</li>
						<li class="sign-rule">签到规则</li>
					</ul>
				</div>
			</c:if>
		</div>
	</div>

	<div class="mall-nav">
		<div class="center">
			<p class="cur-nav">您现在所在的位置：<a href="../index.jsp">首页</a> &gt; <a href="points_mall.jsp">九趣贷</a> &gt; <a href="#">商城列表</a></p>
		</div>
	</div>
	<div class="main">
		<div class="center">
			<div class="product-nav">
				<dl class="nav" id="menu">
					<dt>商品分类：</dt>
					<dd type="0" class="active">全部商品</dd>
					<dd type="1">金券银票</dd>
					<dd type="2">机关兵器</dd>
					<dd type="3">胭脂水粉</dd>
					<dd type="4">山珍奇货</dd>
				</dl>
				<div class="order"  id="o">
					<a class="active" href="#" id="moren">默认排序<span class="jiantou"></span></a><a href="#" id="renqi">人气优先<span class="jiantou"></span></a>
				</div>
			</div>

			<div class="product-list">
				<ul class="item"  id="all">
			</div>

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
</div>
<!--悬浮条-->
<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>
		
<!--底部导航-->

<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
<!--加载js文件-->
<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/utils.js"></script>
<script type="text/tpl" id="list_item">
						<a href="goodsDetails?goodsId=$id">
						<li class="list">
						<div class="product-pic">
                          <img src="$smLogo"/>
                            </div>
                            <p class="tit">$goodsName</p >
	                         <div class="detail">
	                         <p>银子：<span>$points</span> 两</p >
							<p>已兑：<span>$count</span> 份</p >
	                          </div>
							</li>
	</script>
<script type="text/javascript">
    // window.location.href='product_lists.jsp';
    var pageIndex=1, pageCount, type= window.location.href.split("?")[1].substring(0,1),sort="asc";
    loadList();
    function loadList() {
        var data = {
            pageIndex : pageIndex,
            type : type,
            sort:sort
        };
        $.post('/yingpu/pc/pointsmall/list1/json', data, function(data) {
            var tpl = $('#list_item').html();
            var html = '';

            pageIndex = data.page.pageIndex;
            pageCount = data.page.pageCount || 1;
            pageSize = data.page.pageSize;
            $.each(data.data|| [], function(k, v) {
                var i, sign = '+';

                v.index = (~-pageIndex * pageSize) + -~k;
                v.goosName = v.goodsName;
                v.smLogo=v.smLogo;
                v.points=v.points;
                v.count=v.count1;
                html += tpl.formatStr(v);
            });
            $('#all').html(html
                || '<tr><td colspan="5" style="width: 80%; height: 300px; text-align: center; color: gray; font-size: 1.2rem; margin-top: 25%;">暂无数据</td></tr>');
            generatePaginationNav(pageIndex, pageCount, '#page-nav-btn');
        }, 'json');
    }
    //按照分类去查
    $('#menu').on('click', 'dd', function() {
        type= $(this).attr('type');
        pageIndex = 1;
        sort="asc";
        loadList();
    });

    $(function(){
        //商品分类切换
        $("#menu dd").each(function(){
            if($(this).attr('type')==type){
                $("#menu dd").removeClass("active");
                $(this).addClass("active");
            }
            $(this).click(function(){
                $("#menu dd").removeClass("active");
                $(this).addClass("active");
                $('#renqi').removeClass("active")
                $('#moren').addClass("active")
            })
        })

    });
    $(function(){
        //查询方式切换
        $("#o a").each(function(){
            $(this).click(function(){
                $("#o a").removeClass("active");
                $(this).addClass("active");
            })
        })

    });
    //按照人气去查询
    $('#renqi').on('click', '', function() {
        sort="desc";
        type= $("#menu").find(".active").attr('type');
        pageIndex = 1;
        loadList();
    });
    //按照默认去查
    $('#moren').on('click', '', function() {
        sort="asc";
        type= $("#menu").find(".active").attr('type');
        pageIndex = 1;
        loadList();
    });
</script>


</body>
</html>
