// tab 项目信息列表切换
var tab = $('.nav li');
var list = $('.content2 .tab>li');
tab.click(function(){
	tab.removeClass('active');
	$(this).addClass('active');
	list.hide();
	var num = $(this).index();
	list.eq(num).show();
	
})


// 出借金额数字
var add = $('.content1 .right .box .p2 .jia');
var reduce = $('.content1 .right .box .p2 .jian');
var money = $('.content1 .right .box .p2 .num input')
var num = $('.content1 .right .box .p2 .num input').val();

add.click(function(){
	num = $('.content1 .right .box .p2 .num input').val();
	num = parseInt(num)+100;
	money.val(num);
	$("#shijizhifu").text((Number(num)+Number(num * $('body').data('earningRate')/365 * $('body').data('holdDays'))).toFixed(2));
	$("#shouyi").text((num * $('body').data('estimatedAnnualRate')/12).toFixed(2));
});
reduce.click(function(){
	num = $('.content1 .right .box .p2 .num input').val();
	if(num>100){
		num = num-100;
		money.val(num);
        $("#shijizhifu").text((Number(num)+ Number(num * $('body').data('earningRate')/365 * $('body').data('holdDays'))).toFixed(2));
        $("#shouyi").text((num * $('body').data('estimatedAnnualRate')/12).toFixed(2));
	}
	
});
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
$('#price').text(commafy(returnFloat($('#price').text())));
$('#surplusValue').text(commafy(returnFloat($('#surplusValue').text())));
$('#Canlend').text(commafy(returnFloat($('#Canlend').text())));
$('.keyong span').text(commafy(returnFloat($('.keyong span').text())));

$(function(){
    var num1 = $('.content1 .right .box .p2 .num input').val();
    $("#shijizhifu").text((Number(num1)+Number(num1 * $('body').data('earningRate')/365 * $('body').data('holdDays'))).toFixed(2));
    $("#shouyi").text((num1 * $('body').data('estimatedAnnualRate')/12).toFixed(2));
});
function inputMoney(){
    var num1 = $('.content1 .right .box .p2 .num input').val();
    $("#shijizhifu").text((Number(num1)+Number(num1 * $('body').data('earningRate')/365 * $('body').data('holdDays'))).toFixed(2));
    $("#shouyi").text((num1 * $('body').data('estimatedAnnualRate')/12).toFixed(2));
}
