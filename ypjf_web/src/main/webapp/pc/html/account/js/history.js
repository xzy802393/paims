// 项目类型切换
var tab = $('#account .tabs .tab');
var nav = $('#account .nav');
nav.on('click','span',function(){
	nav.find('span').removeClass('active');
	$(this).addClass('active');
	tab.hide();
	var num = $(this).index();
	tab.eq(num).show();
    gParams.type=$(this).index();
    gParams.status=1;
    gParams.dateBefore=1;
    pageIndex = 1;
	if($(this).index()==1){
        chongzhiloadList();
	}else if($(this).index()==2){
        depositloadList();
	}else if($(this).index()==3){
        invitefriends();
    }
	else{
        loadList();
	}
	// console.log("项目切换:"+$(this).index());
	
});
// 期限
	var qixian = $('#account .trans-records .trans-choice .trans-choice-date');
	// console.log(qixian)
	qixian.on('click','dd',function(){
		qixian.find('dd').removeClass('active');
		$(this).addClass('active');
		// // 清空
		// $(this).parent().parent().parent().find('#list').empty();
		gParams.dateBefore = $(this).index();
        pageIndex = 1;
        if(gParams.type== 1){
            chongzhiloadList();
        }else if(gParams.type==2){
            depositloadList();
        }else if(gParams.type==3){
            invitefriends();
        }
        else{
            loadList();
        }
        // console.log("期限切换:"+$(this).index());
        // loadList();
		// 重新加载
		// $(this).parent().parent().parent().find('#list').html();
	});

	



// 状态
var state = $('#account .trans-records .trans-choice .trans-choice-type');
state.on('click','dd',function(){
	state.find('dd').removeClass('active');
	$(this).addClass('active');
    // console.log("状态切换:"+$(this).index());
    gParams.status = $(this).index();
    pageIndex = 1;
    if(gParams.type== 1){
            chongzhiloadList();
	}else if(gParams.type==2){
        depositloadList();
	}else if(gParams.type==3){
        invitefriends();
    }
	else{
        loadList();
	}
	// // 清空
	// $(this).parent().parent().parent().find('#list').empty();


	// 重新加载
	// $(this).parent().parent().parent().find('#list').html();
});


// 查询
$('.querylog').click(function() {
	$('.trans-choice-date dd').removeClass('active').filter('dd:eq(0)').addClass('active');

	with (gParams) {
		dateBefore = '';
	};
	if(gParams.type==1){
        gParams.dateStart = $('#ECalendar_date3').val().replace('起止日', '');
        gParams.dateEnd = $('#ECalendar_date4').val().replace('截止日', '');
    }else if (gParams.type ==2){
        gParams.dateStart = $('#ECalendar_date5').val().replace('起止日', '');
        gParams.dateEnd = $('#ECalendar_date6').val().replace('截止日', '');
    }else{
        gParams.dateStart = $('#ECalendar_date').val().replace('起止日', '');
        gParams.dateEnd = $('#ECalendar_date2').val().replace('截止日', '');
    }
	pageIndex = 1;
    if(gParams.type== 1){
        chongzhiloadList();
    }else if(gParams.type==2){
        depositloadList();
    }else if(gParams.type==3){
        invitefriends();
    }
    else{
        loadList();
    }
});