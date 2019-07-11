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
    	<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
		<meta name="Description" content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
		<meta name="Keywords" content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
		<link rel="shortcut icon" href="../../img/logo1.icon"/>
		<link rel="stylesheet" type="text/css" href="../../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../../css/common.css"/>
		<!--<link rel="stylesheet" type="text/css" href="../infomation/css/Nov_activity.css"/>-->
		
		<link rel="stylesheet" type="text/css" href="../../css/animate.css"/>
		<link rel="stylesheet" type="text/css" href="css/styleCJ.css"/>
		<link rel="stylesheet" type="text/css" href="css/Newyear_activity2.css"/>
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
					<h3><img src="img/img2/xinchun.png" alt="" /></h3>
					<div class="red animated rollIn">
						<p><span>营</span><span>普</span><span>大</span><span>转</span><span>盘</span></p>
						<p><span>中</span><span>奖</span><span>率</span><span>百</span><span>分</span><span>百</span></p>
					</div>
					<p class="time">活动时间：2018年1月27日-2018年2月28日</p>
				</div>
			</div>
			
			<script>
				var img = new Image();
				img.src = "img/img2/images/banner-bg-2_01.jpg";
				img.onload = function() {
					$(".head-banner").css('background','url('+this.src+') no-repeat center'); 
				}
			</script>
			
			<div class="choujiang">
				<div class="meihua1"></div>
				<div class="meihua2"></div>
				<div class="act-des">
					<img src="img/img2/activity-des.png" alt="" />
				</div>
				<div class="choujiang-box shanDeng" id="deng">
					<div id="luck"><!-- luck -->
						<table>
							<tr>
								<td class="luck-unit luck-unit-0"><!-- <img src="img/img2/cz-100.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
								<td class="luck-unit luck-unit-1"><!-- <img src="img/img2/xmtv.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
								<td class="luck-unit luck-unit-2"><!-- <img src="img/img2/4.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
								<td class="luck-unit luck-unit-3"><!-- <img src="img/img2/3.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
							</tr>
							<tr>
								<td class="luck-unit luck-unit-11"><!-- <img src="img/img2/6.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
								<td rowspan="2" colspan="2" class="cjBtn" id="btn">您当前的剩余抽奖次数为<span>0</span>次</td>
								<td class="luck-unit luck-unit-4"><!-- <img src="img/img2/5.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
							</tr>
							<tr>
								<td class="luck-unit luck-unit-10"><!-- <img src="img/img2/1.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
								<td class="luck-unit luck-unit-5"><!-- <img src="img/img2/6.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
							</tr>
							<tr>
								<td class="luck-unit luck-unit-9"><!-- <img src="img/img2/3.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
								<td class="luck-unit luck-unit-8"><!-- <img src="img/img2/4.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
								<td class="luck-unit luck-unit-7"><!-- <img src="img/img2/8.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
								<td class="luck-unit luck-unit-6"><!-- <img src="img/img2/7.png"><img class="large" src="img/img2/xinjiangzao.png" alt="" /> --></td>
							</tr>
						</table>
					</div><!-- luckEnd -->
				</div>

				<div class="record" id="record">
				<!-- 	<marquee behavior="scroll"  scrollamount="3"><p>用户13245673420抽到了小米55寸智能平板电视</p></marquee>
					<marquee behavior="scroll"  scrollamount="1"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee> -->
					<!--<marquee behavior="scroll"  scrollamount="5"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
					<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
					<marquee behavior="scroll"  scrollamount="3"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
					<marquee behavior="scroll"  scrollamount="1"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
					<marquee behavior="scroll"  scrollamount="5"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
					<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
					<marquee behavior="scroll"  scrollamount="2"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
					<marquee behavior="scroll"  scrollamount="4"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>-->
					<!--<marquee behavior="scroll"  scrollamount="5"><p>用户180****8969打开圣诞礼物，获得爱疯x</p></marquee>
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
				
				<div class="prize" style="position: relative; visibility: hidden;">
					<p>恭喜您抽中了<span class="price-name"></span></p>
				</div>
				
				<div class="invest"><a class="invest-btn" href="../../project/list">立即投资</a></div>
				
			</div>
			<div class="bottom-banner"></div>
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
				
				
				
		 	//加载奖品列表
			$.post('/yingpu/pc/prize/list/json',{},function(data){
				
				var html='';
				$('#luck').empty();
					html+='<table><tr>';
					html+='<td class="luck-unit luck-unit-0"><img src="'+data.data[0].prizeicon+'"><img class="large" src="'+data.data[0].prizeimg+'" alt="" /></td>';
					html+='<td class="luck-unit luck-unit-1"><img src="'+data.data[1].prizeicon+'"><img class="large" src="'+data.data[1].prizeimg+'" alt="" /></td>';
					html+='<td class="luck-unit luck-unit-2"><img src="'+data.data[2].prizeicon+'"><img class="large" src="'+data.data[2].prizeimg+'" alt="" /></td>';
					html+='<td class="luck-unit luck-unit-3"><img src="'+data.data[3].prizeicon+'"><img class="large" src="'+data.data[3].prizeimg+'" alt="" /></td>';
					html+='<tr><tr>';
					html+='<td class="luck-unit luck-unit-11"><img src="'+data.data[11].prizeicon+'"><img class="large" src="'+data.data[11].prizeimg+'" alt="" /></td>';
					html+='<td rowspan="4" colspan="2" class="cjBtn" id="btn">您当前的剩余抽奖次数为<span>${not empty pcuser.prizenum ? pcuser.prizenum : 0 }</span>次</td>';
					html+='<td class="luck-unit luck-unit-4"><img src="'+data.data[4].prizeicon+'"><img class="large" src="'+data.data[4].prizeimg+'" alt="" /></td>';
					html+='<tr><tr>';
					html+='<td class="luck-unit luck-unit-10"><img src="'+data.data[10].prizeicon+'"><img class="large" src="'+data.data[10].prizeimg+'" alt="" /></td>';
					html+='<td class="luck-unit luck-unit-5"><img src="'+data.data[5].prizeicon+'"><img class="large" src="'+data.data[5].prizeimg+'" alt="" /></td>';
					html+='<tr><tr>';
					html+='<td class="luck-unit luck-unit-9"><img src="'+data.data[9].prizeicon+'"><img class="large" src="'+data.data[9].prizeimg+'" alt="" /></td>';
					html+='<td class="luck-unit luck-unit-8"><img src="'+data.data[8].prizeicon+'"><img class="large" src="'+data.data[8].prizeimg+'" alt="" /></td>';
					html+='<td class="luck-unit luck-unit-7"><img src="'+data.data[7].prizeicon+'"><img class="large" src="'+data.data[7].prizeimg+'" alt="" /></td>';
					html+='<td class="luck-unit luck-unit-6"><img src="'+data.data[6].prizeicon+'"><img class="large" src="'+data.data[6].prizeimg+'" alt="" /></td>';
					html+='<tr><table>';
					
				 $('#luck').html(html); 
				 
				 onLoadCompleted(data);
			});
