<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=1220"/>
    <title>营普金服—参股商业银行的互联网金融服务平台</title>
    <!--<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">-->
    <meta name="Description"
          content="营普金服，法人持股商业银行，重庆富民银行资金存管，深圳前海股权交易中心上市，股权代码366066。超短期理财，100元起投，安全合规专业高效的互联网金融服务平台。"/>
    <meta name="Keywords"
          content="营普金服,yingpujinfu,营普,yingpu,网贷,P2P,网络借贷,红包,车贷融,房贷融,优企融,个人投资理财,互联网理财,金融理财,短期理财,借款,营夏"/>
    <link rel="shortcut icon" href="../../img/logo1.icon"/>
    <link rel="stylesheet" type="text/css" href="../../css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/guess_worldcup.css"/>
	<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>

<!--顶部-->

<iframe src="../../head.html" class="iframe-head" width="100%" scrolling="no" style="border:0px;display: none;"></iframe>

<!--主体-->
<div class="content">
    <div class="banner">
        <div class="center">
            <div class="act-tit">
                <img src="img/guess_wordcup/tit.png"/>
            </div>

            <div class="act-des">
                6月14日-7月15日起只要是在营普金服注册（实名认证并绑定银行卡）的用户，在世界杯期间参与竞猜胜平负，猜中的用户即可瓜分红包，每天都有千元红包相送，无门槛无限制，只要猜中就有红包相送！
            </div>
        </div>
    </div>
    <div class="main">
       <div class="section center">
       		<div class="sec-tit">
       			<h4>竞猜胜平负</h4>
       		</div>
       		<div class="history">
       			<div class="current">
      				<ul class="container clearfix " id="detail">
       					<li class="item">
       						<div class="team">
       							<img id="img1" src="img/guess_wordcup/Russia.png"/>
       							<span id="team1Name"></span>
       						</div>
       					</li>
       					<li class="item vs">
       						<div class="score" id="teamScore"></div>
       						<div class="time" id="teamStratTime"></div>
       					</li>
       					<li class="item">
       						<div class="team">
					<img id="img2" src="img/guess_wordcup/saudi.png"/>
					<span id="team2Name"></span>
				</div>
					</li>
					</ul>
       			</div>
       			
       			<div id="box0">
       				<div id="box1">
       					<div id="box2">
       						<div class="listbox" id="listBox">
			       			</div>
       					</div>
       				</div>
       				<div id="scroll-bar">
			            <div id="scroll-btn"></div>
			        </div>
       			</div>
			</div>

       </div>
       <!--当天比赛-->
       <div class="section currentgame">
       		<div class="gamecontainer center">

       			<ul class="gamelist clearfix" id="listToday">


       			</ul>
       			
       			<div class="personal-record">
       				<a href="javascript:void(0)" onclick="goPersonalrecord()">我的竞猜记录</a>
       			</div>
       		</div>
       </div>

       <!--获奖记录-->
       <div class="section rewardslist">
       		<div class="rewards-tit">
       			<h4>千元现金红包</h4>
       		</div>
       		<div class="rewards-box center">
				<table class="tit" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th>中奖用户</th>
						<th>对战场次</th>
						<th>中奖金额</th>
					</tr>
				</table>
       				<div class="rewards0">
       					<div class="rewards1" >
       					    <div class="rewards2" id="rewards2">
       					    	<table class="recordbox">
       							</table>

       						</div>
	       				    <div class="scroll-bar" id="rewardsScrollbar">
				                <div class="scroll-btn" id="rewardsScrollbtn"></div>
				        	</div>
       			        </div>
       			  </div>
       		</div>
       </div>

    </div>

    <div class="instruction">
    	<div class="invest-btn">
	    	<a href="">立即注册</a>
	    </div>
        <div class="act-des">
            <h5>活动说明</h5>
            <div class="ins-main">
            	<dl>
	                <dt>1、</dt>
	                <dd>用户获奖后，可与营普金服客服取得联系，安排后续发货兑奖，请您保持通讯畅通。</dd>
	            </dl>
	            <dl>
	                <dt>2、</dt>
	                <dd>虚拟奖品以电子验证码、赠送等方式兑换；实物奖品均由第三方发货，营普金服不负责售后 质量问题。如用户提供的收货地址、收货人联系方式错误，损失由用户自行承担。
	                </dd>
	            </dl>
	            <dl>
	                <dt>3、</dt>
	                <dd>所有礼物，不支持现金折现。请在活动结束前，及时使用您的抽奖机会。</dd>
	            </dl>
            </div>

        </div>
    </div>
