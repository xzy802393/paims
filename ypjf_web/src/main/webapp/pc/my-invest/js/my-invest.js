//照片信息轮播图
function lunbo() {
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        slidesPerView: 4,
        paginationClickable: true,
        spaceBetween: 0,
        loop: true,
        autoplay: 3000,
        autoplayDisableOnInteraction: false,

    });
}

//项目实景和借款人证照按钮切换
var tuanniu = $('.content2 .tab2 .qiehuan span');
tuanniu.click(function () {
    tuanniu.removeClass('active');
    $(this).addClass('active');
});

// tab 项目信息列表切换
var tab = $('.nav li');
var list = $('.content2 .tab>li');
tab.click(function () {
    tab.removeClass('active');
    $(this).addClass('active');
    list.hide();
    var num = $(this).index();
    list.eq(num).show();
    lunbo();
    change();
});


// 出借金额数字
var add = $('.content1 .right .box .p2 .jia');
var reduce = $('.content1 .right .box .p2 .jian');
var money = $('.content1 .right .box .p2 .num input');
var num = $('.content1 .right .box .p2 .num input').val();
var sumNewMoney;

add.click(function () {
    num = $('.content1 .right .box .p2 .num input').val();
    num = parseInt(num) + 100;
    // console.log(num);
    if($('body').data('isNew')=='是'){
        if(num>sumNewMoney){
            $('.newMoney').text("剩余新手投资额度"+sumNewMoney+"元");
            $('.newMoney').css('display','block');
        }else{
            $('.newMoney').css('display','none');
        }
    }
    money.val(num);
    $('#invest-money-input').change();
})
reduce.click(function () {
    num = $('.content1 .right .box .p2 .num input').val();
    if (num > 100) {
        num = num - 100;
        money.val(num);
    }
    if(num<=sumNewMoney){
        $('.newMoney').css('display','none');
    }
    $('#invest-money-input').change();
})


// 优惠券的选择
var yhq = $('.content1 .right .box .p4 .value');
var show = $('.content1 .right .box .p4 .youhuiquan');
// 优惠券框显示
yhq.click(function () {
    $('.youhuiquan>ul>li').show().each(function(i, e) {
        // if ($(e).attr('limitmoney') * 1 > $('#invest-money-input').val()) {
        //     $(e).hide();
        // }
    });
    if ($('.youhuiquan>ul>li').size() > 0) {
        $(this).text('不使用优惠券');
        $('input[name=coupon]').prop('checked', false);

        show.toggle();
    }
})

function change() {
    var h = $('#content').height() + 130;
    $('.iframe-foot').css('top', h + 'px')
}


$('#shijing').click(function () {
    $('#zhengzhaotu').css("display", "none");
    $('#jianjietu').css("display", "block");
});
$('#zhengjian').click(function () {
    $('#zhengzhaotu').css("display", "block");
    $('#jianjietu').css("display", "none");
})


var dot = ($('#jianjie').attr('data') || '').split(';');
for (i = 0; i <= dot.length; i++) {
    if (dot[i] != null && dot[i] != undefined && dot[i] != '') {
        $('#jianjie').append('<div class="swiper-slide"><img src="' + dot[i] + '"/></div>');
    }
}
dot = ($('#zhengzhao').attr('data') || '').split(';');
for (i = 0; i <= dot.length; i++) {
    if (dot[i] != null && dot[i] != undefined && dot[i] != '') {
        $('#zhengzhao').append('<div class="swiper-slide"><img src="' + dot[i] + '"/></div>');
    }
}

function jisuan() {
    $('.jindu').each(function (e) {
        var totalAmount = $(this).attr('totalAmount');
        var financingAmount = $(this).attr('financingAmount');
        // jindu = (*totalAmount -financingAmount) / totalAmount * 100 + "%";
        $('.tuli').css("width", (totalAmount - financingAmount) / totalAmount * 100 + "%");
    });
}

function yuqishouyi() {
    var estimatedAnnualRate = $('body').data('estimatedAnnualRate');
    var deadLine = $('body').data('deadLine');
    var amount = $('#invest-money-input').val();
    // $('#yuqishouyi').text(accDiv(accMul(accMul(amount, estimatedAnnualRate), deadLine), 12).toFixed(2));
    $('#yuqishouyi').text(accMul(accMul(accDiv(accMul(amount,estimatedAnnualRate),360),30),deadLine).toFixed(2));

    // var lv = accMul(accDiv(estimatedAnnualRate,12),amount).toFixed(2);
    // $('#yuqishouyi').text(accMul(lv,deadLine).toFixed(2));
}

