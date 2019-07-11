<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.gargoylesoftware.htmlunit.javascript.host.Console" %>
<%@page language="java" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String url = basePath + request.getServletPath() + "?" + request.getQueryString();
	String encodeUrl = URLEncoder.encode(url, "UTF-8");
	request.setAttribute("isLogin", request.getSession().getAttribute("pcuser") != null);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="../my-invest/css/common-opacity.css"/>
		<link rel="stylesheet" type="text/css" href="../my-invest/css/zhiTou.css"/>
		

        <link rel="stylesheet" type="text/css" href="../css/zhifu-password.css"/>
	</head>
	<body>
		<div id="banner">
			
			<div class="banner">
				<!-- 导航 -->
				<iframe src="../my-invest/head-opacity.html" class="iframe-headfu" width="100%" scrolling="no"  style="border:0px;display: block;z-index:1000"></iframe>
				
				<div class="box">
					<div class="content">
						<img src="img/img-zhitou/banner-person.png" class="banner-person" ondragstart="return false" oncontextmenu="return false">
						<p class="title"><img src="img/img-zhitou/title.png"></p>
						<div class="kuang">
							<ul class="neirong">
								<li class="shengyuchujie clearFix">
									<p class="left">当前剩余可出借金额：</p>
									<p class="right clearFix" style="width:294px;">
										<span class="money"><em></em>元</span>
										<span class="right progress">
											<span class="c1">
												<span class="jindu"></span>
											</span>
										</span>
									</p>
								</li>
								<li class="item1 clearFix">
									<p class="left">可用余额：</p>
									<!-- 登录前 -->
                                    <c:choose>
                                        <c:when test="${isLogin == false}">
                                            <p class="right dLQ clearFix" id="dLQ" style="display: block; width: 294px;">
                                                <span style="float:left;display: block;"><a href="../login.jsp" class="dl">登录</a>后可见</span>
                                                <a href="javascript:toLoginPage();" class="cz" style="float: right;">充值</a>
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- 登录后 -->
                                            <p class="right dLH clearFix" id="dLH" style="display: block; width: 294px;">
                                                <span style="float:left; width: 45px;" id="userMoney">${pcuser.caBalance}</span>
                                                <a href="../myaccount/deposit.jsp" class="cz" style="float: right;">充值</a>
                                            </p>
                                        </c:otherwise>
                                    </c:choose>
								</li>
								<li class="item2 clearFix">
									<p class="left">出借金额：</p>
									<div class="right">
										<p class="money">
											<span class="jian">-</span>
											<span class="num">
												<input type="text" value="1000.00" onkeyup="inputMoneyjudge()">
											</span> 元
											<span class="jia">+</span>
										</p>
                                        <p class="dayu" style="color:red;font-size:12px;line-height:14px;text-align: left;display: none;">出借金额不能大于当前剩余出借金额。请重新输入</p>
										<p class="xiaoyu" style="color:red;font-size:12px;line-height:14px;text-align: left;display: none;">出借金额不能小于1000元。请重新输入</p>
										<p class="zhengchu" style="color:red;font-size:12px;line-height:14px;text-align: left;display: none;">出借金额必须为1000的整数倍。请重新输入</p>
										<p class="tishi" style="color:red;font-size:12px;line-height:14px;text-align: left;display: none;">最低出借1000元起，1000元递增</p>
									</div>
								</li>
								<li class="item3 clearFix">
									<p class="left">选择服务期限：</p>
									<p class="right">
										<span class="tab active">1个月</span>
										<span class="tab">3个月</span>
										<span class="tab">6个月</span>
										<span class="tab">9个月</span>
										<span class="tab">12个月</span>
									</p>
								</li>
								<li class="item3 clearFix">
									<p class="left">综合出借利率：</p>
									<p class="right">
										<span class="lilv"></span>
									</p>
								</li>
								<li class="item3 clearFix">
									<p class="left">服务出借本金(元)：</p>
									<p class="right">
										<span class="bj">1,000.00</span>
									</p>
								</li>
								<li class="item3 clearFix">
									<p class="left">预期总收入(元)：</p>
									<p class="right">
										<span class="sr"> 0.00</span>
									</p>
								</li>
								<li class="item3 clearFix">
									<p class="left">募集时间：</p>
									<p class="right" id="time"></p>
								</li>
								<li class="item3 clearFix">
									<p class="left">授权锁定服务期：</p>
									<p class="right"><span class="qx">3个月</span>（期满后转入自由服务期）</p>
								</li>
								<li class="item3 clearFix">
									<p class="left">退出条件：</p>
									<p class="right">到期债转成功后退出<img src="img/img-zhitou/wenhao.png"  id="tishi" onmouseover="show('tishi')" onmouseout="hide()"></p>
								</li>
								<li class="item4">
									<a href="#" class="shouquan">立即授权</a>
								</li>
								<li class="item4" style="padding-top:10px;">
									温馨提示：市场有风险，出借需谨慎
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		<div id="content">
			<div class="title">
				<span class="active">服务介绍</span>
				<%--<span><a href="javascript:tzurl('/si/boower/Project')" style="color:#787878;">匹配项目</a></span>--%>
				<span>匹配项目</span>
			</div>
			<ul class="tabs">
				<li class="tab1" style="display: block;">
					<p class="p1"><img src="img/img-zhitou/fwjs.png" ></p>
					<ul class="items clearFix">
						<li>
							<p class="p2">自动投</p>
							<p class="p3">系统自动匹配优质标的，省时省力</p>
						</li>
						<li>
							<p class="p2">收益高</p>
							<p class="p3">优质标的利率更高</p>
						</li>
						<li>
							<p class="p2">超省心</p>
							<p class="p3">退出后还本付息，为您省心</p>
						</li>
						<li>
							<p class="p2">更稳健</p>
							<p class="p3">匹配标的安全等级全部为5星级</p>
						</li>
					</ul>
					<p class="p1"><img src="img/img-zhitou/liucheng-title.png" ></p>
					<div class="liucheng" style="width:100%;margin:0 auto;padding-top:6px;"><img src="img/img-zhitou/liucheng.png" ></div>
					
					<p class="p1"><img src="img/img-zhitou/fwts.png" ></p>
					<p class="text">X快享智能投标服务是九趣贷针对出借人和监管部门需求量身打造高效的资金小额分散本息自动出借的自动投标服务。自动投标授权服务期限自授权出借之日起至自由服务期届满日止。 当您选择X快享智能投标服务时，将授权九趣贷为您选择符合条件的标的为您进行分散投标、本金循环出借。服务期限届满后转入自由服务期，自由服务期内，系统会为您自动匹配其他智能标服务，您可以继续享有收益，或者在自由期内您可以选择将匹配的标的进行债权转让，九趣贷将根据您的授权通过债权转让系统帮助您进行转让退出，但平台不保证退出时效，如债权转让未达成，则您需持有该等标的直至转让成功。温馨提示：网贷有风险，出借需谨慎。</p>
					<p class="list">退出方式：</p>
					<p class="textfu">转入自由期后，可随时申请债转退出，不收取退出费用。平台将在申请后第7日内受理。 并通过债权转让自动完成退出，您所持债权转让完成的具体时间，视债权转让市场交易情况而定。</p>
					<p class="list">授权出借条件：</p>
					<p class="textfu">授权出借本金1,000元起，并以1,000元整数倍递增。</p>
					<p class="p1"><img src="img/img-zhitou/fxts.png" ></p>
					<p class="text">市场有风险，出借需谨慎。请您在出借前，仔细阅读<span><a href="javascript:void(viewLicense(0));">《出借风险说明和禁止性行为》</a></span>。</p>
					<p class="list">1.信用风险</p>
					<p class="textfu">网络借贷信息中介机构（下称机构）不提供增信服务，不承担借贷违约风险。如借款人因经营不善、资金周转不灵或主观故意而出现无法或未能正常还款的情况，出借人需自行承担借贷风险，接受本息损失。</p>
					<p class="list">2.延期风险</p>
					<p class="textfu">借款人于借款到期日因自身原因无法按时足额还款，九趣贷将根据出借人的授权采用适当方式代表出借人向借款人进行追索（包括但不限于仲裁和诉讼），无论采取何种方式，在此过程中出借人均有可能延期收到出借本金和利息。</p>
					<p class="list">3.交易失败的风险</p>
					<p class="textfu">本次交易的促成需符合相关法律法规的规定和借款合同的约定，可能存在不能满足成立条件从而导致交易失败的风险。</p>
					<p class="list">4.操作风险</p>
					<p class="textfu">不可预测或无法控制的系统故障、设备故障、通讯故障、停电等突发事故将有可能给借出人造成一定损失。由于通信故障、系统故障以及其他不可抗力等因素的影响，可能导致借出人无法及时作出合理决策，造成借出人损失。</p>
					<p class="list">5.经营风险</p>
					<p class="textfu">机构承诺将按照相关法律法规的规定进行运营及管理，但可能存在因法律法规调整而无法保证符合相关法律和监管部门的要求的现象。如机构无法继续经营网络借贷信息中介业务或发生重大业务调整，或财产状况发生重大变化，则可能对出借人产生不利影响。</p>
					<p class="list">6.其他风险</p>
					<p class="textfu">自然灾害、战争等无法避免或无法控制的因素的出现，将影响市场的正常运行，从而导致还款资金损失，甚至影响该借款的成立、运行、偿付等的正常进行；</p>
					<p class="textfu">特别提示：前述风险提示不能穷尽全部风险及市场的全部情形。</p>
				</li>
				<li class="tab2" style="display: none;">
					<div class="table">
						<table border="0" cellspacing="20" cellpadding="20">
							<tr class="title">
								<th>序号</th>
								<th>标名称</th>
								<th>借款人</th>
								<th>借款期限</th>
								<th>借款金额（元）</th>
							</tr>
							<tbody id="userprojectinfo"></tbody>
						</table>
						<div class="record-page">
							<div class="record-page-list">
								<a href="javascript:go('home')">首页</a>
								<a href="javascript:go('prev')">上一页</a>
								<span id="page-nav-btn"></span>
								<a href="javascript:go('next')">下一页</a>
							</div>
						</div>

					</div>
				</li>
			</ul>
			<div class="line"><span class="left"></span>九趣贷您身边的理财顾问<span class="right"></span></div>
		</div>
		<!--悬浮条-->
		<iframe src="../xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="../yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="./../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>

		<!--底部-->
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;display: block;"></iframe>
		<script src="../my-invest/js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
		<!-- <script src="my-invest/js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script> -->
		<script src="js/utils.js" type="text/javascript" charset="UTF-8"></script>
		<script src="../my-invest/js/zhiTou.js" type="text/javascript" charset="utf-8"></script>
		<script src="../newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/zhifu_password.js" type="text/javascript" charset="utf-8"></script>
        <script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			$(function(){
			    if(isLogin()){
                    $("#dLQ").hide();
                    $("#dLH").show();
				}
			});

			function isLogin(){
			    return !!'${pcuser.phone}';
			}

            function getEncodedCurrentURL(){
                return encodeURIComponent(location.href);
            }

            function toLoginPage() {
			    location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
            }

            function tzurl(url) {
                top.location.href = '/yingpu/pc' + url;
            }

            $('.shouquan').click(function() {
				if(!isLogin()){
				    toLoginPage();
                }else {
                    if ('${pcuser.isIdCard}' != '是') {
                        layer.alert('您还未实名认证，请先实名认证！');
                        return;
                    }
                    if(isSubmit()){
                            $('<form method="post"></form>')
                                .attr('action', '/yingpu/pc/si/checkout')
                                .append(function () {
                                    var html = '';
                                    $.each(investParam(), function (k, v) {
                                        html += '<input name="' + k + '" value="' + v + '" />';
                                    })
                                    return html;
                                })
                                .appendTo($('body'))
                                .submit();

                        //location.href = '/yingpu/pc/si/checkout?' + investParam();
                    }else{
                        return ;
                    }
                }
            })

            function investParam() {
                var p = curProject();
			    var param = {
			        amount : $('.num>input').val(),
                    deadLine : p.deadLine,
                    projectId : p.id
                };
			    return param;
            }

            function openPasswordInput() {
                layer.open({
                    type: 1, //Page层类型
                    area: ['446px', '220px'],
                    title: false,
                    shade: 0.6, //遮罩透明度
//						  ,maxmin: true //允许全屏最小化
                    anim: 1, //0-6的动画形式，-1不开启
                    content: $(".zhifu-password"),
                    cancel: function () {
                        closezhifu();

                    }
                });
                $('#payPassword_rsainput').focus();
            }

            function closezhifu() {
                $('#payPassword_rsainput').val('')
                $('.sixDigitPassword-box').find('b').css({'visibility': 'hidden'});
                $('.sixDigitPassword-box').children('span').css('left', '0px');
                $('.sixDigitPassword-box').children('i').first().addClass('active');
                $('#payPassword_rsainput').focus();
            }

            function touzi() {
                if (!$('body').data('tradPassword')) {
                    layer.alert('您还没有设置支付密码', function () {
                        location.href = '/yingpu/pc/myaccount/payment_password.jsp';
                    });
                    return false;
                }

                $.post('../pc/userproject/touzi', {

                    tradPassword: $('#payPassword_rsainput').val()
                }, function (data) {
                    layer.closeAll();
                    if (data.status == 'success') {
                        layer.alert(data.message, function () {
                            location.href = '/yingpu/pc/html/account/Xzhitou.jsp';
                        });
                    } else {
                        if (data.message == '您的支付密码已被锁定') {
                            var ind = layer.open({
                                'title': '错误提示', 'content': '您的支付密码已被锁定,请重置支付密码', 'btn': ['忘记密码'], 'yes': function () {

                                    location.href = '/yingpu/pc/myaccount/payment_password.jsp';
                                }
                            });
                        } else {
                            var ind = layer.open({
                                'title': '错误提示', 'content': data.message, 'btn': ['重新输入'], 'yes': function () {
                                    layer.close(ind);
                                    closezhifu();
                                    dianjitouzi();
                                }, 'btn2': function () {
                                    location.href = '/yingpu/pc/myaccount/payment_password.jsp';
                                }
                            });
                        }

                        closezhifu();

                    }
                });
            }


		</script>
		<script type="text/javascript">
			var tip_index = 0;
			function show(id) {
				tip_index = layer.tips("<div style='color:#fff;'>X快享智能投标是一种智能投标工具，锁定期满后，系统会为您自动续投其它标的，提高资金利用率；或者您可以在X快享智投锁定期满后，选择手动债转标的， 转让成功后退出本金。如转让不成功会持有债券继续转让，债券历史转让成功率达99.98%。</div>", "#"+id+"", {
				  tips: [3, "#038cf6"],
				  area: ['350px', 'auto'],
				});
			};
			function hide(){
				 layer.close(tip_index);
			}
            function viewLicense(idx) {
                var idxs = [17];
                layer.open({
                    type: 2,
                    content: '<%=basePath%>pc/myaccount/announce/content?id=' + idxs[idx] + '&type=contractsample',
                    area: ['50%', '80%']
                });
            }
            $('#userMoney').text(commafy(returnFloat($('#userMoney').text())));
		</script>
    </body>
</html>
