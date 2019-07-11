<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String url = request.getRequestURL().toString();
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
		<link rel="stylesheet" type="text/css" href="css/calendar.css" />
		<link rel="stylesheet" type="text/css" href="css/points_mall.css"/>		
		<link rel="stylesheet" href="../myaccount/css/style.css" />
		<link rel="stylesheet" type="text/css" href="css/mall_products.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/common4.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		<style>
			.layui-layer-content.layui-layer-loading2{
				margin: 0 auto;
			}
		</style>
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html?num=0" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		<!--主体-->
		<div class="mall">
			<div class="banner"ondragstart="return false" oncontextmenu="return false">
				<div class="center">
					<!--登录之前-->

					<c:if test="${empty pcuser}">
						<div class="login-box" style="display: ;">
							<h4>预期年化收益率</h4>
							<p class="rate">7%-15%</p>
							<p class="active"><a href="../register">注册送新手特权福利</a></p>
							<p class="login-btn">已有账户？<a href="../login?backUrl=<%=URLEncoder.encode(url,"UTF-8")%>">立即登录</a></p>
						</div>
					</c:if>
					<!--登录之后-->
					<c:if test="${not empty pcuser}">
						<div class="login-ok-box">
							<h4>尊敬的JQDCJR${fn:substring(pcuser.phone,8,11 )}<!-- <span id="wenhou"></span> --></h4>
							<div class="yue">
								<p>您的可用银子</p>
								
								<p><span><fmt:formatNumber type="number" pattern="###############0.00"
                                                           groupingUsed="false" value="${not empty pcuser.integral ? pcuser.integral : 0}" /></span></p>
							</div>
								
							<p class="myaccount">
								<a href="javascript:void(0)">立即签到</a>
								<a class="signed" href="javascript:void(0)" style="display: none;">已签到</a>
							</p>
							<ul class="sign-in">
								<li class="sign-days">签到记录</li>
								<li class="sign-rule">签到规则</li>
							</ul>
						</div>
					</c:if>
				</div>
			</div>
			
			<div class="main">
				<div class="section hongbao center">
					<div class="item-tit clearfix">
						<div class="tit left">
							<span>金券银票</span>
						</div>

						<div class="more right">
							<a href="product_lists.jsp?1">查看更多 &gt;</a>
						</div>

					</div>
					<div class="item-content clearfix">
						<div class="item-pic left">
							<img class="transition3" src="img/hongbao-pic.jpg"/>
							<div class="text">
								<h6>一 金券银票 一</h6>
								<p>通兑天下，财聚四海。</p>
								<p>客官，理财里边儿请！</p>
							</div>
						</div>
						<ul class="item-product left" id="hongbao">
						</ul>
					</div>
				</div>
				
				<div class="section jiadian center">
					<div class="item-tit clearfix">
						<div class="tit left">
							<span>机关兵器</span>
						</div>
						<div class="more right">
							<a href="product_lists.jsp?2">查看更多 &gt;</a>
						</div>
					</div>
					<div class="item-content clearfix">
						<div class="item-pic left">
							<img class="transition3" src="img/jiadian-pic.jpg"/>
							<div class="text">
								<h6>一 机关兵器 一</h6>
								<p style="text-align: left;padding-left: 48px;">行走江湖，</p>
								<p>得有几件趁手的家伙！</p>
							</div>
						</div>
						<ul class="item-product left" id="bingqi">

						</ul>
					</div>
				</div>
				<div class="section yanzhi center">
					<div class="item-tit clearfix">
						<div class="tit left">
							<span>胭脂水粉</span>
						</div>
						<div class="more right">
							<a href="product_lists.jsp?3">查看更多 &gt;</a>
						</div>
					</div>
					<div class="item-content clearfix">
						<div class="item-pic left">
							<img class="transition3" src="img/yzsf.jpg"/>
							<div class="text">
								<h6>一 胭脂水粉 一</h6>
								<p>窈窕淑女，君子好逑。</p>
							</div>
						</div>
						<ul class="item-product left" id="yanzhi">
						</ul>
					</div>
				</div>
				<div class="section jiaju center">
					<div class="item-tit clearfix">
						<div class="tit left">
							<span>山珍奇货</span>
						</div>
						<div class="more right">
							<a href="product_lists.jsp?4">查看更多 &gt;</a>
						</div>
					</div>
					<div class="item-content clearfix">
						<div class="item-pic left">
							<img class="transition3" src="img/jujia-pic.jpg"/>
							<div class="text">
								<h6>一 山珍奇货 一</h6>
								<p>吃山珍海味，喝琼浆玉液。</p>
							</div>
						</div>
						<ul class="item-product left" id="qihuo">
						</ul>
					</div>
				</div>
				
				<div class="section get center clearfix">
					<div class="get-silver left">
						
					
						<div class="item-tit clearfix">
							<div class="tit left">
								<span>赚取银子</span>
							</div>
						</div>
						
						<div class="get-content">
							<ul class="tab" id="tab">
								<li class="item active">新手任务</li>
								<li class="item">投资任务</li>
								<li class="item">其他任务</li>							
							</ul>
						
							<ul class="tab-list" id="tabList">
								<li class="list">
									<ul class="mission">
										<li class="mis-list">
											<img src="img/new-register.png" alt="" />
											<p>新手注册</p>
											<p>银子数量: +68</p>
											<p class="btn"><a href="../register">去完成</a></p>
										</li>
										<!--<li class="mis-list"></li>
										<li class="mis-list"></li>
										<li class="mis-list"></li>-->
									</ul>
								</li>
								
								<li class="list" style="display: none;">
									<ul class="mission">
										
										<!--<li class="mis-list"></li>
										<li class="mis-list"></li>
										<li class="mis-list"></li>-->
										<li class="mis-list">
											<img src="img/new-register.png" alt="" />
											<p>项目投资</p>
											<p>预期收益等值银子</p>
											<p class="btn"><a href="../project/list">去完成</a></p>
										</li>
									</ul>
								</li>
								<li class="list" style="display: none;">
									<ul class="mission">									
										<p class="waiting">敬请期待</p>
									</ul>
								</li>
							</ul>
						</div>
					</div>
					<div class="change-record left">
						<div class="item-tit clearfix">
							<div class="tit left">
								<span>江湖传说</span>
							</div>
						</div>
						
						<div class="record-content">
							<div class="scroll-box" id="changeRecord">
								<%--<p class="list">恭喜用户：<span>186*****543 </span> 成功兑换<span>德尔玛加湿器</span></p>--%>
								<%--<p class="list">恭喜用户：<span>186*****543 </span> 成功兑换<span>德尔玛加湿器</span></p>--%>
								<%--<p class="list">恭喜用户：<span>186*****543 </span> 成功兑换<span>德尔玛加湿器</span></p>--%>
								<%--<p class="list">恭喜用户：<span>186*****543 </span> 成功兑换<span>德尔玛加湿器</span></p>--%>
								<%--<p class="list">恭喜用户：<span>186*****543 </span> 成功兑换<span>德尔玛加湿器</span></p>--%>
								<%--<p class="list">恭喜用户：<span>186*****543 </span> 成功兑换<span>德尔玛加湿器</span></p>--%>
								<%--<p class="list">恭喜用户：<span>186*****543 </span> 成功兑换<span>德尔玛加湿器</span></p>--%>
								<%--<p class="list">恭喜用户：<span>186*****543 </span> 成功兑换<span>德尔玛加湿器</span></p>--%>
								<%--<p class="list">恭喜用户：<span>186*****543 </span> 成功兑换<span>德尔玛加湿器</span></p>--%>
							</div>
						</div>
					</div>
				</div>
				
				<div class="section help center">
					<div class="item-tit clearfix">
						<div class="tit left">
							<span>帮助中心</span>
						</div>
					</div>
					
					<div class="help-content">
						<ul class="tab">
							<li class="item active"><span class="icon dhlc"></span>银子兑换流程及说明</li>
							<li class="item"><span class="icon cjwt"></span>常见问题</li>
							<li class="item"><span class="icon zysx"></span>银子注意事项</li>
							<li class="item"><span class="icon hqff"></span>银子获取方法</li>
							<li class="item"><span class="icon dhjl"></span>兑换记录</li>
							<li class="item"><span class="icon yzjl"></span>银子记录</li>
						</ul>
						
						<ul class="tab-list" >
							<li class="list exchange" >
								<dl>
									<dt>一、兑换流程</dt>
									<dd>登录——查询银子——选择礼品——立即兑换——填写订单——配送地址——兑换完成</dd>
								</dl>
								<dl>
									<dt>二、兑换说明</dt>
									<dd>
										<p>1、兑换礼品有时间和数量的限制，先兑先得，兑完即止；</p>
										<p>2、兑换礼品图片仅供参考，礼品以实际领取为准；                                                                             </p>
										<p>3、使用银子兑换的礼品，属于对用户的回馈行为而非交易，九趣贷不提供发票；                                                               </p>
										<p>4、使用银子兑换礼品成功后，不能进行退货或是银子退回账户操作；                                                                    </p>
										<p>5、兑换礼品仅按用户指定地址进行配送，如因地址变更未及时通知九趣贷或提供配送地址错误而导致礼品配送失败，由本人承担相关责任； </p>
										<p>6、兑换礼品皆由九趣贷委托第三方公司配送。发货成功后，九趣贷将为用户提供快递单号以供查询物流配送情况；</p>
										<p>7、您可以在订单确认页选择或修改收货地址。 </p>
										<p>8、兑换礼品仅限投资过的用户才允发放。</p>
									</dd>
								</dl>
								<dl>
									<dt>三、如何查询已兑换的礼品订单？</dt>
									<dd>
										<p>登录九趣商城，即可查看。</p>
										<p>已下单是指用户已经提交兑换申请，后台尚未处理。</p>
										<p>已发货是指平台已完成兑换。</p>
									</dd>
								</dl>
							</li>
							<li class="list question" style="display: none;">
								<dl>
									<dt>Q:</dt>
									<dd>什么是九趣商城？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>九趣商城是九趣贷基于用户回馈计划，为答谢用户长期以来的支持与厚爱而特别推出的一项增值服务。九趣贷注册用户可根据既定规则获取银子、在九趣商城自助查询银子数量、使用银子兑换礼品、参与活动等。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>什么是银子？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>银子是九趣贷按照既定规则，对用户各种行为的记录数据，是平台的回馈方式之一，不构成用户资产、不支持折现。用户可以根据个人账户银子数量情况，选择兑换礼品或者参与其他活动。银子本身不具备构成任何商业交易行为的条件。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>只要是九趣贷用户都能获取银子吗？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>只要您是九趣贷注册用户，都可以按照既定规则获取银子。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>如何登录九趣商城？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>打开“九趣贷”网站，直接登录输入九趣贷注册账号即可。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd> 九趣商城都有哪些礼品可供兑换？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>九趣商城上架礼品会定期进行更新，包括多种精选实物礼品、平台代金券等虚拟礼品。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>在九趣商城兑换礼品是否需要支付费用？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>银子是您兑换礼品的唯一凭证，不需要支付额外费用，也不支持现金或现金加银子兑换。相关物流、采购费用，由九趣贷承担</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>九趣商城兑换的礼品是否可以提供发票？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>银子兑换礼品是九趣贷提供的馈赠服务，不属于买卖交易的礼品，所以不会向用户提供发票。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>九趣商城兑换的礼品是否支持退换货？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>订单一旦生成，若无礼品质量问题，不予办理礼品退换货。为了保障您的权益，请确保是您本人签收，并在签收时当场验货，如发现货物损坏，请直接拒收退回，我们将安排为您重新发货。换货仅限于更换同款式、同型号、同颜色的礼品，配送地址不可变更。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>礼品售后是否保修？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>在九趣商城兑换的礼品，如需要保修服务，可凭礼品签收单及礼品保修卡到指定维修点保修礼品，如无保修卡，则携带礼品签收单即可。银子兑换礼品三包期限可查询礼品中附带的产品/服务说明书，并以礼品签收单日期为起始日期计算。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>什么时候安排发货？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>用户订单提交成功后，九趣贷将在3个工作日内核对订单并安排发货。受第三方物流公司影响，收货时间可能延迟，用户可根据物流编号自主查询物流信息。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>我能退换货吗？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>用户所兑换的礼品如有质量、售后服务等问题，由提供礼品或服务的供应商负责处理、解决，九趣贷将向用户告知礼品的供应商，并将协助用户与供应商联系。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>虚拟礼品到期怎么办？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>部分虚拟礼品（如代金券）有使用期限限制，请务必遵照相关使用说明，在有效期内使用。因过期失效而无法使用的礼品，不再予以补发，且不可退换。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>虚拟礼品怎么配送？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>只有实物礼品才需进行配送，虚拟物品不需要物流配送，依据相关产品说明即时发放，使用方法参考礼品的使用说明。</dd>
								</dl>								
								
							</li>
							<li class="list question" style="display: none;">
								<dl>
									<dt>Q:</dt>
									<dd>银子有效期是多长时间？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>
										<p>为回馈用户，目前银子获取后长期有效。</p>
										<p>*如有变动会提前发布平台公告，以平台公告为准。</p>
									</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>每日获取银子数量有上限限制吗？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>
										<p>1、投资获得的银子数量没有上限限制；</p>
										<p>2、非投资行为银子上限以相关获取方式的具体规则为准。</p>
										
									</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>银子可以转让吗？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>不同账户银子不可转让、不支持合并银子兑换。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>如何查询我的银子？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>登录后在“九趣商城”，查看您当前的银子详情。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>我的银子什么时候开始计算？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>九趣贷九趣商城自2018年7月1日0时起上线，九趣贷将根据规则统一核算和发放银子。</dd>
								</dl>
								<dl>
									<dt>Q:</dt>
									<dd>如何查询我的银子？</dd>
								</dl>
								<dl>
									<dt>A:</dt>
									<dd>我提交银子礼品兑换订单后，是否可以修改？</dd>
								</dl>
							</li>
							<li class="list way" style="display: none;">
								<dl>
									<dt>1、</dt>
									<dd>平台投资是用户获取银子的主要途径，以投资人理财收益为主要计算依据。 主要获取方式：用户单笔投资成功后，根据该笔投资预期收益，可获得等值数量银子。举例：用户A某笔投资预期收益为58.88元，那么他可以获得58.88两银子。</dd>
								</dl>
								<dl>
									<dt>2、</dt>
									<dd>平台针对非投资行为，也给予一定数量的银子奖励。如新用户注册、签到以及参加活动等，具体奖励标准以网站最近奖励或活动公告为准，请关注网站公告。</dd>
								</dl>
								<dl>
									<dt>3、</dt>
									<dd>九趣商城签到，每天一次、每次1两银子，累计连续签到15天额外送10两银子。后期九趣贷还会投放更多的银子获取途径，敬请期待。</dd>
								</dl>
							</li>
							<li class="list trans-records" style="display: none;">
								<!--登录之前-->

								<c:if test="${empty pcuser}">
									<p class="login-btn">已有账户？<a href="../login">立即登录</a></p>
								</c:if>
								<c:if test="${not empty pcuser}">
								<div class="trans-choice">						
									<dl class="trans-choice-date clearfix">
										<dt id="order1">兑奖时间</dt>
										<dd dateBefore="2000" class="active">全部</dd>
										<dd dateBefore="7">最近7天</dd>
										<dd dateBefore="30">1个月</dd>
										<dd dateBefore="90">3个月</dd>
										<div class="trans-choice-date-box">
											选择时间
											<div class="calendarWarp">
												<input type="text" class="ECalendar" id="ECalendar_date" value="起止日">
											</div>
											<span>-</span>
											<div class="calendarWarp">
												<input type="text" class="ECalendar" id="ECalendar_date2" value="截止日">
											</div>
											<input type="submit" name="" id="searchOrder" value="查询" />
										</div>
									</dl>
								</div>
								<table border="0">
									<tr class="title">
										<th style="padding-right: 23px;">换购时间</th>
										<th>换购物品</th>
										<th>换购数量</th>
										<th>所需银子</th>
										<th style="padding-right: 32px;">换购状态</th>
									</tr>
								</table>
								<div class="table-box">
								<table id="drawList">
								</table>
								</div>
								</c:if>
							</li>
							<li class="list trans-records score-records" style="display: none;" >
								<!--登录之前-->

								<c:if test="${empty pcuser}">
										<p class="login-btn">已有账户？<a href="../login">立即登录</a></p>
								</c:if>
								<c:if test="${not empty pcuser}">
								<div class="trans-choice">
									<dl class="trans-choice-date clearfix">
										<dt id="points1">获取时间</dt>
										<dd dateBefore="2000" class="active">全部</dd>
										<dd dateBefore="7">最近7天</dd>
										<dd dateBefore="30">1个月</dd>
										<dd dateBefore="90">3个月</dd>
										<div class="trans-choice-date-box">
											选择时间
											<div class="calendarWarp">
												<input type="text" class="ECalendar" id="startDate" value="起止日">
											</div>
											<span>-</span>
											<div class="calendarWarp">
												<input type="text" class="ECalendar" id="endDate" value="截止日">
											</div>
											<input type="submit" name="" id="searchPoints" value="查询" />
										</div>
									</dl>
								</div>
								<table border="0">
									<tr class="title">
										<th style="padding-right: 26px;">银子变动时间</th>
										<th style="padding-left: 12px;">银子动向</th>
										<th style="padding-left: 16px;">银子数</th>
										<th>总银子</th>
										<th style="padding-right: 33px;">项目名称</th>
									</tr>
								</table>
								<div class="table-box">
									<table id="pointsList">
										<!--<tr>
											<td class="time"><span>2017-09-25</span></td>
											<td>123456789789789</td>
											<td>加湿器</td>										
											<td>成功</td>
											<td>成功</td>
										</tr>-->
									</table>
								</div>
								</c:if>
							</li>
						</ul>
					</div>
					
				</div>
				
			</div>
		</div>
		<div id="fade" class="black-overlay"></div>
		<div class="sign-records" id="signRecords">
			<div class="tit" id="move">
				<h3>签到记录</h3>
				<span onclick="CloseDiv('signRecords','fade')"></span>
			</div>
			<div class="records-box clearfix">
				<div class="text left">
					<p>尊敬的：${pcuser.phone}</p>
                    <p>您已连续签到：<span class="continuous-sign-in-days">0</span>天</p>
					<button class="sign" >立即签到</button>
					<button class="sign already" style="display: none;">已签到</button>

				</div>
				<div class="records left">
					<div id="ca" class="calendar"></div>
				</div>
			</div>
		</div>
		
		<!--客服悬浮条-->
		<%--<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>--%>
		<%--<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>--%>
		<%--<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>--%>
		<!--悬浮条-->
		<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>
		<!--底部导航-->
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>

		<!--加载js文件-->
		<script src="js/jquery.js"></script>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/calendar.js"></script>
		<script src="js/jquery.lazyload.min.js"></script>
		<script src="../myaccount/js/Ecalendar.jquery.min.js"></script>
		<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
            var signInStatistics = {};

            $.get('/yingpu/pc/pointsmall/user/sign-in/history', {
                date : new Date().Format('yyyy-MM-dd hh:mm:ss')
            }, function(result) {
                if (result.data && result.data.length) {
                    $('.myaccount>a:eq(0)').hide();
                    $('.myaccount>a:eq(1)').show();
                    $('.sign').hide();
                    $('.sign.already').show();
                }
            }, 'json');

            function getSignInHistoryOfMonth(month, cb, complete) {
                $.get('/yingpu/pc/pointsmall/user/sign-in/history', { dateMonthStr : month }, function(result) {
                    if (result.data && result.data.length) {
                        cb && cb(result.data);
                        signInStatistics = result.queryBean;
                        $('.continuous-sign-in-days').html(signInStatistics.continuousSignInTimes || 0);
                    }
                    complete && complete();
                }, 'json');
            }

            function showSignInDaysOnCalendar(data) {
                data = data || [];
                $('.date-items>li:eq(1) li').not('.new,.old').each(function(i, e) {
                    var item = {};
                    for (var k in data) {
                        item = data[k];
                        if (new Date(item.signInTime || 0).getDate() == $(e).text()) {
                            $(e).addClass('now');
                            break;
                        }
                    }
                });
            }

            $(function() {
                var month;
               getSignInHistoryOfMonth(
                       new Date().getFullYear() + '-' + ((month = (new Date().getMonth() + 1)) < 10 ? '0' + month : month),
                                showSignInDaysOnCalendar);

               $(document).on('click', '.myaccount>a:eq(0), [class=sign]', function() {
                   $.get('/yingpu/pc/pointsmall/user/sign-in', { }, function(result) {
                        if (result.status == 'success') {
                            $('.myaccount>a:eq(0)').hide();
                            $('.myaccount>a:eq(1)').show();
                            $('.sign').hide();
                            $('.sign.already').show();
                        }
                        else {
                            layer.msg(result.message);
                        }
                   }, 'json');
               });
            });

			function ShowDiv(show_div,bg_div){
				document.getElementById(show_div).style.display='block';
				document.getElementById(bg_div).style.display='block' ;
				var bgdiv = document.getElementById(bg_div);
				bgdiv.style.width = document.body.scrollWidth;
				// bgdiv.style.height = $(document).height();
				$("#"+bg_div).height($(document).height());
			};
				//关闭弹出层
			function CloseDiv(show_div,bg_div){
				document.getElementById(show_div).style.display='none';
				document.getElementById(bg_div).style.display='none';
			};
			$('body').on('click','.sign-rule',function(){
				layer.open({
				  type: 1,
				  shade: false,
				  title: false, //不显示标题
				  content: '<p style="padding:20px;line-height:24px;">九趣商城签到，每天一次、每次1两银子，累计连续签到15天额外送10两银子。后期营普金服还会投放更多的银子获取途径，敬请期待。</p>' //捕获的元素，注意：最好该指定的元素要存放在body最外层，否则可能被其它的相对元素所影响
				});
			})

