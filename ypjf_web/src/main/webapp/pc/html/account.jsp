
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String[] pTypes = {
		"","","","","","","","","","","","",
		"qi", "che", "fang"	
};

request.setAttribute("types", pTypes);



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
		<link rel="stylesheet" type="text/css" href="../css/account.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>-->
		<style>
		.account-personal .personal-pic .shade {
			position: absolute;
		    width: 100%;
		    height: 88px;
		    line-height: 88px;
		    text-align: center;
		    display: block;
		    margin: 0 auto 6px;
		 }
		 
		 .account-personal .personal-pic .shade:hover {
		 	cursor: pointer;
		 }
		 
		 .account-personal .personal-pic .shade span{
		    width: 88px;
		    height: 88px;
		    line-height: 88px;
		    border-radius: 44px;
		    text-align: center;
		    display: block;
		    margin: 0 auto 6px;
		    background: #000;
		    color: #fff;
		    opacity: 0;
		 }
		 .project-rec ul li:first-child{
		 	position: relative;
		 }
		 .project-rec ul li:first-child .add-interest{
		 	position: absolute;
		    right: 4px;
		    top: -7px;
		    padding: 0 5px;
		    font-size: 12px;
		    color: #fff;
		    background: #FFA24D;
		    border-radius: 10px;
		    height: 20px;
		    line-height: 20px;
		 }
		</style>
	</head>
	<body>
		<!--顶部-->
		<input type="file" style="display: none;" id="file-input" name="file" />
		<iframe src="../head3.html?index=6" width="100%" scrolling="no" name="head"  style="border:0px;"></iframe>
		<!--主体-->
		<div class="account-box">
			<div class="center clearfix">
				<!--左边导航-->
				
				<div class="account-nav left">
					
					<iframe src="../myaccount/account_sidebar.html" width="100%" height="722" scrolling="no"  style="border:0px;"></iframe>
					
				</div>
				<!--右边主体部分-->
				
				<div class="account-main left">
					<!--资产统计-->
					<div class="assets-count" id="assetsCount">	
						<!--个人头像等-->
						<div class="account-msg clearfix">
							<div class="account-personal left">
								<div class="personal-pic left" style="position: relative;">
									<div class="shade">
										<span>更换头像</span>
									</div>
									<img src="${not empty pcuser.header ? pcuser.header : ''}" id="user-avatar" />
									<a title="电话注册" href="security_settings.jsp"><span class="renzhen dxrz over"></span></a>
									<a title="实名认证" href="security_settings.jsp"><span class="renzhen smrz ${pcuser.isIdCard == '是' ? 'over' : ''}" ></span></a>
									<a title="绑定银行卡" href="mycard.jsp"><span class="renzhen yhkrz ${pcuser.isIdCard == '是' ? 'over' : ''}"></span></a>
									<a title="邮箱验证" href="security_settings.jsp"><span class="renzhen yxyz ${not empty pcuser.email ? 'over' : ''}"></span></a>
								</div>
								<div class="personal-txt left">
									<p class="name">您好，${pcuser.phone}</p>
									<p class="des" id="wenhou"></p>
								</div>
							</div>
							<div class="line left"></div>
							<div class="account-sign right">

							<c:if test="${data.jandao  ==0}">
								<input type="button" id="qiandao" value="每日签到" />
							</c:if>

							<c:if test="${data.jandao  >0}">
								<input type="button" id="qiandao"  style="background-color:#ccc;"  value="已签到" />
							</c:if>
								<p>每天签到，领现金奖励</p>
								<a href="mysignrewards">查看签到记录</a>
							</div>
						</div>
						
						<!--个人投资收益等-->
						<div class="account-sum">
							<ul>
							<li class="list">
									<p class="num">  <fmt:formatNumber type="number" value="${data.zichan == '' || data.zichan==null ? '0.00' : data.zichan} " pattern="0.00" maxFractionDigits="2"/></p>
									<p class="des">资产总额（元）<span class="icon"><i>总资产=可用余额+待收本金+提现在途+天天存吧</i></span></p>

										</li>
								<li class="center-line"></li>
								<li class="list">
									<p class="num org"> <fmt:formatNumber type="number" value="${data.shouyi ==null||data.shouyi == '' ? '0.00' : data.shouyi} " pattern="0.00" maxFractionDigits="2"/></p>

									<p class="des">已赚取收益（元）<span class="icon"><i>已赚取收益是指所投到期项目已经还本付息中的利息。</i></a></p>
								</li>
								
								
								<li class="center-line"></li>
								<li class="list">
									<p class="num"><fmt:formatNumber type="number" value="${data.daihuoqu == '' || data.daihuoqu ==null  ? '0.00' :data.daihuoqu }" pattern="0.00" maxFractionDigits="2"/></p>
									<p class="des">待获取收益（元）<span class="icon"><i>待获取收益是指项目尚未到期还款，收益尚未到账。</i></span></p>
								</li>
							</ul>
						</div>
						
						<!--个人资产分布等-->
						<div class="asset-allocation clearfix">
							<div class="asset-allocation-l left">
								<h3>资产分布</h3>
								<div class="asset-allocation-chart">
									<div class="chart-text left">
										<p><span class="asset-icon1"></span>可用余额</p><span class="money">￥ <fmt:formatNumber type="number" value="${ pcuser.caBalance =='' || pcuser.caBalance ==null ? '0.00' : pcuser.caBalance }" pattern="0.00" maxFractionDigits="2"/>元</span>
										<!--<p class="even"><span class="asset-icon2"></span>待收收益</p>  <span class="money">￥<fmt:formatNumber type="number" value="${data.daihuoqu == '' || data.daihuoqu ==null  ? '0.00' :data.daihuoqu }" pattern="0.00" maxFractionDigits="2"/>元</span>-->
										<p><span class="asset-icon3"></span>待收本金</p>  <span class="money">￥ <fmt:formatNumber type="number" value="${pcuser.nowInvestAmount =='' ||pcuser.nowInvestAmount==null ? '0.00' : pcuser.nowInvestAmount}" pattern="0.00" maxFractionDigits="2"/>元</span>
										<p class="even"><span class="asset-icon4"></span>提现在途</p>  <span class="money">￥ <fmt:formatNumber type="number" value="${data.tixian  =='' || data.tixian  ==null  ? '0.00' : data.tixian  }" pattern="0.00" maxFractionDigits="2"/>元</span>
										<p><span class="asset-icon2"></span>天天存吧</p>  <span class="money">￥<fmt:formatNumber type="number" value="${pcuser.yebBalance ==''  || pcuser.yebBalance ==null ? '0.00' : pcuser.yebBalance}" pattern="0.00" maxFractionDigits="2"/>元</span>
									</div>
									<div class="chart-pic left" id="chartPie" style="width: 250px;height: 250px;margin-left: 20px;"></div>
								</div>
							</div>
							<div class="asset-allocation-r left">
								<div class="asset-useable">
									<p class="num"> <fmt:formatNumber type="number" value="${ pcuser.caBalance =='' || pcuser.caBalance ==null ? '0.00' : pcuser.caBalance }" pattern="0.00" maxFractionDigits="2"/></p>
									<p class="des">可用余额（元）</p>
								</div>
								<div class="asset-flow">
									<ul class="clearfix">
										<li class="list left">
											
											<p class="num"> <fmt:formatNumber type="number" value="${pcuser.cfBalance =='' || pcuser.cfBalance ==null ? '0.00' : pcuser.cfBalance}" pattern="0.00" maxFractionDigits="2"/></p>
											<p class="des">冻结金额（元）<span class="icon"></span></p>
										</li>
										<li class="center-line left"></li>
										<li class="list left">
											<p class="num">  <fmt:formatNumber type="number" value="${data.tixian  =='' || data.tixian  ==null ? '0.00' : data.tixian  }" pattern="0.00" maxFractionDigits="2"/></p>
											<p class="des">提现在途（元）<span class="icon"></span></p>
										</li>
									</ul>
								</div>
								<div class="asset-flow-btn">
									<input type="button" name="" id="" onclick=" javascript:location.href='../myaccount/deposit';" value="充值" class="over"/>
									<input type="button" name="" id="" onclick=" javascript:location.href='../myaccount/withdraw_deposit.html';" value="提现" />
								</div>
								<div class="asset-list">
									<a href="../myaccount/mytransaction.jsp">查看交易记录</a>
								</div>
							</div>
						</div>
					
						<!--为您推荐-->
						<div class="project-rec">
							<h3>为您推荐</h3>
							<div class="project-title">
								<!--<h4>${data.project[0].name} <span>信息保障</span><span>第三方担保</span></h4>-->
								<h4>${data.project[0].name}
									<span class="${types[data.project[0].categoryId	]}"></span>
									<span class="quan"></span>
									<span class="xi"></span>
								</h4>	
							</div>
							<ul class="clearfix">
								<li>
									<p><span class="large org" id="rate"><fmt:formatNumber type="number" value="${data.project[0].estimatedAnnualRate*100}" pattern="0.00" maxFractionDigits="2"/></span><span class="small">%</span> </p>
									<p>预期年化收益率</p>
									<%--<span class="add-interest">加息0.5%</span>--%>
								</li>
								<li>
									<p><span class="large" id="term">${data.project[0].deadLine}</span><span class="small">月</span> </p>
									<p>借款期限</p>
								</li>
								<li>
									<p><span class="large" id="quota">${data.project[0].financingAmount}</span><span class="small">元</span> </p>
									<p>剩余额度</p>
								</li>
								<li>
									<div class="progress-circle" id="indicatorContainer"  totalAmount="${data.project[0].totalAmount}"  financingAmount="${data.project[0].financingAmount}"></div>
									<p>投资进度</p>
								</li>
								<li>
									<a href="../projectdetails?projectid=${data.project[0].id}" class="invest-btn">立即投资</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--客服悬浮条-->
		<iframe src="../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
		<iframe src="../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>
		<script src="../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		<!--底部导航-->
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>

		<!--加载js文件-->
	<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/echarts.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/radialIndicator.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/utils.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../js/jquery/ajaxfileupload.js"></script>
	<script type="text/javascript">
