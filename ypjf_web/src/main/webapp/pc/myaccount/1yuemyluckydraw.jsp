<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		<link rel="stylesheet" type="text/css" href="css/myluckydraw.css"/>
		<!--<link rel="stylesheet" type="text/css" href="css/sign2.css"/>-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		
		<!--主体-->
		<div class="account-box" style="position: relative;">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">
					<!--<div class="account-nav-name">
						<div class="account-pic">
							<img src="../img/account/account-pic.png"/>
						</div>
						<p class="name">赵丹红</p>
					</div>-->
					<iframe src="account_sidebar.html" width="100%" height="622" scrolling="no"  style="border:0px;"></iframe>
				</div>
				<!--右边主体部分-->
			
				<!--抽奖记录-->
				<div class="luckydraw left" id="luckyDraw">
					<h3>获奖记录</h3>

					<table border="0" cellspacing="" cellpadding="">
						<tr class="title">
							<th>获奖时间</th>
							<th>获奖内容</th>
							<th>获奖主题</th>
						</tr>
						<tbody id="list">
							
						</tbody>
						
					</table>
					
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
		
					<!--<div class="sign-rule">
						<p>签到规则</p>
						<p>APP签到红包为当天所有签到用户平均分配，红包总额由工作人员提前1天设定；</p>
						<p>随着签到人数增加，人均奖励会逐步降低；</p>
						<p>当日签到奖励状态为“待分配”，奖励次日到账。当日签到奖励金额不等于最终到账金额。</p>
						<p>积极签到，分享快乐。</p>
					</div>-->
				</div>
			</div>
		</div>
		
		<!--底部导航-->
		
	<iframe src="../footer.html" width="100%" scrolling="no"  style="border:0px;height:308px;"></iframe>
		<!--加载js文件-->
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/Ecalendar.jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="../js/utils.js"></script>
	<script type="text/javascript" src="js/calendar2.js"></script>
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
		
	

	</script>
	<script type="text/javascript">

							// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
		
		$(function(){
			loadList();
		});
		
		
		
		//内容滚动
			function loadList(){
				$.post('/yingpu/pc/prize/yueprizeHis/list/json',{pageIndex:pageIndex,pageSize:5},function(data){
					var dat=data;
					pageIndex = pageIndex
					pageCount = data.page.pageCount;
					pageSize=data.page.pageSize;
					data=data.data;
					var html='';
				if(data==undefined){
					$('#list').empty();
					$('#list').append('<h3 aligin="center">暂无记录</h3>');	
					return false;
				}
					$.each(data,function(i,o){
							html+='<tr><td>'+new Date(o.createTime).Format('yyyy-MM-dd hh:mm:ss')+'</td>';
							html+='<td>'+o.prizeName+'</td>';
							html+='<td>新年快乐</td></tr>';
					});
				$('#list').empty();
				$('#list').append(html);		
				generatePaginationNav(pageIndex, dat.page.pageCount, '#page-nav-btn');					
									
				});
			}
	</script>
	
	</body>
</html>
