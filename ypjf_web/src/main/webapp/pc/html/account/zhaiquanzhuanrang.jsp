<%@ page language="java" import="java.util.*, java.util.regex.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="css/sanbiao.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>

		
	</head>
	<body>
	<!--顶部-->
	<iframe src="/yingpu/pc/head3.html?index=6" height="104px" width="100%" scrolling="no" name="head"
			style="border:0px;"></iframe>
		<div id="accountBox" class="clearFix">
			<!-- 左边导航 -->
			<div id="aside">
				<iframe src="../../myaccount/account_sidebar.html" width="100%" height="850px" scrolling="no"  style="border:0px;"></iframe>
			</div>
			
			<!-- 右边内容 -->
			<div id="account">
				<div class="trans-records">
					<div class="nav">
						<span class="active">债权转让</span>
					</div>
					<div class="trans-choice">						
						<dl class="trans-choice-date clearfix">
							<dt>交易日期:</dt>
							<dd class="active">全部</dd>
							<dd recent="1m">最近1个月</dd>
							<dd recent="3m">最近3个月</dd>
							<dd recent="1y">最近1年</dd>
							<div class="trans-choice-date-box">
								时间:
								<div class="calendarWarp">
									<input type="text" class="ECalendar" id="dateStart" value="起止日">
								</div>
								<span>至</span>
								<div class="calendarWarp">
									<input type="text" class="ECalendar" id="dateEnd" value="截止日">
								</div>
								<input type="submit" name="" id="search" value="查询记录" />
							</div>
						</dl>
					
						<dl class="trans-choice-type clearfix">
							<dt>项目状态:</dt>
							<dd class="active" status="1">可转让</dd>
							<dd status="2">转让中</dd>
							<dd status="3">已转让</dd>
							<dd status="4" assignReceiver="self">已承接</dd>
						</dl>
					</div>
					<!-- 可转让 -->
					<div id="kezhuanrang" class="list" style="display: block;">
						<table border="0">
                            <thead>
							<tr class="title">
								<th>项目名称</th>
								<th>预期年化利率</th>
								<th>日期</th>
								<th>当前/总(月)</th>
								<th>待收总额(元)</th>
								<th>本金</th>
								<th>待收利息</th>
								<th>操作</th>
							</tr>
                            </thead>
                            <tbody></tbody>

						</table>
						
					</div>
					<!-- 转让中 -->
					<div id="zhuanrangzhong" class="list" style="display: none;">
						<table border="0">
                            <thead>
							<tr class="title">
								<th>项目名称</th>
								<th>日期</th>
								<th>当前/总(月)</th>
								<th>转让本金(元)</th>
								<th>转让价格(元)</th>
								<th>操作</th>
							</tr>
                            </thead>
                            <tbody></tbody>
						</table>
					</div>
					<!-- 已转让 -->
					<div id="yizhuanrang" class="list" style="display: none;">
						<table border="0">
                            <thead>
							<tr class="title">
								<th>项目名称</th>
								<th>日期</th>
								<th>成交本金(元)</th>
								<th>转让本金(元)</th>
								<th>转让价格(元)</th>
								<th>手续费</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
							</tr>
                            </thead>
                            <tbody></tbody>
						</table>
					</div>
					<!-- 已承接 -->
					<div id="yichengjie" class="list" style="display: none;">
						<table border="0">
                            <thead>
							<tr class="title">
								<th>项目名称</th>
								<th>日期</th>
								<th>当前/总(月)</th>
								<th>债权本金(元)</th>
								<th>待收总额(元)</th>
								<th>操作</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                <th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
							</tr>
                            </thead>
                            <tbody></tbody>
						</table>
					</div>
                    <!--页码-->
                    <div class="page">
                        <div class="page-list" id="pageList">
                            <a onclick="go('home')">首页</a>
                            <a onclick="go('prev')">上一页</a>
                            <span id="page-nav-btn">
							</span>
                            <a onclick="go('next')">下一页</a>
                            <!-- <a onclick="go('tail')">尾页</a> -->
                        </div>
                    </div>
				</div>
				</div>
			</div>

        <script type="text/tpl" tpl-id="kezhuanrang">
            <tr>
                <td>$name</td>
                <td>$interestRate</td>
                <td>$valueDate</td>
                <td>$holdMonths/$deadline</td>
                <td>$totalEarnings</td>
                <td>$investmentAmount</td>
                <td>$totalInterest</td>
                <td class="btn"><a href="zhaizhuan-detail.html?id=$id">转让</a></td>
            </tr>
	    </script>
        <script type="text/tpl" tpl-id="zhuanrangzhong">
            <tr>
                <td>$name</td>
                <td>$valueDate</td>
                <td>$holdMonths/$deadline</td>
                <td>$projectAmount</td>
                <td>$amount</td>
                <td class="btn" onclick="cancelAssign($id)">取消转让</td>
            </tr>
	    </script>
        <script type="text/tpl" tpl-id="yizhuanrang">
            <tr>
                <td>$name</td>
                <td>$valueDate</td>
                <td>$amount</td>
                <td>$projectAmount</td>
                <td>$amount</td>
                <td>$interest</td>
                <td onclick="viewContract('userid=${pcuser.id}&projectid=$projectId&id=$id&status=MakeOver')"><span style="$viewStyle">查看合同</span></td>
            </tr>
	    </script>
        <script type="text/tpl" tpl-id="yichengjie">
            <tr>
                <td title="$name$code">$name$code</td>
                <td>$startDate</td>
                <td>$repaymentNum/$deadLine</td>
                <td>$investmentAmount</td>
                <td>$totalAmount</td>
                <td class="btn"><a href="/yingpu/pc/getProjectDetails?projectid=$pid">查看项目</a></td>
                <td onclick="viewContract('userid=${pcuser.id}&projectid=$projectId&id=$id&status=continue')"><span style="cursor:pointer;">查看合同</span></td>
                <td class="btn" onclick="authorize($id,$investmentAmount,$totalAmount)"><a>转让</a></td>
            </tr>
	    </script>
	<!--底部导航-->
	<iframe src="/yingpu/pc/footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;height:326px;"></iframe>
		<script src="js/jquery.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/calendar2.js" type="text/javascript" charset="utf-8"></script>
        <script src="../../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
        <script src="../../js/utils.js" type="text/javascript" charset="utf-8"></script>
        <script src="../../js/queryString.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/zhaiquanzhuanrang.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			$(function(){
				$("#dateStart").ECalendar({
					 type:"time",
					 stamp:false,
					 offset:[0,2],   //弹框手动偏移量;
					 skin:'#ff7f01',
					 format:"yyyy/mm/dd",
					 callback:function(v,e)
					 {
						 $(".callback span").html(v)
					 }
				});
				$("#dateEnd").ECalendar({
					 type:"time",
					 stamp:false,
					 offset:[0,2],   //弹框手动偏移量;
					 skin:'#ff7f01',
					 format:"yyyy/mm/dd",
					 callback:function(v,e)
					 {
						 $(".callback span").html(v)
					 }
				});
			});
            // 授权
            function authorize(id,investmentAmount,totalAmount) {
                var debtItems = [];
                var interest = investmentAmount - totalAmount;
                var isCharge =true;
                debtItems.push({
                    dispersedProjectId : id,
                    isCharge : isCharge
                });
                $.ajax({
                    url : '/yingpu/pc/si/debt/sell/cj',
                    dataType : 'json',
                    // contentType : 'application/json; charset=UTF-8',
                    type : 'POST',
                    data : {
                        id : id,
                        itemJson : JSON.stringify(debtItems),
                        interest : interest
                    },
                    success : function(rsp) {
                        if (rsp.status != 'success') {
                            layer.alert(rsp.message);
                            return;
                        }

                        layer.msg('债转授权完成！');
                        reload(500);
                    }
                });
            }
		</script>
	</body>
	
</html>
