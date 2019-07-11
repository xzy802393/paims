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
		<link rel="stylesheet" type="text/css" href="css/Newyear_activity.css"/>
		<link rel="stylesheet" type="text/css" href="../../css/animate.css"/>
	
		<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/jquery.fireworks.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		
		<style>
		.map-trail .landscape {
		    position: relative;
		    width: 531px;
		    height: 357px;
		    top: 0px;
		    right: 0px;
		    overflow: hidden;
		}
	    .amap-logo {
             display: none !important;
	     } 	
	     .amap-copyright {
	          bottom:-100px !important;
	           display: none !important;
	      }  
	      .ultimate-prize {
	      	display: none;
	      }
	      .ultimate-prize .gray {
	      	  background: #cccccc;
	      	  
	      }
		</style>
	</head>
	<body>

		<!--顶部-->
		
		<iframe src="../../head.html" class="iframe-head" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>	
		
		<!--主体-->
		
		<div class="activity-page">
			<!--顶部-->
			<div class="head-main">	
				<div class="home">
					<div class="gonggao" id="gonggao">
						<div class="des" id="scroll_div" style="width:554px;height:45px;margin:0 auto;white-space: nowrap;overflow:hidden;">
							<div id="scroll_begin" style=""> 她是营普金服的首席客服，也是第一颜值担当！她是一个川妹儿，今年过年，你能送她回家吗？她是营普金服的首席客服，也是第一颜值担当！她是一个川妹儿，今年过年，你能送她回家吗？ </div> 
							<div id="scroll_end" style="display: inline;"></div> 
						</div>
					</div>
				</div>
