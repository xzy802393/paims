<%@ page language="java" import="java.util.*, java.util.regex.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<meta name="Description" content="九趣贷 — 贷快乐，更带梦想"/>
		<meta name="Keywords" content="九趣贷,jiuqudai,九趣,jiuqu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" >
		<meta name="renderer" content="webkit">
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="../css/account.css"/>
		<link rel="stylesheet" type="text/css" href="css/deposit.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/common4.css"/>
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
					
					<iframe src="../myaccount/account_sidebar.html" width="100%" height="622" scrolling="no"  style="border:0px;"></iframe>
					
				</div>
				<!--右边主体部分-->
				
				<div class="deposit-main left">
					<h3>充值</h3>
					<div class="deposit-fun clearfix">
						<p class="deposit-num">充值金额  <input type="number" id="czje" value="0"   maxlength="10"/> <span>元</span></p>
						<p class="account-balance">账户余额 <span id="accountMoney">${pcuser.caBalance}</span> 元，充值后余额 <span id="yue">${pcuser.caBalance}</span> 元</p>
						<p class="pay-style">支付方式  
							<a class="q-payment active" id="kj" onclick="$(this).parent().find('a').removeClass('active');$(this).addClass('active')"><img src="../img/account/deposit-style-1.png"/></a>
							<a class="e-pay" id="wy" onclick="$(this).parent().find('a').removeClass('active');$(this).addClass('active')"><img src="../img/account/deposit-style-2.png"/>网银支付</a></p>
						
						<!--已添加银行卡时显示银行卡和查看充值限额表-->
						<!--没有添加银行卡时显示添加银行卡，查看充值限额，*为了您的资金安全，请先完成等等-->
						<p class="bank left" id="khyh" >开户银行  	


							<c:choose>
							   <c:when test="${pcuser.bankNum!=null}">  
								   <a class="active"><span class="bank-icon" style="background:url(${bank.logo}) no-repeat center;background-size:cover;"></span>${bank.name}（${bank.banknum})</a>     
							   </c:when>
							   <c:otherwise> 
								  <a href="javascript:void($('#bindBank').show())" ><span class="add"></span>添加认证银行卡</a>
							   </c:otherwise>
							</c:choose>

							<a href="javascript:xiane();" class="look-for">查看充值限额表</a>
						</p>
						
						<div class="choose-bank clearfix" id="chooseBank" style="display: none;">
							<div class="title left">
								选择银行
							</div>
							
							<div class="bank-list left" id="bankList">
								<ul class="clearfix">
									<li data-value="0801020000"><a class="active"><img src="../img/yh_logo/gongshang.png"/></a></li>
									<li data-value="0801030000"><a class=""><img src="../img/yh_logo/nonghang-1.png"/></a></li>
									<li data-value="0801050000"><a class=""><img src="../img/yh_logo/jianhang-2.png"/></a></li>
									<li data-value="0803050000"><a class=""><img src="../img/yh_logo/mingsheng.png"/></a></li>
									<li data-value="0801000000"><a class=""><img src="../img/yh_logo/youzheng-16.png"/></a></li>
									<li data-value="0803030000"><a class=""><img src="../img/yh_logo/guangda-18.png"/></a></li>
									<li data-value="0803040000"><a class=""><img src="../img/yh_logo/huaxia-4.png"/></a></li>
									<li data-value="0803080000"><a class=""><img src="../img/yh_logo/zhaoshang-15.png"/></a></li>
									<li data-value="0804184930"><a class=""><img src="../img/yh_logo/luoyangshangye-14.png"/></a></li>
									<li data-value="0801040000"><a class=""><img src="../img/yh_logo/zhonghang.png"/></a></li>
									<li data-value="0803010000"><a class=""><img src="../img/yh_logo/jiaotong-13.png"/></a></li>
									<li data-value="0803100000"><a class=""><img src="../img/yh_logo/pufa-12.png"/></a></li>
									<li data-value="0803090000"><a class=""><img src="../img/yh_logo/xingye-11.png"/></a></li>
									<li data-value="0803020000"><a class=""><img src="../img/yh_logo/zhongxin-10.png"/></a></li>
									<li data-value="0804031000"><a class=""><img src="../img/yh_logo/beijing-9.png"/></a></li>
									<li data-value="0803060000"><a class=""><img src="../img/yh_logo/guangdong-8.png"/></a></li>
									<li data-value="0804105840"><a class=""><img src="../img/yh_logo/pingan-7.png"/></a></li>
									<li data-value="0803160000"><a class=""><img src="../img/yh_logo/zheshang-6.png"/></a></li>
									<li data-value="0803202220"><a class=""><img src="../img/yh_logo/xinhuicunzheng-5.png"/></a></li>
								</ul>
								<!--中国工商银行(0801020000) 
								中国农业银行(0801030000)
								中国建设银行(0801050000)
								中国民生银行(0803050000)
								中国邮政(0801000000) 
								中国光大银行(0803030000)
								华夏银行(0803040000)
								招商银行(0803080000)
								洛阳市商业银行(0804184930)
								中国银行(0801040000)
								交通银行(0803010000)
								上海浦东发展银行(0803100000)
								兴业银行(0803090000)
								中信银行(0803020000)
								北京银行(0804031000)
								广东发展银行(0803060000)
								平安银行(0804105840)
								浙商银行(0803160000)
								鑫汇村镇银行(0803202220)-->
							</div>
						</div>
						<p class="tip left" style="display: none;">*为了您的资金安全，请先完成<a href="#">实名认证</a>和<a href="#">绑定银行卡</a></p>
						
						<div class="deposit-btn">
							<button class="active" onclick="javascript:chongzhi();">充值</button>  每次充值额需大于等于100元
						</div>
						<p class="deposit-tip"> <span>*</span> 根据国家相关规定：不支持使用信用卡充值</p>
					</div>
					
					<div class="reminders">
							<p>温馨提示：                                  </p>
							<p>1、如果在充值过程中遇到问题请致电：400-969-1811，客服竭诚为您服务；</p>
							<p>2、如果超出支付限额，可以拆分整体投资金额多次充值；             </p>
							<p>3、单次充值金额需大于或等于100元；                    </p>
							<p>4、充值服务0手续费，账户金额提现0手续费；                 </p>
							<p>5、请使用借记卡充值，信用卡无法充值；                    </p>
							<p>6、银行卡余额不足需要先补充金额后再次充值；                 </p>
							<p>7、开通网银方法：（1）携带本人身份证到银行柜台办理。（2）登录网上银行办理；</p>
							<p>8、如果存在银行卡状态异常情况，请联系银行做取消挂失或补卡处理；       </p>
							<p>9、每日的充值限额依据各银行限额为准，请注意您的银行卡充值限制，以免造成不便。</p>
					</div>
				</div>	
		</div>
			<!--充值遇到问题的弹框-->
		<div id="tankuang" class="deposit-alert" style="display:none;">
			<div class="alert-tit" id="">
				<p>充值提示</p>
			</div>
			<div class="alert-main">
				<p class="icon"><span></span>请您在新打开的第三方支付页面上完成，完成前请不要关闭此窗口</p>
				<div class="alert-btn">
					<p>完成充值后请根据您的情况点击下面的按钮</p>
					<input class="btn" type="button" onclick="location.href='account';" id="" value="充值遇到问题" />
					<input class="red" type="button"  onclick="location.href='account';"  name="" id="" value="已完成充值" />
				</div>
				<p>如果【快捷充值】提示“未开通支付功能”，请前往银联开通</p>
			</div>
		</div>
		

		<div id="xiane" style="display:none;">
				<div id="magicdomid121" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="bold:true color:#000000 font-family:微软雅黑 font-size:10pt" style="font-weight:bold;font-family:微软雅黑;font-size:10pt;">银行</span> 
