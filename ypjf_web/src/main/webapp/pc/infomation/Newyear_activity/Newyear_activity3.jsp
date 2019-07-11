<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220" />
		<title>营普金服—参股商业银行的互联网金融服务平台</title>
    	<!--<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">-->
		<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
		<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
		<link rel="shortcut icon" href="../../img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="../../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../../css/common.css"/>
		<!--<link rel="stylesheet" type="text/css" href="../infomation/css/Nov_activity.css"/>-->
		
		<link rel="stylesheet" type="text/css" href="../../css/animate.css"/>
		<link rel="stylesheet" type="text/css" href="css/styleCJ.css"/>
		<link rel="stylesheet" type="text/css" href="css/Newyear_activity3.css"/>
		<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		
		<style>
			.cjBtn { color: #fff; }
		</style>
	</head>
	<body>

		<!--顶部-->
		
		<iframe src="../../head.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>	
		
		<!--主体-->
		
		<div class="activity-page">
			<!--顶部-->
			<div class="head-banner">
				<div class="center">
					<img class="animated bounceInDown" src="img/img3/fanpazi.png"/>
				</div>
			</div>
			
			<!--<script>
				var img = new Image();
				img.src = "img/img2/images/banner-bg-2_01.jpg";
				img.onload = function() {
					$(".head-banner").css('background','url('+this.src+') no-repeat center'); 
				}
			</script>-->
			
			<!--云彩-->
			<div class="baiyun">
				<div id="" class="yun yun1" >
					<img src="img/img3/yuncai.png"/>
				</div>
				<div id="" class="yun yun2">
					<img src="img/img3/yuncai.png"/>
				</div>
				<div id="" class="yun yun3">
					<img src="img/img3/yuncai.png"/>
				</div>
				<div id="" class="yun yun4">
					<img src="img/img3/yuncai.png"/>
				</div>
			</div>
			
			
			
			
			
			<div class="choujiang">
				<div class="tit">
					<img src="img/img3/title.png"/>
				</div>
				
				<div class="choujiang-box shanDeng" id="deng">
					<div id="luck"><!-- luck -->
						<table>
							<tr>
								<td class="luck-unit luck-unit-0">
									<div class="artGroup slide">
									  <div class="artwork"> 
									  	<img class="weizi" src="img/img3/fan (2).png">
									    <div class="detail">
									      <img class="jiangpin" src="img/img3/p1.png"/>
									    </div>
									  </div>
									</div>  
								</td>
								<td class="luck-unit luck-unit-1">
									<div class="artGroup slide">
									  <div class="artwork"> 
									  	<img class="weizi" src="img/img3/pai (2).png">
									    <div class="detail">
									      <img class="jiangpin" src="img/img3/p2.png"/>
									    </div>
									  </div>
									</div> 
								</td>
								<td class="luck-unit luck-unit-2">
									<div class="artGroup slide">
									  <div class="artwork"> 
									  	<img class="weizi" src="img/img3/zi (2).png">
									    <div class="detail">
									      <img class="jiangpin" src="img/img3/p3.png"/>
									    </div>
									  </div>
									</div>
								</td>
								
							</tr>
							<tr>
								<td class="luck-unit luck-unit-7">
									<div class="artGroup slide">
									  <div class="artwork"> 
									  	<img class="weizi" src="img/img3/lin (2).png">
									    <div class="detail">
									      <img class="jiangpin" src="img/img3/p4.png"/>
									    </div>
									  </div>
									</div>
								</td>
								
								<!--翻牌子按钮-->
								<td rowspan="1" colspan="1" class="cjBtn" id="btn" class="ksfp"></td>
								
								
								<td class="luck-unit luck-unit-3">
									<div class="artGroup slide">
									  <div class="artwork"> 
									  	<img class="weizi" src="img/img3/xing (2).png">
									    <div class="detail">
									      <img class="jiangpin" src="img/img3/p5.png"/>
									    </div>
									  </div>
									</div>
								</td>
							</tr>
							
							<tr>
								<td class="luck-unit luck-unit-6">
									<div class="artGroup slide">
									  <div class="artwork"> 
									  	<img class="weizi" src="img/img3/hua (2).png">
									    <div class="detail">
									      <img class="jiangpin" src="img/img3/p6.png"/>
									    </div>
									  </div>
									</div>
								</td>
								<td class="luck-unit luck-unit-5">
									<div class="artGroup slide">
									  <div class="artwork"> 
									  	<img class="weizi" src="img/img3/wei (2).png">
									    <div class="detail">
									      <img class="jiangpin" src="img/img3/p7.png"/>
									    </div>
									  </div>
									</div>
								</td>
								<td class="luck-unit luck-unit-4">
									<div class="artGroup slide">
									  <div class="artwork"> 
									  	<img class="weizi" src="img/img3/meta10 (2).png">
									    <div class="detail">
									      <img class="jiangpin" src="img/img3/p8.png"/>
									    </div>
									  </div>
									</div>
								</td>
								
							</tr>
						</table>
					</div><!-- luckEnd -->
				</div>
				
				<div class="tip">
					<p>请点击您抽到的牌子，查看奖品！</p>
				</div>
				<div class="prize" id="" style="position: relative;">
					
					<p>您当前的剩余抽奖次数为<span class="num"> ${not empty pcuser.prizenum ? pcuser.prizenum : 0 }</span>次。</p>
				</div>
				<div class="act-des">
					<img src="img/img3/des.png" alt="" />
				</div>
				
				
			</div>
			<div class="bottom-banner">
				<div class="invest">
					<a class="invest-btn" href="../../project/list"><img src="img/img3/invest.png"/></a>
				</div>
			</div>
		</div>	
		<!--客服悬浮条-->
		<!--<iframe src="../../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe> 
		<iframe src="../../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>-->
		<script src="../../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../js/utils.js" type="text/javascript" charset="utf-8"></script>

		<!--底部导航-->
		<iframe src="../../footer.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../.././layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/modernizr.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/jquery.easing.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			useLoadingShade();
		 	function getEncodedCurrentURL() {
				return encodeURIComponent(location.href);
			}
		
			function showLoginPrompt() {
	 			layer.alert('对不起，登陆后才可以抽奖，请先登录!', { btn : ['登录', '取消'] }, function() {
	 				location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
	 			}, function() {
	 				
	 			});
			}
			
			function isLogin() {
				return !!'${pcuser.phone}';
			}
			
			$(document).ready(function(){
				if (!isLogin()) {
					showLoginPrompt();
				}
				
			
			
			var luck={
			    index:-1,    //当前转动到哪个位置，起点位置
			    count:0,    //总共有多少个位置
			    timer:0,    //setTimeout的ID，用clearTimeout清除
			    speed:20,    //初始转动速度
			    times:0,    //转动次数
			    cycle:50,    //转动基本次数：即至少需要转动多少次再进入抽奖环节
			    prize:-1,    //中奖位置
			    init:function(id){
			        if ($("#"+id).find(".luck-unit").length>0) {
			            $luck = $("#"+id);
			            $units = $luck.find(".luck-unit");
			            this.obj = $luck;
			            this.count = $units.length;
			            $luck.find(".luck-unit-"+this.index).addClass("active");
			        };
			    },
			    roll:function(){
			        var index = this.index;
			        var count = this.count;
			        var luck = this.obj;
			        $(luck).find(".luck-unit-"+index).removeClass("active");
			        index += 1;
			        if (index>count-1) {
			            index = 0;
			        };
			        $(luck).find(".luck-unit-"+index).addClass("active");
			        this.index=index;
			        return false;
			    },
			    stop:function(index){
			        this.prize=index;			       
			        return false;
			    }
			};
			
			function roll(){
			    luck.times += 1;
			    luck.roll();//转动过程调用的是luck的roll方法，这里是第一次调用初始化
			    if (luck.times > luck.cycle+10 && luck.prize==luck.index) {
			        clearTimeout(luck.timer);
			        luck.prize=-1;
			        luck.times=0;
			        click=false;
			    }else{
			        if (luck.times<luck.cycle) {
			            luck.speed -= 10;
			        }else if(luck.times==luck.cycle) {
			            var index = Math.random()*(luck.count)|0;
			            luck.prize = index;        
			        }else{
			            if (luck.times > luck.cycle+10 && ((luck.prize==0 && luck.index==7) || luck.prize==luck.index+1)) {
			                luck.speed += 110;
			            }else{
			                luck.speed += 20;
			            }
			        }
			        if (luck.speed<40) {
			            luck.speed=40;
			        };
			        //console.log(luck.times+'^^^^^^'+luck.speed+'^^^^^^^'+luck.prize);
			        luck.timer = setTimeout(roll,luck.speed);//循环调用
			    }
			    return false;
			}
			
			var click=false;
			gPrizes = {};
			window.onload=function(){
			
				$.post('/yingpu/pc/prize/list/json',{"type":"3yue"},function(data){
					gPrizes = data.data;
				   	console.log(data.data);
			   		data=data.data;
			   		$.each(data, function(i,o) {
			   			$('.luck-unit').eq(i).attr('prize-name',o.prizename).find('.jiangpin').attr('src',o.prizeimg);
			   		});
			    })
			
			
			    luck.init('luck');
			    
			    //判断是否有3d
			    
				$('.artGroup').removeClass('slide').addClass('flip');
			    
			 	
			    	$("#luck #btn").click(function(){
			    		if (!isLogin()) {
							showLoginPrompt();
							return;
						}
			    		if(new Date().getTime() < new Date('2018-03-01').getTime()){
			    			layer.alert('抽奖活动在3月1日开始');
			    			return false;
			    		}
			    		
			    		if(new Date().getTime() >= new Date('2018-04-01').getTime()){
			    			layer.alert('3月抽奖活动已结束，请去4月活动抽奖页面参与抽奖，谢谢！');
			    			return false;
			    		}
			    		 var Num = $('span[class="num"]').html();
			    		if(Num<=0){
			    			layer.alert('您当前的抽奖次数不足');
			    			return ;
			    		}
				        if (click) {//click控制一次抽奖过程中不能重复点击抽奖按钮，后面的点击不响应
				            return false;
				        }else{
				            luck.speed=100;
				            roll();    //转圈过程不响应click事件，会将click置为false
				            click=true; //一次抽奖完成后，设置click为true，可继续抽奖
				            return false;
				        }
					    
				    });
			   
				  
			    $('#luck').delegate('.luck-unit.active','click',function(e){
			    	var evt = e || event;
			    	var div = $('.luck-unit.active');
			    	var Num = $('.prize .num').html();
			    	if(Num>0){
			    		Num = Num-1;
			    	}
			        if($('#luck .luck-unit .artGroup.flip').find('.artwork').hasClass('theFlip')){
			        	return;
			        }else{
				    	console.log("点击成功");
						$.post('/yingpu/pc/prize/draw/json',{"type":"3yue"},function(data){
							if(data.status=='no'){
								layer.alert(data.message);
								return false;
							}else{
								var curImg = div.find('img.jiangpin');
								var curImgSrc = curImg.attr('src');
								var curPrizeName = div.attr('prize-name');
								
								curImg.attr('src', data.data.prizeimg);
								$('.luck-unit[prize-name="' + data.data.prizename + '"]').attr('prize-name', curPrizeName).find('img.jiangpin').attr('src', curImgSrc);
								div.attr('prize-name', data.data.prizename);
								
								$('.luck-unit.active').find('.detail img').attr('src',data.data.prizeimg);
								$('.prize p').html('恭喜您抽中<span style="color:#FF0000">'+data.data.prizename+'</span> ， 您当前的剩余抽奖次数为<span class="num">'+Num+'</span>次。');
								$('#luck .luck-unit .artGroup.flip').find('.artwork').find('img.jiangpin').hide();
								var timer = setTimeout(function(){
									$('#luck .luck-unit .artGroup.flip').find('.artwork').find('img.jiangpin').show().end().each(function(i, e) {
										$(e).addClass('theFlip');
									});
								},0);
							}
					 	});
						
					}
			    });
			  
			    $("#luck #btn").click(function(){
		    	    if($('#luck .luck-unit .artGroup.flip').find('.artwork').hasClass('theFlip')){
		    	    	$('#luck .luck-unit .artGroup.flip').find('.artwork').removeClass('theFlip');
		    	    }else{
		    	    	return;
		    	    }

			    });
			};
		 });	
			//点击奖品翻转
		
			

//		    $(function () {
//		    	
//		    	
//				if ( $('html').hasClass('csstransforms3d') ) {
//				  $('.artGroup').removeClass('slide').addClass('flip');
//				  $('.artGroup.flip').on('mouseenter',
//				    function () {
//				      $(this).find('.artwork').addClass('theFlip');
//				    });
//				  $('.artGroup.flip').on('mouseleave',
//				    function () {
//				      $(this).find('.artwork').removeClass('theFlip');
//				    });
//				} else {
//				  $('.artGroup').on('mouseenter',
//				    function () {
//				      $(this).find('.detail').stop().animate({bottom:0}, 500, 'easeOutCubic');
//				    });
//				  $('.artGroup').on('mouseleave',
//				    function () {
//				      $(this).find('.detail').stop().animate({bottom: ($(this).height() + -1) }, 500, 'easeOutCubic');
//				    });
//				}
//			}); 
		$(function(){
			$(window).scroll(function(){
				$('.iframe-head').show();
			});
		});
		</script>
	</body>
</html>