<!-- 				<canvas id="cas" style="background-color:rgba(0, 5, 24, 0.04);position: absolute;z-index: 2;width: 100%;" height="949">浏览器不支持canvas</canvas> -->
			</div>
			<div style="display:none">
			  <div class="shape">新年快乐</div>
			  <div class="shape">合家幸福</div>
			  <div class="shape">HAPPY</div>
			</div>
			<!--中间地图-->
			<div class="map-main">
				<div class="map-trail" >
				
					<!--地图上轨迹展示-->

					<div class="map" id="map">
						

						
						<!--头像-->
					<!-- 	<div class="map-touxiang">
							<div class="user-touxiang">
								<img src="img/user-tx.png"/>
							</div>
							
						</div> -->
					</div>
					
					<!--风景图展示-->
					<!-- <div class="landscape">
						<div class="pic">
							<img src="img/chengdu.png" alt="" />
						</div>
						<div class="get-prize" id="getPrize">
							获取奖励
						</div>
					</div> -->
					
					
					<!--终极大奖-->
					
					<div class="ultimate-prize">
						<div class="ultimate-prize-btn">
							确认领奖
						</div>
					</div>
				</div>
			</div>
			
			<!--下面说明-->
			<div class="instruction">
				<div class="ins-main clearfix">
					<div class="ins-des left">
						<div class="item">
							<h5>活动时间：</h5>
							<p class="time">2018年1月1日-2018年2月14日（农历腊月二十九）</p>
						</div>
						<div class="item">
							<h5>活动攻略：</h5>
							<p>1、每投资200元，旅程向目标推进1公里；</p>
							<p>2、每成功抵达一个途中城市，可随机获得一种加速交通工具。</p>
						</div>
						<div class="item">
							<h5>活动奖励：</h5>
							<dl>
								<dt>1、</dt>
								<dd>每成功抵达一个途中城市，有机会抽取一项城市专属特色奖励；</dd>
							</dl>
							<dl>
								<dt>2、</dt>
								<dd>凡是将小英成功送到家的“好心人”，可获得周大福（CHOW TAI FOOK）十二生肖狗贵宾犬千足金黄金转运珠吊坠一枚。</dd>
							</dl>
							<dl>
								<dt>3、</dt>
								<dd>凡是将小英成功送到家的“好心人”，还将获得营普金服提供的专属定制U盘一个。</dd>
							</dl>
							<dl>
								<img src="img/prize-1.png"/>
							</dl>
							<dl>
								<img src="img/prize-2.png"/>
							</dl>
						</div>
						<div class="item">
							<h5>活动说明：</h5>
							<dl>
								<dt>1、</dt>
								<dd>投资项目不限期限（不含天天存吧），在活动期间内可累计。</dd>
							</dl>
							<dl>
								<dt>2、</dt>
								<dd>用户获奖后，平台客服会在3个工作日内与您取得联系，安排后续发货兑奖，请您保持通讯畅通。</dd>
							</dl>
							<dl>
								<dt>3、</dt>
								<dd>所有实物奖品，不支持现金折现。实物奖品均由第三方发货，营普金服不负责售后质量问题。如用户提供的收货地址、收货人联系方式错误，损失由用户自行承担。虚拟奖品，详细兑奖方式请联系客服。</dd>
							</dl>
							<dl>
								<dt>4、</dt>
								<dd>请在活动结束前，及时使用您的抽奖机会。</dd>
							</dl>
							<dl>
								<dt>5、</dt>
								<dd>在法律许可范围内，本活动由营普金服做出最终解释。</dd>
							</dl>
						</div>
						
					</div>

					<div class="ins-top left">
						<div class="tit">
							<h3><span class="icon-jb"></span>排行榜TOP 50</h3>
						</div>
						<div class="notice clearfix">
							<span class="icon-ld left"></span>
							<div class="notice-list left" id="scrollAd">
							<!-- 	<p>用户 <span> 159***5987</span> 将小英送回家</p>
								<p>用户 <span> 159***5987</span> 将小英送回家</p>
								<p>用户 <span> 159***5987</span> 将小英送回家</p> -->
							</div>
						</div>
						
						<ul id="activityUserInfo">
						
						
					
						</ul>
							
						
						
						<div class="bottom">
							<p><a href="javascript:void($('#shang').click());">&lt;</a>我当前的排名：<span id="paiming">0</span><a href="javascript:void($('#xia').click());">&gt;</a></p>
						</div>
					</div>
				</div>

			</div>
		
			<!--底部-->
			<div class="bottom-bg">
				
			</div>
		
		</div>
		
		<div class="fade" style="display: none;">
			<div class="luckydraw">
				<div class="luckydraw-box">
					<div class="shiwu" id="shiwuPrize">
						<ul class="clearfix">
							<li class="list">
								<div class="cont">
								    <img class="image" src="img/shiwu-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/shiwu-y-sz.png"/></div>  
								</div>   
							</li>
							<li class="list">
								<div class="cont">  
								    <img class="image" src="img/shiwu-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/shiwu-y-sz.png"/></div>  
								</div>
							</li>
							<li class="list">
								<div class="cont">  
								    <img class="image" src="img/shiwu-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/shiwu-y-sz.png"/></div>  
								</div>
							</li>
							<li class="list">
								<div class="cont">  
								    <img class="image" src="img/shiwu-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/shiwu-y-sz.png"/></div>  
								</div>
							</li>
							<li class="list">
								<div class="cont">  
								    <img class="image" src="img/shiwu-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/shiwu-y-sz.png"/></div>  
								</div>
							</li>
						</ul>
						
						<!--未参加抽奖描述-->
						<div class="shuwu-des">
							<p class="chance">您有 <span class="num">1</span> 次实物奖励翻牌机会！</p>
						</div>
						<!--已参加抽奖描述-->
						<!--<div class="shuwu-des">
							<p class="cong">恭喜您抽到<span class="prize">苏州味道传统礼盒糕点！</span></p>
							<p class="text">平台客服会在3个工作日之内与您联系，安排发货，请您保持通讯畅通!</p>
						</div>-->

					</div>
					<div class="jtgj">
						<ul class="clearfix">
							<li class="list">								
								<div class="cont">  
								    <img class="image" src="img/jtgj-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/jtgj-feiji.png"/></div>  
								</div>
							</li>
							<li class="list">								
								<div class="cont">  
								    <img class="image" src="img/jtgj-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/jtgj-feiji.png"/></div>  
								</div>
							</li>
							<li class="list">								
								<div class="cont">  
								    <img class="image" src="img/jtgj-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/jtgj-feiji.png"/></div>  
								</div>
							</li>
							<li class="list">								
								<div class="cont">  
								    <img class="image" src="img/jtgj-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/jtgj-feiji.png"/></div>  
								</div>
							</li>
							<li class="list">								
								<div class="cont">  
								    <img class="image" src="img/jtgj-n.png">  
								    <div class="info"><span class="selected"></span><img src="img/jtgj-feiji.png"/></div>  
								</div>
							</li>
						</ul>
						
						<!--未参加抽奖描述-->
						<div class="jtgj-des">
							<p class="chance">您有 <span class="num">1</span> 次加速交通工具翻牌机会！</p>
						</div>
						<!--已参加抽奖描述-->
						<!--<div class="jtgj-des">
							<p class="chance">恭喜您抽到<span>直升机(向前推进10000m)</span><a href="#">立即加速</a></p>
						</div>-->

					</div>
				</div>
				<div class="close" id="close"></div>
			</div>		
		</div>
		
		<div class="page" style="display:none;">
			<div class="page-list" id="pageList">
				<a onclick="go('home')">首页</a>
				<a onclick="go('prev')" id="shang">上一页</a>
				<span id="page-nav-btn">
				</span>
				<a onclick="go('next')" id="xia">下一页</a>
				<a onclick="go('tail')">尾页</a>
			</div>
		</div>
		<!--客服悬浮条-->
		<!-- <iframe src="../../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe> -->
		<iframe src="../../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../js/utils.js" type="text/javascript" charset="utf-8"></script>

		<!--底部导航-->
		<iframe src="../../footer.html" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../.././layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
        <script src="js/yanhua.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/swiper-3.4.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/first.js" type="text/javascript" charset="utf-8"></script>-->
		    <script type="text/javascript" src='//webapi.amap.com/maps?v=1.4.2&key=9a9188b05963231144f10ac8975902a8'></script>
    <!-- UI组件库 1.0 -->
    <script src="//webapi.amap.com/ui/1.0/main.js?v=1.0.11"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <script type="x-tpl" id="landscape">
		<div class="landscape">
						<div class="pic">
							<img src="img/chengdu.png" alt="" />
						</div>
						<div class="get-prize">
							获取奖励
						</div>
					</div>
	</script>
	
	<script type="text/javascript">
		function ScrollImgLeft(){
			var speed=30; 
			var scroll_begin = document.getElementById("scroll_begin"); 
			var scroll_end = document.getElementById("scroll_end"); 
			var scroll_div = document.getElementById("scroll_div"); 
			scroll_end.innerHTML=scroll_begin.innerHTML; 
			function Marquee(){ 
				if(scroll_end.offsetWidth-scroll_div.scrollLeft<=0) 
				scroll_div.scrollLeft-=scroll_begin.offsetWidth; 
				else 
				scroll_div.scrollLeft++; 
			} 
			var MyMar=setInterval(Marquee,speed); 
			

			scroll_div.onmouseover=function() {clearInterval(MyMar);} 
			scroll_div.onmouseout=function() {MyMar=setInterval(Marquee,speed);} 
		} 
		
		ScrollImgLeft();
	</script>
	
	
	
	<script type="text/javascript">
		var map,
			gCityId = 0,
			gCitys = ['上海', '苏州', '南京', '合肥', '武汉', '宜昌', '重庆', '成都'];
		    gCityLocations = {
		        '上海' : {"N":31.230416,"L":121.473701,"lng":121.473701,"lat":31.230416},
		        '苏州' : {"N":31.298886,"L":120.58531499999998,"lng":120.585315,"lat":31.298886},
		        '南京' : {"N":32.060255,"L":118.796877,"lng":118.796877,"lat":32.060255},
		        '合肥' : {"N":31.820586,"L":117.227239,"lng":117.227239,"lat":31.820586},
		        '武汉' : {"N":30.593098,"L":114.30539199999998,"lng":114.305392,"lat":30.593098},
		        '宜昌' : {"N":30.691967,"L":111.286471,"lng":111.286471,"lat":30.691967},
		        '重庆' : {"N":29.563009,"L":106.551556,"lng":106.551556,"lat":29.563009},
		        '成都' : {"N":30.572269,"L":104.06654100000003,"lng":104.066541,"lat":30.572269}
		    },
		    gDistance = [],
		    
		    gMarkers = [],
		    
		    gUserInfo = {},
		    
		    gLocations = [
				[
				    [121.473701, 31.230416],
				    [120.882302,31.374973]
				],
			    
				[
				    [120.585315,31.298886],
				    [119.617845,31.969866],
				    [119.455796,32.218837],
				    [119.038316,32.156077]
				],
			    
				[
				    [118.796877,32.060255],
				    [118.653794,32.156077],
				    [118.486253,32.053708],
				    [118.414842,32.063019],
				    [117.448045,31.841627]
				],
			    
				[
				    [117.227239,31.820586],
				    [116.426316,31.687504],
				    [116.030809,31.626719],
				    [115.45952,31.279954],
				    [114.338914,30.908346]
				],
			    
				[
				    [114.305392,30.593098],
				    [113.47698,30.411773]
			    ],
			
			    [
				    [111.286471,30.691967],
				    [110.118947,30.637127],
				    [109.470754,30.215567],
				    [109.242787,30.179959],
				    [108.679738,30.246417],
				    [107.883229,29.987454]
				],
				
				[
				    [106.551556,29.563009],
				    [105.893473,29.373465],
				    [105.291972,29.458399],
				    [104.851145,29.809336],
				    [104.48997,30.371361]
				],
			    
				[
				    [104.066541,30.572269]
				]
		    ],
		    gDrawInfo = [],
		    gDistanceScale = 0;
			    
			// 创建地图
		    map = new AMap.Map('map', {
		        zoom: 4
		    });
			
			
			function createMarker(d, c, s) {
				 var marker = new SimpleMarker({
			            map: map,
			            position: [ d[0],  d[1] ],
			            label : {
			            	content: c,
		                    offset: new AMap.Pixel(25, 20)
			            },
			            iconTheme: 'numv1',
			            iconStyle: s,
			            zIndex : 99
			        });
				return marker;
			}
			
		    function addMarker(i, d, t, info) {
		    	gDrawInfo[i] = info;
		        var marker = new SimpleMarker({
		            map: map,
		            position: [ d[0],  d[1] ],
		            label : {
		            	content: (function() {
		            		return !info || info.drawtype > 0 && info.acceleratetype > 0 ? gCitys[i] : 
		            			('您有一次' + (info.drawtype == 0 ? '抽奖' : '加速') + '机会！');
		            	}()),
	                    offset: new AMap.Pixel(25, 20)
		            },
		            iconTheme: 'numv1',
		            iconStyle: (function() {
		            	if (i == 0) { 
		            		return 'start';
		            	}
		            	if (i == gCitys.length - 1) {
							return 'end';
						}
		            	
						if (gDrawInfo[i]) {
							return 'pass';
						}
						
						return 'red';
		            }()),
		            zIndex : 99
		        });

		        marker.on("click", function(e) {
		        	gCityId = i + 1;
		            createInfoWindow(i, function(html) {
		            	if (!gDrawInfo[i]) {
		            		return html.replace(/<div class="get-prize">[^><]*<\/div>/, '');
		            	}
		            	if (gDrawInfo[i].drawtype > 0 && gDrawInfo[i].acceleratetype > 0) {
			            	return html.replace('获取奖励', '查看奖励');
		            	}
		            	if (gCityId == gCitys.length) {
		            		return html.replace('获取奖励', '获取终级大奖');
		            	}
		            	
		            	return html;
		            }).open(map, new AMap.LngLat(d[0], d[1]));
		        });
		        
	        	gMarkers[i] = marker;
		    }
		    
		    
		    function addMarkerWithoutLabel(i, d, info) {
		    	 var marker = new AMap.Marker({
		            map: map,
		            position: [ d[0],  d[1] ],
		            label : {
	                    offset: new AMap.Pixel(20, 0)
		            }
		        });

	        	gDrawInfo[i] = info;
		        marker.on("click", function(e) {
		        	gCityId = i + 1;
		        	if (gDrawInfo[i]) {
			            createInfoWindow(i).open(map, new AMap.LngLat(d[0], d[1]));
		        	}
		        });	
	        	gMarkers[i] = marker;
		    }
		    

		 	// 计算距离
			var computeDistances = function() {
				for (var i = 0; i < gLocations.length - 1; i++) {
					var locations = gLocations[i];
					var lnglat, distance = i != 0 ? gDistance[i - 1] : 0;
					for (var j = 0; j < locations.length; j++) {
						var location = locations[j];
						lnglat = new AMap.LngLat(location[0], location[1]);
						if (j + 1 <= locations.length - 1) {
							distance += lnglat.distance(locations[j + 1]);
						}
					}

					distance += lnglat.distance(gLocations[i + 1][0]);
					gDistance[i] = distance;
				}
			};    
			
			// 获取城市路线
			var getPath = function() {
		        var paths = [];
		        for (var key in gLocations) {
		        	var locations = gLocations[key];
		        	for (var j in locations) {
		        		var location = locations[j];
			        	paths.push([location[0], location[1]]);
		        	}

		        }
				
		        return paths;
			};
			
			
			function removeMarker(m) {
				if (m) {
					m.hide();
					m.setMap(null);
				}
			}
			
			function createInfoWindow(cid, filter) {
				var siteInfo = siteinfo[cid] || {},
					tpl = $('#landscape').html();
				
				tpl = filter && filter(tpl) || tpl;
				if (siteInfo.image) {
					tpl = tpl.replace('img/chengdu.png', siteInfo.image);
				}

				infoWindow = new AMap.InfoWindow({
			        isCustom: true,
			        content: tpl,
			        offset: new AMap.Pixel(0, -30)
			    });
				
				infoWindow.close();
				return infoWindow;
			}
			
			
			
			// 比例尺
			map.plugin(["AMap.Scale"],function(){
			    var scale = new AMap.Scale({position: 'RB'});
			    map.addControl(scale);
			});
			
			var infoWindow;
			function onReachCity(nav, idx, city) {
				var pos = gCityLocations[city];
			    createInfoWindow(idx + 1).open(map, new AMap.LngLat(pos.lng, pos.lat));
			}
			
			
			var moveListeners = [];
			function moveTo(num) {
				setTimeout(function() {
					navg1.moveByDistance(num * gDistanceScale);
					navg1.pause();
					$.each(moveListeners, function(i, o) {
						o && o.call(navg1);
					});
				}, 500);
			}
			
			
			function onMoveDone(func) {
				moveListeners.push(func);
			}
			
			
			var leadingRoleMarker;
			onMoveDone(function() {
				if (!leadingRoleMarker) {
					leadingRoleMarker = new AMap.Marker({
			            map: map,
			            icon: 'img/people.png',
			            offset: new AMap.Pixel(-38, -48),
						zIndex: 0
			        });
					
					leadingRoleMarker.on('click', function() {
// 						if ()
					});
				}
				
				var pos = this.getPosition();
				leadingRoleMarker.setPosition(pos);
				leadingRoleMarker.show();
			});


		    AMapUI.load(['ui/misc/PathSimplifier', 'lib/$', 'ui/overlay/SimpleMarker'], function(PathSimplifier, $, sm) {
		        if (!PathSimplifier.supportCanvas) {
		            alert('当前环境不支持 Canvas！');
		            return;
		        }

		        var pathSimplifierIns = new PathSimplifier({
		        	
		            zIndex: 10,
					
		            map: map, //所属的地图实例

		            getPath: function(pathData, pathIndex) {
		                return pathData.path;
		            },
		            
		            getHoverTitle: function(pathData, pathIndex, pointIndex) {
		            },
		            
		            renderOptions: {
		            	pathTolerance : 0,
		            	keyPointTolerance : -1,
		                renderAllPointsIfNumberBelow: 100, 			
		                pathLineStyle: {
	                        lineWidth: 6,
	                        strokeStyle: 'red',
	                        borderWidth: 1,
	                        borderStyle: '#eeeeee',
	                        dirArrowStyle: {
	                        	 stepSpace: 15,
	                             strokeStyle: '#eeeeee'
	                        }
	                    }
		            }
		        });

		        window.pathSimplifierIns = pathSimplifierIns;
		        window.SimpleMarker = sm;

		        
				// 设置数据
		        pathSimplifierIns.setData([{
		            name: '',
		            path: getPath()
		        }]);

				//对第一条线路（即索引 0）创建一个巡航器
		        var navg1 = pathSimplifierIns.createPathNavigator(0, {
		            loop: false, 		//循环播放
		            speed: 1,		//巡航速度，单位千米/小时
		            animInterval: 1,
		            pathNavigatorStyle : {
		                width: 62,
		                height: 62,
		                content: PathSimplifier.Render.Canvas.getImageContent('', onload, onerror),
		                pathLinePassedStyle: {
	                        lineWidth: 5,
	                        strokeStyle: '#aaaaaa',
	                        dirArrowStyle: {
	                            stepSpace: 15,
	                            strokeStyle: 'white'
	                        }
	                    }
		            }
		        });
		       
				computeDistances();
				window.navg1 = navg1;
				window.isNavLoaded = true;
				navg1.start();
				onMapLoaded.call(navg1);
		    });
		    
		    
		    function onMapLoaded() {
		    	prepareExecute(function() {
		    		addCityMarkers();
		    	});
		    }
		    
		    
		    function addCityMarkers() {
		    	$.each(siteinfo, function(i, o) {
		    		var city = gCityLocations[o.name];
		    		addMarker(o.id - 1, [city.lng, city.lat], null);
		    	});
		    }
		    
		    
		    function getEncodedCurrentURL() {
				return encodeURIComponent(location.href);
			}
		    
		    
		    function showLoginPrompt() {
	 			layer.alert('对不起，登陆后才可以参加活动，请先登录!', { btn : ['登录', '取消'] }, function() {
	 				location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
	 			}, function() {
	 				
	 			});
			}
			
		    
			function isLogin() {
				return !!'${pcuser.phone}';
			}
			
			
			$(function(){
				if (!isLogin()) {
					showLoginPrompt();
				}
				
				$(window).scroll(function(){
					$(".iframe-head").show();
					
//					$(".home").animate({top:"170px"});
				});
				
			});

			
			var execQueue = [],
				checkQueue = [];

			var isLoadDone = function() {				
					for (var idx in checkQueue) {
						if (checkQueue[idx] && !checkQueue[idx]()) {
							return false;
						}
					}
					return true && checkQueue.length;					
				},

				addCheckCondition = function(condition) {
					checkQueue.push(condition);
				},

				doCheckLoop = function() {
					tId = setInterval(function() {
						if (isLoadDone()) {
							setTimeout(function() {
								var func = execQueue.pop();
								func && func.call(this);
								if (!execQueue.length) {
									clearInterval(tId);
								}
							}, 100);
						}
					}, 100);
				};
			
  			
  			function prepareExecute(func) {
  				if (!isLoadDone()) {
  					execQueue.push(func);
  					return;
  				}
  				
  				func && func.call(this);
  			}
  			

  			prepareExecute(function() {
  				gDistanceScale = gDistance[gDistance.length - 1] / (siteinfo[siteinfo.length - 1].distance * 1000);
  			});


			addCheckCondition(function() {
				return window.isNavLoaded && siteinfo;
			});

  			window.onload = doCheckLoop;
        </script>
		<script type="text/javascript"> 
			//顶部滚动
