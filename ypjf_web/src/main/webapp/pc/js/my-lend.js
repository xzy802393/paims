// // 模块切换
// var $nav = $('#title .nav');
// var $tabs = $('#content .xiangmu>li');
// var $page = $('.record-page')
// $nav.on('click',"li",function(){
// 	$(this).parent().find('span').removeClass('active');
// 	$(this).find('span').addClass('active');
// 	$tabs.hide();
// 	var index = $(this).index();
// 	if(index==0){
// 		$page.css('display','none');
// 	}else if(index==2){
// 		// $.post('/yingpu/pc/project/list',function (data){});
// 		$.get('/yingpu/pc/project/list');
//         // $page.css('display','block');
//     }else if(index==3){
//
//         $page.css('display','block');
//     }
//     $tabs.eq(index).css('display','block');
//
// })




// 项目类型
$btnLei = $('#content #tab .btn .leiXing');
$btnLei.on('click','dd',function(){
	$btnLei.find('dd').removeClass('active');
	$(this).addClass('active');
	// $(this).parent().parent().parent().find('.list').remove();

})
// 项目期限
$btnQiXian = $('#content .btn .qiXian');
$btnQiXian.on('click','dd',function(){
	$btnQiXian.find('dd').removeClass('active');
	$(this).addClass('active');
	// $(this).parent().parent().parent().find('.list').remove();
})
// 年化利率
$btnNianHua = $('#content .btn .nianHuaLv');
$btnNianHua.on('click','dd',function(){
	$btnNianHua.find('dd').removeClass('active');
	$(this).addClass('active');
	// $(this).parent().parent().parent().find('.list').remove();
})
//还款方式
$btnHuanKuan = $('#content .btn .huanKuanfs');
$btnHuanKuan.on('click','dd',function(){
	$btnHuanKuan.find('dd').removeClass('active');
	$(this).addClass('active');
	// $(this).parent().parent().parent().find('.list').remove();
})