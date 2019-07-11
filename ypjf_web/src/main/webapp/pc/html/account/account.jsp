<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String[] pTypes = {
			"","","","","","","","","","","","",
			"qi", "che", "fang"
	};
	request.setAttribute("types", pTypes);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<!-- <link rel="stylesheet" type="text/css" href="/yingpu/pc/html/account/cai123/css/font-awesome.4.6.0.css">
		<link rel="stylesheet" href="/yingpu/pc/html/account/cai123/css/amazeui.min.css">
		<link rel="stylesheet" href="/yingpu/pc/html/account/cai123/css/amazeui.cropper.css">
		<link rel="stylesheet" href="/yingpu/pc/html/account/cai123/css/custom_up_img.css"> -->
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/html/account/css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/html/account/css/account.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/html/account/css/calendar.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/common4.css"/>
		
		<style>
			/* .up-img-cover {width: 100px;height: 100px;}
			.up-img-cover img{width: 100%;}
			.shangchuan img{
				width:20px;
				height:14px;
			}
			.rotate-left,.rotate-right{
				padding-right:10px;
			}
			.rotate-left img{
				width:16px;
				height:16px;
				
			}
			.rotate-right img{
				width:16px;
				height:16px;
			}
			.check img{
				width:24px;
				height:16px;
			} */
		</style>
	</head>
	<body>
		<!--顶部-->
		<input type="file" style="display: none;" id="file-input" name="file" />
		<iframe id="iframe" src="../head3.html?index=5" width="100%" height="110px" scrolling="no" name="head"  style="border:0px;"></iframe>
		<!-- 头像上传框 -->
		<input type="file" style="display: none;" id="file-input" name="file" />
		<!-- 主体 -->
		<div id="accountBox" class="clearFix">
			<!-- 左边导航 -->
			<div id="aside">
				<iframe src="../myaccount/account_sidebar.html" width="100%" height="850px" scrolling="no"  style="border:0px;"></iframe>
			</div>
			
			<!-- 右边内容 -->
			<div id="account">
				<!-- 个人信息 -->
				<div class="person">
					<div class="left">
						<!-- <div class="up-img-cover touXiang"  id="up-img-touch" >
							<div class="shade">
								<span>更换头像</span>
							</div>
							<img class="am-circle" alt="点击图片上传" src="${not empty pcuser.header ? pcuser.header : '/yingpu/pc/img/userimg.jpg'}">
						</div> -->
						<div class="touXiang">
							<div class="shade">
								<span>更换头像</span>
							</div>
							<img src="${not empty pcuser.header ? pcuser.header : '/yingpu/pc/img/userimg.jpg'}" alt="用户头像" id="user-avatar">
						</div>
						<div class="text">
							<%--<p class="name"><span class="nm">您好,JQDCJR${fn:substring(pcuser.phone,8,11)}</span><a class="bq" href="/yingpu/pc/html/level/level.html">${pcuser.member}</a></p>--%>
							<p class="name"><span class="nm">您好,${pcuser.userCode}</span><a class="bq" href="/yingpu/pc/html/level/level.html">${pcuser.member}</a></p>
							<p class="wenhou"></p>
						</div>
						<div class="message">
							<a title="电话注册" href="security_settings.jsp"><span class="renzhen dxrz over"></span></a>
							<a title="实名认证" href="security_settings.jsp"><span class="renzhen smrz ${pcuser.isIdCard == '是' ? 'over' : ''}" ></span></a>
							<a title="绑定银行卡" href="mycard.jsp"><span class="renzhen yhkrz ${pcuser.isIdCard == '是' ? 'over' : ''}"></span></a>
							<a title="邮箱验证" href="security_settings.jsp"><span class="renzhen yxyz ${not empty pcuser.email ? 'over' : ''}"></span></a>
							<%--<img src="${not empty pcuser.header ? pcuser.header : ''}" id="user-avatar" />--%>
							<%--<a class="renzheng" title="电话注册" href="security_settings.jsp" ><img src="../html/account/img/account-dxrz.png" ></a>--%>
							<%--<a class="renzheng" title="实名认证" href="security_settings.jsp"><img src="../html/account/img/account-smrz.png" ></a>--%>
							<%--<a class="renzheng" title="绑定银行卡" href="mycard.jsp"><img src="../html/account/img/account-yhkrz.png" ></a>--%>
							<%--<a class="renzheng" title="邮箱验证" href="security_settings.jsp"><img src="../html/account/img/account-yxyz.png" ></a>--%>
						</div>

					</div>
					<ul class="center clearFix">
						<li class="items">
							<p class="money" style="color:#c11024;" id="zichan"><fmt:formatNumber type="number" value="${data.zichan == '' || data.zichan==null ? '0.00' : data.zichan} " pattern="0.00" maxFractionDigits="2"/></p>
							<p class="text">资产总额(元)</p>
						</li>
						<li class="items">
							<p class="money" style="color: #292929;font-size:18px;" id="shouyi"><fmt:formatNumber type="number" value="${data.shouyi ==null||data.shouyi == '' ? '0.00' : data.shouyi} " pattern="0.00" maxFractionDigits="2"/></p>
							<p class="text">累计收益(元）</p>
						</li>
						<li class="items">
							<p class="money" style="color:#292929;font-size:18px;" id="daishouyi"><fmt:formatNumber type="number" value="${data.daihuoqu == '' || data.daihuoqu ==null  ? '0.00' :data.daihuoqu }" pattern="0.00" maxFractionDigits="2"/></p>
							<p class="text">待获取收益(元）</p>
						</li>
					</ul>
					<div class="right">
						<div class="rightTop">
							<p class="money" id="usableMoney"><fmt:formatNumber type="number" value="${ pcuser.caBalance =='' || pcuser.caBalance ==null ? '0.00' : pcuser.caBalance }" pattern="0.00" maxFractionDigits="2"/></p>
							<p class="text">可用余额(元)</p>
							<a href="#" onclick=" javascript:location.href='../myaccount/deposit';" class="cz-btn">充值</a>
						</div>
						<ul class="rightCenter clearFix">
							<li class="a1">
								<p class="money" id="dongjie"><fmt:formatNumber type="number" value="${pcuser.cfBalance =='' || pcuser.cfBalance ==null ? '0.00' : pcuser.cfBalance}" pattern="0.00" maxFractionDigits="2"/></p>
								<p class="text">冻结金额(元)</p>
							</li>
							<li class="a1">
								<p class="money" id="tixian"><fmt:formatNumber type="number" value="${data.tixian  =='' || data.tixian  ==null ? '0.00' : data.tixian  }" pattern="0.00" maxFractionDigits="2"/></p>
								<p class="text">提现在途(元)</p>
							</li>
						</ul>
						<a href="#" onclick="javascript:location.href='../myaccount/withdraw_deposit.html';" class="tx-btn">提现</a>
					</div>
				</div>
				<!-- 资产分布 -->
				<div class="assets">
					<p class="title">资产分布</p>
					<div class="assets-box clearFix">
						<ul class="tuli-left clearFix">
							<li class="item">          
								<span class="bg" style="background: #5942c2;"></span>
								<p class="text">可用金额：￥<span class="money" id="ziKeyongMoney"><fmt:formatNumber type="number" value="${ pcuser.caBalance =='' || pcuser.caBalance ==null ? '0.00' : pcuser.caBalance }" pattern="0.00" maxFractionDigits="2"/></span></p>
							</li>
							<li class="item">
								<span class="bg" style="background: #6c54d5;"></span>
								<p class="text">新手专享：￥<span class="money" id="ziNew"><fmt:formatNumber type="number" value="${ data.newSumMoney =='' || data.newSumMoney ==null ? '0.00' : data.newSumMoney }" pattern="0.00" maxFractionDigits="2"/></span></p>
							</li>
							 <li class="item">
								<span class="bg" style="background: #8870f5;"></span>
								<p class="text">X快享智能投标：￥<span class="money" id="ziX"><fmt:formatNumber type="number" value="${ data.smartSumMoney =='' || data.smartSumMoney ==null ? '0.00' : data.smartSumMoney }" pattern="0.00" maxFractionDigits="2"/></span></p>
							</li>
							<li class="item">
								<span class="bg" style="background:#b397fe; " ></span>
								<p class="text">散标：￥<span class="money" id="ziSan"><fmt:formatNumber type="number" value="${ data.sanSumMoney =='' || data.sanSumMoney ==null ? '0.00' : data.sanSumMoney }" pattern="0.00" maxFractionDigits="2"/></span></p>
							</li>
							<li class="item">
								<span class="bg" style="background:#dbb6ff;"></span>
								<p class="text">账户自由金：￥<span class="money" id="ziZiYou"><fmt:formatNumber type="number" value="${ data.zhaiSumMoney =='' || data.zhaiSumMoney ==null ? '0.00' : data.zhaiSumMoney }" pattern="0.00" maxFractionDigits="2"/></span></p>
							</li>
							<li class="item">
								<span class="bg" style="background: #eccbff;"></span>
								<p class="text">待收本金：￥<span class="money" id="zidaishou"><fmt:formatNumber type="number" value="${pcuser.nowInvestAmount =='' ||pcuser.nowInvestAmount==null ? '0.00' : pcuser.nowInvestAmount}" pattern="0.00" maxFractionDigits="2"/></span></p>
							</li>
						</ul>
						<div class="tu">
							<div id="echart" style="width:250px;height:250px;"></div>
						</div>
					</div>
				</div>
				<!-- 回款日历 -->
				<div class="money-back">
					<p class="title">回款日历</p>
					<div class="back-box">
						<div class="subTitle clearFix">
							<p>收款明细</p>
							<img src="../html/account/img/wenhao.png" class="wh" id="tishi" onmouseover="show('tishi')" onmouseout="hide()">
							<span class="list"><img src="../html/account/img/listBg.png" ></span>
						</div>
						<div class="rili clearFix" style="display: block;">
							<div class="rili-left">
								<p class="bt">当月待收(元)<span class="money"><fmt:formatNumber type="number" value="${data.MonthDayMoney =='' ||data.MonthDayMoney==null ? '0.00' : data.MonthDayMoney}" pattern="0.00" maxFractionDigits="2"/></span></p>
								<div class="neir">
									<p class="date"></p>
									<div class="you" style="display: block;">
										<p class="text">今日待收(元)</p>
										<p class="num"><fmt:formatNumber type="number" value="${data.dayMoney =='' ||data.dayMoney==null ? '0.00' : data.dayMoney}" pattern="0.00" maxFractionDigits="2"/></p>
										<p class="text">次月待收(元)</p>
										<p class="num"><fmt:formatNumber type="number" value="${data.collectDayMoney =='' ||data.collectDayMoney==null ? '0.00' : data.collectDayMoney}" pattern="0.00" maxFractionDigits="2"/></p>
									</div>
									<div class="meiyou" style="display: none;">
										<p class="text">当天没有项目回款<a href="#" class="cj">快去出借</a>吧...</p>
									</div>
								</div>
							</div>
							<div class="rili-right">
								<div class="line"></div>
								<div id="ca"></div>
							</div>
						</div>
						<ul class="tabs" style="display: none;">
							<div class="nav">
								<span class="active">X快享智能投标</span>
								<span  class="active">散标</span>
							</div>
							<%--<li class="tab" style="display: none;">--%>
								<%--<table border="0" cellspacing="20" cellpadding="20">--%>
									<%--<tr class="title">--%>
										<%--<th>当前/总(期)</th>--%>
										<%--<th>项目名称</th>--%>
										<%--<th>待收日期</th>--%>
										<%--<th>待收本金(元)</th>--%>
										<%--<th>待收利息(元)</th>--%>
										<%--<th>状态</th>--%>
									<%--</tr>--%>

									<%--<c:if test="${empty collectSmartProject}">--%>
										<%--<tr style="text-align: center; ">--%>
											<%--<td rowspan="6">暂无回款记录</td></tr>--%>

									<%--</c:if>--%>

								<%--<c:if test="${not empty collectSmartProject}">--%>
									<%--<c:forEach items="${collectSmartProject}" var="smart">--%>
										<%--<tr>--%>
											<%--<td>${smart.hold}/${smart.deadLine}</td>--%>
											<%--<td>${smart.name}</td>--%>
											<%--<td>${smart.expiresDate}</td>--%>
											<%--<td>${smart.actualAmount}</td>--%>
											<%--<td>${smart.accumulatedEarning}</td>--%>
											<%--<c:if test="${smart.status==1}">--%>
												<%--<td>待回款</td>--%>
											<%--</c:if>--%>
											<%--<c:if test="${smart.status==2}">--%>
												<%--<td>已结束</td>--%>
											<%--</c:if>--%>
										<%--</tr>--%>
									<%--</c:forEach>--%>
								<%--</c:if>--%>
								<%--</table>--%>
							<%--</li>--%>
							<li class="tab" style="display: block;">
								<table border="0" cellspacing="20" cellpadding="20">
									<tr class="title">
										<th>当前/总(期)</th>
										<th>项目名称</th>
										<th>待收日期</th>
										<th>待收本金(元)</th>
										<th>待收利息(元)</th>
										<th>状态</th>
									</tr>
									<c:if test="${empty sanOrde}">
										<tr style="text-align: center; ">
											<td rowspan="6">暂无回款记录</td></tr>
									</c:if>

									<c:if test="${not empty sanOrde}">
										<c:forEach items="${sanOrde}" var="san">
										<tr>
											<td>${san.das}/${san.deadLine}</td>
											<td>${san.name}</td>
											<td><fmt:formatDate value="${san.nextInterest}"/></td>
											<td>${san.money}</td>
											<td>${san.interest}</td>
											<c:if test="${san.status==3}">
												<td>待回款</td>
											</c:if>
										</tr>
										</c:forEach>
									</c:if>
								</table>
							</li>
						</ul>
					</div>
				</div>
				<!-- 热门推荐 -->
				<div class="hot">
					<p class="title">热门推荐</p>
					<ul class="items">
						<li class="item">
							<p class="bt"><a href="../projectdetails?projectid=${data.project[0].id}">新手专享</a></p>
							<div class="box clearFix">
								<div class="hot-left">
									<p class="p1"><span><fmt:formatNumber type="number" value="${data.project[0].estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
									<p class="text">预期年化收益率</p>
								</div>
								<div class="hot-right">
									<p class="p2"><span>${data.project[0].deadLine}</span>个月</p>
									<p class="text">服务期限</p>
								</div>
							</div>
						</li>
						<li class="item">
							<p class="bt"><a href="../projectdetails?projectid=${data.project3[0].id}">新手专享</a></p>
							<div class="box clearFix">
								<div class="hot-left">
									<p class="p1"><span><fmt:formatNumber type="number" value="${data.project3[0].estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
									<p class="text">预期年化收益率</p>
								</div>
								<div class="hot-right">
									<p class="p2"><span>${data.project3[0].deadLine}</span>个月</p>
									<p class="text">服务期限</p>
								</div>
							</div>
						</li>
						<!-- <li class="item">
							<p class="bt"><a href="javascript:tiaozhuan('my-invest/zhiTou.jsp?type=${data.smart[0].deadLine}');">X快享智能投标</a></p>
							<div class="box clearFix">
								<div class="hot-left">
									<p class="p1"><span><fmt:formatNumber type="number" value="${data.smart[0].interestRate*100}" pattern="0.00" maxFractionDigits="2"/></span>%</p>
									<p class="text">预期年化收益率</p>
								</div>
								<div class="hot-right">
									<p class="p2"><span>${data.smart[0].deadLine}</span>个月</p>
									<p class="text">服务期限</p>
								</div>
							</div>
						</li> -->
						<li class="item">
							<p class="bt"><a href="/yingpu/pc/project/list">散标</a></p>
							<div class="box clearFix">
								<div class="hot-left">
									<p class="p1"><span>7.00</span>%</p>
									<p class="text">预期年化收益率</p>
								</div>
								<div class="hot-right">
									<p class="p2"><span>1</span>个月</p>
									<p class="text">服务期限</p>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		
		<!--底部导航-->
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		<!--悬浮条-->
		<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script src="../html/account/js/jquery.js" type="text/javascript" charset="utf-8"></script>
		<script src="../html/account/js/echarts.js" type="text/javascript" charset="utf-8"></script>
		<script src="../html/account/js/calendar.js" type="text/javascript" charset="utf-8"></script>
		<script src="../html/account/js/account.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>


		<script src="../../js/jquery/ajaxfileupload.js"></script>
		
		<script type="text/javascript">
			// echart 图表
			var myChart = echarts.init(document.getElementById('echart'));
			var option2 = {
				tooltip: {
					trigger: 'item',
					formatter: "{a} <br/>{b}: {c} "
				},
				color:["#5942c2","#6c54d5","#8870f5","#b397fe","#dbb6ff","#eccbff"],
				 series: [
		    {
		        name:'资产分布',
		        type:'pie',
		        radius: ['50%', '70%'],
		        avoidLabelOverlap: false,
		        label: {
		            normal: {
		                show: false,
		                position: 'center'
		            },
		            emphasis: {
		                show: true,
		                textStyle: {
							color:'#666',
		                    fontSize: '18',
		                    fontWeight: 'bold'
							
		                }
		            }
		        },
		        labelLine: {
		            normal: {
		                show: false
		            }
		        },
		        data:[
		            {value:<fmt:formatNumber type="number" value="${ pcuser.caBalance =='' || pcuser.caBalance ==null ? '0.00' : pcuser.caBalance }" pattern="0.00" maxFractionDigits="2"/>, name:'可用金额'},
		            {value:<fmt:formatNumber type="number" value="${ data.newSumMoney =='' || data.newSumMoney ==null ? '0.00' : data.newSumMoney }" pattern="0.00" maxFractionDigits="2"/>, name:'新手专享'},
		            {value:<fmt:formatNumber type="number" value="${ data.smartSumMoney =='' || data.smartSumMoney ==null ? '0.00' : data.smartSumMoney }" pattern="0.00" maxFractionDigits="2"/>, name:'X快享智能投标'},
                    {value:<fmt:formatNumber type="number" value="${ data.sanSumMoney =='' || data.sanSumMoney ==null ? '0.00' : data.sanSumMoney }" pattern="0.00" maxFractionDigits="2"/>, name:'散标'},
                    {value:<fmt:formatNumber type="number" value="${ data.zhaiSumMoney =='' || data.zhaiSumMoney ==null ? '0.00' : data.zhaiSumMoney }" pattern="0.00" maxFractionDigits="2"/>, name:'账户自由金'},
					{value:<fmt:formatNumber type="number" value="${pcuser.nowInvestAmount =='' ||pcuser.nowInvestAmount==null ? '0.00' : pcuser.nowInvestAmount}" pattern="0.00" maxFractionDigits="2"/>, name:'代收本金'}
		        ]
		    }
		]};
		myChart.setOption(option2);
            //页面跳转
            function tiaozhuan(url) {
                // window.top.location.href = url;
                top.location.href='/yingpu/pc/'+url;
            }
	</script>
		
	<script type="text/javascript">
        /*var s = "";
        $(function () {
            $.ajax({
                url:"http://localhost/yingpu/pc/userCode",
                type:"post",
                dataType: "json",
                data:{userCode:s},
                success:function (data) {
                    //接收单个参数和前端交互
                    //这里做一些你想做的。
                    //data(success中的data)就是后台响应传递来的数据，具体请看接收参数模块
                    if(data){
                        sessionStorage.user=JSON.stringify(data);
                    }
                }
            })
        })*/
		var tip_index = 0;
		function show(id) {
			tip_index = layer.tips("<div style='color:#666666;'>1.当日待收/次月待收包括您在本平台出借的所有出借项目。</div>", "#"+id+"", {
			  tips: [3, "#fff"],
			  area: ['350px', 'auto'],
			});
		};

        //数据添加分隔符
        function commafy(num) {
            return num && num
                .toString()
                .replace(/(\d)(?=(\d{3})+\.)/g, function ($1, $2) {
                    return $2 + ',';
                });
        }
		function hide(){
			 layer.close(tip_index);
		}
		$('#zichan').text(commafy($('#zichan').text()));
        $('#shouyi').text(commafy($('#shouyi').text()));
        $('#daishouyi').text(commafy($('#daishouyi').text()));
        $('#usableMoney').text(commafy($('#usableMoney').text()));
        $('#dongjie').text(commafy($('#dongjie').text()));
        $('#tixian').text(commafy($('#tixian').text()));
        $('#ziKeyongMoney').text(commafy($('#ziKeyongMoney').text()));
        $('#ziX').text(commafy($('#ziX').text()));
        $('#ziSan').text(commafy($('#ziSan').text()));
        $('#ziZiYou').text(commafy($('#ziZiYou').text()));
        $('#zidaishou').text(commafy($('#zidaishou').text()));
		$('#ziNew').text(commafy($('#ziNew').text()));




	</script>		
	</body>
	
</html>
