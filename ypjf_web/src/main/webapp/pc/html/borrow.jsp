<!--<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">-->
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>营普金服—参股商业银行的互联网金融服务平台</title>
		
		<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
		<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
		<link rel="shortcut icon" href="img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="./css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="./css/common.css"/>
		
		<link rel="stylesheet" type="text/css" href="./css/borrow.css"/>
		
		<script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		<iframe src="head3.html?index=2" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="borrow-main">
			<!--banner-->
			<div class="borrow-banner">
				<div class="center">
					<div class="banner-text">
						<p></p>
						<p>为个人、成长型小微企业提供专业高效的融资渠道</p>
						<p>践行普惠金融，服务实体经济</p>
					</div>
				</div>
			</div>
			<!--借款产品-->
			<div class="center clearfix">
				<div class="borrow-pro">
					<h3>借款产品</h3>
					<ul class="clearfix">
						<li>
							<div class="list-t">
								<p class="title">车贷融</p>
								<img src="./img/borrow-1.1.png"/>
								<p>抵质押均可</p>
								<p>抵押率高达80%</p>
							</div>
							<div class="list-b">
								<span onclick="ShowDiv('borrowApply','fade')">立即申请</span>
							</div>
						</li>
						<li>
							<div class="list-t">
								<p class="title">房贷融</p>
								<img src="./img/borrow-1.2.png"/>
								<p>手续简易快速</p>
								<p>当天即可到账</p>
							</div>
							<div class="list-b">
								<span onclick="ShowDiv('borrowApply','fade')">立即申请</span>
							</div>
						</li>
						<li>
							<div class="list-t">
								<p class="title">优企贷</p>
								<img src="./img/borrow-1.3.png"/>
								<p>服务小微</p>
								<p>助力实体经济</p>
							</div>
							<div class="list-b">
								<span onclick="ShowDiv('borrowApply','fade')">立即申请</span>
							</div>
						</li>
					</ul>
				</div>
				<!--借款流程-->
				<div class="borrow-flow">
					<h3>借款流程</h3>
					<ul class="clearfix">
						<li>
							<img src="./img/borrow-2.1.png"/>
							<p>1、在线提交借款申请</p>
						</li>
						<li>
							<img src="./img/borrow-2.5.png"/>
						</li>
						<li>
							<img src="./img/borrow-2.2.png"/>
							<p>2、工作人员与您联系</p>
						</li>
						<li>
							<img src="./img/borrow-2.5.png"/>
						</li>
						<li>
							<img src="./img/borrow-2.3.png"/>
							<p>3、提交资料，风控审核</p>
						</li>
						<li>
							<img src="./img/borrow-2.5.png"/>
						</li>
						<li>
							<img src="./img/borrow-2.4.png"/>
							<p>4、通过审核，线上发标</p>
						</li>
					</ul>
				</div>
				<!--常见问题-->
				<div class="borrow-ques">
					<h3>常见问题</h3>
					<div class="m-line"></div>
					<ul>
						<li>
							<div class="text">
								<h6>借款审核期限是多久？</h6>
								<p>收到借款申请后，平台工作人员将会和您联系，并进行初步筛选，然后收集相关借款资料。资料提交给风控部门审核，在2个工作日内出具风控意见。</p>						
							</div>
							<div class="icon">1</div>
						</li>
						<li>
							<div class="icon">2</div>
							<div class="text">
								<h6>可借款金额是多少？</h6>
								<p>根据产品不同、借款人资质不同，借款额度有不同设置，最终以风控意见为准。</p>						
							</div>							
						</li>
						<li>
							<div class="text">
								<h6>借款需要支付哪些费用？</h6>
								<p>借款成功后，需要支付借款利息以及营普金服居间服务费。借款未成功，不收取任何费用。</p>						
							</div>
							<div class="icon">3</div>
						</li>
						<li>
							<div class="icon">4</div>
							<div class="text">
								<h6>还款方式有哪些？</h6>
								<p>目前支持“到期一次性还本付息”、“按月付息，到期还本”、“等额本息”三种还款方式。</p>						
							</div>							
						</li>
						<li>
							<div class="text">
								<h6>适用对象</h6>
								<p>有短期资金周转需求的个人；有中长期资金需求的成长型小微企业</p>						
							</div>
							<div class="icon">5</div>
						</li>
						<li>
							<div class="icon">6</div>
							<div class="text">
								<h6>申请条件</h6>
								<p>年龄在18-60周岁的中国大陆居民，能提供个人身份证明、企业资料、财产证明等</p>						
							</div>							
						</li>
						<li>
							<div class="text">
								<h6>额度范围</h6>
								<p>5万-100万</p>						
							</div>
							<div class="icon">7</div>
						</li>
						<li>
							<div class="icon">8</div>
							<div class="text">
								<h6>借款周期</h6>
								<p>1个月-24个月</p>						
							</div>							
						</li>
					</ul>
				</div>
			
			</div>
		</div>
		<!--弹出对话框-->
		<div id="fade" class="black-overlay"></div>
		<div id="borrowApply" class="borrow-apply">
			<div class="borrow-apply-t" id="move">
				<h3>借款申请</h3>
				<span onclick="CloseDiv('borrowApply','fade')"></span>
			</div>
			<div class="borrow-msg clearfix">
				<div class="borrow-apply-l left">
					<ul>
						<li>
							<h4>适用对象：</h4>
							<p>有短期资金周转需求的个人；有中长期资金需求的成长型小微企业</p>
						</li>
						<li>
							<h4>申请条件：</h4>
							<p>年龄在18-60周岁的中国大陆居民，能提供个人身份证明、企业资料、财产证明等。</p>
						</li>
						<li>
							<h4>额度范围：</h4>
							<p>5万-100万元人民币</p>
						</li>
						<li class="clearfix">
							<div class="left">
								<h4>借款周期：</h4>
								<p>1个月-24个月</p>
							</div>
							<div class="app-code right">
								<img src="./img/app-code.png"/>
								<p>扫码下载APP</p>
							</div>
						</li>
					</ul>
				</div>
				<div class="borrow-apply-r left">
					<form action="/yingpu/app/loan/add/pc/json" method="post" id="loanform">
						<p>您的姓名</p>
						<input type="text" name="name" id="" value="" />
						<p>您的手机号</p>
						<input type="text" name="phonenumber" id="" value="" />
						<p>您所在的城市</p>
						<input type="text" name="area" id="" value="" />
						<p>图形验证码</p>
						<input type="text" name="code" id="" value="" style="width: 136px;float: left;" />
						<img src="/yingpu/getCaptcha" id="yanzhengma" onclick="realodImg();" style="width: 120px; margin-left: 17px;height: 40px;"/>						
						<input type="button" value="立即申请" onclick="tijiao();"/>
						<br/>
						<span class="tip">
							<a>资料发送至邮箱：jiekuan@yingpuwealth.com</a> 
							<a  class="borrow-biao" href="downloadborrow">下载<span style="color: #FF7F01;text-decoration: underline;">《营普金服借款人申请表》</span></a>
						</span>
					</form>
				</div>
				<div class="borrow-tip" id="borrpwTip">
					<p><span onclick="$('#borrpwTip').hide();CloseDiv('borrowApply','fade')"></span></p>
					<p>温馨提示</p>
					<p>已收到您的借款申请，营普金服工作人员将会在3个工作日内与您联系。</p>
				</div>
			</div>
		</div>
		
		<!--客服悬浮条-->
		<iframe src="xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<!--底部导航-->
		<iframe src="./footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		
		<script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">



			//弹出隐藏层
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

			//刷新验证码
			function realodImg(){
				$('#yanzhengma').attr('src','/yingpu/getCaptcha?data='+new Date().getTime());
			}


			function tijiao(){
				var name=$('input[name="name"]').val();
				var phonenumber=$('input[name="phonenumber"]').val();
				var area=$('input[name="area"]').val();
				var code=$('input[name="code"]').val();
				console.log(name)
                console.log(phonenumber)
                console.log(area)
                console.log(code)
				if(name==null||name==''){
					
					layer.alert('请填写姓名',{offset:['40%','50%']});
					return false;
				}
				if(phonenumber==null||phonenumber==''){
					layer.alert('请填写电话号码',{offset:['40%','50%']});
					return false;
				}
				if(area==null||area==''){
					layer.alert('请填写所在城市',{offset:['40%','50%']});
					return false;
				}
				if(code==null||code==''){
					layer.alert('请填写验证码',{offset:['40%','50%']});
					return false;
				}
				$.post('/yingpu/app/loan/add/pc/json',{'name':name,'phonenumber':phonenumber,'area':area,'code':code},function(data){
						if(data.status=='ok'){
							$('#borrpwTip').show();
                            location.reload()
						}else{
//						    console.log(data.message)
							window.alert(data.message);
						}

				});
			}
		</script>
		
		

		
	</body>
</html>
