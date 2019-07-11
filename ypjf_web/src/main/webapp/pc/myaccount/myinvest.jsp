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
		<link rel="stylesheet" type="text/css" href="css/account_all.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		<iframe src="../head3.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<script type="text/tpl" id="list_item">
			<tr data="{projectId:$projectId,totolInterest:$totolInterest,money:$money,cardPrice:'$cardPrice'}">
				<td>$index</td>	
				<td>$name</td>	
				<td>$repayRate</td>
				<td>$deadLine个月</td>
				<td>$money</td>
				<td>$createTime</td>
				<td>$endTitme</td>
				<td>$cardRate$cardType</td>
				<td>$totolInterest</td>
				<td onclick="viewContract('userid=${pcuser.id}&projectid=$projectId&id=$id')"><span style="$viewStyle">查看&nbsp;&nbsp;<br/>合同&nbsp;&nbsp;</span></td>
			</tr>
		</script>
		
		
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">
					
					
					<iframe src="account_sidebar.html" width="100%" height="722" scrolling="no"  style="border:0px;"></iframe>
				</div>
				<!--右边主体部分-->
				
				<!--投资记录-->
				<div class="invest-records left">
					<h3>我的投资</h3>
					<div class="tab-menu" id="menu">
						<ul class="clearfix">
							<%--<li status="" class="active">全部</li>--%>
							<li status="2">投标中</li>
							<li status="3" >回款中</li>
							<li status="4" >已还款</li>
							<!-- <li status="5" >已逾期</li> -->
						</ul>
					</div>
					<table border="0" cellspacing="20" cellpadding="20" id="invest-list">
					<thead>
						<tr class="title">
							<th>&nbsp;&nbsp;序号&nbsp;&nbsp;</th>
							<th>项目</th>
							<th>利率（%）</th>
							<th>期限</th>
							<th>投资额（元）</th>
							<th>投资时间</th>
							<th>到期时间</th>
							<th>优惠券</th>
							<th>本息合计（元）</th>
							<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
						</tr>
					</thead>
					<tbody  style="width: 100%; height: 300px;">
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
		<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
	<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../layer-v3.0.3/layer/layer.js"></script>
	<script src="../js/utils.js"></script>
	<script type="text/javascript">
		$(function(){
			//投资记录切换
			$("#menu").on('click', 'li', function(){
                $("#menu li").removeClass("active");
                $(this).addClass("active");
			})

            $('#menu li:eq(0)').click();
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
		
		
		
		function go(act) {
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
					
				default:
					pageIndex = act;
			}
			
			pageIndex = Math.max(1, Math.min(pageIndex, pageCount));
			typeof loadList == 'function' && loadList();
		}
		
		
		function generatePaginationNav(pageIndex, pageCount, sel) {
			var html = '', btnNum = 7, halfNum = btnNum >> 1,
			pe = Math.min(pageCount, pageIndex + halfNum),
			ps = pageIndex + halfNum > pe ? Math.max(1, pe - btnNum + 1) : Math.max(1, pageIndex - halfNum);
			
			for (var i = 0; i < btnNum && ps + i <= pageCount ; i++) {
				html += '<a href="javascript:void(go($index))">$index</a>'.formatStr({index:ps + i});
			}
			
			$(sel).html(html)
				  .find('a').filter(function(){ return $(this).html() == pageIndex; }).addClass('active');
		}
		
		
		function loadList() {
			var data = {
				id : '${pcuser.id}',
				pageIndex : pageIndex,
				status : status
			};
			$.post('../myaccount/invests', data, function(data) {
				var tpl = $('#list_item').html();
				var html = '';
				
				pageIndex = data.page.pageIndex;
				pageCount = data.page.pageCount;
				pageSize = data.page.pageSize;
				$.each(data.data || [], function(k, v) {
					v.index = (~-pageIndex * pageSize) + -~k;
					v.cardRate = v.cardPrice//v.cardRate ? v.cardRate + '%' : null;
					v.cardType = v.cardRate ? '元' + ['','抵扣券', '加息券'][v.cardType] : '无';
					v.repayRate = accMul(v.repayRate, 100);
					//v.endTitme = v.endTitme ? new Date(v.endTitme).Format('yyyy-MM-dd hh:mm:ss') : '';
					v.viewStyle = v.projectStatus > 3   ? 'display: none;' : '';

					html += tpl.formatStr(v);
				});
				
				$('#invest-list>tbody').html(html 
						|| '<tr><td colspan="10" style="width: 100%; height: 300px; text-align: center; color: gray; font-size: 1.2rem; margin-top: 25%;">暂无数据</td></tr>');

				$('#invest-list>tbody>tr').each(function(i, e){
					var data = eval('(' + $(e).attr('data') + ')');
					if (!data) {
						return;
					}
					
					var total=accAdd(data.cardPrice || 0, accAdd(data.totolInterest, data.money));
					$(e).find('td:eq(8)').html(total);
				});
				generatePaginationNav(pageIndex, pageCount, '#page-nav-btn');
			}, 'json');
		}
		
		
		$('#menu').on('click', 'li', function() {
			status = $(this).attr('status');
			pageIndex = 1;
			loadList();
		});


	</script>	
	</body>
</html>
