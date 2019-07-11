
var mySwiper = new Swiper('.swiper-container',{
								
				  paginationClickable: true,
				  spaceBetween: 0,
				  slidesPerView: 1,
				  loop: true,
				  autoplay: 3000,
				  autoplayDisableOnInteraction: false,
				  observer: true,//修改swiper自己或子元素时，自动初始化swiper
				  observeParents: true//修改swiper的父元素时，自动初始化swiper
				  
			});
						  
			$('.arrow-left').on('click', function(e){
			  e.preventDefault()
			  mySwiper.swipePrev()
			})
			$('.arrow-right').on('click', function(e){
			  e.preventDefault()
			  mySwiper.swipeNext()
			});
			var carrousel = $( ".carrousel" );
			
			$('.swiper-wrapper').delegate('img','click',function(e){
				
					console.log("123");
				  var src = $(this).attr( "src" );
				  var img=new Image();
				  img.src=src;
				  
				  var realwidth=img.width;
				  var realheight=img.height;
				 var w,h;
				 if(realwidth>realheight){
				 	 w=800;
				 	 h=800/realwidth*realheight;
				 }else{
				 	 h=800;
				 	 w=800/realheight*realwidth;
				 }
				 
				  carrousel.find("img").attr( "src", src ).css({'width':w,'height':h,'left':($(window).width()-w)/2+"px",'top':(($(window).height()-h)/2)+'px'});
				  //判断图片是竖还是横
				  
				
				carrousel.fadeIn(); 
			});
			
			carrousel.each(function(){
				$(this).click(function(e){
				  carrousel.find("img").attr( "src", '' );
				  carrousel.fadeOut(0);
				});
			});
			


//选项卡切换功能
var $btns = $('#idea .navs .nav');
var $items = $('#idea .list li');
$btns.on('click',function(){
	$btns.removeClass('active');
	$(this).addClass('active');
	var num = $(this).index();
	$items.css('display','none');
	$items.eq(num).css('display','block');
});



