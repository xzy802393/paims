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
		<title>营普金服—参股商业银行的互联网金融服务平台</title>
		<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
		<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
		<link rel="shortcut icon" href="../img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="css/account_common.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		<link rel="stylesheet" type="text/css" href="css/account_all.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html?index=5" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">
					<!--<div class="account-nav-name">
						<div class="account-pic">
							<img src="../img/account/account-pic.png"/>
						</div>
						<p class="name">赵丹红</p>
					</div>-->
					
					<iframe src="account_sidebar.html" width="100%" height="722" scrolling="no"  style="border:0px;"></iframe>
				</div>
				<!--右边主体部分-->
				
				<!--投资记录-->
				<div class="trans-records left">
					<h3>交易记录</h3>
					<div class="trans-choice">						
						<dl class="trans-choice-date clearfix">
							<dt>交易日期</dt>
							<dd dateBefore="" class="active">全部</dd>
							<dd dateBefore="7">最近7天</dd>
							<dd dateBefore="30">1个月</dd>
							<dd dateBefore="90">3个月</dd>
							<div class="trans-choice-date-box">
								选择时间
								<div class="calendarWarp">
									<input type="text" class="ECalendar" id="dateStart" value="起止日">
								</div>
								<span>-</span>
								<div class="calendarWarp">
									<input type="text" class="ECalendar" id="dateEnd" value="截止日">
								</div>
								<input type="submit" name="" id="search" value="查询" />
							</div>
						</dl>
					
						<dl class="trans-choice-type clearfix">
							<dt>交易类型</dt>
							<dd type="" class="active">全部</dd>
							<dd type="1,3">充值</dd>
							<dd type="2,4">提现</dd>
							<dd type="5">投资</dd>
							<dd type="8,11,12,14">收益</dd><!-- 
							<dd status="1,2,3">回收本金</dd> -->
							<dd type="6,7,9,10,13">其他</dd>
						</dl>
					</div>
					<table border="0" id="trans-list">
					<thead>
						<tr class="title">
							<th>时间</th>
							<th>交易类型</th>
							<th>交易详情</th>
							<th>交易状态</th>
							<th>交易金额（元）</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
					</table>
					
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
		
		<!--客服悬浮条-->
		<!--客服悬浮条-->
		<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/Ecalendar.jquery.min.js" type="text/javascript"></script>
	<script src="../js/utils.js"></script>
	<script type="text/tpl" id="list_item">
						<tr>
							<td class="time">$createTime</td>
							<td>$type</td>
							<td>$desc</td>
							<td>$status</td>
							<td class="org">$money</td>
						</tr>
	</script>
	<script type="text/javascript">
		var /* types = {
				1 : '转入',
				2 : '转出',
				3 : '投资',
				4 : '项目回款' || '利息发放', // (同意转出后改变为2）
				5 : '余额宝投入',
				6 : '转出余额宝',
				7 : '签到发放',
				8 : '邀请人收益',
				9 : '项目流标资金返还给投资人',
				10 : '',
				11 : ''
			}, */
			
			types = {
				1 : '充值',
				2 : '提现',
				3 : '借款人充值', 
				4 : '借款人提现',
				5 : '投资',
				6 : '借款人放款',
				7 : '借款人还款',
				8 : '利息发放',
				9 : '转入天天存吧',
				10 : '天天存吧转出',
				11 : '签到发放',
				12 : '邀请人收益',
				13 : '项目流标资金返还给投资人',
				14 : '合伙人分成',
				15 : '更改银行卡',
                16 : '天天存吧利息发放'
			},
			
			gParams = {
				dateBefore : '',
				type : '',
				status : '',
				dateStart : '',
				dateEnd : ''
			},
			
			gStatus = {
				1 : '处理中',
				2 : '成功',
				3 : '失败'
			};
		
		
		function filter(data) {
			var isSkip = false;
			$.each([3, 4, 6, 7, 15], function(k, v) {
				if (data.type == v) {
					return !(isSkip = true);
				}
			});
			
			return isSkip;
		}
		
	
		//useLoadingShade();
		function loadList() {
			var data = {
				id : '${pcuser.id}',
				pageIndex : pageIndex,
				status : gParams.status,
				dateBefore : gParams.dateBefore,
				type : gParams.type,
				dateStart : gParams.dateStart,
				dateEnd : gParams.dateEnd
			};

			$.post('../myaccount/transaction/list', data, function(data) {
				var tpl = $('#list_item').html();
				var html = '';
				
				pageIndex = data.page.pageIndex;
				pageCount = data.page.pageCount || 1;
				pageSize = data.page.pageSize;
				$.each(data.data || [], function(k, v) {
					var i, sign = '+';
					if (filter(v)) {
						return true;
					}

					v.index = (~-pageIndex * pageSize) + -~k;
					v.typeDesc = types[v.type];
					if (!!v.name) {
						v.typeDesc = v.type != 5 ? '回款' : v.typeDesc;
						v.typeDesc += ' ' + v.name;
					}

					switch(v.type) {
						case 2:
						case 4:
						case 5:
						case 6:
						case 7:
						case 10:
							sign = '-';
							break;
					}
					
					
					
					v.money = sign + v.money;
					v.type = /* gParams.status && !gParams.type ? '回收本金' : */ v.typeDesc;
					v.desc = v.tradeNo;
					v.status = gStatus[v.status];
					v.createTime = '<span>' + (v.createTime && v.createTime.substring(0, (i = v.createTime.indexOf(' ')))) + '</span><br/>'
								 + '<span>&emsp;&nbsp;' + (v.createTime && v.createTime.substring(-~i)) + '</span>';
					
					html += tpl.formatStr(v);
				});
				
				
				$('#trans-list>tbody').html(html 
						|| '<tr><td colspan="5" style="width: 100%; height: 300px; text-align: center; color: gray; font-size: 1.2rem; margin-top: 25%;">暂无数据</td></tr>');
				generatePaginationNav(pageIndex, pageCount, '#page-nav-btn');
			}, 'json');
		}
		
		
		$('.trans-choice').on('click', 'dd', function() {
			$(this).addClass('active').parent().find('dd').not($(this)).removeClass();
				
			var keys = ['dateBefore', 'type', 'status'], key = '';
			for (var k in keys) {
				if ($(this).attr(keys[k]) != null) {
					key = keys[k];
					break;
				}
			}
			
			switch(key) {
				case 'dateBefore':
					gParams.dateStart = '';
					gParams.dateEnd = '';
					break;
					
				case 'type':
				case 'status':
					gParams[key == 'type' ? 'status' : 'type'] = '';
					break;
			}
			console.log(key)
			gParams[key] = $(this).attr(key);
			pageIndex = 1;
			loadList();
		});

		
		loadList();
		
		$('#search').click(function() {
			gParams = {
					dateBefore : '',
					dateStart : ''/* ,
					type : '',
					dateEnd : '' */
			};
			
			gParams.dateStart = $('#dateStart').val().replace('起止日', '');
			gParams.dateEnd = $('#dateEnd').val().replace('截止日', '');
			pageIndex = 1;
			
			loadList();
		});
	
	
		//侧边栏样式
		$(function(){
			//a标签样式
			$("#sideBar li a").each(function(){
			   $(this).click(function(){ 
			   	  //console.log($("#sideBar li"));
			 	  $("#sideBar li h4").removeClass("on");
			 	  $(this).parent().find("h4").addClass("on");
			 	  $("#sideBar li a").removeClass("active");
			 	  $(this).addClass("active");
			 	  console.log($(this)) 
			   });
	   	  	});
	   	  	//点击标题收起
	   	  	$("#sideBar li h4").each(function(){
			   $(this).click(function(){ 
			   	  //console.log($("#sideBar li"));
			   	  $(this).toggleClass('on');
			 	  $(this).parent().find("a").toggle('slow');
			   });
	   	  	});
		});	

//		$(function(){
//			//投资记录切换
//			$("#menu li").each(function(){
//				$(this).click(function(){
//					$("#menu li").removeClass("active");
//					$(this).addClass("active");
//				})
//			})
//
//		});
		
	
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
	</script>
	
	</body>
</html>