$('#content').mouseover(function () {
    $('#content').css('z-index', '3000');
})
$('#content').mouseout(function () {
    $('#content').css('z-index', '0');
})
$('.iframe-headfu').mouseover(function () {
    $('.iframe-headfu').css('z-index', '3000');
})
$('.iframe-headfu').mouseout(function () {
    $('.iframe-headfu').css('z-index', '0');
})

$('#invest-money-input').blur(function() {
    $(this).change();
})
.keyup(function (e) {
    e = e || event;
    $(this).change();
    /*if ((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105) || e.keyCode == 102) {

    }*/
})
.change(function () {
    var val = $(this).val(), validVal;
    if (val < $('body').data('limitMoney') * 1 || isNaN(val)) {
        //validVal = $('body').data('limitMoney');
    }
    else if (val > $('body').data('financingAmount') * 1 && $('body').data('financingAmount') * 1 > 0) {
        //validVal = $('body').data('financingAmount');
    }

    if (validVal) {
        $(this).val(validVal);
    }

    var value = val;
    $('.youhuiquan>ul>li').show().each(function(i, e) {
        if ($(e).attr('limitmoney') * 1 > value) {
            $(e).hide();
        }
    });

    yuqishouyi();
});

$.fn.sortFunc = function (options) {
    //默认值parentEle为空,orderBy为正序
    var defaults = {
        parentEle: '',
        orderBy: 'asc',
        type: 'number',
        attr: 'money'
    };
    //如果调用时设置options，则用新值替换默认值
    var opts = $.extend(defaults, options);
    //正序排序(排序方法主要是通过将id值构造为Date对象进行比较)
    var asc = function (a, b) {

        if (opts.type == 'number') {
            return $(a).attr(opts.attr) > $(a).attr(opts.attr) ? 1 : -1;
        }
        return new Date($(a).attr(opts.attr)) > new Date($(b).attr(opts.attr)) ? 1 : -1;
    };
    //倒序排序
    var desc = function (a, b) {
        if (opts.type == 'number') {
            return $(a).attr(opts.attr) > $(a).attr(opts.attr) ? -1 : 1;
        }
        return new Date($(a).attr(opts.attr)) > new Date($(b).attr(opts.attr)) ? -1 : 1;
    };
    //如果parentEle值不为空或body,则先将其清空后重新最佳排序后内容
    if (opts && opts.parentEle != 'body' && opts.parentEle != '') {
        $(opts.parentEle).empty().append($(this).sort(
            (opts.orderBy == "asc") ? asc : desc
        ));
    } else {
        //未设置parentEle时,避免元素显示错位，先为其包裹一个父元素
        //在完成排序及追加内容后，再移除父元素
        $(this).wrapAll("<div class='dundan'></div>");
        var sortEle = $(this).sort((opts.orderBy == "asc") ? asc : desc);
        $(".dundan").empty().append(sortEle).children().unwrap();
    }
};

$('.youhuiquan>ul').find('li').sortFunc({
    orderBy: "asc",
    type: "number",
    attr: "money"
});

function sort(type) {
    if (type == 1) {
        $('.youhuiquan').find('li').sortFunc({
            orderBy: "asc",
            type: "number",
            attr: "money"
        });
    } else {
        $('.youhuiquan').find('li').sortFunc({
            orderBy: "asc",
            type: "data",
            attr: "endtime"
        });
    }
}

$('.high,.daoqi').click(function () {
    if ($(this).attr('class') == 'high') {
        sort(1);
        $('.coupon-expire').hide();
    }
    else {
        $('.coupon-expire').show();
        sort(2);
    }

    $(this).css('color', '#ff7d54').parent().children().not($(this)).css('color', '#000');
    $('input[name=coupon]').prop('checked', false);
});

$('.youhuiquan').on('click', '[name=coupon]', function () {
    $('input[name=coupon]').not($(this)).prop('checked', false);
    $('.value').text($(this).next('p').text());
    $('.youhuiquan').hide();
});


function touzi() {
    if ($('body').data('isLogin') == 'true') {
        location.href = 'login';
    }

    if ($('#payPassword_rsainput').val().length != 6) {
        layer.alert('请输入6位支付密码');
        return false;
    }
    var cardid = '';
    if (!!$('input[name=coupon]:checked').val()) {
        cardid = $('input[name=coupon]:checked').val();
        console.log(cardid);
    }
    layer.load(2);
    $.post('../pc/userproject/touzi', {
        projectId: $('body').data('projectId'),
        money: $('#invest-money-input').val(),
        payType: '1',
        cardId: cardid,
        "investmentport": "PC",
        tradPassword: $('#payPassword_rsainput').val()
    }, function (data) {
        layer.closeAll();
        if (data.status == 'success') {
            layer.alert(data.message, function () {
                location.reload(false);
            });
        } else {
            if (data.message == '您的支付密码已被锁定') {
                var ind = layer.open({
                    'title': '错误提示', 'content': '您的支付密码已被锁定,请重置支付密码', 'btn': ['忘记密码'], 'yes': function () {

                        location.href = '/yingpu/pc/myaccount/payment_password.jsp';
                    }
                });
            } else {
                var ind = layer.open({
                    'title': '错误提示', 'content': data.message, 'btn': ['重新输入'], 'yes': function () {
                        layer.close(ind);
                        closezhifu();
                        dianjitouzi();
                    }, 'btn2': function () {
                        location.href = '/yingpu/pc/myaccount/payment_password.jsp';
                    }
                });
            }

            closezhifu();

        }
    });
}

