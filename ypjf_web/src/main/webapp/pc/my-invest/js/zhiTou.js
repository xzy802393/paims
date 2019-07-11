// tab 项目信息列表切换
var projectIndex = 0;
var tab = $('#content .title span');
var list = $('#content .tabs>li');

tab.click(function () {
    tab.removeClass('active');
    $(this).addClass('active');
    list.hide();
    var num = $(this).index();
    list.eq(num).show();
})

// 出借金额数字
var add = $('#banner .box .kuang .item2 .money .jia');
var reduce = $('#banner .box .kuang .item2 .money .jian');
var money = $('#banner .box .kuang .item2 .money .num input')
var num = $('#banner .box .kuang .item2 .money .num input').val();

var balance = $('#banner .box .kuang .neirong em');

// 服务期限的切换,利率，本金，收入的更改
var timeBtn = $('#banner .item3 .right .tab');
var liLv = $('#banner .item3 .right .lilv');//利率
var benjin = $('#banner .item3 .right .bj');//本金
var shouru = $('#banner .item3 .right .sr');//预计收入
var fwqx = $('#banner .item3 .right .qx');//服务期限
var tishiyu = $('#banner .item2 .right .tishi');//输入金额小于1000时
var zhengchu = $('#banner .item2 .right .zhengchu');//输入金额不能被1000整除时
var xiaoyu = $('#banner .item2 .right .xiaoyu');//输入金额小于1000时；
var dayu = $('#banner .item2 .right .dayu');//输入金额大于出借金额时；
// var shuru = $('#banner .item2 .right .money .num input');

function curProject() {
    return siProjectInfo[projectIndex];
}


add.click(function () {
    $(".jian").css('background', '#038cf6');
    tishiyu.css('display', 'none');
    num = $('#banner .box .kuang .item2 .money .num input').val();
    if (num == "") {
        num = 0;
    }
    num = parseInt(num) + 1000;
    if (num < 1000) {
        xiaoyu.css('display', 'block');
    } else if (num % 1000 != 0) {
        zhengchu.css('display', 'block');
    }
    else {
        xiaoyu.css('display', 'none');
        zhengchu.css('display', 'none');
    }
    if (num > curProject().remainsAmount) {
        dayu.css('display', 'block');
    }
    money.val(num);
    benjin.text(commafy(returnFloat(num)));
    // shouru.text(commafy(accMul(accDiv(accMul(num, curProject().interestRate), 365), curProject().deadLine * 30).toFixed(2)));
    shouru.text(commafy(accMul(accDiv(accMul(num,curProject().interestRate),12),curProject().deadLine).toFixed(2)));
    $(this)[num > curProject().remainsAmount ? 'addClass' : 'removeClass']('disabled');
});

reduce.click(function () {
    num = $('#banner .box .kuang .item2 .money .num input').val();
    var invalid = false;
    if (num > 1000) {
        num = num - 1000;
        money.val(num);
        benjin.text(commafy(returnFloat(num)));
        // shouru.text(commafy(accMul(accDiv(accMul(num, curProject().interestRate), 365), curProject().deadLine * 30).toFixed(2)));
        shouru.text(commafy(accMul(accDiv(accMul(num,curProject().interestRate),12),curProject().deadLine).toFixed(2)));
        if (num <= curProject().remainsAmount) {
            dayu.css('display', 'none');
        }
    }
    else {
        if (num <= 1000) {
            xiaoyu.css('display', 'block');
        } else if (num % 1000 != 0) {
            zhengchu.css('display', 'block');
        }
        else {
            xiaoyu.css('display', 'none');
            zhengchu.css('display', 'none');
        }
        $(".jian").css('background', '#a9a8a8');
        tishiyu.css('display', 'none');
        invalid = true;
    }
    $(this)[invalid ? 'addClass' : 'removeClass']('disabled');
});


timeBtn.click(function () {
    projectIndex = $(this).index();
    // console.log(projectIndex);
    var money = $('#banner .item2 .right .money .num input').val();
    var neirong = $(this).html();
    var p = curProject();
    timeBtn.removeClass('active');
    $(this).addClass('active');
    if(p!=null || p!=undefined){
        // balance.text(p.remainsAmount);
        balance.text(commafy(returnFloat(p.remainsAmount)));
        if(money>p.remainsAmount){
            dayu.css('display', 'block');
        }else{
            dayu.css('display', 'none');
        }if(p.remainsAmount<=0){
            $('.shouquan').css('background','gray');
        }else{
            $('.shouquan').css('background','#038cf6');
        }

        liLv.text((p.interestRate * 100).toFixed(2) + '%');
        benjin.text(commafy(returnFloat(money)));
        // shouru.text(commafy(accMul(accDiv(accMul(num, p.interestRate), 365), p.deadLine * 30).toFixed(2)));
        shouru.text(commafy(accMul(accDiv(accMul(num,p.interestRate),12),curProject().deadLine).toFixed(2)));
        fwqx.text(neirong);
        countDown(p.raiseStartTime,p.remainsAmount);
        jisuan();
    }
});

