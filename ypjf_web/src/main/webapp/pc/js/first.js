//banner

$(document).ready(function(){
	
	var curIndex = 0, //当前index
      imgLen = $(".imgList li").length; //图片总数
      $(".imgList").css('width',100*imgLen+'%');
     // 定时器自动变换2.5秒每次
	var autoChange = setInterval(function(){ 
	    if(curIndex < imgLen-1){ 
	      curIndex ++; 
	    }else{ 
	      curIndex = 0;
	    }
	    //调用变换处理函数
	    changeTo(curIndex); 
	  },2500);
 
    $(".indexList").find("li").each(function(item){ 
	    $(this).hover(function(){ 
	      clearInterval(autoChange);
	      changeTo(item);
	      curIndex = item;
	    },function(){ 
	      autoChangeAgain();
	    });
    });
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
	    },2500);
	    }
	  function changeTo(num){ 
	    var goLeft = num * $(".banner-list").width();
	    $(".imgList").animate({left: "-" + goLeft + "px"},100);
	    $(".indexList").find("li").removeClass("indexOn").eq(num).addClass("indexOn");
	  };
	  
	  
//平台公告广告

	function myGod(id,w,n){
		//id 为父元素的ID，w为默认多久滚动一次，n 为朝上还是朝下滚
	var box=document.getElementById(id),can=true,w=w||1500,fq=fq||10,n=n==-1?-1:1;
	box.innerHTML+=box.innerHTML;
	box.onmouseover=function(){can=false};
	box.onmouseout=function(){can=true};
	var max=parseInt(box.scrollHeight/2);
	new function (){
	   var stop=box.scrollTop%18==0&&!can;
	   if(!stop){
	    var set=n>0?[max,0]:[0,max];
	    box.scrollTop==set[0]?box.scrollTop=set[1]:box.scrollTop+=n;
	   };
	   setTimeout(arguments.callee,box.scrollTop%18?fq:w);
	};
	};
	
	myGod('scrollAd',3000);
	
	  


//监控滚动事件
//			$(window).scroll(function(){
//				if($(window).scrollTop()>=600){
//				data_1.start();
//				data_2.start();
//				data_3.start();
//				data_4.start();
//				}
//			})

//表示项目进度的插件js
	  
	 
	
	
//车贷融图片滚动
   $(".car-loan-f").hover(function(e){
   	 timer=setTimeout(function(){
   	 	console.log($(".car-loan-f").css('left'));
   		/* $('.car-pic').css('left',e.pageX-100+1);*/
   		 /* $('.car-pic').animate({left:280},"slow",function(){  	  	
   	  });*/
   	},'1000');
   	
   	
   	  $('.car-pic').css('left',5);
   	  console.log($('.car-pic'));
   	  
// 		if($('.car-pic').left == "280px"){
// 			$('.car-pic').left = 0;  			   		
// 			$('.car-pic').animate({left:280},"10000");
// 		}
   	
  });
/*  $(".car-loan-f").monseout(function(e){
  		timer
  });*/
 
 //合作机构轮播
    
   	 //合作机构轮播
    	var swiper = new Swiper('.swiper-container', {
//      pagination: '.swiper-pagination',
//      nextButton: '.swiper-button-next',
//      prevButton: '.swiper-button-prev',
        slidesPerView: 6,
        paginationClickable: true,
        spaceBetween: 0,
//      loop: true,
//      autoplay: 3000,
//      autoplayDisableOnInteraction: false,
        observer:true
    });
    
  
    

})
  