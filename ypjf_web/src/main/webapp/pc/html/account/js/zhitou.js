// 项目类型切换
var toubiao = $('#account #toubiao');
var huikuan = $('#account #huikuan');
// var wanjie = $('#account #wanjie');
var nav = $('#account .nav');
nav.on('click','span',function(){
	nav.find('span').removeClass('active');
	$(this).addClass('active');
    // gParams.type=$(this).index();
	// if(gParams.status==2){
    //     huikuanList();
	// }else{
    //     loadList();
	// }
});



// 期限
var qixian = $('#account .trans-records .trans-choice .trans-choice-date');
qixian.on('click','dd',function(){
	qixian.find('dd').removeClass('active');
	$(this).addClass('active');
	gParams.dateBefore=$(this).index();
    pageIndex = 1;
    loadList();

});
// 状态
var state = $('#account .trans-records .trans-choice .trans-choice-type');
state.on('click','dd',function(){
	state.find('dd').removeClass('active');
	$(this).addClass('active');
    gParams.status=$(this).index();
    pageIndex = 1;
    $('#expiresDate')[['show', 'hide'][$(this).index() == 1 ? 1 : 0]]();
    $('#hetong')[['show', 'hide'][$(this).index() == 2 ? 1 : 0]]();
    loadList();
});
// 查询
$('#search').click(function() {
    $('.trans-choice-date dd').removeClass('active').filter('dd:eq(0)').addClass('active');
    with (gParams) {
        dateBefore = '';
    };
    gParams.dateStart = $('#ECalendar_date').val().replace('起止日', '');
    gParams.dateEnd = $('#ECalendar_date2').val().replace('截止日', '');
    pageIndex = 1;
    loadList();
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
