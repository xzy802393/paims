
//轮播图区域
// var prev = $('#banner .btn .prev');
// var next = $('#banner .btn .next');
// var curIndex = 0, //当前index
// imgLen = $(".imgList li").length; //图片总数
// // 定时器自动变换2.5秒每次
// var autoChange = setInterval(function(){ 
// 	if(curIndex < imgLen-1){ 
// 		curIndex ++; 
// 	}else{ 
// 		curIndex = 0;
// 	}
// 	//调用变换处理函数
// 	changeTo(curIndex); 
// },3000);
// //清除定时器时候的重置定时器--封装
// function autoChangeAgain(){ 
// 		autoChange = setInterval(function(){ 
// 		if(curIndex < imgLen-1){ 
// 			curIndex ++;
// 		}else{ 
// 			curIndex = 0;
// 		}
// 	//调用变换处理函数
// 		changeTo(curIndex); 
// 	},3000);
// 	}
// function changeTo(num){ 
// 	var goLeft = num * $(".banner").width();
// 	$(".imgList").animate({left: "-" + goLeft + "px"},500);
// };
// 
// // 前一张
// $('#banner .btn .prev').click(function(){
// 	clearInterval(autoChange);
// 	if(curIndex>0){
// 		curIndex--;
// 		changeTo(curIndex);
// 	}else{
// 		curIndex=4;
// 		changeTo(curIndex);
// 	}
// })
// // 后一张
// $('#banner .btn .next').click(function(){
// 	clearInterval(autoChange);
// 	if(curIndex<4){
// 		curIndex++;
// 		changeTo(curIndex);
// 	}else{
// 		curIndex=0;
// 		changeTo(curIndex);
// 	}
// })

//轮播图区域
var swiper = new Swiper('#banner .banner-list .swiper-container', {
	pagination: '.swiper-pagination',
	nextButton: '#banner .swiper-button-next',
	prevButton: '#banner .swiper-button-prev',
	slidesPerView: 1,
	 // width: window.innerWidth,
	paginationClickable: true,
	spaceBetween: 0,
	loop: true,
	autoplay: 3500,
	autoplayDisableOnInteraction: false
});
var $bp = $('#banner .banner-list .swiper-button-prev');
$bp.on('mouseover',function(){
	$(this).addClass('active');
});
$bp.on('mouseout',function(){
	$(this).removeClass('active');
});
var $bn = $('#banner .banner-list .swiper-button-next');
$bn.on('mouseover',function(){
	$(this).addClass('active');
});
$bn.on('mouseout',function(){
	$(this).removeClass('active');
});
// 产品展示
var lis = $('.content4 .box .left li');
// console.log(lis);
lis.click(function(){
	lis.removeClass('listC');
	$(this).addClass('listC');
	var timer = setTimeout(function(){
		biaoshade();
	},300)
})



// 合作伙伴
var swiper = new Swiper('.hezuo .swiper-container', {
	pagination: '.swiper-pagination',
// 	nextButton: '.swiper-button-next',
// 	prevButton: '.swiper-button-prev',
	slidesPerView: 6,
	paginationClickable: true,
	spaceBetween: 0,
	loop: true,
	// autoplay: 3000,
	speed:3000,
    // autoplay: {
    //   delay: 3000,
    //   disableOnInteraction: false,
    //   waitForTransition: false
    // },
	freeMode:true,
	autoplay: {
		delay:0
	},
	autoplayDisableOnInteraction: false
});
    
    
	
// 散标和债券切换
var $huan = $('.content4 .box h3 span');
var $tabs =	$('.content4 .box .tab');

$huan.click(function(){
	$huan.removeClass('active');
	$(this).addClass('active');
	$tabs.hide();
	var num = $(this).index();
	$tabs.eq(num).show();
	
	
})

// 九趣动态
var swiper1 = new Swiper('.dongtaibox .swiper-container', {
	pagination: '.swiper-pagination',
	// nextButton: '.dongtaibox .swiper-button-next',
	// prevButton: '.dongtaibox .swiper-button-prev',
	slidesPerView: 1,
	paginationClickable: true,
	spaceBetween: 0,
	loop: true,
	autoplay: 4000,
	autoplayDisableOnInteraction: false
});
// 行业新闻
var swiper2 = new Swiper('.newsbox .swiper-container', {
	pagination: '.swiper-pagination',
	// nextButton: '.newsbox .swiper-button-next',
	// prevButton: '.newsbox .swiper-button-prev',
	slidesPerView: 1,
	paginationClickable: true,
	spaceBetween: 0,
	loop: true,
	autoplay: 4000,
	autoplayDisableOnInteraction: false
});


// 新手专享区域鼠标移入向左上移动一段距离
var lisxin = $('.content3 .neirong li');
lisxin.hover(function(){
	$(this).css({'transform':'translate(-3px,-3px)'});
},function(){
	$(this).css({'transform':'translate(0,0)'})
});


// 标列表添加阴影
biaoshade();
function biaoshade(){
	var lisliebiao = $('.content4 .right .list');
	// console.log(lisliebiao)
	lisliebiao.hover(function(){
		$(this).css({'box-shadow':'0px 0px 2px 1px #d0d0d0'});
		$(this).find('.xiangmu').css('border-bottom','none');
		
	},function(){
		$(this).css({'box-shadow':'none'});
		var index = $(this).index();
		if(index==3){
			$(this).find('.xiangmu').css('border-bottom','none');
		}else{
			$(this).find('.xiangmu').css('border-bottom','1px solid #d0d0d0');
		}
		
	});
};


// 平台信息区域鼠标移入向左上移动一段距离
var pingtaiimg = $('#content .content1 .xinxi li img');
pingtaiimg.hover(function(){
	$(this).css({'transform':'translate(0,-3px)'});
},function(){
	$(this).css({'transform':'translate(0,0)'})
});


//平台公告滚动列表
function myGod(id, w, n) {
    //id 为父元素的ID，w为默认多久滚动一次，n 为朝上还是朝下滚
    var box = document.getElementById(id), can = true, w = w || 1500, fq = fq || 30, n = n == -1 ? -1 : 1;
    box.innerHTML += box.innerHTML;
    box.onmouseover = function () {
        can = false
    };
    box.onmouseout = function () {
        can = true
    };
    var max = parseInt(box.scrollHeight / 2);
    new function () {
        var stop = box.scrollTop % 18 == 0 && !can;
        if (!stop) {
            var set = n > 0 ? [max, 0] : [0, max];
            box.scrollTop == set[0] ? box.scrollTop = set[1] : box.scrollTop += n;
        }
        ;
        setTimeout(arguments.callee, box.scrollTop % 18 ? fq : w);
    };
};

myGod('annoceCenter',1440);
