<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String url = basePath + request.getServletPath() + "?" + request.getQueryString();
    String encodeUrl = URLEncoder.encode(url, "UTF-8");
%>
<%!
    Date addDays(Date date, int days) {
    	return com.cz.yingpu.frame.util.DateUtils.addDay(days, date);
    }

    Date addMonths(Date date, int months) {
        return org.apache.commons.lang.time.DateUtils.addMonths(date, months);
    }
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
        <base href="<%=basePath%>pc/my-invest/" />
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="css/zhitou-futou.css"/>
        <link rel="stylesheet" type="text/css" href="css/xugou1.css"/>
        <link rel="stylesheet" type="text/css" href="css/xugou2.css"/>
        <link rel="stylesheet" type="text/css" href="../css/my-lend.css"/>
        <style>
            #content .record-page-list span {
                border: none;
                text-align: center;
                display: inline;
                width: 12px;
                margin-left: 10px;
            }
        </style>
	</head>
	<body>
		<!--顶部-->

        <iframe src="../head3.html" class="iframe-headfu" width="100%" height="110px" scrolling="no"  style="border:0px;display: block;z-index:1000"></iframe>
		
		<div id="banner">
			<div class="banner" ondragstart="return false" oncontextmenu="return false">
				<img src="img/img-zhitoufutou/banner-person.png" class="person" ondragstart="return false" oncontextmenu="return false">
				<div class="gray"></div>
				<div id="box" class="clearFix">
					<div class="left">
						<div class="box-left">
							<p class="bt">
								<span class="name">${data.name}</span>
								<span class="state">出借中</span>
							</p>
							<p class="cj">出借金额<span class="money">
                                <fmt:formatNumber pattern="###,###,###,###,##0.00" value="${data.investmentAmount}"/> </span>元</p>
							<ul class="items clearFix">
								<li class="item" style="text-align: left;">
									<p class="p1"><span><fmt:formatNumber pattern="###0.00" value="${data.earningRate * 100}" /></span>%</p>
									<p class="p2">综合出借率</p>
								</li>
								<li class="item" style="text-align: center;">
									<p class="p1"><span>${data.deadLine}</span> 个月</p>
									<p class="p2">项目期限</p>
								</li>
								<li class="item" style="text-align: right;">
									<p class="p1"><span>${data.holdDays}</span> 天</p>
									<p class="p2">已持有天数</p>
								</li>
							</ul>
						</div>
						
					</div>
					<div class="right">
						<div class="box-right">
							<p class="p1">待收款</p>
							<p class="cj"><span class="money">
                                <fmt:formatNumber pattern="###,###,###,###,##0.00" value="${data.investmentAmount + (data.investmentAmount * data.earningRate / 12 * data.deadLine)}" />
                                </span>元</p>
							<ul class="items clearFix" >
								<li class="item">本金：<span>
                                    <fmt:formatNumber pattern="###,###,###,###,##0.00" value="${data.investmentAmount}" />
                                </span>元</li>
								<li class="item">预期利息：<span>
                                    <fmt:formatNumber pattern="###,###,###,###,##0.00" value="${(data.investmentAmount * data.earningRate / 12 * data.deadLine)}" />
                                    </span>元</li>
								<li class="item">活动让利：<span>
                                    <fmt:formatNumber pattern="###,###,###,###,##0.00" value="${data.discountAmount}" />
                                </span>元</li>
								<li class="item">续投奖励金额：<span>
                                    <fmt:formatNumber pattern="###,###,###,###,##0.00" value="${data.investmentAmount * data.reinvestAdditionalEarningRate / 12 * data.deadLine }" />
                                </span>元</li>
							</ul>
							<p class="end">
                                预计在<span><fmt:formatDate type="date" value="${data.expiresDate}" /></span>，将收到利息<span>
                                <fmt:formatNumber pattern="###,###,###,###,##0.00" value="${(data.investmentAmount * data.earningRate / 12)}" />
                                </span>元
                            </p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="content">

			<div class="content1">
				<p class="title"><img src="img/img-zhitoufutou/xugou-title.jpg" ></p>
				<div class="subtitle clearFix">
					<p class="subtitle-left">开启到期续购后，出借的本金将自动出借下一期（您选择期限）的X快享智能投标，同时可享最高<span style="color:#038cf6;">0.2%</span>的加息利率。</p>
					<div class="subtitle-right">
						<div class="contentBox">
						    <div class="btnBox">
						        <div id="btn" isopen="${data.reinvest ? 'on' : 'off' }"></div>
						        <span class="on">开</span>
						        <span class="off">关</span>
						    </div>
						</div>
						<div class="miaoshu">续购开席</div>
					</div>
				</div>
				<ul class="jindu">
					<li class="shenqing kuang" style="margin-left:0;">
						<img src="img/img-zhitoufutou/circleHui.jpg" >
						<p class="text"><span>出借申请</span>
						<p class="time"><fmt:formatDate type="date" value="${data.createTime}" /></p>
					</li>
					<li class="line"><img src="img/img-zhitoufutou/lineHui.jpg" ></li>
					<li class="line"><img src="img/img-zhitoufutou/lineHui.jpg" ></li>
					<li class="qixiri kuang">
						<img src="img/img-zhitoufutou/circleHui.jpg" >
                        <p class="text"><span>起息日</span>
						<p class="time"><fmt:formatDate type="date" value="${data.valueDate}" /></p>
					</li>
					<li class="line"><img src="img/img-zhitoufutou/lineHui.jpg" ></li>
					<li class="line"><img src="img/img-zhitoufutou/lineHui.jpg" ></li>
					<li class="daoqiri kuang">
						<img src="img/img-zhitoufutou/circleHui.jpg" >
                        <p class="text"><span>到期日</span></p>
						<p class="time"><fmt:formatDate type="date" value="${data.expiresDate}" /></p>
					</li>
					<li class="line"><img src="img/img-zhitoufutou/lineHui.jpg" ></li>
					<li class="line"><img src="img/img-zhitoufutou/lineHui.jpg" ></li>
					<li class="xutouri kuang">
						<img src="img/img-zhitoufutou/circleHui.jpg" />
                        <p class="text"><span>续投日</span></p>
						<p class="time">
                            <%= new SimpleDateFormat("yyyy-MM-dd").format(
								addDays((Date)((Map)request.getAttribute("data")).get("expiresDate"), 1))%>
                        </p>
					</li>
				</ul>
			</div>
			<div class="content2">
				<p class="title"><img src="img/img-zhitoufutou/chujie-title.jpg" ></p>
				<div class="navs">
					<span class="" style="padding-left:14px;">持有中项目 <img src="img/img-zhitoufutou/wenhaoLan.jpg" id="tishi" onmouseover="show('tishi')" onmouseout="hide()"></span>
					<span class="gray" >已到期项目 <img src="img/img-zhitoufutou/wenhaoLan.jpg"  id="tishi1" onmouseover="show1('tishi1')" onmouseout="hide()"></span>
					<span class="gray" >已转让项目 <img src="img/img-zhitoufutou/wenhaoLan.jpg"  id="tishi2" onmouseover="show2('tishi2')" onmouseout="hide()"></span>
				</div>
				<ul class="items">
					<li class="item" style="display: block;">
						<div class="tabs">
							<table border="0" cellspacing="20" cellpadding="20">
                                <thead>
								<tr class="title">
									<th>项目名称</th>
									<th>持有金额</th>
									<th>出借日期</th>
									<th>操作</th>
								</tr>
                                </thead>
                                <tbody>
								</tbody>

							</table>
							
						</div>
					</li>
					<li class="item" style="display: none;">
						<div class="tabs">
							<table border="0" cellspacing="20" cellpadding="20">
                                <thead>
								<tr class="title">
									<th>项目名称</th>
									<th>本息合计</th>
									<th>到期日期</th>
									<th>操作</th>
								</tr>
                                </thead>
								<tbody></tbody>
							</table>
						</div>
					</li>
					<li class="item" style="display: none;">
						<div class="tabs">
							<table border="0" cellspacing="20" cellpadding="20">
                                <thead>
								<tr class="title">
									<th>项目名称</th>
									<th>本息合计</th>
									<th>到期日期</th>
									<th>操作</th>
								</tr>
                                </thead>
                                <tbody></tbody>
							</table>
						</div>
					</li>
				</ul>
                <p>&nbsp;</p>
                <div class="record-page" style="display:block;">
                    <div class="record-page-list">
						<a onclick="go('home')">首页</a>
						<a onclick="go('prev')">上一页</a>
						<span id="page-nav-btn">
						</span>
						<a onclick="go('next')">下一页</a>
						<a onclick="go('tail')">尾页</a>
					</div>
				</div>
			</div>
			<div id="mask" style="display: none;"></div>
		</div>
		<!--底部导航-->
        <div id="fade" class="black-overlay"></div>
        <div id="box1" style="display: none;">
            <p class="title clearFix"><span>开启X快享智能投标到期续购</span><img src="img/img-zhitoufutou/tankuang-close.png" class="close" ></p>
            <p class="text">开启到期续购后，在当期X智投到期那日，出借的本金将自动出借下一期（您选择期限）的X智投，并在享受续购成功当天X智投的综合出借利率的基础上，叠加续购加息和活动红包。<span class="color">开启续购后，则不可关闭续购。</span></p>
            <ul class="items clearFix">
                <li class="item">
                    <p class="p1">续购金额</p>
                    <p class="p2 je">
                        <fmt:formatNumber pattern="###,###,###,###,##0.00" value="${data.investmentAmount}" />
                    </p>
                </li>
                <li class="item">
                    <p class="p1">续购加息</p>
                    <p class="p2 ll">+0.15%</p>
                </li>
            </ul>
            <div id="table" class="list">
                <table border="0">
                    <tr class="title">
                        <th>续购期限</th>
                        <th>续购加息</th>
                        <th class="rangli">活动让利</th>
                        <th>预计计息时间</th>
                        <th>预计到期时间</th>
                    </tr>
                    <tr>
                        <td class="checked"><input type="radio" name="month" value="3"/><span>3个月</span></td>
                        <td rate="0.001">+0.1%</td>
                        <td class="rangli">—</td>
                        <td><%= new SimpleDateFormat("yyyy-MM-dd").format(
                                addMonths(addDays((Date)((Map)request.getAttribute("data")).get("expiresDate"), 1), 3))%></td>
                        <td><%= new SimpleDateFormat("yyyy-MM-dd").format(
                                addMonths(addDays((Date)((Map)request.getAttribute("data")).get("expiresDate"), 2), 3))%></td>
                    </tr>
                    <tr>
                        <td class="checked"><input type="radio" name="month" value="6"/><span>6个月</span></td>
                        <td rate="0.001">+0.1%</td>
                        <td class="rangli">—</td>
                        <td><%= new SimpleDateFormat("yyyy-MM-dd").format(
                                addMonths(addDays((Date)((Map)request.getAttribute("data")).get("expiresDate"), 1), 6))%></td>
                        <td><%= new SimpleDateFormat("yyyy-MM-dd").format(
                                addMonths(addDays((Date)((Map)request.getAttribute("data")).get("expiresDate"), 2), 6))%></td>
                    </tr>
                    <tr>
                        <td class="checked" style="position: relative;"><input type="radio" name="month" value="9"/><span>9个月</span></td>
                        <td rate="0.001">+0.1%</td>
                        <td class="rangli">—</td>
                        <td><%= new SimpleDateFormat("yyyy-MM-dd").format(
                                addMonths(addDays((Date)((Map)request.getAttribute("data")).get("expiresDate"), 1), 9))%></td>
                        <td><%= new SimpleDateFormat("yyyy-MM-dd").format(
                                addMonths(addDays((Date)((Map)request.getAttribute("data")).get("expiresDate"), 2), 9))%></td>
                    </tr>
                    <tr>
                        <td class="checked" style="position: relative;"><input type="radio" name="month" value="12"/><span>12个月</span><img src="img/img-zhitoufutou/hot.png" style="position: absolute;right:6px;top:-2px;" /></td>
                        <td rate="0.0015">+0.15%</td>
                        <td class="rangli">—</td>
                        <td><%= new SimpleDateFormat("yyyy-MM-dd").format(
                                addMonths(addDays((Date)((Map)request.getAttribute("data")).get("expiresDate"), 1), 12))%></td>
                        <td><%= new SimpleDateFormat("yyyy-MM-dd").format(
                                addMonths(addDays((Date)((Map)request.getAttribute("data")).get("expiresDate"), 2), 12))%></td>
                    </tr>
                </table>
            </div>
            <div class="btns">
                <span class="continue">开启续购</span>
                <span class="reset">取消</span>
            </div>
        </div>
        <div id="box2" style="display: none;">
            <p class="title clearFix"><span>开启X快享智能投标到期续购</span><img src="img/img-zhitoufutou/tankuang-close.png" class="close" ></p>
            <p class="line1"><span class="text">续购金额</span><span class="number">
                <fmt:formatNumber pattern="###,###,###,###,##0.00" value="${data.investmentAmount}" />
            </span><span class="return">返回修改</span></p>
            <p class="line1"><span class="text">续购期限</span><span class="number" id="deadline"></span></p>
            <p class="line1"><span class="text">续购加息</span><span class="number" id="additional-rate">+0.00%</span></p>
            <p class="line1"><span class="text">活动让利</span><span class="number">—</span></p>
            <p class="line1"><span class="text">预期计息时间</span><span class="number" id="value-date">2019.07.08</span></p>
            <p class="line1"><span class="text">预期到期时间</span><span class="number" id="expires-date">2020.07.09</span></p>
            <div class="btns">
                <span class="continue">开启续购</span>
                <span class="reset">取消</span>
            </div>
        </div>

        <script>
            var chujieday = new Date('${data.createTime}').getTime();
            var qixiday = new Date('${data.valueDate}').getTime();
            var daoqiday = new Date('${data.expiresDate}').getTime();
            var futouday = new Date(daoqiday + 86400000).getTime();
        </script>
		<iframe src="../footer2.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>

		<script src="../js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/zhitou-futou.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
        <script type="tpl" id="list1-item">
            <tr>
                <td>$name</td>
                <td>$investmentAmount</td>
                <td>$createTime</td>
                <td class="color" id="$id" onclick="viewContract('userid=${pcuser.id}&projectid=$id&oid=${data.id}')">查看协议</td>
            </tr>
        </script>
        <script type="tpl" id="list2-item">
            <tr>
                <td>$name</td>
                <td>$totalAmount</td>
                <td>$expiresDate</td>
                <td class="color" id="$id" onclick="viewContract('userid=${pcuser.id}&projectid=$id&id=$id&status=MakeOver'")>查看协议</td>
            </tr>
        </script>
        <script type="tpl" id="list3-item">
            <tr>
                <td>$name</td>
                <td>$debtAmount</td>
                <td>$expiresDate</td>
                <td class="color" id="$id" onclick="viewContract('userid=${pcuser.id}&projectid=$id&id=$id&status=MakeOver'")>查看协议</td>
            </tr>
        </script>


		<script type="text/javascript">
            var additionalEarningRate = 0,
                deadline = 0;


            useLoadingShade();
            $(function() {
                $(".contentBox").on("click",function(){
                    if($("#btn").attr("isopen")=="off"){
                        ShowDiv("box1","fade");
                        $("#btn").attr("isopen","on").animate({left:32},"slow");
                        $(".btnBox").css("background-color","#038cf6");
                        $(".on").css("display","inline-block");
                        $(".off").css("display","none");
                        $("#box1").contents().find('.continue').on('click',function(){
                            $("#box1").hide();
                            $("#box2").show();
                            $("#box2").contents().find('.continue').on('click',function(){
                                $.post('/yingpu/pc/si/debt/resmartinvset/confirm', {
                                    orderId : '${param.id}',
                                    additionalEarningRate : additionalEarningRate,
                                    deadline : deadline
                                }, function(result) {
                                    if (result.status == 'success') {
                                        layer.alert('已成功开启续投功能');
                                        $("#box2").hide();
                                        $("#fade").hide();
                                    }
                                    else {
                                        layer.alert(result.message || '对不起，请求出错！');
                                    }
                                }, 'json');
                            });
                            // 返回上一个弹框
                            $("#box2").contents().find('.return').on('click',function(){
                                $("#box2").hide();
                                $("#box1").show();
                            });
                            // 关闭此弹框2
                            $("#box2").contents().find('.reset').on('click',function(){
                                $("#box2").hide();
                                $("#fade").hide();
                                close();
                            });
                            // 关闭此弹框2
                            $("#box2").contents().find('.close').on('click',function(){
                                $("#box2").hide();
                                $("#fade").hide();
                                close();
                            });
                        });
                        $("#box1").contents().find('.reset').on('click',function(){
                            $("#box1").hide();
                            $("#fade").hide();
                            close();
                        });
                        $("#box1").contents().find('.close').on('click',function(){
                            $("#box1").hide();
                            $("#fade").hide();
                            close();
                        });
                    }

                    function close(){
                        $("#btn").attr("isopen","off").animate({left:"1px"});
                        $(".btnBox").css("background-color","#ededed");
                        $(".on").css("display","none");
                        $(".off").css("display","inline-block");
                    }
                });

                if($("#btn").attr("isopen")=="on") {
                    open();
                }

                $('#table tr input[type=radio]').change(function() {
                    if (this.checked) {
                        var $td = $(this).parent();
                        valueDate = $td.nextAll('td:eq(2)').text(),
                        expiresDate = $td.nextAll('td:eq(3)').text(),
                        additionalEarningRate = $td.nextAll('td:eq(0)').attr('rate'),
                        deadline = $(this).val();

                        $('#deadline').html($td.text());
                        $('#additional-rate').html($td.nextAll('td:eq(0)').text());
                        $('#value-date').html(valueDate);
                        $('#expires-date').html(expiresDate);
                    }
                })
                .eq(0).click();


            });

            function open() {
                $("#btn").attr("isopen","on").animate({left:32},"slow");
                $(".btnBox").css("background-color","#038cf6");
                $(".on").css("display","inline-block");
                $(".off").css("display","none");
                $("#mask").show();
                $(".tan1").show();
            }

            var listIndex = 1;
            loadList = function(idx) {
                listIndex = idx || listIndex;
                $.get('/yingpu/pc/myaccount/order/project/list', {
                    id : '${param.id}',
                    cate : listIndex,
                    pageIndex : pageIndex
                }, function(result) {
                    console.log(result.data);
                    if (result.data == undefined) {
                        html = '<span style="display: block; text-align: center; width:100%;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
                        $('.content2 .items li').eq(listIndex - 1).find('table').html(html);
                        $('.record-page').css('display','none');
                    }else{
                    if (result.status == 'success') {
                        var tpl = $('#list' + listIndex + '-item').html(),
                            html = '';
                        $.each(result.data || [], function (i, o) {
                            o.createTime = new Date(o.createTime).Format("yyyy-MM-dd");
                            o.expiresDate = new Date(o.expiresDate).Format("yyyy-MM-dd");
                            html += tpl.formatStr(o);
                        });
                        $('.content2 .items li').eq(listIndex - 1).find('table>tbody').html(html);
                        page = result.page;
                        pageCount = page.pageCount;
                        $('.record-page').css('display','block');
                        generatePaginationNav(page.pageIndex, page.pageCount, '#page-nav-btn');
                    }
                }
                }, 'json');
            };
            loadList(1);

            //弹出隐藏层
            function ShowDiv(show_div,bg_div){
                document.getElementById(show_div).style.display='block';
                document.getElementById(bg_div).style.display='block' ;
                var bgdiv = document.getElementById(bg_div);
                bgdiv.style.width = document.body.scrollWidth;
                // bgdiv.style.height = $(document).height();
                $("#"+bg_div).height($(document).height());
            };
            //关闭弹出层
            function CloseDiv(show_div,bg_div){
                document.getElementById(show_div).style.display='none';
                document.getElementById(bg_div).style.display='none';
            };

            function viewContract(param) {
                event.preventDefault();
                event.stopPropagation();
               // var param ='userid='+ud+'&projectid='+pd+'&id='+od;
                layer.open({
                    type: 2,
                    title: '查看合同',
                    shadeClose: true,
                    shade: 0.8,
                    area: ['50%', '80%'],
                    content: '<%=basePath%>app/userproject/getContinueToBuy/json?'+param
                });
            }
            console.log(content);
		</script>
	</body>
</html>
