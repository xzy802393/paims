// 项目类型切换
var toubiao = $('#account #toubiao');
var huikuan = $('#account #huikuan');
// var wanjie = $('#account #wanjie');
var nav = $('#account .nav');
nav.on('click','span',function(){
	nav.find('span').removeClass('active');
	$(this).addClass('active');
    gParams.type=$(this).index();
    pageIndex = 1;
	if(gParams.status==2){
        huikuanList();
	}else{
        loadList();
	}

    // loadList();
// 	toubiao.show();
// 	huikuan.hide();
// 	wanjie.hide();
});



// 期限
var qixian = $('#account .trans-records .trans-choice .trans-choice-date');
qixian.on('click','dd',function(){
    // console.log("期限状态"+$(this).index());
	qixian.find('dd').removeClass('active');
	$(this).addClass('active');
	gParams.deadLine=$(this).index();
    pageIndex = 1;
	if(gParams.status==2){
        huikuanList();
	}else{
        loadList();
	}
});
// 状态
var state = $('#account .trans-records .trans-choice .trans-choice-type');
state.on('click','dd',function(){
	state.find('dd').removeClass('active');
	$(this).addClass('active');
	// console.log("项目状态"+$(this).index());
	gParams.status=$(this).index();
    pageIndex = 1;
	if($(this).index()==2){
		huikuan.show();
		toubiao.hide();
        huikuanList();
	}else {
		toubiao.show();
		huikuan.hide();
        loadList();
	}

	if($(this).index()==3){
		$("#hetong").hide();
	}else{
        $("#hetong").show();
	}

/*	if($(this).text()=="还款中"){
		huikuan.show();
		toubiao.hide();
		// wanjie.hide();
	}else if($(this).text()=="投标中"){
		toubiao.show();
		huikuan.hide();
		// wanjie.hide();
	}else if($(this).text()=="完结中"){
		toubiao.show();
		huikuan.hide();
		// wanjie.show();
	}*/
});
