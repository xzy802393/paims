
<%@ page language="java" import="java.util.*, java.util.regex.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String[][] status = {
		{"", ""},
		{ "敬请期待", "invest-btn orange", "" }, 
		{ "立即投资", "invest-btn", "" },
		{ "还款中", "invest-btn gray", "project-false ysk" },
		{ "已还款", "invest-btn gray", "project-false yhk" },
		{ "满标待审", "invest-btn green", "" }
};


String[] pTypes = {
		"","","","","","","","","","","","","",
		"che", "qi", "fang"	
};

request.setAttribute("status", status);
request.setAttribute("types", pTypes);

request.setAttribute("isLogin", request.getSession().getAttribute("pcuser") != null);

%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



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
		<link rel="stylesheet" type="text/css" href="../css/jquery.lineProgressbar.css"/>
		<link rel="stylesheet" type="text/css" href="../css/invest.css"/>
		
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<style>
		 .xi {
		    display: inline-block;
		    width: 21px;
		    height: 21px;
		    background: url(../img/project-xi.png) no-repeat center;
		   /*  vertical-align: middle; */
		}
		/*加息0.5%*/
			.invest-project .project-list li:first-child{
				position: relative;
			}
			.invest-project .project-list li:first-child .add-interest{
				position: absolute;
			    right: -20px;
			    top: -16px;
			    padding: 0 5px;
			    font-size: 12px;
			    color: #fff;
			    background: #FFA24D;
			    border-radius: 10px;
			    height: 20px;
			    line-height: 20px;
			}

		</style>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		<script>
			var conditions = {
					categoryId : '',
					deadLine : '',
					estimatedAnnualRate : '',
					totalAmount : '',
					pageIndex : 1
				},
				baseUrl = '<%=basePath%>pc/project/list';
				
				
			String.prototype.contains = function() {
		        if (!arguments.length) return false;

		        var strs = arguments;
		        for (var i = 0; i < strs.length; i++) {
		            if (this.indexOf(strs[i]) == -1) {
		                return false;
		            }
		        }
				return true;
			};

				
			function parseParam() {
				var param = {},
					str = arguments[0] || '';

				if (str && str.trim().length > 0 && (str.contains('&') || str.contains('='))) {
	                var temp = str.contains('&') ? str.split('&') : [str];
					for (var i = 0; i < temp.length; i++) {
						arr = temp[i].split('=');
						param[arr[0]] = !!arr[1] ? decodeURIComponent(arr[1]) : null;
					}
				}

				return param;
			}
				
				
			function getURLParam(kvs) {
				var param = '';
				for (var k in conditions) {
					param += k + '=' + encodeURIComponent(conditions[k]) + '&';
				}
				
				return param.substring(0, param.length - 1);
			}
				
				
			function goURLByCondition(applyCdts) {
				if (!applyCdts.pageIndex) {
					applyCdts.pageIndex = 1;
				}
				
				for (var k in applyCdts) {
					if (applyCdts[k] == null) {
						continue;
					}
					
					conditions[k] = applyCdts[k];
				}

                /*if ('${isLogin}' != 'true') {
                    layer.alert('对不起，登陆后才可以查看，请先登录!', { btn : ['登录', '取消'] }, function() {
                        location.href = '/yingpu/pc/login?backUrl=' + encodeURIComponent(baseUrl + '?' + getURLParam(conditions));
                    }, function() {

                    });
                    return;
                }*/

				goURL(baseUrl + '?' + getURLParam(conditions));
			}

			
			function goURL(url) {
				location.href = url; 
			}
			
			
			function gogogo(act) {
				var pageCount = '${page.pageCount}' * 1,
					totalCount = '${page.pageIndex}' * 1;
				
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
				}
				
				console.log(pageIndex)
				pageIndex = Math.max(1, Math.min(pageIndex, pageCount));
				
				goURLByCondition({ pageIndex : pageIndex });
			}

			function viewWithoutInvestPrompt() {
			    layer.alert('您未投资该项目，无法查看此项目详情！');
            }

            function viewEndedProjectPrompt() {
                layer.alert('此项目已还款！');
            }

            function viewWithoutLoginPrompt() {
                layer.alert('您尚未登录，无法查看此项目详情！');
            }
			
			$(function() {
				var urlParams = parseParam(location.search.substring(1));
				for (var k in conditions) {
					if (!!urlParams[k]) {
						conditions[k] = urlParams[k];
					}
				}
				
				pageIndex = conditions.pageIndex || 1;
				
			});
		</script>
	</head>
	<body>
		<!--顶部-->
		<!--<div class="header">
			<div class="header-top">
				<div class="center">
					<div class="contact left">
						<p>服务热线：400-9690-900</p>
						<a href="#" class="tel"><img src="../img/images/head-tel_03.png"/></a>
						<a href="#" class="weixin"><img src="../img/images/head-weixin_03.png"/></a>
						<a href="#" class="weibo"><img src="../img/images/head-weibo_03.png"/></a>
					</div>
					
					<div class="nav right">
						<ul class="nav-item clearfix">
							<li class="app"><a href="" class="org"><img src="../img/head-phone.png"/> 手机APP</a></li>
							<li><a href="#" class="org"><img src="../img/head-vip.png"/> 个人中心 <img class="pull" src="../img/head-pull.png" /></a></li>
							<li><a href="#">帮助中心</a></li>
							<li><a href="#">活动中心</a></li>
							<li><a href="#" class="bold">登录</a></li>
							<li><a href="#" class="bold">注册</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="header-nav">
				<div class="center clearfix">
					<div class="logo left">
						<img src="../img/logo.png"/>					
					</div>
					<div class="logo-text left">
						<p class="red">新金融倡导者</p>
						<p class="black">营创智慧金融，普享财富人生</p>
					</div>
					
					<div class="nav right">
						<ul class="nav-list">
							<li><a href="../index.jsp">首页</a></li>
							<li><a href="invest.jsp" class="active">我要投资</a></li>
							<li><a href="#">我要借款</a></li>
							<li><a href="#">安全保障</a></li>
							<li><a href="#">信息披露</a></li>
							<li><a href="#" class="account"><img src="../img/account.png"/> 我的账户</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>-->
		<iframe src="../head3.html?index=1" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="invest-main">
			<!--banner-->
			<div class="invest-banner">
				<!--<div class="center">
					<div class="banner-text">
						<p>产品丰富</p>
						<p>服务多元</p>
						<p>理财放心</p>
						<p>财富增值</p>
					</div>
				</div>-->
			</div>
			<div class="center clearfix">
				<!--筛选出的项目-->
				<div id="project-list" class="invest-main-l left">
					
					<div class="invest-choice" style="display:none;">
						<h4>筛选投资项目</h4>
						<div class="choice-item">
							<dl class="list">
								<dt class="item-title">产品种类</dt>
								<dd><a href="javascript:void(goURLByCondition({categoryId : ''}))" class="${empty param.categoryId ? 'active' : ''}">不限</a></dd>
								<c:forEach items="${categories}" var="c"> 
									<dd><a class="${param.categoryId == c.id ? 'active' : ''}" href="javascript:void(goURLByCondition({categoryId : '${c.id}'}))">${c.name}</a></dd>
								</c:forEach>
							</dl>
						</div>
						<div class="choice-item">
							<dl class="list">
								<dt class="item-title">项目期限</dt>
								<dd><a href="javascript:void(goURLByCondition({deadLine : ''}))" class="${empty param.deadLine ? 'active' : ''}">不限</a></dd>
								<c:forEach items="${deadlines}" var="d"> 
									<c:if test="${d.deadline != 0}">
										<dd><a class="${param.deadLine == d.deadline ? 'active' : ''}" href="javascript:void(goURLByCondition({deadLine : '${d.deadline}'}))">${d.deadline}个月</a></dd>
									</c:if>
								</c:forEach>
							</dl>
						</div>
						<div class="choice-item">
							<dl class="list">
								<dt class="item-title">预期收益</dt>
								<dd><a href="javascript:void(goURLByCondition({estimatedAnnualRate : ''}))" class="${empty param.estimatedAnnualRate ? 'active' : ''}">不限</a></dd>
								<dd><a data="{estimatedAnnualRate : '0-0.59'}">0-5.9%</a></dd>
								<dd><a data="{estimatedAnnualRate : '0.06-0.08'}">6%-8%</a> </dd>
								<dd><a data="{estimatedAnnualRate : '0.08-0.1'}">9%-10%</a> </dd>
								<dd><a data="{estimatedAnnualRate : '0.101-0.12'}">10.1%-12%</a> </dd>
								<dd><a data="{estimatedAnnualRate : '0.121-1'}">12.1%以上</a></dd>
								<!--<dd><a data="{estimatedAnnualRate : '0.11'}">11%</a></dd>
								<dd><a data="{estimatedAnnualRate : '0.12'}">12%</a></dd>-->
							</dl>
						</div>
						<div class="choice-item">
							<dl class="list">
								<dt class="item-title">借款金额</dt>
								<dd><a href="javascript:void(goURLByCondition({totalAmount : ''}))" class="${empty param.totalAmount ? 'active' : ''}">不限</a></dd>
								<dd><a data="{totalAmount : '0-100000'}">10万以下</a>  </dd>
								<dd><a data="{totalAmount : '100000-200000'}">10万-20万</a></dd>
								<dd><a data="{totalAmount : '200000-500000'}">20万-50万</a></dd>
								<dd><a data="{totalAmount : '500000-1000000'}">50万-100万</a></dd>
								<dd><a data="{totalAmount : '1000000-999999999999'}">100万以上</a> </dd>
							</dl>
						</div>
					</div>

					<div style="margin-top: 60px;">
						<c:forEach items="${list}" var="p">
						<!--可投资项目1-->
						<div class="invest-project">
							<div class="project-title clearfix">

								<div class="left"> <a href="${isLogin ?
                                            ((p.status != 4) ?
                                                    '../projectdetails?projectid='.concat(p.id)
                                                    : 'javascript:void(viewEndedProjectPrompt())')
                                            : (p.status == 2 ? '../projectdetails?projectid='.concat(p.id)
                                                    :'javascript:void(viewWithoutLoginPrompt())') }">${p.name}</a>
								</div>
								<div class="project-func left">
									<span>产品丰富</span>
									<span>服务多元</span>
									<span>安全保障</span>
									<span>财富增值</span>
								</div>
								<div class="project-icon left">
									<span class="${types[p.categoryId]}"></span>
									<span class="quan"></span>
									<span class="xi"></span>
								</div>
							</div>
							<div class="project-content">
								<ul class="project-list clearfix">
									<li style="width: 16%">
										<p><span class="large"><fmt:formatNumber value="${p.estimatedAnnualRate * 100}" type="currency" pattern="#0.00"/></span><span class="small">%</span></p>
										<p class="des">预期年化收益率</p>
										<%--<span class="add-interest">加息0.5%</span>--%>
									</li>
									<li style="width: 12%">
										<p><span class="large">${p.deadLine}</span><span class="small">个月</span></p>
										<p class="des">借款期限</p>
									</li>
									<li style="width: 14%">
										<p><span class="large"><fmt:formatNumber type="number" value="${p.totalAmount / 10000}" pattern="0.00" maxFractionDigits="2"/>  </span><span class="small">万元</span></p>
										<p class="des">借款额度</p>
									</li>
									<li style="width: 17%;margin-top: 36px;">
										<p><span class="small">${p.repayment}</span></p>
										<p class="des">还款方式</p>
									</li>	
									<li style="width: 17%;margin-top: 36px;">
										<p id="progressBar1" class="progress-bar" totalAmount="${p.totalAmount}" financingAmount="${p.financingAmount }"></p>
										<p class="des" style="margin-top: -26px;">项目进度</p>
									</li>
									<li style="width: 16%">

									<%-- ${p.status == 2 ? '../projectdetails?projectid=' : 'javascript:void(0)'}${p.status == 2 ? p.id : ''} --%>
										<a href="${isLogin ?
										        ((p.status != 4) ?
										                '../projectdetails?projectid='.concat(p.id)
										                        : 'javascript:void(viewEndedProjectPrompt())')
										                 : (p.status == 2 ? '../projectdetails?projectid='.concat(p.id)
                                                             :'javascript:void(viewWithoutLoginPrompt())') }"
										   class="${status[p.status][1]}">${status[p.status][0]}</a>
										<%--<c:if test="${not empty status[p.status][2]}">
											<span class="${status[p.status][2]}"></span>
										</c:if>--%>
									</li>
								</ul>
							</div>
						</div>
					</c:forEach>
					</div>
					
					<!--翻页-->
					<div class="invest-page">
						<div class="invest-page-list">
							<a href="javascript:void(gogogo('home'))">首页</a>
							<a href="javascript:void(gogogo('prev'))">◀</a>
							<c:forEach var="index" begin="${page.pageIndex + 4 > page.pageCount ?
										(page.pageCount - 4 < 1 ? 1 : page.pageCount - 4) : page.pageIndex}"
									end="${page.pageCount < page.pageIndex + 4 ? page.pageCount : page.pageIndex + 4}" step="1">
								<a href="javascript:void(goURLByCondition({pageIndex : '${index}'}))" class="${page.pageIndex == index ? 'active' : ''}">${index}</a>
							</c:forEach>
							<a href="javascript:void(gogogo('next'))">▶</a>
							<%--<a href="javascript:void(gogogo('tail'))">尾页</a>--%>
						</div>
					</div>
				</div>
				
				<!--右边部分-->
				<div class="invest-main-r left">
					<a href="../register"><img src="../img/invest-main-ad.png"/></a>
					
					<!--具有滚动条的div-->
					<div class="investors-box">
						<h5>他们正在理财：</h5>
						<div id="investors-list" class="investors-list">
							<div id="">
								<ul>
									<c:forEach items="${investers}" var="tp">

										<li><span class="invester-icon"></span><p>【${fn:substring(tp.phone, 0, 3)}****${fn:substring(tp.phone, 7, 11)}】 ：投资<span style="color: #FF0000;font-weight: bold;"><fmt:formatNumber value="${tp.money}" type="currency" pattern="############0.00"/></span>元</br>&nbsp;&nbsp;投资项目：${tp.name}</p></li>

									</c:forEach>
								</ul>
							</div>
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
		<script src="../js/jquery.lineProgressbar.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/jquery.slimscroll.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>

        <script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		<script type="text/javascript">
			$(document).ready(function(){				
				$('.progress-bar').each(function(e){
					var totalAmount=$(this).attr('totalAmount');
					var financingAmount=$(this).attr('financingAmount');
					var yitouzi=accAdd(totalAmount,-financingAmount);
					
					$(this).LineProgressbar({
					  percentage:  accMul(100,accDiv(yitouzi,totalAmount).toFixed(4)),
					  fillBackgroundColor: '#ff7f01',
					  height: '12px',
					  radius: '6px'
					}); 
				});
				
				$('[data]').each(function() {
					var data = eval('(' + $(this).attr('data') + ')');
					for (var k in data) {
						if (conditions[k] == data[k]) {
							$(this).addClass('active');
						}
					}
					
					$(this).click((function(d) {
						return function() { goURLByCondition(d) };
					})(data));
	
				});
				
				//删除滚动条
//				$('#investors-list').slimScroll({  
//	                height: '748px'  
//	            });
					//滚动内容
				function myGod(id,w,n){
					//id 为父元素的ID，w为默认多久滚动一次，n 为朝上还是朝下滚
					var box=document.getElementById(id),can=true,w=w||1500,fq=fq||10,n=n==-1?-1:1;
					box.innerHTML+=box.innerHTML;
					box.onmouseover=function(){can=false};
					box.onmouseout=function(){can=true};
					var max=parseInt(box.scrollHeight/2);
					new function (){
					   var stop=box.scrollTop%18==0&&!can;
					   if(!stop){
					    var set=n>0?[max,0]:[0,max];
					    box.scrollTop==set[0]?box.scrollTop=set[1]:box.scrollTop+=n;
					   };
					   setTimeout(arguments.callee,box.scrollTop%18?fq:w);
					};
				};
				
				myGod('investors-list',10);
				
				if ($('#project-list .invest-project').size() == 0) {
					$('<div style="width: 100%; height: 200px; text-align: center;margin-top: 20%; margin-left: -50px;">'
										    + '<p style="color: gray; font-size: 1.2rem; ">'
										    + '暂无项目'
										    + '</p></div>').insertAfter('.invest-choice');
					$('.invest-page').hide();
				}
			})
		</script>

		
	</body>
</html>