//		$(function(){
//			//a标签样式
//			$("#sideBar li a").each(function(){
//			   $(this).click(function(){ 
//			   	  //console.log($("#sideBar li"));
////			 	  $("#sideBar li h4").removeClass("on");
////			 	  $(this).parent().find("h4").addClass("on");
//			 	  $("#sideBar li a").removeClass("active");
//			 	  $(this).addClass("active");
//			 	  console.log($(this)) 
//			   });
//	   	  	});
//	   	  	//点击标题收起
//	   	  	$("#sideBar li h4").each(function(){
//			   $(this).click(function(){ 
//			   	  //console.log($("#sideBar li"));
//			   	  $(this).toggleClass('on');
//			 	  $(this).parent().find("a").toggle('slow');
//			   });
//	   	  	});
//		});	

			//资产分布图表
		$(function(){
			//配置路径
			require.config({
	            paths: {
	                echarts: '../js/build/dist'
	            }
	       });
	        // 使用
	        require(
	            [
	                'echarts',
	                'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
	            ],
	         function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('chartPie')); 
				var option = {
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
 
//				    calculable : true,
				    series : [
				        {
				            name:'资产分布',
				            type:'pie',
				            radius : ['40%', '70%'],
				            itemStyle : {
				                normal : {
				                    label : {
				                        show : false
				                    },
				                    labelLine : {
				                        show : false
				                    }
				                },
				                emphasis : {
				                    label : {
				                        show : true,
				                        position : 'center',
				                        textStyle : {
				                            fontSize : '14',
				                            fontWeight : 'normal'
				                        }
				                    }
				                }
				            },

				           

				            data:[
				                {value:'<fmt:formatNumber type="number" value="${ pcuser.caBalance =='' || pcuser.caBalance ==null ? '0.00' : pcuser.caBalance }" pattern="0.00" maxFractionDigits="2"/>', name:'可用余额'},
//				                {value:'<fmt:formatNumber type="number" value="${data.daihuoqu == '' || data.daihuoqu ==null  ? '0.00' :data.daihuoqu }" pattern="0.00" maxFractionDigits="2"/>', name:'待收收益'},
				                {value:'<fmt:formatNumber type="number" value="${pcuser.nowInvestAmount =='' ||pcuser.nowInvestAmount==null ? '0.00' : pcuser.nowInvestAmount}" pattern="0.00" maxFractionDigits="2"/>', name:'待收本金'},
				                {value:'<fmt:formatNumber type="number" value="${data.tixian  =='' || data.tixian  ==null  ? '0.00' : data.tixian  }" pattern="0.00" maxFractionDigits="2"/>', name:'提现在途'},
				                {value:'<fmt:formatNumber type="number" value="${pcuser.yebBalance ==''  || pcuser.yebBalance ==null ? '0.00' : pcuser.yebBalance}" pattern="0.00" maxFractionDigits="2"/>', name:'天天存吧'}
				            ]
				        }
				    ]
				};
	        //使用制定的配置项和数据显示图表
	        myChart.setOption(option);
	     	}
        );
    });
		
			
	$('.shade span').click(function() {
		$('#file-input').val('').click();
	});
	
	
	$(document).on('change', '#file-input', function() {
		if (!/(?:jpg|png|bmp|jpeg|gif|ico)$/.test($(this).val())) {
			layer.msg('上传的头像只能是图片格式 (jpg/png/bmp/ico)！');
			return;
		}
		
		if (this.files[0] && this.files[0].size > 1024 * 1024) {
			layer.msg('上传的头像大小不能超过1MB，请重新选择！');
			return;
		}

		uploadFile($(this).attr('id'), function(data) {
			if (!!data) {
				$('#user-avatar').attr('src', data);
				updateUserAvatar(data);
			}
		});
	})
	.on('mouseover', '.shade', function() {
		$('.shade span').stop().animate({opacity : 0.3});
	})
	.on('mouseout', '.shade', function() {
		$('.shade span').stop().animate({opacity : 0});
	});
	
	
	function updateUserAvatar(data) {
		useLoadingShade();
		$.post('../myaccount/doChangeUserAvatar', {
			header : data
		}, function(data) {
			if (data.status == 'success') {
				layer.msg('更换头像成功！');
			}
			else{
				layer.msg('对不起更换头像失败，请稍后再试！');
			}
			
			cancelLoadingShade();
		}, 'json');
	}
	
	
	function onError(msg) {
		layer.alert(msg || '上传出错');
	}
	
	
	function uploadFile(eleId, successCallback) {
		var index = layer.load(2, { shade : [0.5, '#fff'] });
		$.ajaxFileUpload({
            url : '/yingpu/adminFileUpload',
            secureuri : false,
            fileElementId : eleId,
            dataType : 'text',
            data : { from : 'frontend' },
            success : function(data, status) {
            	if (data.indexOf('出错') != -1) {
            		onError(data);
            		return;
            	}
            	successCallback && successCallback(data);
            },
            error : function(data, status, e) {
           		onError(data);
            }, 
            complete : function() {
            	layer.close(index);
            }
        });
	}
    
	
    //为您推荐的圆形进度条
    $(function(){
	    var radialObj2 = $('#indicatorContainer').radialIndicator({
	        barColor: '#ff7f01',
	        barWidth: 8,
//		        initValue: 40,
	        roundCorner: true,  //如果设置为true则圆形指示器的刻度bar有圆角。
	        percentage: true, //设置为true显示圆形指示器的百分比数值。
	        fontSize: 20,
	        fontColor: '#666'
	    }).data('radialIndicator');
	    var totalAmount=$('#indicatorContainer').attr('totalAmount');
		var financingAmount=$('#indicatorContainer').attr('financingAmount');
		var yitouzi=	accAdd(totalAmount,-financingAmount);
	    radialObj2.animate(accMul(100,accDiv(yitouzi,totalAmount).toFixed(4)));//启动动画
	    $('#qiandao').click(function(e){
	    	useLoadingShade();
	    	$.post('./signhis',{type:1,osType:'pc'},function(data){

	    		

	    		if(data.message=='签到成功'){
	    			layer.alert(data.message);
	    			$('#qiandao').attr({'style':'background-color:#ccc;','value':'已签到'});
	    		}else{
	    			layer.alert(data.message);
	    		}
	    		
	    	});
	    });

	    $('#wenhou').text(wenhou());
    });


    //  问候语

function wenhou(){
	var now = new Date(),hour = now.getHours() 
		if(hour < 6){ return ("早点休息！明天的阳光更灿烂！ ")} 
		else if (hour < 12){ return "早上好，一日之计在于晨！今天要努力哦！"} 
		else if (hour < 18){ return "下午好，做一个微笑挂在嘴边，快乐放在心上的人！"} 
		else if (hour < 24){ return "晚上好，夜色如黛，万家灯火，和家人在一起最最幸福！！"} 
		else { return ""}
	}
	</script>
	</body>
</html>
