<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

	String[] pTypes = {
			"", "", "", "", "", "", "", "", "", "", "", "",
			"qi", "che", "fang"
	};
	request.setAttribute("types", pTypes);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="../account/css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../account/css/history.css"/>
		<link rel="stylesheet" type="text/css" href="../account/css/style.css"/>
		
	</head>
	<body>
	<!--顶部-->
	<iframe src="/yingpu/pc/head3.html?index=6" height="104px" width="100%" scrolling="no" name="head" style="border:0px;"></iframe>
		<div id="accountBox" class="clearFix">
			<!-- 左边导航 -->
			<div id="aside">
				<iframe src="../../myaccount/account_sidebar.html" width="100%" height="850px" scrolling="no"  style="border:0px;"></iframe>
			</div>
			
			<!-- 右边内容 -->
			<div id="account">
				<div class="trans-records">
					<div class="nav">
						<span class="active">交易记录</span>
						<span>充值记录</span>
						<span>提现记录</span>
						<span>邀友收益</span>
					</div>
					<ul class="tabs">
						<!-- 交易记录 -->
						<li class="tab" style="display: block;">
							<div class="trans-choice">						
								<dl class="trans-choice-date clearfix">
									<dt>交易日期:</dt>
									<dd class="active">全部</dd>
									<dd>最近1个月</dd>
									<dd>最近3个月</dd>
									<dd>最近1年</dd>
									<div class="trans-choice-date-box">
										时间:
										<div class="calendarWarp">
											<input type="text" class="ECalendar" id="ECalendar_date" value="起止日">
										</div>
										<span>至</span>
										<div class="calendarWarp">
											<input type="text" class="ECalendar" id="ECalendar_date2" value="截止日">
										</div>
										<input type="submit" name="" id="search" class="querylog" value="查询记录" />
									</div>
								</dl>
							
								<dl class="trans-choice-type clearfix">
									<dt>交易类型:</dt>
									<dd class="active">全部</dd>
									<dd>投资</dd>
									<dd>收益</dd>
								</dl>
							</div>
							<div id="list"">
								<table border="0">
									<tr class="title">
										<th>日期</th>
										<th>类型</th>
										<th>金额(元)</th>
										<th>交易详情</th>
										<th>交易状态</th>
									</tr>
									<tbody id="userprojectinfo"></tbody>
								</table>
							</div>
						</li>
						<!-- 充值记录 -->
						<li class="tab" style="display: none;">
							<div class="trans-choice">						
								<dl class="trans-choice-date clearfix">
									<dt>交易日期:</dt>
									<dd class="active">全部</dd>
									<dd>最近1个月</dd>
									<dd>最近3个月</dd>
									<dd>最近1年</dd>
									<div class="trans-choice-date-box">
										时间:
										<div class="calendarWarp">
											<input type="text" class="ECalendar" id="ECalendar_date3" value="起止日">
										</div>
										<span>至</span>
										<div class="calendarWarp">
											<input type="text" class="ECalendar" id="ECalendar_date4" value="截止日">
										</div>
										<input type="submit" name="" id="search" class="querylog" value="查询记录" />
									</div>
								</dl>
							
								<dl class="trans-choice-type clearfix">
									<dt>交易状态:</dt>
									<dd class="active">全部</dd>
									<dd>处理中</dd>
									<dd>成功</dd>
									<dd>失败</dd>
								</dl>
							</div>
							<div id="list">
								<table border="0">
									<tr class="title">
										<th>日期</th>
										<th>充值金额(元)</th>
										<th>交易详情</th>
										<th>状态</th>
									</tr>
									<tbody id="chonzghiprojectinfo"></tbody>
								</table>
								
							</div>
						</li>
						<!-- 提现记录 -->
						<li class="tab" style="display: none;">
							<div class="trans-choice">						
								<dl class="trans-choice-date clearfix">
									<dt>交易日期:</dt>
									<dd class="active">全部</dd>
									<dd>最近1个月</dd>
									<dd>最近3个月</dd>
									<dd>最近1年</dd>
									<div class="trans-choice-date-box">
										时间:
										<div class="calendarWarp">
											<input type="text" class="ECalendar" id="ECalendar_date5" value="起止日">
										</div>
										<span>至</span>
										<div class="calendarWarp">
											<input type="text" class="ECalendar" id="ECalendar_date6" value="截止日">
										</div>
										<input type="submit" name="" id="search" class="querylog" value="查询记录" />
									</div>
								</dl>
							
								<dl class="trans-choice-type clearfix">
									<dt>交易状态:</dt>
									<dd class="active">全部</dd>
									<dd>处理中</dd>
									<dd>成功</dd>
									<dd>失败</dd>
								</dl>
							</div>
							<div id="list">
								<table border="0">
									<tr class="title">
										<th>日期</th>
										<th>提现金额(元)</th>
										<th>交易详情</th>
										<th>交易状态</th>
									</tr>
									<tbody id="depositprojectinfo"></tbody>
								</table>
								
							</div>
						</li>
						<!-- 邀友收益 -->
						<li class="tab" style="display: none;">
							<div class="trans-choice">						
								<dl class="trans-choice-date clearfix">
									<dt>交易日期:</dt>
									<dd class="active">全部</dd>
									<dd>最近1个月</dd>
									<dd>最近3个月</dd>
									<dd>最近1年</dd>
									<div class="trans-choice-date-box">
										时间:
										<div class="calendarWarp">
											<input type="text" class="ECalendar" id="ECalendar_date3" value="起止日">
										</div>
										<span>至</span>
										<div class="calendarWarp">
											<input type="text" class="ECalendar" id="ECalendar_date4" value="截止日">
										</div>
										<input type="submit" name="" id="search" class="querylog" value="查询记录" />
									</div>
								</dl>
							
								<dl class="trans-choice-type clearfix">
									<dt>收益记录:</dt>
									<dd class="active">收益明细</dd>
									<dd>完成</dd>
									<dd>处理中</dd>
								</dl>
							</div>
							<div id="list">
								<table border="0">
									<tr class="title">
										<th>日期</th>
										<th>好友姓名</th>
										<th>手机号</th>
										<th>邀友收益(元)</th>
										<th>状态</th>
									</tr>
                                    <tbody id="invitefriends"></tbody>
								</table>
								
							</div>
						</li>
						
					
					</ul>
					
					
					
					<!--页码-->
					<div class="page">
						<div class="page-list" id="pageList">
							<a onclick="go('home')">首页</a>
							<a onclick="go('prev')">上一页</a>
							<span id="page-nav-btn"></span>
							<a onclick="go('next')">下一页</a>
							<%--<a onclick="go('tail')">尾页</a>--%>
						</div>
					</div>
				</div>
				</div>
			</div>
	<!--底部导航-->
	<iframe src="/yingpu/pc/footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;height:326px;"></iframe>
	<script src="/yingpu/pc/my-invest/js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../account/js/utils1.js" type="text/javascript" charset="utf-8"></script>
	<script src="../account/js/jquery.js" type="text/javascript" charset="utf-8"></script>
	<script src="../account/js/calendar2.js" type="text/javascript" charset="utf-8"></script>
	<script src="../account/js/history.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			$(function(){
				$("#ECalendar_date").ECalendar({
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
				$("#ECalendar_date2").ECalendar({
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
                $("#ECalendar_date3").ECalendar({
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
                $("#ECalendar_date4").ECalendar({
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
                $("#ECalendar_date5").ECalendar({
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
                $("#ECalendar_date6").ECalendar({
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
		</script>
	<script>
        var gParams = {
            type : '',
            dateBefore : '',
            dateStart : '',
            dateEnd : '',
            status : ''
        };
        loadList();
        function loadList() {
            $.post('/yingpu/pc/myaccount/getDealOrder', {
                pageIndex: pageIndex,
                id: '${pcuser.id}',
                status:gParams.status,
                type:gParams.type,
                dateBefore: gParams.dateBefore,
                dateStart: gParams.dateStart,
                dateEnd: gParams.dateEnd
            }, function (data) {
                // console.log(data)
                var dat = data;
                pageIndex = dat.page.pageIndex;
                pageCount = data.page.pageCount;
                pageSize = data.page.pageSize;
                data = data.data;
                var html = '';

                if (data==undefined || data.length == 0 ){
                    html = '<span style="display: block; text-align: center; width:988px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
                    $('#userprojectinfo').empty();
                    $('#userprojectinfo').append(html);
                    $('.page').css('display','none');
                    generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');

                }else {
                    // var len = data.length;

                    $.each(data, function (i, o) {
                        html += '<tr>';
                        html += '<td>' + new Date(o.createTime).Format('yyyy-MM-dd hh:mm:ss') + '</td>';
                        if(o.type== 3){
                            html += '<td>投资</td>';
						}else if(o.type== 4){
                            html += '<td>投资回款</td>';
						}else if(o.type== 8){
                            html += '<td>邀请人收益</td>';
						}else if(o.type== 11){
                            html += '<td>智投投资</td>';
                        }else if(o.type==12){
                            html += '<td>智投利息发放</td>';
						}else if(o.type==13){
                            html += '<td>债权投资</td>';
                        }else if(o.type == 14){
                            html += '<td>投资返现</td>';
						}else if(o.type == 15){
                            html +='<td>会员升级收益</td>';
						}
                        html += '<td>' + o.money + '</td>';
                        if(o.code==undefined){
                            html += '<td>'+o.tradeNo+'</td>';
						}else{
                            html += '<td>' + o.code+ '</td>';
						}
                        if(o.status == 1){
                            html += '<td>处理中</td>';
                        }else if(o.status ==2){
                            html += '<td>成功</td>';
                        }else {
                            html += '<td>失败</td>';
                        }
                    });
                    $('#userprojectinfo').empty();
                    $('#userprojectinfo').append(html);
                    $('.page').css('display','block');
                    generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
                }
            });
        }
        function chongzhiloadList() {
            $.post('/yingpu/pc/myaccount/getDealOrder', {
                pageIndex: pageIndex,
                id: '${pcuser.id}',
                status:gParams.status,
                type:gParams.type,
                dateBefore: gParams.dateBefore,
                dateStart: gParams.dateStart,
                dateEnd: gParams.dateEnd
            }, function (data) {
                // console.log(data)
                var dat = data;
                pageIndex = dat.page.pageIndex;
                pageCount = data.page.pageCount;
                pageSize = data.page.pageSize;
                data = data.data;
                var html = '';

                if (data==undefined || data.length == 0 ){
                    html = '<span style="display: block; text-align: center; width:988px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
                    $('#chonzghiprojectinfo').empty();
                    $('#chonzghiprojectinfo').append(html);
                    $('.page').css('display','none');
                    generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');

                }else {
                    // var len = data.length;

                    $.each(data, function (i, o) {
                        html += '<tr>';
                        html += '<td>' + new Date(o.createTime).Format('yyyy-MM-dd hh:mm:ss') + '</td>';
                        html += '<td>' + o.money + '</td>';
                        html += '<td>' + o.tradeNo+ '</td>';
                        if(o.status == 1){
                            html += '<td>处理中</td>';
                        }else if(o.status ==2){
                            html += '<td>成功</td>';
                        }else {
                            html += '<td>失败</td>';
                        }
                    });
                    $('#chonzghiprojectinfo').empty();
                    $('#chonzghiprojectinfo').append(html);
                    $('.page').css('display','block');
                    generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
                }
            });
        }
        function depositloadList() {
            $.post('/yingpu/pc/myaccount/getDealOrder', {
                pageIndex: pageIndex,
                id: '${pcuser.id}',
                status:gParams.status,
                type:gParams.type,
                dateBefore: gParams.dateBefore,
                dateStart: gParams.dateStart,
                dateEnd: gParams.dateEnd
            }, function (data) {
                // console.log(data)
                var dat = data;
                pageIndex = dat.page.pageIndex;
                pageCount = data.page.pageCount;
                pageSize = data.page.pageSize;
                data = data.data;
                var html = '';

                if (data==undefined || data.length == 0 ){
                    html = '<span style="display: block; text-align: center; width:988px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
                    $('#depositprojectinfo').empty();
                    $('#depositprojectinfo').append(html);
                    $('.page').css('display','none');
                    generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');

                }else {
                    // var len = data.length;

                    $.each(data, function (i, o) {
                        // alert(o.createTime);
                        html += '<tr>';
                        html += '<td>' + new Date(o.createTime).Format('yyyy-MM-dd hh:mm:ss') + '</td>';
                        html += '<td>' + o.money + '</td>';
                        html += '<td>' + o.tradeNo+ '</td>';
                        if(o.status == 1){
                            html += '<td>处理中</td>';
                        }else if(o.status ==2){
                            html += '<td>成功</td>';
                        }else {
                            html += '<td>失败</td>';
                        }
                    });
                    $('#depositprojectinfo').empty();
                    $('#depositprojectinfo').append(html);
                    $('.page').css('display','block');
                    generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
                }
            });
        }
        function invitefriends() {
            $.post('/yingpu/pc/myaccount/getDealOrder', {
                pageIndex: pageIndex,
                id: '${pcuser.id}',
                status:gParams.status,
                type:gParams.type,
                dateBefore: gParams.dateBefore,
                dateStart: gParams.dateStart,
                dateEnd: gParams.dateEnd
            }, function (data) {
                // console.log(data)
                var dat = data;
                pageIndex = dat.page.pageIndex;
                pageCount = data.page.pageCount;
                pageSize = data.page.pageSize;
                data = data.data;
                var html = '';

                if (data==undefined || data.length == 0 ){
                    html = '<span style="display: block; text-align: center; width:988px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
                    $('#invitefriends').empty();
                    $('#invitefriends').append(html);
                    $('.page').css('display','none');
                    generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');

                }else {
                    // var len = data.length;

                    $.each(data, function (i, o) {
                        html += '<tr>';
                        html += '<td>' + new Date(o.createtime).Format('yyyy-MM-dd hh:mm:ss') + '</td>';
                        html += '<td>' + o.realName + '</td>';
                        html += '<td>' + o.phone+ '</td>';
                        html += '<td>' + o.money + '</td>';
                        if(o.status == 1){
                            html += '<td>处理中</td>';
                        }else if(o.status ==2){
                            html += '<td>成功</td>';
                        }else {
                            html += '<td>失败</td>';
                        }
                        html += '</tr>';
                    });
                    $('#invitefriends').empty();
                    $('#invitefriends').append(html);
                    $('.page').css('display','block');
                    generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
                }
            });
        }
	</script>
	</body>
</html>
