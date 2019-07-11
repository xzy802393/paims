<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   

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
		<link rel="stylesheet" type="text/css" href="css/myrewards.css"/>

	
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html" width="100%" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">

					<iframe src="account_sidebar.html" width="100%" height="722" scrolling="no"  style="border:0px;"></iframe>
				</div>
				<!--右边主体部分-->
				
				<!--邀请奖励-->
				<div class="rewards left">
					<div class="rewards-ad">
						<img src="../img/account/myreward-ad.jpg"/>
						<a href="http://www.yingpuwealth.com/yingpu/pc/infomation/Feb_activity/May_activity.jsp">点击查看最新活动</a>
					</div>
					<div class="rewards-visit clearfix">
						<h3>邀请方式</h3>
						<div class="rewards-visit-link left">
							<p><span>邀请方式一：</span>将您的邀请专属链接发送给您的好友</p>
							<div class="visit-link">
								<p>http://www.yingpuwealth.com/yingpu/pc/infomation/generalize/generalize.html?code=${pcuser.inviteCode}</p>
							</div>
							<p class="copy-btn">复制链接</p>
						</div>
						<div class="line left"></div>
						<div class="rewards-visit-code left">
							<p><span>邀请方式二：</span>将二维码发送给好友，好友扫码即可注册，系统会默认输入你的邀请码（你的好友无需输入）。</p>
							<div class="visit-code">
								<img src="${pcuser.inviteCodeUrl}" class="code"/>								
							</div>
						</div>
					</div>
					<div class="rewards-visit-f">
						<h3>邀请到的好友</h3>
						<table border="0" cellspacing="" cellpadding="">
							<tr>
								<th>序号</th>
								<th>好友</th>
								<th>时间</th>
							</tr>

							<tbody id="list">
								

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
					<div class="rewards-tip">
						<p>申明</p>
						<p>1、若用户恶意采用特殊手段刷奖或盗用他人身份信息，扰乱正常活动秩序，营普金服有权取消其获得奖励的资格；</p>
						<p>2、邀请奖励活动由营普金服设计，营普金服有权对活动内容、形式、奖励进行修改、暂停或终止；</p>
						<p>3、在法律许可范围内，本活动最终解释权归营普金服所有，如有任何疑问，请咨询客服：400-969-1811</p>
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
	<script type="text/javascript" src="../js/jquery.zclip/jquery.zclip.js"></script>
	<script type="text/javascript" src="../js/utils.js"></script>
	<script src="../../layer-v3.0.3/layer/layer.js"></script>
	<script src="js/Ecalendar.jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function(){
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

			loadList();



			    $(".copy-btn").zclip({
        path: "../js/jquery.zclip/ZeroClipboard.swf",
        copy: function(){
        return $('.visit-link>p').text();
        },
        beforeCopy:function(){/* 按住鼠标时的操作 */
            $(this).css("color","orange");
        },
        afterCopy:function(){/* 复制成功后的操作 */
           	layer.alert('复制成功');
        }
    });
		});		

		function loadList(){
				$.post('../myaccount/yaoqing/list/json',{pageIndex:pageIndex,pageSize:5},function(data){
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
							html+='<tr><td>'+((i+1)+((dat.page.pageIndex-1)*4))+'</td>';
							html+='<td>'+o.phone+'</td>';
							html+='<td>'+new Date(o.dateline).Format('yyyy-MM-dd hh:mm:ss')+'</td></tr>';

					});
				$('#list').empty();
				$('#list').append(html);		
				generatePaginationNav(pageIndex, dat.page.pageCount, '#page-nav-btn');					
									
								
 
				});
			}

	</script>
	
	</body>
</html>
