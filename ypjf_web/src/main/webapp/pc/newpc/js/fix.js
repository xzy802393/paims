// 导航随着滚动条的滚动,附着在顶部
var t=0;
var h=150;
var fix = $(".fix");
$(function() {
	$(window).scroll(function() {
		t=$(window).scrollTop();
		// console.log(t);
		if(t>h){
			fix.show();
			// center.css("padding-top","30px");
		}else{
			fix.hide();
			// center.css("padding-top","0");
		}
	});
});

// 附着在顶部导航
$('.fix #header .bottom .right li a').mouseover(function(){
	$(this).addClass('hover');
	$('.kuangfix').css('display','none');
	$('.kuangchujie').css('display','none');
});
$('.fix #header .bottom .right li a').mouseout(function(){
	$(this).removeClass('hover');
});
$('.fix #header .bottom .right li a').eq(4).mouseover(function(){
	$('.kuangfix').slideDown();
});
$('.fix #header .bottom .right li a').eq(1).mouseover(function(){
    $('.kuangchujie').slideDown();
});


$('.fix .kuangfix').hover(function(){
	$(this).show();
},function(){
	$(this).slideUp();
})

$('.fix .kuangchujie').hover(function(){
    $(this).show();
},function(){
    $(this).slideUp();
})
