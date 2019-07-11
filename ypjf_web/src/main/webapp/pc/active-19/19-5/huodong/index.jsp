<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="css/huodong.css"/>
		<link rel="shortcut icon" href="../../../img/logo1.icon"/>
		<title></title>
		<style>

		</style>
	</head>
	<body>
		<!--顶部-->

		<iframe src="../../../head3.html" class="iframe-head" width="100%" height="110px" scrolling="no"  style="border:0px;display: block;"></iframe>

		<!--主体-->
		<div id="content">
			<div id="banner">
				<div class="banner">
					<div class="title"><img src="img/bannerTitle.png" ></div>
				</div>
			</div>
			<div id="jiangpinZS">
				<div class="title">
					<h1></h1>
					<p class="time">活动时间 2019.05.01日起</p>
				</div>
				<ul class="jiangpin">
					<li class="items">
						<div class="item">
							<img src="img/kongtiao.png" style="width:191px;height:164px;padding-top:24px;padding-bottom:26px;">
							<p class="p1">美的 5匹 空调柜机</p>
							<p class="p2"><span>劳动价：</span>￥10200</p>
						</div>
						<div class="item">
							<img src="img/diannao.png" style="width:183px;height:155px;padding-top:32px;padding-bottom:26px;">
							<p class="p1">Apple iMac 27寸 </p>
							<p class="p2"><span>劳动价：</span>￥6730</p>
						</div>
						<div class="item">
							<img src="img/100.png" style="width:205px;height:133px;padding-top:54px;padding-bottom:26px;">
							<p class="p1">100元京东E卡</p>
							<p class="p2"><span>劳动价：</span>￥100</p>
						</div>
					</li>
					<li class="items">
						<div class="item">
							<img src="img/gangbi.png" style="width:167px;height:165px;padding-top:26px;padding-bottom:24px;">
							<p class="p1">优尚钢笔高档礼盒</p>
							<p class="p2"><span>劳动价：</span>￥50</p>
						</div>
						<div class="item">
							<img src="img/20.png"  style="width:205px;height:133px;padding-top:50px;padding-bottom:32px;">
							<p class="p1">20元京东E卡</p>
							<p class="p2"><span>劳动价：</span>￥20</p>
						</div>
						<div class="item">
							<img src="img/10.png"  style="width:205px;height:133px;padding-top:50px;padding-bottom:32px;">
							<p class="p1">10元京东E卡</p>
							<p class="p2"><span>劳动价：</span>￥10</p>
						</div>
						<div class="item">
							<img src="img/5.png"  style="width:205px;height:133px;padding-top:50px;padding-bottom:32px;">
							<p class="p1">5元京东E卡</p>
							<p class="p2"><span>劳动价：</span>￥5</p>
						</div>
					</li>

				</ul>
				<div class="touzi">
					<h1><div class="miaoshu"><a href="/yingpu/pc/project/list?backUrl=/yingpu/pc/active-19/19-5/huodong/index.jsp"><img src="img/touzi.png" ></a></div></h1>
				</div>
			</div>
			<div id="active">
				<div class="canyu">
					<span class="a1">参与方法：</span>活动期间，参与五“亿”劳动节的用户，年化达500及以上可兑换一个劳动值，拥有1个劳动值即可抽取一次劳动礼品。
				</div>
				<div class="cishu">
					<h1><div class="miaoshu"><span class="num">0</span></div></h1>
				</div>
				<ul class="main">
					<div class="container" id="luck">
						<%--<table cellspacing="36px">--%>
							<%--<tr>--%>
								<%--<td class="pao pao-0">--%>
									<%--<img src="img/jiangkongtiao.png">--%>
									<%--<p class="mc">美的空调</p>--%>
									<%--<div class="bgadd"></div>--%>
								<%--</td>--%>
								<%--<td class="pao pao-1">--%>
									<%--<img src="img/jiangdiannao.png">--%>
									<%--<p class="mc">Apple iMac</p>--%>
									<%--<div class="bgadd"></div>--%>
								<%--</td>--%>
								<%--<td class="pao pao-2">--%>
									<%--<img src="img/jiang100.png">--%>
									<%--<p class="mc">100元京东E卡</p>--%>
									<%--<div class="bgadd"></div>--%>
								<%--</td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td class="pao pao-7">--%>
									<%--<img src="img/xiexie.png">--%>
									<%--<div class="bgadd"></div>--%>
								<%--</td>--%>
								<%--<td class="cjBtn" id="btn"><img src="img/click.png" ></td>--%>
								<%--<td class="pao pao-3">--%>
									<%--<img src="img/jianggangbi.png">--%>
									<%--<p class="mc">优尚钢笔礼盒</p>--%>
									<%--<div class="bgadd"></div>--%>
								<%--</td>--%>
							<%--</tr>--%>
							<%--<tr>--%>
								<%--<td class="pao pao-6">--%>
									<%--<img src="img/jiang5.png">--%>
									<%--<p class="mc">5元京东E卡</p>--%>
									<%--<div class="bgadd"></div>--%>
								<%--</td>--%>
								<%--<td class="pao pao-5">--%>
									<%--<img src="img/jiang10.png">--%>
									<%--<p class="mc">10元京东E卡</p>--%>
									<%--<div class="bgadd"></div>--%>
								<%--</td>--%>
								<%--<td class="pao pao-4">--%>
									<%--<img src="img/jiang20.png">--%>
									<%--<p class="mc">20元京东E卡</p>--%>
									<%--<div class="bgadd"></div>--%>
								<%--</td>--%>
							<%--</tr>--%>

						<%--</table>--%>
					</div>
				</ul>
				<div class="mingdan">
					<div class="box">
					<ul class="list record" id="record">
					</ul>
					</div>
				</div>
			</div>
			<div id="bottom">
				<div class="shuoming">
					<div class="box">
						 <h3>活动说明</h3>
						<div class="text">
							<p>1、用户获奖后，可与九趣贷官方客服取得联系，安排后续发货对奖，请您保持通讯畅通。</p>
							<p>2、虚拟奖品以电子验证码，赠送等方式兑换；实物奖品均由第三方发货，九趣贷不负责售后质量问题。如用户提供的收货地址、收货人联系方式错误，损失由用户自行承担。</p>
							<p>3、所有礼物不支持现金折现。请在活动结束前，及时使用您的抽奖机会。</p>
							<p class="tishi">温馨提示：年化投资金额=实际投资金额/12*标的期限（月份）</p>
						</div>
					</div>

				</div>

			</div>
		</div>

		<div id="tankuang">
			<div class="content1" id="prize">
				<div class="bg">
					<div class="prize">
						<img src="" class="tu">
						<p class="jiang"></p>
					</div>
					<div class="btns1">
						<img src="img/know.png" id="know" style="cursor: pointer;">
						<img src="img/continue.png" class="continue" style="cursor: pointer;">
					</div>
				</div>
			</div>
			<div class="content2" id="nothing">
				<div class="bg">
					<div class="btns2">
						<img src="img/know.png" id="know" style="cursor: pointer;">
						<img src="img/continue.png" class="continue" style="cursor: pointer;">
					</div>
				</div>
			</div>
		</div>

		<!--底部导航-->
		<iframe src="../../../footer2.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="/yingpu/pc/js/utils.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/huodong.js" type="text/javascript" charset="utf-8"></script>
		<script>
			var activityId = 1, drawTimes = 0, remainsTimes = 0, isDrawing = false;
            $(function () {
                if (!isLogin()) {
                    showLoginPrompt();
                    return;
                }
                loadUserDrawInfo(function (remains, draws) {
                    remainsTimes = remains - draws;
                    $('.num').text(remainsTimes);
                });
            });

            /** 获取用户抽奖信息*/
            function loadUserDrawInfo(s, f) {
                $.post('/yingpu/pc/prize/draw/info/json', {activityId: activityId}, function (data) {
                    if (data.status == 'success') {
                        var info = data.data || {};
                        s && s((info.totalDrawTimes || 0), (info.usedDrawTimes || 0));
                    }
                });
            }

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

			$(document).ready(function() {
				if (!isLogin()) {
					showLoginPrompt();
				}

				//加载奖品列表
				$.post('/yingpu/pc/prize/list/json',{activityId:activityId},function(data){
					var html='';
					$('#luck').empty();
					html+='<table  cellspacing="36px"><tr>';
					html+='<td class="pao pao-0"><img img src="'+data.data[0].prizeicon+'"><p class="mc"></p><div class="bgadd"></div></td>';
					html+='<td class="pao pao-1"><img img src="'+data.data[1].prizeicon+'"><p class="mc">'+data.data[1].prizename+'</p><div class="bgadd"></div></td>';
					html+='<td class="pao pao-2"><img img src="'+data.data[2].prizeicon+'"><p class="mc">'+data.data[2].prizename+'</p><div class="bgadd"></div></td>';
					html+='</tr><tr>';
					html+='<td class="pao pao-7"><img img src="'+data.data[7].prizeicon+'"><p class="mc">'+data.data[7].prizename+'</p><div class="bgadd"></div></td>';
					html+='<td class="cjBtn" id="btn"><img src="img/click.png" ></td>';
					html+='<td class="pao pao-3"><img img src="'+data.data[3].prizeicon+'"><p class="mc">'+data.data[3].prizename+'</p><div class="bgadd"></div></td>';
					html+='</tr><tr>';
					html+='<td class="pao pao-6"><img img src="'+data.data[6].prizeicon+'"><p class="mc">'+data.data[6].prizename+'</p><div class="bgadd"></div></td>';
					html+='<td class="pao pao-5"><img img src="'+data.data[5].prizeicon+'"><p class="mc">'+data.data[5].prizename+'</p><div class="bgadd"></div></td>';
					html+='<td class="pao pao-4"><img img src="'+data.data[4].prizeicon+'"><p class="mc">'+data.data[4].prizename+'</p><div class="bgadd"></div></td>';
					html+='</tr></table>';
					$('#luck').html(html);
					onLoadCompleted(data);
				});


				//加载最近抽奖记录,显示5到6条
				$.post('/yingpu/pc/prize/randprizeHis/list/json',{pageIndex : 1,activityId:activityId},function(data){
					var html='';
					if(data.data){
						$.each(data.data, function(i,o) {
							html+='<li behavior="scroll"  scrollamount="'+Math.floor(Math.random()*10 + 5)+'"><span class="kehu">'+o.phone.substring(0,3)+'****'+o.phone.substring(9,11)+'</span>抽中了<span class="jiang">'+o.prizename+'</span></li>';
						});
						$('#record').html(html);
					}
                    if(new Date() >=new Date('2019-5-01 15:30:00')){
                        xunum();
                    }
				});

			});

			var luck={
				index:-1,	//当前转动到哪个位置，起点位置
				count:8,	//总共有多少个位置
				timer:0,	//setTimeout的ID，用clearTimeout清除
				speed:1,	//初始转动速度
				times:5,	//转动次数
				cycle:36,	//转动基本次数：即至少需要转动多少次再进入抽奖环节
				prize:-1,	//中奖位置
				running:true,  //添加锁，使转盘在转动过程中再点击抽奖无效。
				init:function(id){
					if ($("#"+id).find(".pao").length>0) {
						$luck = $("#"+id);
						$units = $luck.find(".pao");
						this.obj = $luck;
						this.count = $units.length;
						$luck.find(".pao").find('.bgadd').show();
						$luck.find(".pao-"+this.index).find('.bgadd').hide();
					};
				},

				roll:function(){
					var index = this.index;
					var count = this.count;
					var luck = this.obj;
					$(luck).find(".pao-"+index).find('.bgadd').show();
					index += 1;
					if (index>count-1) {
						index = 0;
					};
					$(luck).find(".pao-"+index).find('.bgadd').hide();
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
					onRollingFinish();
				}else{
					if (luck.times<luck.cycle) {
						luck.speed -= 10;
					}else{
						if (luck.times > luck.cycle+10 && ((luck.prize==1 && luck.index==2) || luck.prize==luck.index+1)) {
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

					/** 奖品列表加载完成。 */
					gPrizes = [], gAcquiredPrize = {};

					function onLoadCompleted(data) {
						gPrizes = data.data;
						// console.log(gPrizes);
					}

					/** 当按下抽奖按钮。 */
					function onDrawButtonPress() {
                        if (!isLogin()) {
                            showLoginPrompt();
                            return;
                        }
                        // console.log($('.num').text());
                        if ($('.num').html() > 0) {
                            // $('.prize').css('visibility', 'hidden');
                            luck.times = 5;
                            doDraw();
                        }
                        else {
                            layer.alert('您的可抽奖次数不足！');
                        }
                    }


                        /** 抽奖 */
                        function doDraw() {
                            click = true;
                            $.post('/yingpu/pc/prize/generic/draw/json', {activityId: activityId}, function (data) {
                                if (data.status == 'ok') {
                                    drawTimes++;
                                    remainsTimes--;
                                    onAcquirePrize(data.data);
                                    // console.log(data.data);
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
                                $('.num').text(remainsTimes);
                            });
                        }

                        /** 抽中奖品时。 */
                        function onAcquirePrize(data) {
                            // var $btn = $('#btn'),
                            var num = $('.num').text();
                                pIndex = 0;
                            gAcquiredPrize = data;
                            // $btn.html($btn.html() > 0 ? $btn.html() - 1 : 0);
                            // num.html( $('.num').text()> 0 ? $('.num').text() - 1 : 0);

							// console.log(gPrizes);
                            $.each(gPrizes, function (i, v) {
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


                        // 如果中奖。zhong = true;
                        // var zhongjiang = false;

                        /** 滚动结束时。 */
                        function onRollingFinish() {
                            // luck.prize = 3;
                            luck.speed = 200;
                            setTimeout(function () {
                                if(gAcquiredPrize.prizename.indexOf('谢谢惠顾') != -1){
                                    weizhong();
								}else{
                                    zhong(gAcquiredPrize.prizeimg, gAcquiredPrize.prizename);
								}
                            }, 1000);
                        }


                        // 关闭中奖弹框
                        $("#tankuang").click(function () {
                            $("#tankuang").hide();
                            $("#tankuang .content1").hide();
                            $("#tankuang .content2").hide();
                        });

                        /** 转动光标到指定奖品。 */
                        function rollCursorToPosition(pos) {
                            luck.prize = pos;
                            roll();
                        }

                        // 中奖
                        function zhong(src, name) {
                            $("#tankuang").show();
                            $("#tankuang .content1").show();
                            // 奖品图片
                            $("#tankuang .content1 .tu").attr("src", src);
                            // 奖品名称
                            $("#tankuang .content1 .jiang").html(name);
                        }

                        // 未中奖
                        function weizhong(numm) {
                            $("#tankuang").show();
                            $("#tankuang .content2").show();
                        }


            var click=false;
                $(function(){
                    $(document).on('click', "#btn", function(){
                        // layer.alert("2月抽奖活动已结束，请去三月活动抽奖页面参与抽奖，谢谢！");
                        // return;
                        if (!click) {
                            //按下弹起效果
                            // $("#btn").addClass("cjBtnDom");
                            // setTimeout(function(){
                            //     $("#btn").removeClass("cjBtnDom");
                            // },200);
                            luck.init('luck');
                             onDrawButtonPress();
                        }
                    });
                });
			var timer = setTimeout(function(){
                myGod('record', 100);
			},1000);
            //滚动列表
            function myGod(id, w, n) {
                //id 为父元素的ID，w为默认多久滚动一次，n 为朝上还是朝下滚
                var box = document.getElementById(id), can = true, w = w || 1500, fq = fq || 30, n = n == -1 ? -1 : 1;
                box.innerHTML += box.innerHTML;
                box.onmouseover = function () {
                    can = false
                };
                box.onmouseout = function () {
                    can = true
                };
                var max = parseInt(box.scrollHeight / 2);
                new function () {
                    var stop = box.scrollTop % 18 == 0 && !can;
                    if (!stop) {
                        var set = n > 0 ? [max, 0] : [0, max];
                        box.scrollTop == set[0] ? box.scrollTop = set[1] : box.scrollTop += n;
                    }
                    ;
                    setTimeout(arguments.callee, box.scrollTop % 18 ? fq : w);
                };
            };


            $('.continue').click(function () {
                $("#tankuang").hide();
                $("#tankuang .content1").hide();
                $("#tankuang .content2").hide();
                luck.init('luck');
                onDrawButtonPress();
            });
		</script>
	</body>
</html>