//			加载日历
			$('#ca').calendar({
		        width: 320,
		        height: 320,
		        data:[
		        	{date:'2018/6/25'},{date:'2018/6/26'}
		        ],
		        onSelected: function (view, date, data) {

		        },
                onMonthChange : function(year, month) {
                    setTimeout(function () {
                        var index = layer.load(2);
                        getSignInHistoryOfMonth(year + '-' + (month < 10 ? '0' + month : month),
                            showSignInDaysOnCalendar, function () {
                                layer.close(index);
                            }
                        );
                    }, 610);
                }
		    });


			$('body').on('click','.sign-days',function(){
				ShowDiv('signRecords','fade');
			})


			var index = layer.load(2);
            $.post('/yingpu/pc/pointsmall/list/json',{
                userId:"${pcuser.id}"
			},function(data){

                if(data.status=='success') {
                	layer.close(index);
                    var hongbao = '';
                    var bingqi = '';
                    var yanzhi = '';
                    var qihuo = '';
                    var order1='';
                    var points=data.data.points;
                    var draw=data.data.draw;
                    var order=data.data.order;
                    for (var i = 0; i < data.data.list.length; i++) {
						if(data.data.list[i].goodsType==1){
                            hongbao +='<a href="goodsDetails?goodsId='+data.data.list[i].id+'">'
                                +'<li class="list">'
                                +'<div class="product-pic">'
                                +'<img src="'+data.data.list[i].smLogo+'" />'
                                +'</div>'
                                +' <p class="tit">'+data.data.list[i].goodsName+'</p>'
                                +' <div class="detail">'
                                +'<p>银子：<span>'+data.data.list[i].points+'</span> 两</p>'
                                +'<p>已兑：<span>'+data.data.count[i].count1+'</span> 人</p>'
                                +'</div>'
                                +'</li>'
                                +' </a>'
						}
                        if(data.data.list[i].goodsType==2){
                            bingqi +='<a href="goodsDetails?goodsId='+data.data.list[i].id+'">'
                                +'<li class="list">'
                                +'<div class="product-pic">'
                                +'<img src="'+data.data.list[i].smLogo+'"/>'
                                +'</div>'
                                +' <p class="tit">'+data.data.list[i].goodsName+'</p>'
                                +' <div class="detail">'
                                +'<p>银子：<span>'+data.data.list[i].points+'</span> 两</p>'
                                +'<p>已兑：<span>'+data.data.count[i].count1+'</span> 人</p>'
                                +'</div>'
                                +'</li>'
                                +' </a>'
                        }
                        if(data.data.list[i].goodsType==3){
                            yanzhi +='<a href="goodsDetails?goodsId='+data.data.list[i].id+'">'
                                +'<li class="list">'
                                +'<div class="product-pic">'
                                +'<img src="'+data.data.list[i].smLogo+'"/>'
                                +'</div>'
                                +' <p class="tit">'+data.data.list[i].goodsName+'</p>'
                                +' <div class="detail">'
                                +'<p>银子：<span>'+data.data.list[i].points+'</span> 两</p>'
                                +'<p>已兑：<span>'+data.data.count[i].count1+'</span> 人</p>'
                                +'</div>'
                                +'</li>'
                                +' </a>'
                        }
                        if(data.data.list[i].goodsType==4){
                            qihuo +='<a href="goodsDetails?goodsId='+data.data.list[i].id+'">'
                                +'<li class="list">'
                                +'<div class="product-pic">'
                                +'<img src="'+data.data.list[i].smLogo+'"/>'
                                +'</div>'
                                +' <p class="tit">'+data.data.list[i].goodsName+'</p>'
                                +' <div class="detail">'
                                +'<p>银子：<span>'+data.data.list[i].points+'</span> 两</p>'
                                +'<p>已兑：<span>'+data.data.count[i].count1+'</span> 人</p>'
                                +'</div>'
                                +'</li>'
                                +' </a>'
                        }
                    }
                   	if(points&&points.length){
                        poitnsList(points);
					}
					if(draw&&draw.length){
                        drawList(draw);
					}
					if(order&&order.length) {
                        for (var i = 0; i < order.length; i++) {
                            order1 += '<p class="list">恭喜用户：<span>' + order[i].phone + '</span> 成功兑换<span>' + order[i].goodsName + '</span></p>'
                        }
                    }
                    $("#changeRecord").html(order1);
                    $("#hongbao").html(hongbao);
                    $("#bingqi").html(bingqi);
                    $("#yanzhi").html(yanzhi);
                    $("#qihuo").html(qihuo);
//					$("img.lazy").lazyload({
//		                placeholder: "img/loading.gif",
//		                effect: "fadeIn"
//		            });

                }
            })

			$('.tab').find('.item').click(function(){
				$(this).siblings().removeClass('active');
				$(this).addClass('active');
				$(this).parents('.tab').next('.tab-list').find('.list').hide();
				$(this).parents('.tab').next('.tab-list').find('.list').eq($(this).index()).show();
			})


			$(function(){
				$("#ECalendar_date").ECalendar({
					 type:"time",
					 stamp:false,
					 offset:[0,2],   //弹框手动偏移量;
					 skin:'#ff7f01',
					 format:"yyyy-mm-dd",
					 callback:function(v,e)
					 {
						 $(".callback span").html(v)
					 }
				});
				$("#ECalendar_date2").ECalendar({
					 type:"time",
					 stamp:false,
					 offset:[0,2],   //弹框手动偏移量;
					 skin:'#ff7f01',
					 format:"yyyy-mm-dd",
					 callback:function(v,e)
					 {
						 $(".callback span").html(v)
					 }
				});

                $("#startDate").ECalendar({
                    type:"time",
                    stamp:false,
                    offset:[0,2],   //弹框手动偏移量;
                    skin:'#ff7f01',
                    format:"yyyy-mm-dd",
                    callback:function(v,e)
                    {
                        $(".callback span").html(v)
                    }
                });
                $("#endDate").ECalendar({
                    type:"time",
                    stamp:false,
                    offset:[0,2],   //弹框手动偏移量;
                    skin:'#ff7f01',
                    format:"yyyy-mm-dd",
                    callback:function(v,e)
                    {
                        $(".callback span").html(v)
                    }
                });
			});
            //银子获取记录
            function poitnsList(data){
                var pList='';
                //pList.empty();
                for (var i = 0; i < data.length; i++) {
                    var date = new Date(data[i].operationTime).Format("yyyy-MM-dd hh:mm:ss");
                    var pointsCome=data[i].operationType;//银子来源
					var integral=data[i].integral;
					if(integral<0){
                        integral=-integral;
					}
					var projectName=data[i].name;
					var pointsComeName='';
					if(pointsCome==0){
                        pointsComeName="注册";
                        projectName="注册";
                        integral="<span style='color: #09f825;font-weight:900; font-size:15px' >+</span>"+integral;
					}
                    if(pointsCome==1){
                        pointsComeName="实名认证";
                        projectName="实名认证"
                        integral="<span style='color: #09f825;font-weight:900; font-size:15px' >+</span>"+integral;
                    }
                    if(pointsCome==2){
                        pointsComeName="投资";
                        integral="<span style='color: #09f825;font-weight:900; font-size:15px' >+</span>"+integral;
                    }
                    if(pointsCome==3){
                        pointsComeName="生日奖励";
                        projectName="生日奖励"
                        integral="<span style='color: #09f825;font-weight:900; font-size:15px' >+</span>"+integral;
                    }
                    if(pointsCome==4){
                        pointsComeName="银子消费";
                        integral="<span style='color: red;font-weight:900; font-size:15px' >-</span>"+integral;
                        projectName="银子消费";
                    }
                    if(pointsCome==5){
                        pointsComeName="签到奖励";
                        projectName="签到奖励";
                        integral="<span style='color: #09f825;font-weight:900; font-size:15px' >+</span>"+integral;
                    }
                    if(pointsCome==6){
                        pointsComeName="会员升级奖励";
                        projectName="会员升级奖励";
                        integral="<span style='color: #09f825;font-weight:900; font-size:15px' >+</span>"+integral;
					}
                    pList +='<tr>'
                        +'<td class="time"><span>'+date+'</span></td>'
                        +'<td>'+pointsComeName+'</td>'
                        +'<td>'+integral+'</td>'
                        +'<td>'+data[i].totalIntegral+'</td>'
                        +'<td>'+projectName+'</td>'
                        +'</tr>'
                }
                $("#pointsList").empty();
                $("#pointsList").html(pList)
			}

            //银子兑换记录
            function drawList(data){
                var dList='';

                for (var i = 0; i < data.length; i++) {
                    var date = new Date(data[i].createTime).Format("yyyy-MM-dd hh:mm:ss");
                   	var status=data[i].ts;
                   	var id=data[i].td;
                    var pointsComeName='';
                    if(status==1){
                        status="待付款";
                    }
                    if(status==2){
                        status="已下单";
                    }
                    if(status==5){
                        status="已收货";
                    }

                    dList += '<tr >'
                    +'<td class="time" ><span>'+date+'</span></td>'
                    +'<td>'+data[i].goodsName+'</td>'
					+'<td>'+data[i].goodsNumber+'</td>'
                    +'<td>'+data[i].totalIntegral+'</td>'
                    +'<td >'+status+'</td>'
                    +'</tr>'
            }
                $("#drawList").empty();
                $("#drawList").html(dList)
            }
