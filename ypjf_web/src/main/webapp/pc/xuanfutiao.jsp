<!--<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
<link rel="stylesheet" type="text/css" href="css/reset.css"/>
<link rel="stylesheet" type="text/css" href="css/common.css"/>
<link rel="stylesheet" type="text/css" href="css/xuanfutiao.css"/>
<style type="text/css">
	#doyoo_panel{
		display: none;
	}
</style>
</head>
<body>
	<div class="xuanfutiao">
		<ul>
			<li>
				<div class="now"><img src="img/xf-qq.png"/></div>
				<div class="tip">QQ群:417778462</div>
				<!--<div class="tip">QQ群:417778462<img style="margin-left: 0px;" src="img/xf-qq.png"/></div>-->
			</li>
			<li>
				<div class="now"><img src="img/xf-kf.png"/></div>
				<div class="tip"><a style="color: #fff;" id="kefu"  onclick="doyoo.util.openChat('g=10075903');return false;">在线客服<img style="margin-left: 47px;" src="img/xf-kf.png"/></a></div>
			</li>
			<li>
				<div class="now-app"><img style="margin-top: 6px;" src="img/xf-app.png"/></div>
				<!--<div class="tip"><a style="color: #fff;" onclick="window.parent.location='html/appload.jsp'">APP客户端<img style="margin-left: 32px;" src="img/xf-app.png"/></a></div>-->
				<div class="app"><img src="img/app-code.png"/></div>
			</li>
			<li>
				<div class="now"><img style="margin-top: 8px;" src="img/xf-jsq.png"/></div>
				<div class="tip" id="jisuanqi">计算器<img style="margin-left: 60px;" src="img/xf-jsq.png"/></div>
			</li>
			<li>
				<div class="go-top" id="goTop" onclick="$(window).scrollTop(0);" style="display: none;"><img src="img/xf-go-top.png"/></div>
			</li>
		</ul>
	</div>
	
</body>
<script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<!--<script src="js/layer.js" type="text/javascript" charset="utf-8"></script>-->
<script type="text/javascript" charset="utf-8" src="http://lead.soperson.com/20003063/10087323.js"></script>
<script src="js/utils.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
		
		
		
		  $(function(){
				var timer = setInterval(function(){
					$('#doyoo_panel').css({"top":"-180px","display":"none"});
					$('#talk99_message').hide();
					$("#doyoo_f_chat").css("cssText", "display:none !important;");
				},0);
				setTimeout(function(){
					clearInterval(timer);
				},5000);
				
			});	
		
			$(".now").mouseenter(function(){

					console.log('啊');
					$(this).hide();
					$(this).parent().find(".tip").show();
					

			});
			$('.tip').mouseleave(function(){
//				$('.tip').hide();
//				$(".now").show();
				$(this).hide();
				$(this).parent().find(".now").show();
			});
		
		
		
			$(".now-app").hover(function(){
				$('.tip').hide();
				$(".now").show();
				$(this).css('background','#FF7F01');
				$(this).parent().find(".app").show();
				
			},function(){
				$(this).css('background','#FF860E');
				$(this).parent().find(".app").hide();
			});
	
			

	
		
			 $(window.parent).scroll(function(){
				if($(window.parent).scrollTop()>0){
					$("#goTop").css('display','block');
				}else{
					$("#goTop").css('display','none');
				}
			});
			
			
			
//			
//			$(function(){
//				var timer = setInterval(function(){
//					$('#doyoo_panel').hide();
//					$('#talk99_message').hide();
//					$("#doyoo_f_chat").css("cssText", "display:none !important;");
//				},0);
//				setTimeout(function(){
//					clearInterval(timer);
//				},5000);
//				
//			});	
			
//		$("#jisuanqi").click(function(){
//			$(document).parent().find(".iframe-jisuanqi").show();
//		});
			
		$(function(){
			$("#fade").height($(document).parent().height());
		});

	});
	

	
	
 </script>


</html>