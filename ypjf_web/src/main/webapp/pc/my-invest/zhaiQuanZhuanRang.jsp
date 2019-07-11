<%@ page import="java.net.URLEncoder" %>
<%@page language="java" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String url = basePath + request.getServletPath() + "?" + request.getQueryString();
	String encodeUrl = URLEncoder.encode(url, "UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8" />
		<title>九趣贷 — 贷快乐，更带梦想</title>
        <base href="<%=basePath%>/pc/my-invest/" />
		<link rel="stylesheet" type="text/css" href="../my-invest/css/commonfu.css"/>
		<%--<link rel="stylesheet" type="text/css" href="../my-invest/css/my-invest.css"/>--%>
		<link rel="stylesheet" type="text/css" href="../my-invest/css/zhaiquanzhuanrang.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/zhifu-password.css"/>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<style>
            #content .contentgxb .left .box .xiangmu .line4 .gxb .you .progress .jindu span {
                display: block;
                background: #ff7552;
                border-radius: 5px;
                width: 100%;
                height: 100%;
            }
            #content .content2 .tab .tab2 .record-page-list span {
                border: none;
                text-align: center;
                display: inline;
                width: 12px;
                margin-left: 10px;
            }
        </style>
	</head>
	<body>
		<!-- 导航 -->
		<iframe src="../head3.html" class="iframe-headfu" width="100%" scrolling="no"  style="border:0px;display: block;z-index:1000"></iframe>
		<div id="content">
			<div class="nav-bar">
				<p>您当前所在的位置：<a href="/"> 九趣贷 </a> &gt;  <a href="/yingpu/pc/project/list">我要出借</a> &gt; <a class="now"> 债券转让列表</a></p>
			</div>
			<div class="clearFix contentgxb content1">
				<div class="left">
					<div class="box">
						<div class="title clearFix">
							<p class="leftt">
								<span class="personname">${data.name}</span>
								<span class="name">项目ID：${data.code}</span>
							</p>
							<p class="rightt"><a href="/yingpu/pc/getProjectDetails?projectid=${data.id}">查看原始借款信息</a></p>
						</div>
						 <ul class="xiangmu">
							<li class="line1">
								<span class="nianhua">
									<p class="num"><em class="shuzi" id="price">${data.investmentAmount + data.assignedAmount + (
									    data.isdata.interest)}</em>元</p>
									<p class="text">债权价格</p>
								</span>
								<span class="qixian">
									<p class="num"><em class="shuzi" id="surplusValue">${data.investmentAmount}</em>元</p>
									<p class="text">剩余债权</p>
								</span>
								<span class="edu">
									<p class="num1" style="text-align: center;"><em class="shuzi">
                                        <fmt:formatNumber value="${data.estimatedAnnualRate * 100}" pattern="##0.00" /> </em>%</p>
									<p class="text">预期年化利率</p>
								</span>
							</li>
							<li class="line4">
								
								<div class="a4 clearFix">
									<p class="gxb">
										<span class="zuo">还款方式：</span>
										<span class="you">按月付息/到期还本</span>
									</p>
									<p class="gxb">
										<span class="zuo">最低承接：</span>
										<span class="you">100元</span>
									</p>
									<p class="gxb">
										<span class="zuo">还款日：</span>
										<span class="you"><fmt:formatDate value="${data.nextInterest}" pattern="yyyy-MM-dd"/></span>
									</p>
									<p class="gxb">
										<span class="zuo">剩余期限：</span>
										<span class="you"><span class="color">${data.repaymentNum}个月</span>/ ${data.deadLine}个月</span>
									</p>
									<p class="gxb">
										<span class="zuo">还款来源：</span>
										<span class="you">其他</span>
									</p>
									<p class="gxb">
										<span class="zuo">温馨提示：</span>
										<span class="you">市场有风险，出借需谨慎</span>
									</p>
									<p class="gxb" style="width:100%;">
										<span class="zuo">出借进度：</span>
										<span class="you">
											<!-- <p  class="progress" style="display: inline-block;"><span class="jindu"><span></span></span></p> -->
											<strong class="progress">
												<span class="jindu" style="width: ${data.assignedAmount / (data.investmentAmount + data.assignedAmount) * 100}%; float:right;"><span></span></span>
											</strong>
											<span class="per">${data.assignedAmount / (data.investmentAmount + data.assignedAmount) * 100}%</span>
										</span>
									</p>
								</div>
							</li>
						</ul> 
						
					</div>
				</div>
				<div class="right">
					<div class="box">
						<p class="p">剩余可出借 <span id="Canlend">${data.investmentAmount}</span>元</p>
						<p class="p">倒计时：<span id="time" style="font-size: 14px;color: #787878;"></span></p>
						<p class="p1"><span class="keyong clearFix">可用余额：
                            <c:choose>
                                <c:when test="${empty pcuser}"><a href="" class="login">登录</a>后可见</span></c:when>
                                <c:otherwise>
                                   <span>${pcuser.caBalance}</span>
                                </c:otherwise>
                            </c:choose>

                            <a class="chongzhi" balance="${pcuser.balance}" project="${data.investmentAmount}" style="">全部承接</a></p>
						<p class="p2"><span class="wenzi clearFix">出借金额：</span><span type="text" class="money"><span class="jian">-</span><span class="num"><input type="text" value="100" onkeyup="inputMoney()" ></span> 元<span class="jia">+</span></span></p>
                        <p class="p3 clearFix"><span class="wenzi">实际支付：<span id="shijizhifu">0</span>元,到期收益：<span id="shouyi">0</span>元</span></p>
						<p class="p5"><a href="javascript:void(0)" class="chujie"><img src="img/btn-shouquanchujie.png" alt=""></a></p>
						<p class="p6 clearFix">
							<input type="checkbox" name="" id="agreeText" value="agree" checked="checked">
							<lable for="agreeText">已阅读并同意<a href="javascript:void(viewLicense(0));">《网络借贷风险和禁止性行为提示书》</a>、<a href="javascript:void(viewLicense(1));">《债权转让与受让协议》</a></lable>
						</p>
					</div>
				</div>
			</div>
			
			<div class="content2">
				<ul class="nav clearFix">
					<li class="active">转让说明 </li>
					<li>承接记录</li>
					<li>常见问题</li>
				</ul>
				<ul class="tab">
					<li class="tab1" style="display: block;">
						<div class="title"><p>转让说明：</p></div>
						<div class="box1"><p>债权转让，指出借人将在九趣贷平台出借的借款项目转让给其他九趣贷用户，并与授让人签订债权转让协议，收回本金及利息的操作。债权转让能提高出借者资金的流动性，当你需要流动资金时，可以通过出售你名下拥有的符合相应条件的债权给其他出借人，从而完成债权转让，获得流动资金。</p></div>
						<ul class="items clearFix">
							<li>
								<img src="img/img-zhaiquan/a1.png" >
							</li>
							<li>
								<img src="img/img-zhaiquan/jiantou.png" >
							</li>
							<li>
								<img src="img/img-zhaiquan/a2.png" >
							</li>
							<li>
								<img src="img/img-zhaiquan/jiantou.png" >
							</li>
							<li>
								<img src="img/img-zhaiquan/a3.png" >
							</li>
							<li>
								<img src="img/img-zhaiquan/jiantou.png" >
							</li>
							<li>
								<img src="img/img-zhaiquan/a4.png" >
							</li>
							<li>
								<img src="img/img-zhaiquan/jiantou.png" >
							</li>
							<li>
								<img src="img/img-zhaiquan/a5.png" >
							</li>
						</ul>
						<div class="box1"><p>资金用途：用于资金周转</p></div>
						<div class="box1"><p>风险评估：风险评估请见原始债权项目的具体信息；本项目适合风险承受能力为“稳健型”及以上的出借人承接；</p></div>
						<div class="box1"><p>还款保障措施：债权承接后，仍适用原始债权项目的还款保障。</p></div>
						<%--<div class="box1"><p>风险告知：市场有风险 出借需谨慎 、查看 <span class="color">《风险揭示书》</span></p></div>--%>
					</li>
					<li class="tab2" style="display: none;">
						<div class="table">
							<table border="0" cellspacing="20" cellpadding="20" id="receive-list">
                                <thead>
                                    <tr class="title">
                                        <th>序号</th>
                                        <th>承接人</th>
                                        <th>承接金额</th>
                                        <th>承接时间</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
							</table>
                            <div class="record-page">
                                <!--页码-->
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
					</li> 
					
					<li class="tab3" style="display: none;">
						<ul class="detail">
							<li>
								<p class="p1">1.什么样的债权可以转让？</p>
								<p class="p2">出借九趣贷X享智能投标服务项目满锁定期即可进行免费转让。</p>
								<p class="p2">A.发债权转让时，该转让标处于逾期状态时不允许转让，若转让时没有处于逾期，但在转让中时债权变为逾期状态，系统将会把债权停止转让。</p>
								<p class="p2">B.单个债权能分拆进行债权转让，但是不能同时分拆成多笔转让。</p>
							</li>
							<li>
								<p class="p1">2.转让的债权标的有效期多久？</p>
								<p class="p2">债权标的一个自然日内有效，当天24:00前未成功转让部分，会由系统自动下线。</p>
								<p class="p2">案例：A君2月2日上午10点时发布债权转让标的，若2月2日24点前有部分债权未转让成功，则24点时系统会自动下线该标的。</p>
							</li>
							<li>
								<p class="p1">3.购买的债权还可以再次转让吗？</p>
								<p class="p2">可以，购买债权并持有债券超过授权服务期限可进行再次转让。</p>
							</li>
							<li>
								<p class="p1">4.债权转让保障方式怎么样？</p>
								<p class="p2">债权转让适用于第三方担保公司担保。 此外债权转让的标的其他担保保障等与原项目完全相同。</p>
							</li>
							<li>
								<p class="p1">5.债权转让的参考年回报率怎么计算？</p>
								<p class="p2">债权转让的参考年回报率计算公式如下：</p>
								<p class="p2">[待收收益+(本金-本金折让后价格)]/（未结算利息+本金折让后价格) /剩余天数*365*100%；</p>
								<p class="p2">案例：A君出借了一个期限为6个月，参考年回报率为9.5%，还款方式为到期本息的标的1000元，持有173天后进行债权转让。此时，剩余的期限是11天，转让时选择原价全额转让，则此时的参考年回报率计算如下： (1000元*11天/365天*9.5%+0)/(1000元*173天/365天*9.5%+1000)/11天*365天*100%=9.09% （具体参考年回报率与小数点精确的位数有关，有可能显示上稍有误差）</p>
							</li>
							<li>
								<p class="p1">6.为什么转让出来的利率有时候比原项目少，有时候比原项目多？</p>
								<p class="p2">因为承接者承接时所支付的本金是含有先垫付利息部分，所以若债权转让者原价转让时，理论上承接者的利率是低于原有利率的。实际上，承接者所垫付的利息在下一期就会原价归还，所以实际预期年化利率是与原项目一样的。此外，若债权转让者以低于原价的价格转让时，承接者的利率就会高于原有项目的利率</p>
							</li>
							<li>
								<p class="p1">7.债权转让服务费怎么收取？</p>
								<p class="p2">债权转让服务费=转让总额*0.5%，即债权转让费=(本金转让价+未结算利息)*0.5%，该服务费每成功交易一笔则即时收取，债权转让服务费由发起人支付。</p>
							</li>
							<li>
								<p class="p1">8.承接债权转让标有什么规则吗？</p>
								<p class="p2">用户第一次承接单个转让标时，需要校验短信验证码才能完成承接；短信验证码校验成功后，如再次承接该转让标时无需校验短信验证码即可完成承接。每个账号承接债权转让标时每天最多可获取8条短信验证码；短信验证码60s内不支持重发。</p>
							</li>
						</ul>
					</li>
					
				</ul>
				 <div class="line"><span class="left"></span>九趣贷您身边的理财顾问<span class="right"></span></div> 
			</div>
		</div>
		<!--支付密码的弹框-->

		<div class="zhifu-password" style="display: none;">
			<form action="" method="post" name="payPassword" id="form_paypsw">
				<div id="payPassword_container" class="alieditContainer clearfix" data-busy="0">
					<label for="i_payPassword" class="i-block">请输入6位支付密码</label>
					<div class="i-block clearfix" data-error="i_error">
						<div class="i-block six-password left">
							<input class="i-text sixDigitPassword" id="payPassword_rsainput" type="password"
								   autocomplete="off" required="required" value="" name="payPassword_rsainput"
								   data-role="sixDigitPassword" tabindex="" maxlength="6" minlength="6"
								   aria-required="true">
							<div tabindex="0" class="sixDigitPassword-box" style="width: 180px;">
								<i style="width: 29px; border-color: transparent;" class=""><b
										style="visibility: hidden;"></b></i>
								<i style="width: 29px;"><b style="visibility: hidden;"></b></i>
								<i style="width: 29px;"><b style="visibility: hidden;"></b></i>
								<i style="width: 29px;"><b style="visibility: hidden;"></b></i>
								<i style="width: 29px;"><b style="visibility: hidden;"></b></i>
								<i style="width: 29px;"><b style="visibility: hidden;"></b></i>
								<span style="width: 29px; left: 0px; visibility: hidden;" id="cardwrap"
									  data-role="cardwrap"></span>
							</div>
						</div>
						<a class="forget-password left" href="/yingpu/pc/myaccount/payment_password.jsp">忘记支付密码？</a>
					</div>

				</div>
				<input type="button" style="cursor: pointer;" value="确认承接" onclick="javascript:chengjie();">
			</form>
		</div>

		<!--底部-->
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;display: block;"></iframe>

		<!--悬浮条-->
		<iframe src="../xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="../yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>


		<script src="../my-invest/js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script src="../newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
		<script src="../my-invest/js/zhaiquanzhuanrang.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/zhifu_password.js" type="text/javascript" charset="utf-8"></script>
        <script type="tpl" id="list-item">
            <tr>
                <td>$index</td>
                <td>$receiver</td>
                <td>$amount</td>
                <td>$receivedTime</td>
            </tr>
        </script>
		<script type="text/javascript">
            $('body').data('earningRate', '${data.earningRate} ');
            $('body').data('estimatedAnnualRate', '${data.estimatedAnnualRate}');
            $('body').data('holdDays', '${data.holdDays} ');

            console.log(${data.estimatedAnnualRate});
            console.log(${data.holdDays});

            function viewLicense(idx) {
                var idxs = [17, 21];
                layer.open({
                    type: 2,
                    content: '<%=basePath%>pc/myaccount/announce/content?id=' + idxs[idx] + '&type=contractsample',
                    area: ['50%', '80%']
                });
            }

            $('.chongzhi').click(function() {
                var balance = $(this).attr('balance'),
                    remains = $(this).attr('project');
                $('.num input').val(Math.min(remains, balance));
            })

            useLoadingShade();
            $('.chujie').click(function() {
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
                // $('.zhifu-password').show();
            });
            function chengjie(){
                if ($('#payPassword_rsainput').val().length != 6) {
                    layer.alert('请输入6位支付密码');
                    return false;
                }
                console.log($('#shijizhifu').text());
                $.post('/yingpu/pc/si/debt/project/receive', {
                    itemId : '${param.id}',
                    amount : $('.num input').val(),
					// amount:$('#shijizhifu').text(),
                    tradePassword: $('#payPassword_rsainput').val()
                }, function(result) {
                    layer.closeAll();
                    if (result.status != 'success') {
                        var ind = layer.open({
                            'title': '错误提示', 'content': result.message, 'btn': ['重新输入'], 'yes': function () {
                                layer.close(ind);
                                closezhifu();
                                // chengjie();
                            }, 'btn2': function () {
                                location.href = '/yingpu/pc/myaccount/payment_password.jsp';
                            }
                        });
                        // layer.alert(result.message);
                        // closezhifu();
                        // return;
                    }else{
                        layer.alert('承接成功！', function () {
                            location.reload(false);
                        });
					}
                });
            }
            loadList = function() {
                $.get('/yingpu/pc/si/debt/receive/history', {
                    projectId : '${data.dpId}',
                    pageIndex : pageIndex
                }, function(result) {
                    var html = '';
                    if(result.data == undefined){
                        var html = '<span style="display: block; font-size: 22px; margin-top: 220px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
                        $('#receive-list').html(html);
                        $('.record-page').css('display','none');
                    }else {
                        $.each(result.data || [], function (i, v) {
                            v.index = i + 1;
                            v.receiver = (v.receiver || '').substring(0, 1) + '**';
                            v.amount = commafy(returnFloat(v.amount));
                            v.receivedTime = new Date(v.receivedTime).Format("yyyy-MM-dd hh:mm:ss");
                            html += $('#list-item').text().formatStr(v);
                        });

                        pageCount = result.page.pageCount;
                        $('#receive-list>tbody').html(html);
                        $('.record-page').css('display','block');
                        generatePaginationNav(result.page.pageIndex, result.page.pageCount, "#page-nav-btn");
                    }
                });
            };
            loadList();
            function closezhifu() {
                $('#payPassword_rsainput').val('');
                $('.sixDigitPassword-box').find('b').css({'visibility': 'hidden'});
                $('.sixDigitPassword-box').children('span').css('left', '0px');
                $('.sixDigitPassword-box').children('i').first().addClass('active');
                $('#payPassword_rsainput').focus();
            }
            countDown();
            function countDown(){
                var starttime = new Date('${data.expiresTime}');
                if(starttime<new Date()){
                    $('#time').html("已截止");
                }else {
                    setInterval(function () {
                        var nowtime = new Date();
                        var time = starttime - nowtime;
                        var day = parseInt(time / 1000 / 60 / 60 / 24);
                        var hour = parseInt(time / 1000 / 60 / 60 % 24);
                        var minute = parseInt(time / 1000 / 60 % 60);
                        var seconds = parseInt(time / 1000 % 60);
                        $('#time').html(day + "天" + hour + "小时" + minute + "分钟" + seconds + "秒");
                    }, 1000);
                }
            }
		</script>
	</body>
</html>