//            //确认收货
//            $("body").on('click','#confirmId',function(){
//                var this1=$(this);
//                var id=$(this).parent().next().val();
//                alert(id);
//                $.post('/yingpu/pc/pointsmall/confirm',{
//                    orderId:id
//                },function(data){
//                    if(data.status=='success') {
//                       $("#confirmId").parent().html("已收货");
//                    }
//                })
//            })
			//点击一周，一月，3月
            $('.trans-choice').on('click', 'dd', function() {
                $(this).addClass('active').parent().find('dd').not($(this)).removeClass();
                var biaozhi=$(this).addClass('active').parent().find('dt').attr("id");
             //   alert(biaozhi);
                var date=$(this).attr('dateBefore');
                //alert(date)
             	loadList(date,biaozhi);
            });
			//按照时间去查询
            function loadList(date,biaozhi) {
                $.post('/yingpu/pc/pointsmall/byDate',{
                    userId:"${pcuser.id}",
					date:date,
					biaozhi:biaozhi
                },function(data){
                    if(data.status=='success') {
                           if(biaozhi=='order1'){
                               drawList(data.data);
						   }else{
                               poitnsList(data.data)
						   }

                        }
                })
            }

                      //按制定日期查询
            				$("#searchOrder").click(function(){
						   var startdate=$("#ECalendar_date").val();
                           var endDate=$("#ECalendar_date2").val();
                                if(startdate=="起止日"|endDate=="截止日"){
                                    layer.alert('请选择一个合理时间段!')
                                    return;
                                }
                           var temp='';
                           if(startdate>endDate){
                               temp=startdate;
                               startdate=endDate;
                               endDate=temp;
						   }
                          $.post('/yingpu/pc/pointsmall/byDate1',{
                              userId:"${pcuser.id}",
                              startDate:startdate,
							  endDate:endDate
                            },function(data){
                                if(data.status=='success') {
                                    drawList(data.data);
                                }
                           })
                       });

            //按制定日期查询
            $("#searchPoints").click(function(){
                var startdate=$("#startDate").val();
                var endDate=$("#endDate").val();
                if(startdate=="起止日"|endDate=="截止日"){
                    layer.alert('请选择一个时间段!')
                    return;
				}
                var temp='';
                if(startdate>endDate){
                    temp=startdate;
                    startdate=endDate;
                    endDate=temp;
                }
                $.post('/yingpu/pc/pointsmall/byDate2',{
                    userId:"${pcuser.id}",
                    startDate:startdate,
                    endDate:endDate
                },function(data){
                    if(data.status=='success') {
                        poitnsList(data.data);
                    }
                })
            });


            //滚动列表
           function myGod(id,w,n){
					//id 为父元素的ID，w为默认多久滚动一次，n 为朝上还是朝下滚
					var box=document.getElementById(id),can=true,w=w||1500,fq=fq||30,n=n==-1?-1:1;
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

			myGod('changeRecord',100);


		</script>
	</body>
</html>