</div>
<div id="magicdomid122" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="bold:true color:#000000 font-family:微软雅黑 font-size:10pt" style="font-weight:bold;font-family:微软雅黑;font-size:10pt;">快速充值/委托充值</span> 
</div>
<div id="magicdomid123" class="ace-line gutter-noauthor emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;font-family:&quot;border:none !important;">
	<span class="bold:true color:#000000 font-family:微软雅黑 font-size:10pt" style="font-weight:bold;font-family:微软雅黑;font-size:10pt;">（APP签约）</span> 
</div>
<div id="magicdomid124" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="bold:true color:#000000 font-family:微软雅黑 font-size:10pt" style="font-weight:bold;font-family:微软雅黑;font-size:10pt;">手机快捷充值</span> 
</div>
<div id="magicdomid125" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">工行</span> 
</div>
<div id="magicdomid126" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，40万/日（单日仅限5笔成功交易），50万/月</span> 
</div>
<div id="magicdomid127" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日（单日仅限5笔成功交易），100万/月</span> 
</div>
<div id="magicdomid128" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">农行</span> 
</div>
<div id="magicdomid129" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，30万/日，50万/月（单日仅限6笔成功交易）</span> 
</div>
<div id="magicdomid130" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，20万/日（单日仅限6笔成功交易），100万/月</span> 
</div>
<div id="magicdomid131" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">建行</span> 
</div>
<div id="magicdomid132" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，10万/日，50万/月</span> 
</div>
<div id="magicdomid133" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，10万/日，100万/月</span> 
</div>
<div id="magicdomid134" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">中行</span> 
</div>
<div id="magicdomid135" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span> 
</div>
<div id="magicdomid136" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，10万/日，100万/月</span> 
</div>
<div id="magicdomid137" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">邮储</span> 
</div>
<div id="magicdomid138" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span> 
</div>
<div id="magicdomid139" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span> 
</div>
<div id="magicdomid140" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">招行</span> 
</div>
<div id="magicdomid141" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，20万/日，50万/月</span> 
</div>
<div id="magicdomid142" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，20万/日，100万/月</span> 
</div>
<div id="magicdomid143" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">兴业</span> 
</div>
<div id="magicdomid144" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，50万/月</span> 
</div>
<div id="magicdomid145" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，100万/月</span> 
</div>
<div id="magicdomid146" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">广发</span> 
</div>
<div id="magicdomid147" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span> 
</div>
<div id="magicdomid148" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span> 
</div>
<div id="magicdomid149" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">平安</span> 
</div>
<div id="magicdomid150" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span> 
</div>
<div id="magicdomid151" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span> 
</div>
<div id="magicdomid152" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">中信</span> 
</div>
<div id="magicdomid153" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">1万/笔，2万/日,2万/月</span> 
</div>
<div id="magicdomid154" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">1万/笔，2万/日,2万/月</span> 
</div>
<div id="magicdomid155" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">华夏</span> 
</div>
<div id="magicdomid156" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span> 
</div>
<div id="magicdomid157" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span> 
</div>
<div id="magicdomid158" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">光大</span> 
</div>
<div id="magicdomid159" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，50万/月</span> 
</div>
<div id="magicdomid160" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，100万/月</span> 
</div>
<div id="magicdomid161" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">浦发</span> 
</div>
<div id="magicdomid162" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，30万/日，50万/月</span> 
</div>
<div id="magicdomid163" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万元/笔，20万/日，100万/月</span> 
</div>
<div id="magicdomid164" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">民生</span> 
</div>
<div id="magicdomid165" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，50万/日/月</span> 
</div>
<div id="magicdomid166" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">10万/笔，20万/日，100万/月</span> 
</div>
<div id="magicdomid167" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">交行</span> 
</div>
<div id="magicdomid168" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，50万/月</span> 
</div>
<div id="magicdomid169" class="ace-line gutter-noauthor text-align-type-center emptyGutter" style="margin:0px;padding:0px 60px 0px 54px;font-size:12pt;text-align:center;font-family:&quot;border:none !important;">
	<span class="color:#000000 font-family:微软雅黑 font-size:10pt" style="font-family:微软雅黑;font-size:10pt;">5万/笔，5万/日，100万/月</span> 
