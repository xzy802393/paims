// 导航随着滚动条的滚动,附着在顶部
var t=0;
var h=500;
var fix = $(".fix");
// console.log(h);
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

//轮播图区域
var prev = $('#banner .btn .prev');
var next = $('#banner .btn .next');
var curIndex = 0, //当前index
imgLen = $(".imgList li").length; //图片总数
// 定时器自动变换2.5秒每次
var autoChange = setInterval(function(){ 
	if(curIndex < imgLen-1){ 
		curIndex ++; 
	}else{ 
		curIndex = 0;
	}
	//调用变换处理函数
	changeTo(curIndex); 
},3000);
//清除定时器时候的重置定时器--封装
function autoChangeAgain(){ 
		autoChange = setInterval(function(){ 
		if(curIndex < imgLen-1){ 
			curIndex ++;
		}else{ 
			curIndex = 0;
		}
	//调用变换处理函数
		changeTo(curIndex); 
	},3000);
	}
function changeTo(num){ 
	var goLeft = num * $(".banner").width();
	$(".imgList").animate({left: "-" + goLeft + "px"},500);
};

// 前一张
prev.click(function(){
	clearInterval(autoChange);
	if(curIndex>0){
		curIndex--;
		changeTo(curIndex);
		// console.log(curIndex);
	}else{
		curIndex=4;
		changeTo(curIndex);
	}
})
// 后一张
next.click(function(){
	clearInterval(autoChange);
	if(curIndex<4){
		curIndex++;
		changeTo(curIndex);
		// console.log(curIndex);
	}else{
		curIndex=0;
		changeTo(curIndex);
	}
})




// 产品展示
var lis = $('.content4 .box .left li');
// console.log(lis);
lis.click(function(){
	lis.removeClass('listC');
	$(this).addClass('listC');
})




// 动态和新闻按钮切换
// 动态

var curIndex2 = 0, //当前index
    imgLen1 = $(".dongtaibox li").length; //图片总数
//
function dongTai(num){
    var goLeft = num * $(".dongtaibox").width();
    $(".dongtaibox .dongtailist").animate({left: "-" + goLeft + "px"},500);
};
// 前一张
$('.content5 .dongtai .prev').click(function(){
    if(curIndex2>0){
        curIndex2--;
    }else{
        curIndex2=4;
    }
    dongTai(curIndex2);
    // console.log(curIndex2);
})
// 后一张
$('.content5 .dongtai .next').click(function(){
    if(curIndex2<4){
        curIndex2++;

    }else{
        curIndex2=0;
    }
    dongTai(curIndex2);
    // console.log(curIndex2)
})

// // 新闻
var curIndex1 = 0, //当前index
    imgLen2 = $(".newsbox li").length; //图片总数

function newsChange(num){
    var goLeft = num * $(".newsbox").width();
    $(".newsbox .newslist").animate({left: "-" + goLeft + "px"},500);
};

// 前一张
$('.content5 .news .prev').click(function(){
    if(curIndex1>0){
        curIndex1--;

    }else{
        curIndex1=4;
    }
    newsChange(curIndex1);
    // console.log(curIndex1);
})
// 后一张
$('.content5 .news .next').click(function(){
    if(curIndex1<4){
        curIndex1++;

    }else{
        curIndex1=0;
    }
    newsChange(curIndex1);
    // console.log(curIndex1);
})


// 合作伙伴
var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        slidesPerView: 6,
        paginationClickable: true,
        spaceBetween: 0,
        loop: true,
        autoplay: 3000,
        autoplayDisableOnInteraction: false
    });


    