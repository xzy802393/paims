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
		<link rel="stylesheet" type="text/css" href="css/mycard.css"/>
		

		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head.html" name="head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				<div class="account-nav left">
					<!--<div class="account-nav-name">
						<div class="account-pic">
							<img src="../img/account/account-pic.png"/>
						</div>
						<p class="name">赵丹红</p>
					</div>-->
					<iframe src="account_sidebar.html" width="100%" height="722" scrolling="no"  style="border:0px;"></iframe>
				</div>
				<!--右边主体部分-->
				
				<!--邀请奖励-->
				<div class="mycard left" >

					<div class="zhangdan" style="margin-top: -108px;">
						<%--<div class="tankuang">--%>
							<%--<img src="../zhang-dan/images/zhangdantankuang.png" alt="弹框" class="chakan">--%>
							<%--<img src="../zhang-dan/images/guanbi.png" alt="关闭" class="close">--%>
						<%--</div>--%>
						<div class="lianjie">
							<iframe src="../zhang-dan/index.html?userId=${pcuser.id}" class="zhangdanlianjie" scrolling="no"  width="375px" height="667px" style="border:0px;margin:137px 350px 0px;"></iframe>
							<img src="../zhang-dan/images/guanbi.png" alt="关闭" class="close">
						</div>

					</div>

				</div>
			</div>
		</div>
		
		
		<!--绑定银行卡-->
		<!--绑定银行卡-->
		<iframe src="bind_bankcard.jsp" id="bindBank" width="100%" style="position: absolute;top: 0;left: 0;display: none;z-index: 10;" scrolling="no"></iframe>
		
		<!--客服悬浮条-->
		<!--客服悬浮条-->
		<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
			
		<!--底部导航-->
		
		<iframe src="../footer.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/Ecalendar.jquery.min.js" type="text/javascript"></script>
	<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">

        function isLogin(){
            return !!'${pcuser.phone}';
        }
        $(function(){
            if(!isLogin()){
                $('.zhangdan').css('display','none')
            }else{
                $('.zhangdan').css('display','block');
            }
        });
        var h = ($(window).height() )/2 ;

        $('.chakan').css("padding-top",h-284);
        $('.zhangdanlianjie').css("margin-top",h-332);
        // 关闭弹框
        $('.close').on('click',function(){
            $('.zhangdan').css('display','none');
        });

       /* // 查看账单
        $('.chakan').on('click',function(){
            $('.tankuang').css('display','none');
            $('.lianjie').css('display','block');
        });*/


		/*function fmtDate(obj){
		    var date =  new Date(obj);
		    var y = 1900+date.getYear();
		    var m = "0"+(date.getMonth()+1);
		    var d = "0"+date.getDate();
		    return y+"-"+m.substring(m.length-2,m.length)+"-"+d.substring(d.length-2,d.length);
		}

		function changeBankCard() {
			window.open('changeBankCard');
		}

		function showView(profile) {
			if (profile.isIdCard == '是') {
				$('.mycard-manage:eq(1)').hide();
				$('.mycard-manage:eq(0)').show();

				$('#bank-name').html(profile.bankName);
				$('#add-time').html(fmtDate(profile.cardTime));
			//	console.log(profile.bankNum)
				$('#card-last-num').html(profile.bankNum && profile.bankNum.substr(-4));
			}
		}


		function loadProfile() {
            useLoadingShade();
			loadUserProfile().done(function(data) {
			    cancelLoadingShade();
				showView(data);
			});
		}


		$(function(){
			$("#bindBank").height($(document).height());

			if (gIsProfileLoaded) {
				showView(gUserProfile);
			}
			else{
				loadProfile();
			}
		});
		*/
		
	</script>
	
	</body>
</html>