//		 
		 
		 //加载最近抽奖记录,显示5到6条
			$.post('/yingpu/pc/prize/randprizeHis/list/json',{pageIndex : 1},function(data){
				console.log(data);
				var html='';
				if(data.data){
				$.each(data.data, function(i,o) {
					html+='<marquee behavior="scroll"  scrollamount="'+Math.floor(Math.random()*10 + 5)+'"><p>用户'+o.phone.substring(0,3)+'****'+o.phone.substring(7,11)+'抽到了'+o.prizename+'</p></marquee>';
				});
				$('#record').html(html);
				}
			});
		 
		 });

		var luck={
			index:0,	//当前转动到哪个位置，起点位置
			count:12,	//总共有多少个位置
			timer:0,	//setTimeout的ID，用clearTimeout清除
			speed:1,	//初始转动速度
			times:5,	//转动次数
			cycle:36,	//转动基本次数：即至少需要转动多少次再进入抽奖环节
			prize:-1,	//中奖位置
			running:true,  //添加锁，使转盘在转动过程中再点击抽奖无效。
			
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
			luck.roll();
			if (luck.times > luck.cycle+10 && luck.prize==luck.index) {
				clearTimeout(luck.timer);
				luck.prize=-1;
				luck.times=0;
				click=false;
				onRollingFinish();
			}else{
				if (luck.times<luck.cycle) {
					luck.speed -= 10;
				}
				else {
					if (luck.times > luck.cycle+10 && ((luck.prize==0 && luck.index==7) || luck.prize==luck.index+1)) {
						luck.speed += 110;
					}else{
						luck.speed += 20;
					}
				}
				if (luck.speed<40) {
					luck.speed=40;
				};
	
				luck.timer = setTimeout(roll,luck.speed);
			}
			return false;
		}
		
			
		/** 奖品列表加载完成。 */
		gPrizes = [], gAcquiredPrize = {};
		function onLoadCompleted(data) {
			gPrizes = data.data;
			console.log(gPrizes);
		}
		
		/** 当按下抽奖按钮。 */
		function onDrawButtonPress() {
			if (!isLogin()) {
				showLoginPrompt();
				return;
			}
			
			if ($('#btn span').html() > 0) {
				$('.prize').css('visibility', 'hidden');
				luck.times = 5;
				doDraw();
			}
			else {
				layer.alert('您的可抽奖次数不足！');
			}	
		}
		
		/** 抽奖。 */
		function doDraw() {
    		click = true;
	 		$.post('/yingpu/pc/prize/draw/json', { }, function(data) {
	 			if (data.status == 'ok') {
	 				onAcquirePrize(data.data);
	 			}
	 			else {
	 				click = false;
					if (data.status == 'login') {
						showLoginPrompt();
					}
					else {
						layer.alert(data.message);
					}
				}
	 		});
		}
		
		/** 抽中奖品时。 */
		function onAcquirePrize(data) {
			var $btn = $('#btn span'), 
				pIndex = 0;
			
			gAcquiredPrize = data;
			$btn.html($btn.html() > 0 ? $btn.html() - 1 : 0);

			$.each(gPrizes, function(i, v) {
				if (data.prizename == v.prizename) {
					pIndex = i;
					return false;
				}
			});
			
			rollCursorToPosition(pIndex);
		}
		
		/** 转动光标到指定奖品。 */
		function rollCursorToPosition(pos) {
			luck.prize = pos;
            roll();
		}
		
		/** 滚动结束时。 */
		function onRollingFinish() {
			var msg = $('.prize').css('visibility', 'visible').find('.price-name').html(gAcquiredPrize.prizename).end().text();		
			luck.speed = 200;
			setTimeout(function() {
				/* layer.alert('<p>' + msg + '!<p><p><img src="' + gAcquiredPrize.prizeimg + '"/></p>',
					{ title : '中奖提示', icon : 1, btn: ['查看已获得奖品', '关闭提示'] },
					function() {
						location.href = '/yingpu/pc/myaccount/myluckydraw.jsp';
					},
					function() { }
				); */
				layer.alert(msg + '!', { title : '中奖提示', icon : 1 });
			}, 1000);
		}
	 	
	
	
	//闪灯效果
		var num = 0;
		$(".shanDeng").attr("class",function(){
			setInterval(function(){ 
				num++;
				if(num%2==0){
					$('#deng').addClass("shanDeng2");
				}else{
					$('#deng').addClass("shanDeng");
					$('#deng').removeClass('shanDeng2');
				}
			},500)
		})
	
	
		var click=false;
		$(function(){
			luck.init('luck');
			$(document).on('click', "#btn", function(){
				layer.alert("2月抽奖活动已结束，请去三月活动抽奖页面参与抽奖，谢谢！");
				return;
	            /*if (!click) {
					//按下弹起效果
					$("#btn").addClass("cjBtnDom");
					setTimeout(function(){	
						$("#btn").removeClass("cjBtnDom");
					},200);

                 	onDrawButtonPress();
	            }*/
			});
		});
				
		$(function(){
			$(window).scroll(function(){
				$('.iframe-head').show();
			});
		});
		</script>
	</body>
</html>