</div>
<input type="hidden" id="1" value="+team1Score+">

<!--客服悬浮条-->
<!--<iframe src="../../xuanfutiao.jsp" class="iframe-xuanfutiao" onload="$(this).show()" scrolling="no"></iframe>
<iframe src="../../jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no"></iframe>-->
<script src="../../js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
<script src="../../js/utils.js" type="text/javascript" charset="utf-8"></script>

<!--底部导航-->
<iframe src="../../footer.html" width="100%" scrolling="no" style="border:0px;height:326px;"></iframe>

<!--加载js文件-->
<script src="../../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../../.././layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="js/scroll-bar.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	//加载赛事信息。
    $.get('/yingpu/pc/worldCup/list/json',{},function(data){
			if(data.status=='success') {
                var date = new Date(data.data.nowTime).Format("yyyy-MM-dd");//从后台获取当前时间
				if(date=='2018-06-13'){
				    date='2018-06-14';
				}
                if(date=='2018-06-29'){
                    date='2018-06-28';
                }
                if(date=='2018-07-04'||date=='2018-07-05'){
                    date='2018-07-03';
                }
                if(date=='2018-07-08'||date=='2018-07-09'){
                    date='2018-07-07';
                }
                if(date=='2018-07-12'||date=='2018-07-13'){
                    date='2018-07-11';
                }
                var listBox = '';//遍历展示所有的比赛场次
                var listToday = '';//展示当天的比赛场次
				var listGuess='';
				var listBian='';
                $("#listBox").empty();
                $("#listToday").empty();
                $(".recordbox").empty();
                var count = 0;
                var teamInfo = data.data.teamInfo;
                var userInfo = data.data.userInfo;
                var u=data.data.u;
                for (var i = 0; i < teamInfo.length; i += 2) {
                    var win1 = teamInfo[i].isWinner == 1 ? "win" : " ";//哪对赢了给哪队加win标签
                    var win2 = teamInfo[i + 1].isWinner == 1 ? "win" : "";
                    var team1Score = teamInfo[i].score;//两个队的比分
                    var team2Score = teamInfo[i + 1].score;
                    listBox += '<ul class="container clearfix">'
                        + '<li class="item" >'
                        + '<div class="team ' + win1 + ' ">'
                        + '<input type="hidden"  value="' + team1Score + '">'
                        + '<span class="win"></span>'
                        + ' <img src="img/guess_wordcup/' + teamInfo[i].name + '.png"/>'
                        + '<input type="hidden"  value="' + teamInfo[i].name+ '">'
                        + '<span class="zhongwen1">' + teamInfo[i].chineseName + '</span>'
                        + '</div>'
                        + '</li>'
                        + '<li class="item vs">'
                        + '<div> vs </div>'
                        + '<input type="hidden"  value="' + teamInfo[i].startTime + '">'
                        + '</li>'
                        + '<li class="item" >'
                        + '<div class="team ' + win2 + '">'
                        + '<input type="hidden"  value="' + team2Score + '">'
                        + '<span class="win"></span>'
                        + '<img src="img/guess_wordcup/' + teamInfo[i + 1].name + '.png"/>'
                        + '<input type="hidden"  value="' + teamInfo[i+1].name+ '">'
                        + '<span class="zhongwen2">' + teamInfo[i + 1].chineseName + '</span>'
                        + '</div>'
                        + '</li>'
                        + '</ul>'


                    if (teamInfo[i].startDate == date) {
                        count++;
                        var startTime = teamInfo[i].startTime;
                        var time = new Date(startTime);
                        var beginTime = p(time.getHours()) + ':' + p(time.getMinutes());
                        listToday += '<li class="list">'
                            + '<ul class="team clearfix">'
                            + '<li class="teamA" id="' + teamInfo[i].tmId + '">'
                            + '<input type="hidden"  value="' + team1Score + '">'
                            + '<img class="teamimg" src="img/guess_wordcup/' + teamInfo[i].name + '.png"/>'
                            + '<input type="hidden"  value="' + teamInfo[i].name+ '">'
                            + '<p class="teamname">' + teamInfo[i].chineseName + '</p>'
                            + '</li>'
                            + ' <li class="teamT">'
                            + '<p>vs</p>'
                            + '<p>竞猜截止时间</p>'
                            + '<p>' + beginTime + '</p>'
                            + '</li>'
                            + '<li class="teamB">'
                            + '<input type="hidden"  value="' + team2Score + '">'
                            + '<input type="hidden"  value="' + teamInfo[i].startTime + '">'
                            + '<img src="img/guess_wordcup/' + teamInfo[i + 1].name + '.png"/>'
                            + '<input type="hidden"  value="' + teamInfo[i+1].name+ '">'
                            + '<p class="teamname">' + teamInfo[i + 1].chineseName + '</p>'
                            + '</li>'
                            + '</ul>'
                            + '<div class="guess">'
                            + '<div class="guess-select clearfix">'
                            + '<span class="guess-option win" id="' + teamInfo[i].startTime + "-" + teamInfo[i].scoreInfoId + "-" + teamInfo[i].tmId + '">' + teamInfo[i].chineseName + ' 胜' + '</span>'
                            + '<span class="guess-option equal " id="' + teamInfo[i].startTime + "-" + 0 + "-" + teamInfo[i].tmId + '">平局</span>'
                            + '<span class="guess-option fail" id="' + teamInfo[i + 1].startTime + "-" + teamInfo[i + 1].scoreInfoId + "-" + teamInfo[i + 1].tmId + '">' + teamInfo[i + 1].chineseName + ' 胜' + '</span>'
                            + '</div>'
                            + '<div class="guess-confirm id="'+i+'"">确定</div>'
                            + '</div>'
                            + '</li>'
                    }
                }

                if (count == 1) {
                    $("#listToday").addClass("gamelist1")
                }
                if (count == 2) {
                    $("#listToday").addClass("gamelist2")
                }
                if (count == 3) {
                    $("#listToday").addClass("gamelist3")
                }
                $("#listBox").html(listBox);
                $("#listToday").html(listToday);
                var a = [];
                $("#listToday").find(".teamA").each(function (i, o) {
                    a.push($(o).attr("id"));
                });
                var b= $("#listToday").find(".guess-confirm")//获取确定按钮

                if (userInfo != null) {
                    for (var i = 0; i < a.length; i++) {
                        for (var j = 0; j < userInfo.length; j++) {
                            if (a[i] == userInfo[j].matchId) {
                                $(b[i]).html("已竞猜");
                                $(b[i]).addClass("over");
                            }
                        }
                    }
                }
                //显示当天第一场比赛
//                		var first= $("#listBox").find(".container clearfix").eq(0);
//                        var team1E=first.find("src").eq(0).val();
//                        var teamName1=first.find(".teamA .teamname").html();
//                        var teamName2=first.find(".teamB .teamname").html();
//                        var team1Score=first.find('input').eq(0).val();
//                        var team1E=first.find("input").eq(1).val();
//                        var team2Score=first.find('input').eq(2).val();
//                        var startTime=first.find('input').eq(3).val();
//                        var team2E=first.find("input").eq(4).val();
						var date=new Date(u[0].startTime);
                       var date1 =date.Format("MM-dd hh:mm");

                       if( !/^\d+$/.test(u[0].score) || !/^\d+$/.test(u[1].score)){
                           $("#teamScore").html(0+':'+0);
					   }
					   else{
                           $("#teamScore").html(u[0].score+':'+u[1].score);
					   }

                        $("#team1Name").html(u[0].chineseName);
                        $("#team2Name").html(u[1].chineseName);
                      	 $("#teamStratTime").html(date1);
                        $("#img1").attr("src","img/guess_wordcup/"+u[0].name+".png");
                        $("#img2").attr("src","img/guess_wordcup/"+u[1].name+".png");


                //展示用户中奖信息
				var guessInfo=data.data.guessInfo;
                for (var i=0;i<guessInfo.length;i++)
                {
                    listGuess+='<tr>'
                			+'<td>'+guessInfo[i].phone+'</td>'
                			+'<td>'+guessInfo[i].matchTeams+'</td>'
                			+'<td>现金'+guessInfo[i].getMoney+'元</td>'
							+'</tr>'
                }
                $(".recordbox").html(listGuess);


			}
	})

    //时间不够10的加0补充
    function p(s) {
        return s < 10 ? '0' + s: s;
    }
    useLoadingShade();
    function getEncodedCurrentURL() {
        return encodeURIComponent(location.href);
    }

    function showLoginPrompt() {
        layer.alert('对不起，登陆后才可以竞猜，请先登录!', { btn : ['登录', '取消'] }, function() {
            location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
        }, function() {

        });
    }

    function isLogin() {
        return !!'${pcuser.phone}';
    }
    //滚动条
   Scroll("box2", "scroll-bar", "scroll-btn", 5);
    Scroll("rewards2", "rewardsScrollbar", "rewardsScrollbtn", 5);

	//竞猜成功
    $("body").on('click','.guess-option',function(){
        $(this).parents('.guess-select').find('.guess-option').removeClass('active');
        $(this).addClass('active');
    })

	//投票
    $("body").on('click','.guess-confirm',function(){
        var this1=$(this);
        var startTime=$(this).prev().find('.active').attr('id').split("-")[0];
        var teamId=$(this).prev().find('.active').attr('id').split("-")[1];
        var matchId=$(this).prev().find('.active').attr('id').split("-")[2];
        var now=new Date().getTime();

        if(!isLogin()) {
            showLoginPrompt();
            return;
        }
        if('${pcuser.isIdCard}'!='是'){
            layer.alert('对不起，只有实名认证的用户才可以进行竞猜!')
			return;
		}
        else{
        $.post('/yingpu/pc/worldCup/guess/json',{
            userId:"${pcuser.id}",
            teamId:teamId,
			matchId:matchId,
			startTime:startTime
		},function(data){
            if(data.status=='success'){
                this1.addClass("over");
                this1.html("已投");
                layer.msg(data.data);


            }else{
                layer.msg('你已经猜过了');
            }
        })}

    });
	
	function goPersonalrecord() { 
		 if(!isLogin()) {
            showLoginPrompt();
            return;
        }else{
        	window.location.href='../../myaccount/myluckydraw.jsp';
        }
	}
    
    $(".guess-confirm").mousedown(function(){

        $(this).css('backgroundColor','#edbd06');
    }).mouseup(function(){
        $(this).css('backgroundColor','#ffdb53');
    })
    $(function () {
        $(window).scroll(function () {
            $('.iframe-head').show();
        });
    });

	//点击比赛。显示比赛详情
    $('#listBox').on('click','.team',function() {
	    var a=($(this).parents('.container').children('.item').eq(0).find('input').eq(0).val());//比分
        var b = ($(this).parents('.container').children('.item').eq(2).find('input').eq(0).val());
        var c=$(this).parents('.container').children('.item').eq(0).find('.zhongwen1').html();
        var d=$(this).parents('.container').children('.item').eq(2).find('.zhongwen2').html();
        var e = $(this).parents('.container').children('.item').eq(1).find('input').val();
        var team1E=$(this).parents('.container').children('.item').eq(0).find('input').eq(1).val();
        var team2E=$(this).parents('.container').children('.item').eq(2).find('input').eq(1).val();
        var date = new Date(parseInt(e)).Format("yyyy-MM-dd hh:mm");
		if(a=="null"&&b=="null"){
            $("#teamScore").html(0+':'+0);
		}
		else{$("#teamScore").html(a+':'+b);}
		$("#team1Name").html(c);
		$("#team2Name").html(d);
		$("#teamStratTime").html(date);
        $("#img1").attr("src","img/guess_wordcup/"+team1E+".png");
        $("#img2").attr("src","img/guess_wordcup/"+team2E+".png");

    })
</script>
</body>
</html>