</div>
<div>
	<br />
</div>

		</div>
		
		<!--客服悬浮条-->
		<!--客服悬浮条-->
		<%--<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>--%>
		<%--<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>--%>
		<%--<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>--%>
		
		<iframe src="bind_bankcard.jsp" id="bindBank" width="100%" style="position: absolute;top: 0;left: 0;display: none;z-index: 10;" scrolling="no"></iframe>

			<!--悬浮条-->
			<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
			<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
			<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<!--底部导航-->
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:308px;"></iframe>
		
		<!--加载js文件-->
	<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/queryString.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../layer-v3.0.3/layer/layer.js"></script>
	<script src="../js/radialIndicator.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
			<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>

	<script type="text/javascript">
		
		$("#bindBank").height($(document).height());
			//资产分布图表
		$(function(){
				if(queryString('type')!=null&&queryString('type')!=undefined&&queryString('type')!=''){
					$('#tankuang').show();
				}
				$('#czje').keyup(function(e){
					
							if($('#czje').val()==''){
								$('#yue').text(commafy(returnFloat(${pcuser.caBalance})));
							}else{
						
								$('#yue').text(commafy(returnFloat(accAdd('${pcuser.caBalance}',$('#czje').val()))));
								
							}	
				});	

				$('.pay-style>a').click(function(){
					if($(this).attr('id')=='wy'){
						$('#khyh').hide();
						$('#chooseBank').show();
					}else{
						$('#khyh').show();
						$('#chooseBank').hide();
					}
					
				});

				$("#bankList").on("click","li",function(){
					$("#bankList").find("a").removeClass("active");
					$(this).find("a").addClass("active");
				})
    });
    	function xiane(){

    		layer.open({content:$('#xiane').html(),area:['500px','800px']});
    	}
    	function chongzhi(){
    		   if($('#czje').val()==''){
    			layer.alert('请输入充值金额');
    			return false;
    		}
    		if($('#czje').val()<100){
    			layer.alert('充值金额必须大于100');
    			return false;
    		}
    		if('${pcuser.bankNum}'==null||'${pcuser.bankNum}'==''){
    			$('#bindBank').show();
    			return false;
    		}
    		if($('.pay-style').find('a[class*=active]').attr('id')=='kj'){

    				$('#tankuang').show();
    				window.open('pcWebRech/json?money='+$('#czje').val());
    				/*$.post('pcWebRech/json',{money:$('#czje').val()},function(data){
    					layer.alert(data);
    			});*/
    		}else{
    				$('#tankuang').show();
    				window.open('pcWyWebRech/json?money='+$('#czje').val()+'&bank='+$('#bankList').find('a[class="active"]').parent('li').attr('data-value'));

    			/*	$.post('pcWyWebRech/json',{money:$('#czje').val()},function(data){
    			layer.alert(data);

    			});*/
    		}

    	}
        $('#accountMoney').text(commafy(returnFloat($('#accountMoney').text())));
        $('#yue').text(commafy(returnFloat($('#yue').text())));
 
	</script>
		
		

		
	</body>
</html>