//			function ScrollImgLeft(){
//				var speed=500; 
//				var scroll_begin = document.getElementById("scroll_begin"); 
//				var scroll_end = document.getElementById("scroll_end"); 
//				var scroll_div = document.getElementById("scroll_div"); 
//				scroll_end.innerHTML=scroll_begin.innerHTML; 
//				function Marquee(){ 
//					if(scroll_end.offsetWidth-scroll_div.scrollLeft<=0) 
//					scroll_div.scrollLeft-=scroll_begin.offsetWidth; 
//					else 
//					scroll_div.scrollLeft++; 
//				} 
//				var MyMar=setInterval(Marquee,speed); 
//				
//	
//				scroll_div.onmouseover=function() {clearInterval(MyMar);} 
//				scroll_div.onmouseout=function() {MyMar=setInterval(Marquee,speed);} 
//			} 
//			
//			ScrollImgLeft();

			
			function myGod(id,w,n){
				//id 为父元素的ID，w为默认多久滚动一次，n 为朝上还是朝下滚
			var box=document.getElementById(id),can=true,w=w||1500,fq=fq||10,n=n==-1?-1:1;
			box.innerHTML+=box.innerHTML;
			box.onmouseover=function(){can=false};
			box.onmouseout=function(){can=true};
			var max=parseInt(box.scrollHeight/2);
				new function (){
				   var stop=box.scrollTop%26==0&&!can;
				   if(!stop){
				    var set=n>0?[max,0]:[0,max];
				    box.scrollTop==set[0]?box.scrollTop=set[1]:box.scrollTop+=n;
				   };
				   setTimeout(arguments.callee,box.scrollTop%26?fq:w);
				};
			};
			
			
			
			
			$(document).on('click', 'body', function(e) {
				/* if ($(e.target).parents('.amap-marker').size() == 0 && infoWindow && infoWindow.getIsOpen()) {
					if ($(e.target).parents('.landscape').size() == 0 && e.target != $('.landscape')[0]) {
						if (infoWindow) {
							infoWindow.close();
						}
					}
				} */
			});
			
			function getRand(num) {
				return parseInt(Math.random() * 1000 % num);
			}
			
			$(window).load(function(){
				$(document).on('click', '.get-prize', function() {
					infoWindow.close();
					infoWin && infoWin.close();
					if (gCityId) {
						var isUltimate = false;
						if (gCityId == gCitys.length) {
							$('.ultimate-prize').fadeIn();
							if (gDrawInfo[888888]) {
								$('.ultimate-prize .ultimate-prize-btn').html('已领取大奖');
							}
							isUltimate = true;
						}
						
						if (!isUltimate) {
							if (gDrawInfo[gCityId - 1].drawtype > 0 || gDrawInfo[gCityId - 1].acceleratetype > 0) {
								var j = 0;
								getMyActivity1PrizeInfo(gCityId, function(datum) {
									$.each(datum || [], function(j, data) {
										var $container;
										if (j == 0 && gDrawInfo[gCityId - 1].drawtype > 0) {
											$container = $('.shiwu');
											$('.shiwu').find('.num').html(0);
										}
										if (j == 1 && gDrawInfo[gCityId - 1].acceleratetype > 0) {
											$container = $('.jtgj');
											$('.jtgj').find('.num').html(0);
										}
										
										if (!data) {
											return;
										}
										
										
										$.each(data, function(i, o) {
											if ($container) {
												$container.find('.cont').addClass('rotator').find('.info img').eq(i).attr('src', o.prizeimg);
												if (o.probability == '已中奖') {
													$container.find('.cont').eq(i).addClass('zhongjiang');
													acquiredPrize = o;
													
													var descs = ['<p class="cong">恭喜您抽到<span class="prize">'+ acquiredPrize.prizename +  '！</span></p>'
																   +'<p class="text">平台客服会在3个工作日之内与您联系，安排发货，请您保持通讯畅通!</p>',
																 '<p class="chance">恭喜您抽到<span>' + acquiredPrize.prizename + '</span></p>'
														];
	
													
													$container.find('[class$=-des]').each(function(i, e) {
														$(e).html(descs[j++]);
													});
												}
											}
										});
									});
								});
							}
							$(".fade").show();
						}
						
					}
				});
				
			    // 抽奖
			    $(document).on('click', '.shiwu .cont', function(){
			        if ($('.shiwu .rotator').size() == 0) {
			    	   if (gDrawInfo[gCityId - 1].drawtype == 0) {
			       			var _this = $(this), acquiredPrize, $prizeImgEle;
				       		draw(gCityId, function(data) {
				       			var $item = _this.parents('.shiwu').find('.cont');
				       			$.each(data || [], function(i, o) {
				       				if (!o) return;
				       				
				       				_this.parents('.shiwu').find('.info img').eq(i).attr('src', o.prizeimg);
				       				if (o.probability == '已中奖') {
										acquiredPrize = o;
										$prizeImgEle = $item.find('.info img').eq(i);
									}
								});
				       			
				       			var $curImg = _this.find('.info img'),
				       				prizeImg = $prizeImgEle.attr('src');
				       			
				       			$prizeImgEle.attr('src', $curImg.attr('src'));
				       			$curImg.attr('src', prizeImg);
				       			$item.addClass('rotator');
				       			_this.addClass('zhongjiang');
								$(".shiwu .shuwu-des").html('<p class="cong">恭喜您抽到<span class="prize">'+ acquiredPrize.prizename +  '！</span></p>'
														   +'<p class="text">平台客服会在3个工作日之内与您联系，安排发货，请您保持通讯畅通!</p>')
								
								var $num = _this.parents('.shiwu').find('.num');
								$num.html($num.html() - 1);
								gDrawInfo[gCityId - 1].drawtype = 1;
								if (gCityId == gCitys.length) {
									$('.ultimate-prize').fadeIn();
								}
								
								var pos = gMarkers[gCityId - 1].getPosition(),
									di = gDrawInfo[gCityId - 1];
								removeMarker(gMarkers[gCityId - 1]);
								addMarker(gCityId - 1, [pos.lng, pos.lat], di.drawtype == 0 ? 0 : 1, gDrawInfo[gCityId - 1]);
				       		});
						}
			       }
			    });
			    

			    // 加速
			    $(document).on('click', '.jtgj .cont', function(){  
		    	 	if ($('.jtgj .rotator').size() == 0) {
						if (gDrawInfo[gCityId - 1].acceleratetype == 0) {
							var _this = $(this), acquiredPrize, $prizeImgEle;
				       		accelerate(gCityId, function(data) {
				       			var $item = _this.parents('.jtgj').find('.cont');
				       			$.each(data || [], function(i, o) {
				       				if (!o) return;

									_this.parents('.jtgj').find('.info img').eq(i).attr('src', o.prizeimg);
									if (o.probability == '已中奖') {
										acquiredPrize = o;
										$prizeImgEle = $item.find('.info img').eq(i);
									}
								});
				       			
				       			var $curImg = _this.find('.info img'),
				       				prizeImg = $prizeImgEle.attr('src');
				       			
				       			$prizeImgEle.attr('src', $curImg.attr('src'));
				       			$curImg.attr('src', prizeImg);
				       			$item.addClass('rotator');
				       			_this.addClass('zhongjiang');
				       			
								$(".jtgj .jtgj-des").html('<p class="chance">恭喜您抽到<span>' + acquiredPrize.prizename 
													+ '</span><!--<a onclick="acclerateNow(' + acquiredPrize.price + ')">立即加速</a>--></p>')
								
								var $num = $(_this).parents('.jtgj').find('.num');
								$num.html($num.html() - 1);
								
								gDrawInfo[gCityId - 1].acceleratetype = 1;
								moveTo(navg1.getMovedDistance() / 1000 + _data.price * 1000);
								getMyActivity1HistoryInfo();
								
								var pos = gMarkers[gCityId - 1].getPosition(),
									di = gDrawInfo[gCityId - 1];
								removeMarker(gMarkers[gCityId - 1]);
								addMarker(gCityId - 1, [pos.lng, pos.lat], di.drawtype == 0 ? 0 : 1, gDrawInfo[gCityId - 1]);
				       		});
						}
		    	 	}
			   
		    	 	
			   })
			   .on('click', '#close', function() {
				   $(".fade").hide();
			    	init();
			    	
			   })
			   .on('click', '.ultimate-prize-btn', function() {
				   if (gDrawInfo[888888]) {
						$('.ultimate-prize').fadeOut();
						return;
				   }
				   getUltimatePrize();
			   });
			    
			    function init(){
		    		$(".cont").removeClass('rotator');
		    		$(".cont").removeClass('zhongjiang');
		    		$('.shiwu .cont img').attr('src', 'img/shiwu-n.png');
		    		$('.shiwu .cont .info img').attr('src', 'img/shiwu-y-sz.png');
		    		$('.jtgj .cont img').attr('src', 'img/jtgj-n.png');
		    		$('.jtgj .cont .info img').attr('src', 'img/jtgj-feiji.png');
		    		$('.luckydraw').find('.num').html(1);
		    		$('.luckydraw [class$=-des]').html('<p class="chance">您有 <span class="num">1</span> 次实物奖励翻牌机会！</p>');
			    };
			});  
			
			function acclerateNow() {
				$('#close').click();
			}
		</script> 
		
	<script type="text/javascript">

		var siteinfo;
		//初始化城市信息
		function initcityinfo(){
			var index = layer.load(2);
			$.post('/yingpu/pc/activity1/initcityinfo/json',{},function(data){
				layer.close(index);
				siteinfo=data.data;
				$('#paiming').text(!isLogin() ? '无' : data.message);
				loadList();
				lunboTop10();
			});
		}
	
		initcityinfo();

		//轮播加速信息（最近10条）
		function lunboTop10(){
			var index = layer.load(2);
			$.post('/yingpu/pc/activity1/lunboTop10/json',{},function(data){
				layer.close(index);
				console.log(data);

				var html='';
				$.each(data.data,function(i,o){
					html+='<p>用户 <span> '+o.phone.substring(0,3)+'****'+o.phone.substring(7,11)+'</span> 将小英送到'+o.sitename+'</p>';
				});	
				$('#scrollAd').append(html);
				myGod('scrollAd',3000);
			});
		}
		
	//到达站点之后抽取加速
		function accelerate(siteId, func){
			var index = layer.load(2);
			$.post('/yingpu/pc/activity1/accelerate/json',{siteId : siteId},function(data){
				layer.close(index);
				_data = data.data;
				if (data.status == 'success') {
					func && func(data.data);
				}
			});
		}

		//送小英最快的10个人
		function loadList(){
			var index = layer.load(2);
			if(pageIndex>5)pageIndex=5;
			$.post('/yingpu/pc/activity1/activityUserTop10/json',{pageIndex:pageIndex,pageSize:10},function(data){
				layer.close(index);
				if (!data.data || !data.page) {
					return;
				}
				var dat=data;
					pageIndex = pageIndex
					pageCount = data.page.pageCount;
					pageSize=data.page.pageSize;
					data=data.data;
					if(data==undefined){
					$('#activityUserInfo').empty();
					$('#activityUserInfo').append('<h3 aligin="center">暂无记录</h3>');	
					return false;
				}

				var html='';
				$.each(data,function(i,o){
					html+='<li class="list clearfix">';
					var xuhao=pageIndex*10-10+i+1;
					if(pageIndex==1){
							if(i+1==1){
								html+='<div class="xh jp left">'+xuhao+'</div>';
							}else if(i+1==2){
								html+='<div class="xh yp left">'+xuhao+'</div>';
							}else if(i+1==3){
								html+='<div class="xh tp left">'+xuhao+'</div>';
							}else{
								html+='<div class="xh  left">'+xuhao+'</div>';
							}
					}else{
							html+='<div class="xh  left">'+xuhao+'</div>';
					}
					
					html+='<div class="tx left"><img src=" '+(o.header==undefined || o.header =='' ? "img/icon-tx.png" :o.header)+'"/></div>';
					html+='<div class="tel left">'+o.phone.substring(0,3)+'****'+o.phone.substring(7,11)+'</div>';
					html+='	<div class="mature-progress left">';
					html+='	<div class="mature-progress-bottom">';

	
					html+='<div class="mature-progress-box '+generateclass(o.siteId)+' " id="mamture_progress">';
	
					html+=generateclass1(o.siteId);
					html+='<div class="progress-box" id="progress_content" data-progress="8000">';
					html+=generateclass2(o.siteId,o.mileage,o.tolmileage);
					html+='</div>	</div>';
					html+='	<div class="mature-progress-box bgtwos">';
					html+='<dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl>';
					html+='</div>	</div></li>';
				});	
				$('#activityUserInfo').empty();
				$('#activityUserInfo').append(html);	
				generatePaginationNav(pageIndex, dat.page.pageCount, '#page-nav-btn');			
				
			});
		}
	//获取自己的行进信息
		function getMyActivity1UserInfo(){
			var index = layer.load(2);
			$.post('/yingpu/pc/activity1/getMyActivity1UserInfo/json',{},function(data){
				layer.close(index);
				data = data.data[0];
				gUserInfo = data || {};
				prepareExecute(function() {
					moveTo(data && data.mileage * 1000 || 0);
				});

			});
		}

	//加载站点奖品信息
		function getMyActivity1PrizeInfo(siteId, func){
			var index = layer.load(2);
			$.post('/yingpu/pc/activity1/getMyActivity1PrizeInfo/json',{siteId:siteId},function(data){
				layer.close(index);
				if (data.status == 'success') {
					func && func(data.data);
				}
			});
		}
	//到达站点抽奖
		function draw(siteId, func){
			var index = layer.load(2);
			$.post('/yingpu/pc/activity1/draw/json',{siteId:siteId},function(data){
				layer.close(index);
				if (data.status == 'ok') {
					func && func(data.data);
				}				
			});
		}
	//加载自己的抽奖记录
		function getMyActivity1HistoryInfo(siteId) {
			var index = layer.load(2);
			$.post('/yingpu/pc/activity1/getMyActivity1HistoryInfo/json',{siteId:siteId},function(data){
				layer.close(index);
				prepareExecute(function() {
					$.each(data.data, function(i, o) {
						var location = gCityLocations[gCitys[o.siteId - 1]];
						if (o.siteId == 1) {
							return;
						}

						infoWin = null;
						if (o.siteId >= gCitys.length) {
							 location = gCityLocations[gCitys[gCitys.length - 1]];
							 gCityId = gCitys.length;
							 if (o.siteId == 888888){
								gDrawInfo[888888] = {};
							}
							else if (o.siteId == gCitys.length) {
								gDrawInfo[o.siteId] = o;
								infoWin = createInfoWindow(o.siteId - 1, function(html) {
									if (gDrawInfo[888888]) {
										return html.replace('获取奖励', '查看终级大奖');
									}
				            		return html.replace('获取奖励', '获取终级大奖');
					            });
							}
							
							if (infoWin) {
								removeMarker(gMarkers[gCityId] - 1);
								createMarker([location.lng, location.lat], '', 'end').on('click', function() {
									gCityId = gCitys.length;
									infoWin.open(map, new AMap.LngLat(location.lng, location.lat));
								});
							}
							return ;
						}
						
						var siteId = o.siteId - 1;
						if (o.drawtype >= 0 && gMarkers[siteId]) {
							gMarkers[siteId].hide();
							gMarkers[siteId].setMap(null);
							gMarkers[siteId] = null;
						}
						
						if (o.drawtype >= 0) {
							addMarker(o.siteId - 1, [location.lng, location.lat], 0, o);
						}
						else if (o.acceleratetype >= 0) {
							addMarker(o.siteId - 1, [location.lng, location.lat], 1, o);
						}
					});
				});
			});
		}

	//生成class
		function generateclass(siteId){
			var str='';
			for(var i=(siteId-1);i>=0;i--){
				str+=' v'+i+' ';
			}
			return str;
		}
	
		function generateclass1(siteId){
			 var html='';
			$.each(siteinfo,function(i,o){
				html+='<dl><dt>0</dt>';
				if(o.id==siteId){
					html+='<dd style="display: block;">';
				}else{
					html+='<dd>';
				}
				html+='<span class="member-ico v'+o.id+'"></span>'+o.name+'</dd></dl>';
			});
				
			return html;
		}
	
	
		function generateclass2(siteId,licheng,toltal){
				var html='';
					var width=119*(licheng/toltal);
				$.each(siteinfo,function(i,o){
					var w=0;
					if(i==0)return true; 
					if(siteId>i){
						w=17;
					}else if(siteId==i){
							w=7;
						}else{
							w=0;
					
					}
					/*if(width>17){
						w=17;
						width=width-17;
					}else if(width<=0){
						w=0;
					}else{
						w=width;
						width=0;
					}*/
					html+='<i class="progress-box-'+i+'" style="width: '+w+'px;"></i>';
	
				});
				return html;
	
		}
		
		
		function getUltimatePrize() {
			var index = layer.load(2);
			$.get('/yingpu/pc/activity1/bigPrize/json', {}, function(data) {
				layer.close(index);
				if (data.status == 'success') {
					layer.msg('领取成功！');
					$('.ultimate-prize').fadeOut();
					gDrawInfo[888888] = {};
				}
			});
		}

		$(function() {
			if (isLogin()) {
				getMyActivity1HistoryInfo();
				getMyActivity1UserInfo();
			}
			
		})


	</script>
	</body>
</html>
