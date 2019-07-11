<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>-->
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
		<link rel="stylesheet" type="text/css" href="css/merry_luckydraw.css"/>
		<link rel="stylesheet" type="text/css" href="../css/animate.css"/>
		<link rel="stylesheet" type="text/css" href="../css/idangerous.swiper.css"/>
		
		
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head.html" class="iframe-head" id="head" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>	
		
		<!--主体-->
		<div class="merry">			
			<div class="merry-head">
				<div class="head-ball">
					<span class="ball-f"></span>
					<span class="ball-s"></span>
					<span class="ball-t"></span>
				</div>
				<div class="head-bg"></div>
				<div class="head-star">
					<span class="star-a"></span>
					<span class="star-b"></span>
					<span class="star-c"></span>
					<span class="star-d"></span>
					<span class="star-e"></span>
					<span class="star-f"></span>
					<span class="star-g"></span>
				</div>
				<div class="head-tit clearfix">
					<div class="tit-l left">
						<img src="../img/active-dec/act-tit-l.png"/>
					</div>
					<div class="tit-c left">
						<img class="animated bounce" src="../img/active-dec/act-tit-c.png"/>
					</div>
					<div class="tit-r right">
						<img src="../img/active-dec/act-tit-r.png"/>
						<span class="old-man"></span>
					</div>
				</div>
			</div>
			<div class="merry-content">
				<div class="content-tit">
					<img src="../img/active-dec/tit-2.png"/>
					<div class="act-text">
						<p class="act-tip">尊敬的用户<span class="phone">${pcuser.phone}</span>，您当前的剩余抽奖次数为 <span class="num">${ not empty pcuser.prizenum ? pcuser.prizenum : 0 }</span> 次，点击下方圣诞树上的礼盒即可参与抽奖！</p>
						<h6>活动说明：</h6>
						<dl>
							<dt>1、</dt>
							<dd>活动时间：2017年12月1日-2017年12月31日。</dd>
						</dl>
						<dl>
							<dt>2、</dt>
							<dd>用户每累计投资10000元，即可获取1次打开神秘礼物的机会，神秘礼物为随机投放。获奖记录可在我的账户我的奖励中查看。</dd>
						</dl>
						<dl>
							<dt>3、</dt>
							<dd>用户获奖后，平台客服会在3个工作日内与您取得联系，安排后续发货兑奖，请您保持通讯畅通。</dd>
						</dl>
						<dl>
							<dt>4、</dt>
							<dd>所有礼物，不支持现金折现。实物奖品均由第三方发货，营普金服不负责售后质量问题。如用户提供的收货地址、收货人联系方式错误，损失由用户自行承担。</dd>
						</dl>
						<dl>
							<dt>5、</dt>
							<dd>请在活动结束前，及时使用您的抽奖机会。</dd>
						</dl>
						
					</div>
				</div>
				<div class="jiange-bg"></div>
				<div class="merry-tree" id="bgSnow">
					
					<div class="round">
						<span class="round-a"></span>
					</div>
					<div class="tree">
						<img src="../img/active-dec/tree.png"/>
						<div class="gift" id="gift">
							<a href="javascript:void(0)">
								<span class="gift-a">
									<div class="tip">
										<div class="quan"></div>
										<div class="finger"></div>
									</div>
								</span>
							</a>
							<a href="javascript:void(0)">
								<span class="gift-b">
									<div class="tip">
										<div class="quan"></div>
										<div class="finger"></div>
									</div>
								</span>
							</a>
							<a href="javascript:void(0)">
								<span class="gift-c">
									<div class="tip">
										<div class="quan"></div>
										<div class="finger"></div>
									</div>
								</span>
							</a>
							<a href="javascript:void(0)">
								<span class="gift-d">
									<div class="tip">
										<div class="quan"></div>
										<div class="finger"></div>
									</div>
								</span>
							</a>
							<a href="javascript:void(0)">
								<span class="gift-e">
									<div class="tip">
										<div class="quan"></div>
										<div class="finger"></div>
									</div>
								</span>
							</a>
							<a href="javascript:void(0)">
								<span class="gift-f">
									<div class="tip">
										<div class="quan"></div>
										<div class="finger"></div>
									</div>
								</span>
							</a>
							<a href="javascript:void(0)">
								<span class="gift-g">
									<div class="tip">
										<div class="quan"></div>
										<div class="finger"></div>
									</div>
								</span>
							</a>
							<a href="javascript:void(0)">
								<span class="gift-h">
									<div class="tip">
										<div class="quan"></div>
										<div class="finger"></div>
									</div>
								</span>
							</a>
							
						</div>
					</div>
					
					<div class="record" id="record">
						<!-- <marquee behavior="scroll"  scrollamount="3"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="1"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="5"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="3"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="1"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="5"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="4"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="5"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="3"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="1"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="5"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="4"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="5"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="3"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="1"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="5"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
						<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee> -->
					</div>
					
				</div>
				<div class="tip-bg">
					<h3 class="left">奖品展示</h3>
					<div class="device left">
					  	<a class="arrow-left" href="#"></a>
					    <a class="arrow-right" href="#"></a>
					  	<div class="swiper-container">
						    <div class="swiper-wrapper" id="prizelist">

						    </div> 
					  	</div>
					  </div>
				</div>
			</div>
			<div class="bottom-bg"></div>
			<div class="bg-star">
				<div class="left-star">
					<span class="star-a"></span>
					<span class="star-b"></span>
					<span class="star-c"></span>
					<span class="star-d"></span>
					<span class="star-e"></span>
					<span class="star-f"></span>
					<span class="star-g"></span>
				</div>
				<div class="right-star">
					<span class="star-a"></span>
					<span class="star-b"></span>
					<span class="star-c"></span>
					<span class="star-d"></span>
					<span class="star-e"></span>
					<span class="star-f"></span>
					<span class="star-g"></span>
				</div>
			</div>
		</div>
		
		<div id="fade" class="black-overlay"></div>
		<div class="rewards animated tada" id="rewards">
			<div class="rewards-content">
				<div class="close" onclick="$('#fade').hide();$('#rewards').hide();"></div>
				<div class="rewards-box clearfix">
					<!--<div class="text left">
						<p>恭喜您</p>
						<p>抽到<span>王者荣耀孙悟空限定皮肤</span></p>
						<p>获奖后，平台客服会在3个工作日内与您取得联系，安排后续发货兑奖，请您保持通讯畅通。</p>
					</div>
					<div class="pic left">
						<img src="../img/active-dec/zhizb.png"/>
					</div>-->
				</div>
			</div>
		</div>
		
		<!--客服悬浮条-->
		<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		
		<!--底部导航-->
		<iframe src="../footer.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/snow.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/idangerous.swiper.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../.././layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		<script src="../js/utils.js"></script>
		
		<script type="text/javascript">
		
			function getEncodedCurrentURL() {
				return encodeURIComponent(location.href);
			}
		
			function showLoginPrompt() {
	 			layer.alert('对不起，登陆后才可以抽奖，请先登录!', { btn : ['登录', '取消'] }, function() {
	 				location.href = '../login?backUrl=' + getEncodedCurrentURL();
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
				
				
			  $("#gift .tip").eq(0).show();
			    var i=0;
			    function fad(){
				    var m = i%8;
				    var n = (i+2)%8;
				    $("#gift .tip").eq(m).fadeOut(1000);
				    $("#gift .tip").eq(n).fadeIn(1000);
				    i++;
				  };
			  int = setInterval(fad,3000);
			  
			  //
			  
			 $("#bgSnow").snowfall({image :"../img/active-dec/snow.png", minSize: 10, maxSize:45,flakeCount : 50, maxSpeed : 1});
			 
			 
			 //弹出奖品层
			 $("#fade").height($(document).height());
			 
			
			//加载奖品列表
			$.post('/yingpu/pc/prize/list/json',{},function(data){
				console.log(data);
				$.each(data.data, function(i,o) {
					var html='';
					html+='<div class="swiper-slide">';
					html+='<div class="title">';
					html+='<img src="'+o.prizeicon+'"/>';
					html+='<div class="money">';
					
					if (o.price == '限定') {
						html+='<p>'+o.price+'</p>';
					}
					else {
						html+='<p>价值'+o.price+'元</p>';
					}

					html+='</div></div></div>';
					if (o.prizename.indexOf('谢谢参与') != -1) {
						return;
					}
					
					mySwiper.appendSlide(html);
				});
				/* $('#prizelist').html(html); */
			});
			
			
			//加载最近抽奖记录
			$.post('/yingpu/pc/prize/randprizeHis/list/json',{pageIndex : 1},function(data){
				console.log(data);
				var html='';
				$.each(data.data, function(i,o) {
					html+='<marquee behavior="scroll"  scrollamount="'+Math.floor(Math.random()*10 + 5)+'"><p>用户'+o.phone.substring(0,3)+'****'+o.phone.substring(7,11)+'打开圣诞礼物，获得'+o.prizename+'</p></marquee>';
				});
				$('#record').html(html);
				
				
			});


			//抽奖动作
			$('.jiangpin').click(function(){
			 	
			 });
			
			
			function getEncodedCurrentURL() {
				return encodeURIComponent(location.href);
			}


			 //
			 $("#gift a").each(function(){
			 	$(this).on('click',function(){
			 		if (!isLogin()) {
						showLoginPrompt();
						return;
					}
			 		
			 		layer.load(2);
			 		$.post('/yingpu/pc/prize/draw/json',{},function(data){
			 			layer.closeAll();
			 				data.prize = data.data;
			 				if(data.status=='ok'){
			 					$("#fade").show();
			 					$("#rewards").show();
			 					var html = '';

			 					if (data.prize.prizename.indexOf('谢谢参与') == -1) {
									html+='<div class="text left">';
									html+='	<p>恭喜您</p>';
									html+='<p>抽到<span>'+data.prize.prizename +'</span></p>';
									html+='<p>获奖后，平台客服会在3个工作日内与您取得联系，安排后续发货兑奖，请您保持通讯畅通。</p></div>';
									html+='	<div class="pic left">';
									html+='<img src="'+data.prize.prizeimg+'"/>	</div>';
			 					} else {
			 						html+='<div class="text left" style="margin-top: 17px;">';
									html+='	<p>谢谢参与！</p>';
									html+='<p style="font-size: 14px;"><br/>豆亲，您离神秘大礼就差一步了哦！加油加油</p>';
									html+='<!--<p>获奖后，平台客服会在3个工作日内与您取得联系，安排后续发货兑奖，请您保持通讯畅通。</p>--></div>';
									html+='	<div class="pic left">';
									html+='<img src="'+data.prize.prizeimg+'"/>	</div>';
			 					}	
								$('.rewards-box').html(html);
			 				} else {
			 					if (data.status == 'login') {
		 							showLoginPrompt();
			 					}
			 					else {
			 						layer.alert(data.message);
			 					}
			 				}

			 				$('.num').html($('.num').html() * 1 > 0 ? $('.num').html() * 1 - 1 : 0);
			 		});
			 		/*$("#fade").show();
			 		$("#rewards").show();*/
			 	})
			 });
			 
			 var mySwiper = new Swiper('.swiper-container',{
		        paginationClickable: true,
		        spaceBetween: 0,
	         	slidesPerView: 5,
	      		loop: true,
	      		autoplay: 3000,
	      		autoplayDisableOnInteraction: false
		    });
			 
			
			 
				  
				  
				  $('.arrow-left').on('click', function(e){
				    e.preventDefault()
				    mySwiper.swipePrev()
				  })
				  $('.arrow-right').on('click', function(e){
				    e.preventDefault()
				    mySwiper.swipeNext()
				  })
			 

			});
			
			$(function(){
				$(window).scroll(function(){
					$('.iframe-head').show();
				});
			});

		</script>
		
		
	
				
	</body>
</html>
