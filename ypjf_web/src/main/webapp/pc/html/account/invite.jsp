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
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/html/account/css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/html/account/css/invite.css"/>
	<!-- 	<link rel="stylesheet" href="share/css/share.min.css"> -->
		<style>

		</style>
	</head>
	<body>
		<!--顶部-->
		<iframe src="/yingpu/pc/head3.html?index=6" width="100%" height="110px" scrolling="no" name="head"  style="border:0px;"></iframe>

		<div id="accountBox" class="clearFix">
			<!-- 左边导航 -->
			<div id="aside">
				<iframe src="../../myaccount/account_sidebar.html" width="100%" height="850px" scrolling="no"  style="border:0px;"></iframe>
			</div>

			<!-- 右边内容 -->
			<div id="account">
				<div id="banner">
					<img src="img/invite-img/banner.jpg" >
				</div>
				<div id="box">
					<!-- 邀请链接 -->
					<div class="inviteLink">
						<p class="title">专属邀请链接：</p>
						<div class="link clearFix">
							<div class="linkLeft">
								<textarea type="text" value="" readonly="readonly">http://39.106.27.146/yingpu/pc/register?code=${pcuser.inviteCode}</textarea>

								<span class="copy-btn">复制链接</span>
							</div>
							<div class="linkRight">
								 <div class="lianjie social-share"  data-initialized="true" style="text-align: center;" data-url="http://www.yingpuwealth.com/yingpu/pc/register-share/share.html?inviteCode=${pcuser.inviteCode}"  data-title="下载九趣贷APP">
								    <a href="#" class="social-share-icon icon-wechat"><img src="img/invite-img/weixin.jpg" class="img weixin"></a>
									<a href="#" class="social-share-icon icon-weibo"><img src="img/invite-img/weibo.jpg"  class="img weibo"></a>
								    <a href="#" class="social-share-icon icon-qq"><img src="img/invite-img/qq.jpg"  class="img qq"></a>
								</div>
								<!-- <div class="visit-code">
									<img src="img/invite-img/code.png" class="code"/>
									<p class="miaoshu">我的专属邀请码</p>
								</div> -->
							</div>
						</div>
						<p class="text">微信扫一扫专属邀请码，或复制邀请链接发送给好友,Ta通过你的链接成功注册为九趣贷会员，邀请关系确立</p>
					</div>
					<!-- 邀请奖励 -->
					<div class="jiangli">
						<p class="title">将属于你的奖励邀请</p>
						<p class="subtitle">成功邀请人数满足相应条件可领取叠加奖励</p>
					</div>
					<!-- 奖励列表 -->
					<ul class="items">
						<li class="item clearFix">
							<div class="zheng">
								<p class="text">赢取条件:被邀请的25个好友自成功注册之日起30个自然日之内，首次单笔出借直投项目金额（除新手专享项目、加息项目、转让项目除外）<span style="color:#fc1d59;">≥50.000</span></p>
								<p class="btn"><img src="img/invite-img/btn1.jpg" ></p>
							</div>
							<div id="share_box" style="display: none;">
							    <h1 class="share_title">分享至</h1>
							    <div class="social-share" data-initialized="true" style="text-align: center;" data-url="http://www.yingpuwealth.com/yingpu/pc/register-share/share.html?inviteCode=${pcuser.inviteCode}"  data-title="下载九趣贷APP">
							        <a href="#" class="social-share-icon icon-wechat"><img src="img/invite-img/wxs.png" ></a>
									<a href="#" class="social-share-icon icon-weibo"><img src="img/invite-img/wbs.png" ></a>
							        <a href="#" class="social-share-icon icon-qq"><img src="img/invite-img/qqs.png" ></a>
							    </div>
							</div>
						</li>
						<li class="item clearFix">
							<div class="zheng">
								<p class="text">赢取条件：被邀请的15个好友自成功注册之日起30个自然日之内，首次单笔出借直投项目金额（除新手专享项目、加息项目、转让项目除外）<span style="color:#ff4517;">≥40.000</span></p>
								<p class="btn"><img src="img/invite-img/btn2.jpg" ></p>
							</div>
							<div id="share_box" style="display: none;">
							    <h1 class="share_title">分享至</h1>
							    <div class="social-share" data-initialized="true" style="text-align: center;" data-url="http://www.yingpuwealth.com/yingpu/pc/register-share/share.html?inviteCode=${pcuser.inviteCode}"  data-title="下载九趣贷APP">
							        <a href="#" class="social-share-icon icon-wechat"><img src="img/invite-img/wxs.png" ></a>
							    	<a href="#" class="social-share-icon icon-weibo"><img src="img/invite-img/wbs.png" ></a>
							        <a href="#" class="social-share-icon icon-qq"><img src="img/invite-img/qqs.png" ></a>
							    </div>
							</div>
						</li>
						<li class="item clearFix">
							<div class="zheng">
								<p class="text">赢取条件：被邀请的10个好友自成功注册之日起30个自然日之内，首次单笔出借直投项目金额（除新手专享项目、加息项目、转让项目除外）<span style="color:#3e62f3;">≥30.000</span></p>
								<p class="btn"><img src="img/invite-img/btn3.jpg" ></p>
							</div>
							<div id="share_box" style="display: none;">
							    <h1 class="share_title">分享至</h1>
							    <div class="social-share" data-initialized="true" style="text-align: center;" data-url="http://www.yingpuwealth.com/yingpu/pc/register-share/share.html?inviteCode=${pcuser.inviteCode}"  data-title="下载九趣贷APP">
							        <a href="#" class="social-share-icon icon-wechat"><img src="img/invite-img/wxs.png" ></a>
							    	<a href="#" class="social-share-icon icon-weibo"><img src="img/invite-img/wbs.png" ></a>
							        <a href="#" class="social-share-icon icon-qq"><img src="img/invite-img/qqs.png" ></a>
							    </div>
							</div>
						</li>
						<li class="item clearFix">
							<div class="zheng">
								<p class="text">赢取条件：被邀请的6个好友好友自成功注册之日起30个自然日之内，首次单笔出借直投项目金额（除新手专享项目、加息项目、转让项目除外）<span style="color:#0bb9ce;">≥20.000</span></p>
								<p class="btn"><img src="img/invite-img/btn4.jpg" ></p>
							</div>
							<div id="share_box" style="display: none;">
							    <h1 class="share_title">分享至</h1>
							    <div class="social-share" data-initialized="true" style="text-align: center;" data-url="http://www.yingpuwealth.com/yingpu/pc/register-share/share.html?inviteCode=${pcuser.inviteCode}"  data-title="下载九趣贷APP">
							        <a href="#" class="social-share-icon icon-wechat"><img src="img/invite-img/wxs.png" ></a>
							    	<a href="#" class="social-share-icon icon-weibo"><img src="img/invite-img/wbs.png" ></a>
							        <a href="#" class="social-share-icon icon-qq"><img src="img/invite-img/qqs.png" ></a>
							    </div>
							</div>
						</li>
						<li class="item clearFix">
							<div class="zheng">
								<p class="text">赢取条件：被邀请的3个好友好友自成功注册之日起30个自然日之内，首次单笔出借直投项目金额（除新手专享项目、加息项目、转让项目除外）<span  style="color:#b174e0;">≥15.000</span></p>
								<p class="btn"><img src="img/invite-img/btn5.jpg" ></p>
							</div>
							<div id="share_box" style="display: none;">
							    <h1 class="share_title">分享至</h1>
							    <div class="social-share" data-initialized="true" style="text-align: center;" data-url="http://www.yingpuwealth.com/yingpu/pc/register-share/share.html?inviteCode=${pcuser.inviteCode}"  data-title="下载九趣贷APP">
							        <a href="#" class="social-share-icon icon-wechat"><img src="img/invite-img/wxs.png" ></a>
							    	<a href="#" class="social-share-icon icon-weibo"><img src="img/invite-img/wbs.png" ></a>
							        <a href="#" class="social-share-icon icon-qq"><img src="img/invite-img/qqs.png" ></a>
							    </div>
							</div>
						</li>
						<li class="item clearFix">
							<div class="zheng">
								<p class="text">赢取条件：被邀请的2个好友好友自成功注册之日起30个自然日之内，首次单笔出借直投项目金额（除新手专享项目、加息项目、转让项目除外）<span style="color:#b174e0;">≥10.000</span></p>
								<p class="btn"><img src="img/invite-img/btn6.jpg" ></p>
							</div>
							<div id="share_box" style="display: none;">
							    <h1 class="share_title">分享至</h1>
							    <div class="social-share" data-initialized="true" style="text-align: center;" data-url="http://www.yingpuwealth.com/yingpu/pc/register-share/share.html?inviteCode=${pcuser.inviteCode}"  data-title="下载九趣贷APP">
							        <a href="#" class="social-share-icon icon-wechat"><img src="img/invite-img/wxs.png" ></a>
							    	<a href="#" class="social-share-icon icon-weibo"><img src="img/invite-img/wbs.png" ></a>
							        <a href="#" class="social-share-icon icon-qq"><img src="img/invite-img/qqs.png" ></a>
							    </div>
							</div>
						</li>
					</ul>
					<!-- 邀请到的好友 -->
					<div class="friends">
						<p class="title">邀请到的好友</p>
						<div class="box">
								<div class="table">
									<table border="0" cellspacing="" cellpadding="">
										<thead>
										<tr>
											<th>序号</th>
											<th>好友</th>
											<th>时间</th>
										</tr>
										</thead>
                                        <tbody id="list">
                                        </tbody>
									</table>

								</div>
							</div>
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
					<!-- 邀请规则 -->
					<%--<div class="rules">--%>
						<%--<p class="title">活动规则</p>--%>
						<%--<p class="subTitle">活动时间：自2019年1月1日起至活动结束日</p>--%>
						<%--<div class="text">--%>
							<%--<p class="p1">1、邀请活动，新用户可以通过朋友的邀请链接注册，也可以在注册时在邀请码一栏填写邀请人的电话号码。不是通过邀请链接注册、没有填写邀请码，均不能认定为邀请关系，老用户无法享受邀请奖励，新用户注册奖励不变。</p>--%>
							<%--<p class="p1">2、被邀请的好友自注册之日起30个自然日内，首次单笔出借直投项目（除新手专享项目、加息项目、转让项目除外）的金额符合以下条件，即可获得以下奖励：</p>--%>
							<%--<p class="p1">邀请25个好友，平均每位好友50,000≥出借金额，即可获得价值￥9599的Iphone XS一台+10%返利</p>--%>
							<%--<p class="p1">邀请15个好友，平均每位好友40,000≥出借金额，即可获得价值￥6499的11英寸Ipad pro一台+10%返利</p>--%>
							<%--<p class="p1">邀请10个好友，平均每位好友30,000≥出借金额，即可获得价值￥2699的iRobot 扫地机器人一台+10%返利</p>--%>
							<%--<p class="p1">邀请6个好友，平均每位好友20,000≥出借金额，即可获得价值￥300的京东E卡一张+10%返利</p>--%>
							<%--<p class="p1">邀请3个好友，平均每位好友15,000≥出借金额，即可获得价值￥150的京东E卡一张+10%返利</p>--%>
							<%--<p class="p1">邀请2个好友，平均每位好友10,000≥出借金额，即可获得价值￥50的京东E卡一张+10%返利</p>--%>
							<%--<p class="p1">每位符合奖励条件的用户，最多只能获得1次京东E卡奖励。</p>--%>
							<%--<p class="p1">3、奖励的发放：符合奖励条件的客户，自出借之日起30个工作日内，平台自动将实物奖励/京东E卡内容包含卡号及密码，发送收货地址/邮箱，请注意查收。</p>--%>
							<%--<p class="p1">4、如有任何疑问欢迎咨询在线客服或拨打免费客服电话：400-969-1811，竭诚为您服务！</p>--%>
							<%--<p class="p2">活动说明：在实际操作中，可能存在多个邀请人邀请同一位好友的情况。邀请关系的最终确立，以该好友成功注册时填写的邀请人为准。若推荐人恶意采用特殊手段刷奖或盗用他人身份信息，一经发现，九趣贷有权取消该邀请人的获奖资格。九趣贷有权对本活动进行修改、暂停或终止。</p>--%>
							<%--<p class="p2">*本活动在法律允许范围内解释权归九趣贷所有*    </p>--%>
						<%--</div>--%>
					<%--</div>--%>
				</div>
			</div>
		</div>
		<!--底部导航-->
		<iframe src="/yingpu/pc/footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;height:326px;"></iframe>

		<script src="js/jquery.js" type="text/javascript" charset="utf-8"></script>
		<script src="share/js/jquery.share.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="share/js/social-share.min.js"></script>
        <script type="text/javascript" src="/yingpu/pc/js/utils.js"></script>
		<script src="js/jquery.zclip/jquery.zclip.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/invite.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
		// 复制链接
		$(".copy-btn").zclip({
			path: "js/jquery.zclip/ZeroClipboard.swf",
			copy: function(){
			return $(this).parent().find("textarea").val();
			},
			beforeCopy:function(){/* 按住鼠标时的操作 */
				$(this).css("color","orange");
			},
			afterCopy:function(){/* 复制成功后的操作 */
				var $copysuc = $("<div class='copy-tips'><div class='copy-tips-wrap'>☺ 复制成功</div></div>");
				$("body").find(".copy-tips").remove().end().append($copysuc);
				$(".copy-tips").fadeOut(3000);
			}
		});
        loadList();
        function loadList(){
            $.post('/yingpu/pc/myaccount/yaoqing/list/json',{pageIndex:pageIndex,pageSize:5},function(data){
                var dat=data;

                pageIndex = pageIndex
                pageCount = data.page.pageCount;
                pageSize=data.page.pageSize;
                data=data.data;
                var html='';
                if(data==undefined){
                    html='<span style="display: block; text-align: center; width:925px;border-bottom: 1px solid #eee;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
                    $('#list').empty();
                    $('#list').append(html);
                    $('.page').css('display','none');
                    return false;
                }else {
                    $.each(data, function (i, o) {
                        html += '<tr><td>' + ((i + 1) + ((dat.page.pageIndex - 1) * 4)) + '</td>';
                        html += '<td>' + o.phone + '</td>';
                        html += '<td>' + new Date(o.dateline).Format('yyyy-MM-dd hh:mm:ss') + '</td></tr>';

                    });
                    $('#list').empty();
                    $('#list').append(html);
                    generatePaginationNav(pageIndex, dat.page.pageCount, '#page-nav-btn');
                }
            });
        }
		</script>
	</body>
</html>
