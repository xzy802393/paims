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

</head>
<body>
	
	
	<!--计算器-->
	<div id="fade" class="black-overlay" ></div>
	<div class="counter" id="counter" >
		<div class="counter-tit">
			<p>计算收益</p>
			<span class="close" onclick="$('#counter').hide();$('#fade').hide();"></span>
		</div>
		<div class="counter-form">
			<form id="" action="" method="post" onsubmit="return false;">

				<label><span>年化利率</span>
					<input name="yearRate" type="text" value="" /> %
				</label>
				<label><span>还款方式</span>
					<select name="repayType">
						<option value="0">按月付息，到期还本</option>
						<option value="1">一次性还本付息</option>
					</select>
				</label>
				<label><span>投资本金</span>
					<input name="investAmount" type="text" value=""/></label>
				<label><span>投资期限</span>
					<input name="deadline" type="text" value="" /> 月
				</label>
				<input type="submit" class="counter-btn" value="计算收益"/>
			</form>
			<div class="result">
				<p>到期收益：<span>0.00</span>元</p>
				<p>返还本金：<span>0.00</span>元</p>
				<p>本息合计：<span>0.00</span>元</p>
			</div>
		</div>
	</div>	
</body>
<script src="./js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" charset="utf-8" src="http://lead.soperson.com/20003063/10087323.js"></script>
<script src="js/utils.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
		
			$(".now").mouseenter(function(){
					
				if($(this).next('.tip').css("display")=='none'){
					console.log('啊');
					$(this).hide();
					$(this).parent().find(".tip").show();
				}
			});
			$('.tip').mouseout(function(){
				$('.tip').hide();
				$(".now").show();
			});
		/*	$(".now").mouseout(function(e){
				console.log($(event.target).parents('.now').size());
					if($(event.target).parents('.now').size()>0){
							console.log($(event.target).parents('.now').size());
							$(".now").show();
							$(this).parent().find(".tip").hide();
					}
				
			});*/
			$(".now-app").hover(function(){
				$(this).css('background','#FF7F01');
				$(this).parent().find(".app").show();
				
			},function(){
				$(this).css('background','#b5b5b5');
				$(this).parent().find(".app").hide();
			});
			
			$('.counter-btn').click(function() {
				
			});
			

	
		
			 $(window.parent).scroll(function(){
				if($(window.parent).scrollTop()>0){
					$("#goTop").css('display','block');
				}else{
					$("#goTop").css('display','none');
				}
			});
			
			
			
			
			$(function(){
				var timer = setInterval(function(){
					$('#doyoo_panel').hide();
					$('#talk99_message').hide();
				},10);
				setTimeout(function(){
					clearInterval(timer);
				},5000);
				
			});	
			
//		$("#jisuanqi").click(function(){
//			$("#fade").show();
//			$("document iframe").css({
//				'width':$('iframe').parent().width(),
//				'height':$('iframe').parent().height()
//			});
//			$("#counter").show();
//		});
			
		$(function(){
//			$("#fade").height($(document).parent().height());
			
			$("#counter").css('top',$(window).height()+"400px");
//			$("body").css({"overflow":"hidden","height":"100%"})
		});

	});
	

	
	
 </script>


</html>