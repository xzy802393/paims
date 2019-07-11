// 项目类型切换
var kezhuanrang = $('#account #kezhuanrang');
var zhuanrangzhong = $('#account #zhuanrangzhong');
var yizhuanrang = $('#account #yizhuanrang');
var yichengjie = $('#account #yichengjie');
var list = $('#account .trans-records .list');
// 期限
var qixian = $('#account .trans-records .trans-choice .trans-choice-date');
qixian.on('click','dd',function(){
	qixian.find('dd').removeClass('active');
	$(this).addClass('active');
	
});

var container = kezhuanrang;
// 状态
var state = $('#account .trans-records .trans-choice .trans-choice-type');
state.on('click','dd',function(){
	state.find('dd').removeClass('active');
	$(this).addClass('active');


	if($(this).text()=="可转让"){
		list.hide();
		kezhuanrang.show();
        container = kezhuanrang;
	}else if($(this).text()=="转让中"){
		list.hide();
		zhuanrangzhong.show();
        container = zhuanrangzhong;
	}else if($(this).text()=="已转让"){
		list.hide();
		yizhuanrang.show();
        container = yizhuanrang;
	}else if($(this).text()=="已承接"){
		list.hide();
		yichengjie.show();
        container = yichengjie;
	}

});


var params = {
    dateStart : '',
    dateEnd : ''
};

$('.trans-choice-date, .trans-choice-type').on('click', 'dd', function() {
    $(this).addClass('active').parent().find('dd').not($(this)).removeClass();
    var classStr = $(this).attr('class');
    if (classStr == 'trans-choice-type') {
        with(params) {
            dateStart = '';
            dateEnd = '';
        }
    }

    pageIndex = 1;
    loadList();
});

$('#search').click(function() {
    params.dateStart = $('#dateStart').val().replace('起止日', '').replace(/\//g, '-');
    params.dateEnd = $('#dateEnd').val().replace('截止日', '').replace(/\//g, '-');
    pageIndex = 1;
    $('.trans-choice-date dd:eq(0)').click();
});

loadList = function() {
    var param = {};
    $('.trans-choice-date, .trans-choice-type').find('dd.active').each(function(i, e) {
        $.each(e.attributes, function(i, v) {
            param[v.name] = v.value;
        });
    });
    loadListFunc(param);
};

function loadListFunc(param) {
    var data = {
        pageIndex : pageIndex,
        dateStart : params.dateStart,
        dateEnd : params.dateEnd
    };

    $.post('/yingpu/pc/myaccount/debt/list/json', $.extend(data, param), function(data) {
        var tpl = $('[tpl-id=' + container.attr('id') +']').html();
        var html = '';

        if(data.data == undefined){
            html = '<span style="display: block; text-align: center; width:988px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
            container.find('tbody').html(html);
            $('.page').css('display','none');
        }else {
            // console.log(param);
            pageIndex = data.page.pageIndex;
            pageCount = data.page.pageCount || 1;
            pageSize = data.page.pageSize;
            $.each(data.data || [], function (k, v) {
                v.projectAmount = (v.amount - v.interest).toFixed(2);
                if (v.investmentAmount && param.status != 4) {
                    v.investmentAmount = v.investmentAmount - v.assigningAmount ;
                    v.totalEarnings = Number(v.investmentAmount + accMul(accDiv(
                        accMul(v.investmentAmount, v.earningRate), 365), v.deadline * 30)).toFixed(2);
                    v.totalInterest = Number(accMul(accDiv(
                        accMul(v.investmentAmount, v.earningRate), 365), v.deadline * 30)).toFixed(2);
                    v.interestRate = v.earningRate * 100 + '%';
                }
                if (param.status == 4) {
                    v.totalAmount = v.investmentAmount + v.totolInterest;
                }

                html += tpl.formatStr(v);
            });
            container.find('tbody').html(html);
            $('.page').css('display','block');
            generatePaginationNav(pageIndex, pageCount, '#page-nav-btn');
        }
    }, 'json');
}

/** 取消转让 */
function cancelAssign(id) {
    $.post('/yingpu/pc/si/debt/sell/cancel', { debtAssignmentId : id }, function(result) {
        if (result.status != 'success') {
            layer.alert(result.message);
            return;
        }
        layer.msg('债转取消成功！');
        reload(500);
    });
}



$(function() {
    $('.trans-choice-date dd:eq(0)').click();
})

function viewContract(param) {
    // param = 'userid='+ud+'&projectid='+pd+'&id='+d;
    // console.log(param);
    layer.open({
        type: 2,
        title: '查看合同',
        shadeClose: true,
        shade: 0.8,
        area: ['50%', '80%'],
        content: '/yingpu/app/userproject/getCreditorPact/json?' + param
    });
}
