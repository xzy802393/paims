<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		<link rel="stylesheet" type="text/css" href="css/myrewards.css"/>
		<link rel="stylesheet" type="text/css" href="css/sign2.css"/>

		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
	</head>
	<body>
		<!--顶部-->
		<iframe src="../head3.html" width="100%" scrolling="no"  style="border:0px;"></iframe>
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
				
				<!--每日签到-->
				<div class="signrewards left" id="signRewards">
					<div class="signrewards-main clearfix">
						<div class="signrewards-sign left">

							<c:if test="${data.jandao.num ==0}">
							<div class="sign-btn" onclick="">
							
								
											<a href="javascript:qiandao();" class="sign-y">今日签到</a>
							</div>
							</c:if>
							<c:if test="${data.jandao.num >0}">
							<div class="sign-btn no" onclick="">
											<a href="#" class="sign-n" >今日已签</a>
							</div>
							</c:if>

							
							
							<p class="day">您已经签到 <span>${data.tianshu.tianshu}</span> 天</p>
							<img src="../img/account/sign-rewards-pic_03.png"/>
							<p class="get">每天签到领现金红包</p>
							<!--<p class="money">昨日签到获取奖励 <span>${data.daycount}</span> 元</p>-->
						</div>
						<div class="signrewards-records left">
							<div style="background: #fcfcfc;" id="calendar"></div>
							<!--<div id="sign_note" style="text-align:center;position: relative;padding: 15px;font-size: 14px;">
								<span style="color:red;">*规则：本月签到21天即可领取奖品</span>
							</div>-->
							<button onclick="$('#signRewards').hide();$('#signRecords').show()">查看签到记录</button>
						</div>
					</div>
					<div class="signrewards-list">
						<div class="signrewards-list-bc">
							<div class="date">
								<span class="date-date" id="todayDate"></span>
								<span class="date-day" id="todayDay"></span>
							</div>
							<!-- <p class="num">今日已有<span>${data.daycount}</span>人签到</p> -->
							<div class="signrewards-list-contain" id="scrollAd">

							<c:forEach var="o" items="${data.daylists}">
								<p>用户${fn:substring(o.phone, 0, 3)}****${fn:substring(o.phone, 7, 11)} <span class="sign-in-time">${o.createTime}</span></p>


						</c:forEach>	
							</div>
						</div>
					</div>
					

				</div>
							
				<!--签到记录-->
				<div class="sign-records left" id="signRecords">
					<h3>我的签到</h3>
					<div class="sign-earn">
						<ul>
							<li class="list">
								<p>累计获取收益</p>
							</li>
							<li class="line"><span></span></li>
							<li class="list">
								
								<p><span>${data.amount.amount}</span>元</p>
							</li>
							<li class="list">

							<c:if test="${data.jandao.num ==0}">
								<button  onclick="qiandao();" id="qiandao">立即签到</button>
							</c:if>
							<c:if test="${data.jandao.num>0}">
								<button  onclick="qiandao();" id="qiandao" style="background-color:#bfbfbf;"  >已签到</button>

							</c:if>
							</li>
						</ul>
					</div>
					
					<h3>签到记录</h3>
					<table border="0" cellspacing="" cellpadding="" >
						<tr class="title">
							<th>签到时间</th>
							<th>签到奖励</th>
							<th>奖励状态</th>
						</tr>
					<tbody id="hisinfo"></tbody>
				
					</table>
					
					<div class="record-page">
								<!--页码-->
								<div class="page">
									<div class="page-list" id="pageList">
										<a onclick="go('home')">首页</a>
										<a onclick="go('prev')">上一页</a>
										<span id="page-nav-btn">
										</span>
										<a onclick="go('next')">下一页</a>
										<a onclick="go('tail')">尾页</a>
									</div>
								</div>
							</div>
					
					<div class="sign-rule">
						<p>签到规则</p>
						<p>APP签到红包为当天所有签到用户平均分配，红包总额由工作人员提前1天设定；</p>
						<p>随着签到人数增加，人均奖励会逐步降低；</p>
						<p>当日签到奖励状态为“待分配”，奖励次日到账。当日签到奖励金额不等于最终到账金额。</p>
						<p>积极签到，分享快乐。</p>
					</div>
				</div>
			</div>
		</div>
	<!--客服悬浮条-->
		<!--客服悬浮条-->
		<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<!--底部导航-->
		
	<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		<!--加载js文件-->
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/Ecalendar.jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="js/calendar2.js"></script>
	<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../layer-v3.0.3/layer/layer.js"></script>
	<script type="text/javascript">
        function stampToDatetime(stamp) {
            if (stamp) {
                var num, remain, unit;

                remain = stamp / 1000;
                if (remain >= 86400) {
                    num = Math.floor(remain / 86400);
                    remain = remain % 86400;
                    unit = '天';
                }
                else if (remain >= 3600) {
                    num = Math.floor(remain / 3600);
                    remain = remain % 3600;
                    unit = '小时';
                }
                else if (remain >= 60) {
                    num = Math.floor(remain / 60);
                    remain = remain % 60;
                    unit = '分钟';
                }
                else {
                    num = remain;
                    unit = '秒';
                }
                if (unit == '秒' && num < 60) {
                    return '刚刚';
                }

                return num + unit;
            }

            return '';
        }

		$('.sign-in-time').each(function(i, e) {
		    var stamp = new Date($(e).html() || new Date().getTime()).getTime(),
                timeInterval = stampToDatetime(new Date().getTime() - stamp);
		    $(e).html(timeInterval == '刚刚' ? timeInterval : timeInterval + '前');
        })
		
		$(function(){
			//投资记录切换
			$("#menu li").each(function(){
				$(this).click(function(){
					$("#menu li").removeClass("active");
					$(this).addClass("active");
				});

			
			})

	loadList();
		});
		
			function loadList(){
				$.post('../myaccount/signhis/list/json',{pageIndex:pageIndex,projectId:'${data.project[0].id}',pageSize:4},function(data){
				var 	dat=data;

					pageIndex = dat.page.pageIndex;
					pageCount = data.page.pageCount;
					pageSize=data.page.pageSize;
					data=data.data;
					var html='';

					$.each(data,function(i,o){
							console.log(html);

							html+='<tr><td>'+o.createTime+'</td>';
							html+='<td>'+(o.money==undefined ? '未分配' :o.money)+'</td>';
							html+='<td>'+(o.isSend=='是' ? '已到账' : '未分配')+'</td></tr>';
					});
					$('#hisinfo').empty();
				$('#hisinfo').append(html);		
				generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');					
									
								

				});
			}

	</script>
	<script type="text/javascript">
		$(function(){
		  //ajax获取日历json数据

		  var datas=JSON.parse('${data.usersign}');
		  var createTime='';
		  var arr=[];
		  for(var i=0;i<datas.length;i++){
		  		day =datas[i].createTime;
		  		day=day.substring(day.lastIndexOf('-')+1,day.lastIndexOf('-')+3);

		  		arr.push({"signDay":day});
		  }

		  var signList=[{"signDay":new Date().getDate()},{"signDay":"11"},{"signDay":"12"},{"signDay":"13"}];
		   calUtil.init(arr);
		   $('#sign_layer').attr('disabled','disabled');
		});
		
		$(function(){
			$("#todayDate").html(new Date().getDate());
			var d = new Date();
			var today = new Array('星期日','星期一','星期二','星期三','星期四','星期五','星期六');  
			$("#todayDay").html(today[d.getDay()]);
		});
		
		
		
		//内容滚动
		function myGod(id,w,n){
			//id 为父元素的ID，w为默认多久滚动一次，n 为朝上还是朝下滚
			var box=document.getElementById(id),can=true,w=w||1500,fq=fq||10,n=n==-1?-1:1;
			box.innerHTML+=box.innerHTML;
			box.onmouseover=function(){can=false};
			box.onmouseout=function(){can=true};
			var max=parseInt(box.scrollHeight/2);
			new function (){
			   var stop=box.scrollTop%18==0&&!can;
			   if(!stop){
			    var set=n>0?[max,0]:[0,max];
			    box.scrollTop==set[0]?box.scrollTop=set[1]:box.scrollTop+=n;
			   };
			   setTimeout(arguments.callee,box.scrollTop%18?fq:w);
			};
		};
		
		myGod('scrollAd',1500);


		//签到

		function qiandao(){
			useLoadingShade();
			
				$.post('./signhis',{type:1,osType:'pc'},function(data){

	    		if(data.message=='签到成功'){
	    			$('#qiandao').attr({'value':'已签到','style':'background-color:#fff;'});
	    			layer.alert(data.message);
	    		}else{
	    			layer.alert(data.message);
	    		}
	    		
	    	});


		}
	</script>
	
	</body>
</html>
