
// tab 项目信息列表切换
var tab = $('.navs span');
var list = $('.content2 .items li');
console.log(list);
tab.click(function(){
	tab.addClass('gray');
	$(this).removeClass('gray');
	list.hide();
	var num = $(this).index();
	list.eq(num).show();
	loadList(num + 1);
});


// 进度条
var istrue1 = false;
var istrue2 = false;
var istrue3 = false;
var istrue4 = false;
var kuang = $('.jindu li.kuang');

// 根据时间判断true与false状态
var myDate = new Date();
var times = myDate.getTime();

if(times>chujieday){
	istrue1 = true;
}
if(times>qixiday){
	istrue2 = true;
}
if(times>daoqiday){
	istrue3 = true;
}
if(times>futouday){
	istrue4 = true;
}

// 出借申请
if(istrue1){
	var el = kuang.eq(0);
	kuang.eq(0).find('img').attr('src','img/img-zhitoufutou/circlelv.jpg');
	kuang.eq(0).prev().find('img').attr('src','img/img-zhitoufutou/lineLv.jpg');
	kuang.eq(0).next().find('img').attr('src','img/img-zhitoufutou/lineLv.jpg');
};
// 起息日
if(istrue2){
	var el = kuang.eq(1);
	kuang.eq(1).find('img').attr('src','img/img-zhitoufutou/circlelv.jpg');
	kuang.eq(1).prev().find('img').attr('src','img/img-zhitoufutou/lineLv.jpg');
	kuang.eq(1).next().find('img').attr('src','img/img-zhitoufutou/lineLv.jpg');
};
// 到期日
if(istrue3){
	var el = kuang.eq(2);
	kuang.eq(2).find('img').attr('src','img/img-zhitoufutou/circlelv.jpg');
	kuang.eq(2).prev().find('img').attr('src','img/img-zhitoufutou/lineLv.jpg');
	kuang.eq(2).next().find('img').attr('src','img/img-zhitoufutou/lineLv.jpg');
};
// 续投日
if(istrue4){
	var el = kuang.eq(3);
	kuang.eq(3).find('img').attr('src','img/img-zhitoufutou/circlelv.jpg');
	kuang.eq(3).prev().find('img').attr('src','img/img-zhitoufutou/lineLv.jpg');
	kuang.eq(3).next().find('img').attr('src','img/img-zhitoufutou/lineLv.jpg');
};



var tip_index = 0;
function show(id) {
	tip_index = layer.tips("<div style='color:#fff;'>X快享智能投标是一种智能投标工具，锁定期满后，系统会为您自动续投其它标的，提高资金利用率；或者您可以在X快享智投锁定期满后，选择手动债转标的， 转让成功后退出本金。如转让不成功会持有债券继续转让，债券历史转让成功率达99.98%。</div>", "#"+id+"", {
	  tips: [3, "#038cf6"],
	  area: ['350px', 'auto'],
	});
};
function hide(){
	 layer.close(tip_index);
}

var tip_index = 0;
function show(id) {
	tip_index = layer.tips("<div style='color:#fff;'>持有中标的是该X快享智投中您目前出借的标的</div>", "#"+id+"", {
	  tips: [3, "#038cf6"],
	  area: ['180px', 'auto'],
	});
};
function hide(id){
	 layer.close(tip_index);
};
function show1(id) {
	tip_index = layer.tips("<div style='color:#fff;'>已到期的标的是该X快享智投中您曾经持有，现在已经到期的标的</div>", "#"+id+"", {
	  tips: [3, "#038cf6"],
	  area: ['180px', 'auto'],
	});
};
function show2(id) {
	tip_index = layer.tips("<div style='color:#fff;'>已转让标的是该X快享只投您曾经持有，但后台自动匹配转让出的标的</div>", "#"+id+"", {
	  tips: [3, "#038cf6"],
	  area: ['180px', 'auto'],
	});
};