var siProjectInfo = [];

var S=true;

$(function () {
    $.get('/yingpu/pc/si/project/newest/json', {}, function (data) {
        if (data.status == 'success') {
            var list = data.data;
            siProjectInfo = list;
            // console.log(list);
            liLv.text(((curProject().interestRate) * 100).toFixed(2) + "%");
            // console.log(returnFloat(curProject().remainsAmount));
            balance.text(commafy(returnFloat(curProject().remainsAmount)));

            if(curProject().remainsAmount<=0){
                $('.shouquan').css('background','gray');
                S = false;
            }else{
                S=true;
                $('.shouquan').css('background','#038cf6');
            }
            // shouru.text(commafy(accMul(accDiv(accMul(num, curProject().interestRate), 365), curProject().deadLine * 30).toFixed(2)));
            shouru.text(commafy(accMul(accDiv(accMul(num,curProject().interestRate),12),curProject().deadLine).toFixed(2)));
            countDown(curProject().raiseStartTime,curProject().remainsAmount);
            jisuan();
        }
    });
});
function jisuan() {
    var totalAmount = curProject().totalAmount;
    var financingAmount = curProject().remainsAmount;
    jindu = financingAmount / totalAmount * 100 + "%";
    // console.log(jindu);
    $('.jindu').css("width", (totalAmount-financingAmount) / totalAmount * 100 + "%");
}

//数据添加分隔符
function commafy(num) {
    return num && num
        .toString()
        .replace(/(\d)(?=(\d{3})+\.)/g, function ($1, $2) {
            return $2 + ',';
        });
}

function inputMoneyjudge() {
    inputmoney = $('#banner .box .kuang .item2 .money .num input').val();
    num = inputmoney;
    benjin.text(commafy(returnFloat(inputmoney)));
    // shouru.text(commafy(accMul(accDiv(accMul(inputmoney, curProject().interestRate), 365), curProject().deadLine * 30).toFixed(2)));
    shouru.text(commafy(accMul(accDiv(accMul(num,curProject().interestRate),12),curProject().deadLine).toFixed(2)));
    if (num < 1000) {
        xiaoyu.css('display', 'block');
        zhengchu.css('display', 'none');
    } else if (num >= 1000) {
        if (num % 1000 != 0) {
            zhengchu.css('display', 'block');
        } else if (num > curProject().remainsAmount) {
            dayu.css('display', 'block');
        }
        else {
            dayu.css('display', 'none');
            zhengchu.css('display', 'none');
        }
        xiaoyu.css('display', 'none');
    }
}
function isSubmit(){
    if(xiaoyu.css("display")=="block" || dayu.css("display")=="block" || tishiyu.css("display")=="block" || zhengchu.css("display") == "block" || S==false){
        return false;
    }else{
        return true;
    }

}

loadList();
function loadList() {
    $.post('/yingpu/pc/si/boower/Project', {pageIndex: pageIndex
    }, function (data) {
        // console.log(data)
        var dat = data;
        pageIndex = dat.page.pageIndex;
        pageCount = data.page.pageCount;
        pageSize = data.page.pageSize;
        data = data.data;
        var html = '';

        if (data==undefined || data.length == 0 ){
            html = '<span style="display: block; text-align: center;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
            $('#userprojectinfo').empty();
            // $('#userprojectinfo').append(html);
            $('.table').append(html);
            $('.record-page').css('display','none');
            generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
        }else {
            // var len = data.length;
            $.each(data, function (i, o) {
                html += '<tr>';
                html += '<td>' + ((i + 1) + ((dat.page.pageIndex - 1) * 10)) + '</td>';
                html += '<td><a href="/yingpu/pc/getProjectDetails?projectid='+o.id+'"style="color: dodgerblue">'+o.name + '</a></td>';
                html += '<td>' + o.legalPerson.substring(0,1)+ '**</td>';
                html += '<td>' + o.deadLine+ '个月</td>';
                html += '<td>'+commafy(returnFloat(o.totalAmount))+'</td>';
                html += '</tr>';
            });
            $('#userprojectinfo').empty();
            $('#userprojectinfo').append(html);
            $('.record-page').css('display','block');
            generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
        }
    });
}
    var type = window.location.href.split("=")[1];
    if(type==3){
        projectIndex = 0;
    }else if(type==6){
        projectIndex = 1;
    }else if(type==9){
        projectIndex = 2;
    }else if (type == 12){
        projectIndex = 3;
    }
    timeBtn.removeClass('active');
    timeBtn.eq(projectIndex).click();
var time=0;
function countDown(raiseStartTime,remainsAmount){
    var starttime = new Date(raiseStartTime);
    starttime.setDate(starttime.getDate()+7);
    if(starttime<new Date() || remainsAmount <=0){
        $('#time').html("招标已截止");
        $('.shouquan').css('background','gray');
        S=false;
        window.clearInterval(time);
    }else {
        S=true;
        window.clearInterval(time);
        time = setInterval(function () {
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

