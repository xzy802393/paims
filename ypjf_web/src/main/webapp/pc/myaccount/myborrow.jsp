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
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="css/account_common.css"/>
		<link rel="stylesheet" type="text/css" href="css/account_all.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">
					
					<iframe src="account_sidebar.html" width="100%" height="850" scrolling="no"  style="border:0px;"></iframe>
					
				</div>
				<!--右边主体部分-->
				
				<!--投资记录-->
				<div class="borrow-records left">
					<h3>我的借款</h3>
					<div class="tab-menu" id="menu">
						<ul class="clearfix">
							<li status="2" class="active">募集中</li>
							<li status="3">待还款</li>
							<li status="4">已还款</li>
							<li status="5">已逾期</li>
						</ul>
					</div>
					<table border="0" id="invest-list">
						<thead>
							<tr class="title">
								<th>&nbsp;&nbsp;序号&nbsp;&nbsp;</th>
								<th>项目</th>
								<th>利率（%）</th>
								<th>期限</th>
								<th>投资额（元）</th>
								<th>投资时间</th>
								<th>到期时间</th>
								<th>本息合计（元）</th>
								<th>&emsp;&emsp;&emsp;&emsp;</th>
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
		<!-- <iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		 --><!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		<!--加载js文件-->
		<script type="text/tpl" id="list_item">
			<tr data="">
				<td>$index</td>
				<td>$name</td>
				<td>$repayRate</td>
				<td>$deadLine个月</td>
				<td>$totalAmount</td>
				<td>$createTime</td>
				<td>$endTitme</td>
				<td>$totolInterest</td>
				<td style="visibility: hidden;">&emsp;&emsp;<a onclick="repay($id)" class="repay-btn">还款</a></td>
			</tr>
		</script>
	<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../layer-v3.0.3/layer/layer.js"></script>
	<script src="../js/utils.js"></script>
	<script type="text/javascript">

		$(function(){
			//投资记录切换
			$("#menu li").each(function(){
				$(this).click(function(){
					$("#menu li").removeClass("active");
					$(this).addClass("active");
				})
			})

		});
		
		
		var pageIndex, pageCount, status = 2;
		String.prototype.formatStr = function() {
			var regex = /\\$[a-zA-Z_]\w*/g,
				regexQuotes = /([$\/{}()?*.\[\]+^])/,
				args = arguments,
				matched = [],
				str = this,
				tempArr = [],
				isKvValue = false;

			while((tempArr = regex.exec(this)) != null) {
				matched.push(tempArr[0]);
			}
			
			if (typeof args[0] == 'object' && args[0].constructor == Object) {
				var i = 0;
				for (var key in args[0]) {
					matched[i] = '$' + key;
					args[i++ + 1] = args[0][key];
				}
				args.length = i;
				isKvValue = true;
			}

			var value;
			for (var i = 0; i < Math.min(matched.length, args.length); i++) {
				str = str.replace(new RegExp('\\' + matched[i], 'g'),
						args[isKvValue ? i + 1 : i] == null ? '' : args[isKvValue ? i + 1 : i]);
			}

			return str;
		};
		
		
		function viewContract(param) {
			layer.open({
			   type: 2,
			   title: '查看合同',
			   shadeClose: true,
			   shade: 0.8,
			   area: ['50%', '80%'],
			   content: '<%=basePath%>app/userproject/gethetong/json?' + param
			});
		}
		
		
		function repay(pid) {
			if (!pid) {
				return;
			}
			
			var ai = layer.alert('您是否要还款？', {btn: ['是', '否']}, function() {
			  	layer.close(ai);
				var pi = layer.prompt({title: '请输入还款金额'}, function(pass, index){
				  	if (pass <= 0) {
				  		layer.msg('还款金额不能小于等于0！');
				  		return;
				  	}
				  	
				  	layer.close(pi);
				  	doRepay(pid, pass);
				}, function() {
					layer.close(ai);
				});
			}, function() {
				
			});
		}
		
		function doRepay(projectId, money) {
			var ll = layer.msg('正在还款中...', {
				  icon: 16
				  ,shade: 0.01
			});
			$.post('<%=basePath%>pc/myaccount/doRepay', {
				phone : ${pcuser.phone},
				project : projectId,
				money : money
			}, function(data) {
				layer.close(ll);
				if (data.status == 'success') {
					layer.alert('还款成功！');
					return;
				}
				
				layer.alert('对不起，还款失败，请稍后再试！');
			}, 'json');
		}
		
		
		function loadList() {
			var data = {
				id : '${pcuser.id}',
				pageIndex : pageIndex,
				status : status
			};

			$.post('../myaccount/loan/list', data, function(data) {
				var tpl = $('#list_item').html();
				var html = '';
				
				pageIndex = data.page.pageIndex;
				pageCount = data.page.pageCount || 1;
				pageSize = data.page.pageSize;
				$.each(data.data || [], function(k, v) {
					v.index = (~-pageIndex * pageSize) + -~k;
					v.cardRate = v.cardRate ? v.cardRate + '%' : null;
					v.cardType = v.cardRate ? ['','抵扣券', '加息券'][v.cardType] : '无';
					html += tpl.formatStr(v);
				});
				
				$('#invest-list>tbody').html(html 
						|| '<tr><td colspan="10" style="width: 100%; height: 300px; text-align: center; color: gray; font-size: 1.2rem; margin-top: 25%;"><span style="display: block;text-align: center;width:988px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span></td></tr>');
				
				
				$('#invest-list>tbody>tr').each(function(i, e){
					/* var data = eval('(' + $(e).attr('data') + ')');
					var total=accAdd(data.cardPrice || 0, accAdd(data.totolInterest, data.money));
					$(e).find('td:eq(7)').html(total); */
					$(e).find('td:eq(8)').css('visibility', status == 3 ? 'visible' : 'hidden');
				});
				generatePaginationNav(pageIndex, pageCount, '#page-nav-btn');
			}, 'json');
		}
		
		
		$('#menu').on('click', 'li', function() {
			status = $(this).attr('status');
			pageIndex = 1;
			loadList();
		});


		$('#menu li:eq(0)').click();
		
	</script>	
	</body>
</html>
