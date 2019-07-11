var activityId = 57,
    drawTimes = 0,
    remainsTimes = 0,
    isDrawing = false;

/** 获取用户抽奖信息*/
function loadUserDrawInfo(s, f) {
    $.post('/yingpu/pc/prize/draw/info/json', {activityId: activityId}, function (data) {
        if (data.status == 'success') {
            var info = data.data || {};
            s && s((info.totalDrawTimes || 0), (info.usedDrawTimes || 0));
        }
    });
}

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

var $item = $("#active .box>div");
// 鼠标移入，锤子显示
$item.mouseover(function () {
    $(this).find('.chui').css("z-index", "1000");
    $(this).find('.chui').show();
});
// 鼠标移出，锤子隐藏
$item.mouseout(function () {
    $(this).find('.chui').hide();
});
// 鼠标点击，蛋碎
$item.click(function () {
    if (!isLogin()) {
        showLoginPrompt();
        return;
    }
    if (!isDrawing) {
        isDrawing = true;
        var numm =$item.index($(this));
        draw(numm);
        // $(this).find('.dan1').hide();
        // $(this).find('.sui1').show();

    }
});

/* 抽奖的过程 */
function draw(numm) {
    $.post('/yingpu/pc/prize/generic/draw/json', {activityId: activityId}, function (data) {
        var prize = data.data;
        if (data.status != 'success' && data.status != 'ok') {
            // error && error(data.message);
            isErroe(data.message);
        } else {
            drawTimes++;
            remainsTimes--;
            if (prize.prizename.indexOf('谢谢参与') != -1) {
                // fail && fail(prize);
                weizhong(numm);
            } else {
                // success && success(prize);
                zhong(numm,prize);
            }
            $('.num').text(remainsTimes);
        }
        isDrawing = false;
    });
}

/* 出现异常*/
function isErroe(msg) {
    // $item.eq(num).find('.dan1').hide();
    // $item.eq(num).find('.sui1').show();
    layer.msg(msg);
    // reset();
}

// 重置活动
function reset() {
    $item.find('.dan1').show();
    $item.find('.sui1').hide();
    $item.find('.chui').hide();
}

// 关闭中奖弹框
$("#tankuang").click(function () {
    $("#tankuang").hide();
    $("#tankuang .content1").hide();
    $("#tankuang .content2").hide();
    reset();
});


// 中奖
function zhong(numm,prize) {
    $item.eq(numm).find('.dan1').hide();
    $item.eq(numm).find('.sui1').show();
    $("#tankuang").show();
    $("#tankuang .content1").show();
    // 碎蛋里边的奖品图片
    $item.eq(numm).find('.sui1 .jiang').attr("src",prize.prizeimg);
    // 奖品名称
    $("#tankuang .content1 .jiang").html(prize.prizename);
    // 奖品价格
    $("#tankuang .content1 .nums").html(prize.price);
}

// 未中奖
function weizhong(numm) {
    $item.eq(numm).find('.dan1').hide();
    $item.eq(numm).find('.sui1').show();
    $("#tankuang").show();
    $("#tankuang .content2").show();
    $item.find('.sui1 .jiang').attr("src", "");
}

