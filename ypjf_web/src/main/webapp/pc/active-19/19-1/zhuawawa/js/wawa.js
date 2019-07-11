var flag = false;
var cishu;
// var $num =$('.bottom.cishu');
var userTotalDrawTimes = 0,
    userReaminDrawTimes = 0,
    activityId = 52
acquiredPrize = null;

var timer = 0;
var k = true; //是否可以点击
var talon = $(".sheng").offset().left + 7;//首先获取爪子的位置(这里是固定的)
var l;


var c = 0;//娃娃的
setTimeout("scrollLeft()", 2000);

// 娃娃动
function scrollLeft() {
    var speed = 20;

    function Marquee() {

        c++;
        if ($(".wawa2").width() - $(".gundong").scrollLeft() <= 0) {
            c = 0;
            $(".gundong").scrollLeft(c);
        } else {
            $(".gundong").scrollLeft(c);
        }
    }//Marquee结束
    var timer = setInterval(Marquee, speed);

}

// 点击按钮
$('.btn').on('click', function () {
    if (!isLogin()) {
        layer.alert('很抱歉，登录后才进行抽奖，请先登录!', {title: '温馨提示', btn: ['登录', '取消']}, function () {
            location.href = '/yingpu/pc/login?backUrl=' + getEncodedCurrentURL();
        }, function () {

        });
        return;
    }
    if (!flag) {
        if (cishu > 0) {
            flag = true;
            draw();
            // 不能连续点击
            if ($('.btn_star').css('display') == "block") {
                $('.btn_star').css('display', 'none');
                $('.btn_end').css('display', 'block');
                $('.jiazi .lose').css('display', 'none');
                $('.jiazi .win').css('display', 'block');
                // 绳子变化
                $('.shengBg').animate({height: 285}, 2800);
                time_ww = setTimeout(btn, 6000);//按钮点击
                time_zz = setTimeout(zhuazi, 3000);//爪子变化
                time_tk = setTimeout(tankuang, 6000);//按钮点击
                $(".shengBg").animate({height: 0}, 3000);//缩回来(绳子)
            }
            cishu--;
            $('.cishu').html(cishu)
        } else {
            layer.alert('您的可抽奖次数不足');
        }
    }
});

function btn() {
    $('.btn_star').css('display', 'block');
    $('.btn_end').css('display', 'none');

}

function zhuazi() {
    for (var i = 0; i < $(".gundong li").length; i++) {
        l = $(".gundong li").eq(i).offset().left + 68.5//此时此刻每个娃娃的位置
        // console.log(l);
        if (l + 70 >= talon && talon >= l - 70) {
            var l1 = $(".gundong li").eq(0).offset().left + 68.5;
            // console.log(l);
            var num = (l - l1) / 137;
            var index = parseInt(num);
            // console.log(index);
            var tupian = $(".gundong li").eq(index).find('img')[0].src;
            // console.log(tupian);
            $('.lose img').attr("src", tupian);
            $('.jiazi .lose').css('display', 'block');
            $('.jiazi .lose img').css('display', 'block');
            $('.jiazi .win').css('display', 'none');
            $(".gundong li").eq(index).css('visibility', 'hidden');
            time_wz = setTimeout(function () {
                $(".gundong li").eq(index).css('visibility', 'visible');
                $('.jiazi .lose img').css('display', 'none');
            }, 4000);//按钮点击
        }
    }
}

// 弹框
var $tankuang = $('#tankuang');
// var isOk = true;//获奖
var isOk;

function tankuang() {
    $tankuang.css('display', 'block');
    if (isOk) {
        $('#tankuang .content2').hide();
        $('#tankuang .content1').css('display', 'block');
    } else {
        $('#tankuang .content1').hide();
        $('#tankuang .content2').css('display', 'block');
    }
    $tankuang.on('click', function () {
        $tankuang.css('display', 'none');
        // window.location.reload();
    });
}

/** 获取用户抽奖信息*/
function loadUserDrawInfo() {
    $.post('/yingpu/pc/prize/draw/info/json', {activityId: activityId}, function (data) {
        if (data.status == 'success') {
            var info = data.data || {};
            cishu = userReaminDrawTimes = (userTotalDrawTimes = (info.totalDrawTimes || 0)) - (info.usedDrawTimes || 0);
            // console.log(cishu);
            // $num.html(cishu);
            $('.cishu').html(cishu);
        }
    });
}

function draw() {
    // console.log("开始抽奖")
    $.post('/yingpu/pc/prize/generic/draw/json', {activityId: activityId}, function (data) {
        var prize = data.data;
        // console.log(prize);
        // console.log(data.data.prizename)
        if (data.status != 'success' && data.status != 'ok') {
            layer.alert(data.message);
            error(data.message);
            isOk = false;

        } else {
            // var html = '';
            // callback(prize.prizename.indexOf('谢谢参与') == -1, prize);

            if (prize.prizename.indexOf('谢谢参与') != -1) {
                isOk = false;
            }else{
                isOk = true;
                $('.jiang').html(prize.prizename);
            }
        }
    });
}