function dianjitouzi() {
    if ($('body').data('isLogin') == 'true') {
        location.href = '/yingpu/pc/login';
        return false;
    }
    if (!$('#agreeText').is(':checked')) {
        layer.alert('请阅读并同意协议');
        return false;
    }
    if($('.newMoney').css('display')=='block'){
        layer.alert('您的投资金额超出新手投资金额');
        return false;
    }

    if (parseFloat($('body').data('caBalance')) < $('#invest-money-input').val()) {
        layer.alert('您账户余额不足');
        return false;
    }
    if ($('#invest-money-input').val() % 100 != 0) {
        layer.alert('投资金额必须为100的倍数');
        return false;
    }
    if ($('#invest-money-input').val() < 500) {
        layer.alert('投资金额必须大于500');
        return false;
    }
    if ($('body').data('tradPassword') == null || $('body').data('tradPassword') == undefined || $('body').data('tradPassword') == '') {
        layer.alert('您还没有设置支付密码', function () {

            location.href = '/yingpu/pc/myaccount/payment_password.jsp';

        });
        return false;
    }
    layer.open({
        type: 1, //Page层类型
        area: ['446px', '220px'],
        title: false,
        shade: 0.6, //遮罩透明度
//						  ,maxmin: true //允许全屏最小化
        anim: 1, //0-6的动画形式，-1不开启
        content: $(".zhifu-password"),
        cancel: function () {
            closezhifu();

        }
    });
    $('#payPassword_rsainput').focus();
}

function closezhifu() {
    $('#payPassword_rsainput').val('')
    $('.sixDigitPassword-box').find('b').css({'visibility': 'hidden'});
    $('.sixDigitPassword-box').children('span').css('left', '0px');
    $('.sixDigitPassword-box').children('i').first().addClass('active');
    $('#payPassword_rsainput').focus();
}

$('.chujie').click(function () {
    if ($(this).attr('status') == '2') {
        dianjitouzi();
    }
});

$(function() {
    // foot的定位
    change();
    yuqishouyi();
    jisuan();
    countDown();
});

function inputMoneyjudge(){
    num = $('.content1 .right .box .p2 .num input').val();
    if($('body').data('isNew')=='是'){
        if(num>sumNewMoney){
            $('.newMoney').text("剩余新手投资额度"+sumNewMoney+"元");
            $('.newMoney').css('display','block');
        }else{
            $('.newMoney').css('display','none');
        }
    }
}

$(function () {
    if(sessionStorage.user){
        $.post('/yingpu/pc/userproject/getNewSumMoney', {id:JSON.parse(sessionStorage.user).id}, function (data) {
            sumNewMoney = 50000.0 - data.sumNewMoney;
        });
    }
});


function countDown(){
    var starttime = new Date($('body').data('starttime'));
    var status = $('body').data('status');
    starttime.setDate(starttime.getDate()+7);
    if(starttime<new Date() || status== 5 || status == 3){
        $('#time').html("已截止");
    }else {
        setInterval(function () {
            var nowtime = new Date();
            var time = starttime - nowtime;
            var day = parseInt(time / 1000 / 60 / 60 / 24);
            var hour = parseInt(time / 1000 / 60 / 60 % 24);
            var minute = parseInt(time / 1000 / 60 % 60);
            var seconds = parseInt(time / 1000 % 60);
            $('#time').html(day + "天" + hour + "小时" + minute + "分钟" + seconds + "秒");
        }, 1000);
    }
}
function returnFloat(value){
    var value=Math.round(parseFloat(value)*100)/100;
    var s=value.toString().split(".");
    if(s.length==1){
        value=value.toString()+".00";
        return value;
    }
    if(s.length>1){
        if(s[1].length<2){
            value=value.toString()+"0";
        }
        return value;
    }
}
function commafy(num) {
    return num && num
        .toString()
        .replace(/(\d)(?=(\d{3})+\.)/g, function ($1, $2) {
            return $2 + ',';
        });
}
var n = $('#invest-money-input').val();
$('#invest-money-input').val(returnFloat(n));

$('#currentMoney').text(commafy(returnFloat($('#currentMoney').text()))+"元");