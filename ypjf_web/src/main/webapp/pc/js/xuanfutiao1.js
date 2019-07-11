// 悬浮条的滚动
		 var top = parseInt($('.iframe-xuanfu').css('top'));
		 $('.iframe-xuanfu').css({ 'top': top+t ,'display':'block'});

		 window.onload = function() {
			 // 联系客服
			 $(".iframe-xuanfu").contents().find("#kf").mouseover(function(){
			 	$(this).addClass('yiru');
			 	$(this).find('.now').css('display','none');
			 	$(this).find('.yiruh').css('display','none');
			 	$(this).find('.tip').css('display','block');
			 });
			 $(".iframe-xuanfu").contents().find("#kf").mouseout(function(){
			 	$(this).removeClass('yiru');
			 	$(this).find('.now').css('display','block');
			 	$(this).find('.yiruh').css('display','none');
				$(this).find('.tip').css('display','none');
			 });
			 $(".iframe-xuanfu").contents().find("#kf").click(function(){
			 
			 	$(this).addClass('yiru');
			 	$(this).find('.now').css('display','none');
			 	$(this).find('.yiruh').css('display','none');
			 	$(this).find('.tip').css('display','block');
			 });
			 
			 
			 // app
			 
			 $(".iframe-xuanfu").contents().find("#app").mouseover(function(){
			 	$(this).addClass('yiru');
			 	$(this).find('.now').css('display','none');
			 	$(this).find('.yiruh').css('display','none');
			 	$(this).find('.tip').css('display','block');
			 	$(this).find('.app').css('display','block');
			 });
			 $(".iframe-xuanfu").contents().find("#app").mouseout(function(){
			 	$(this).removeClass('yiru');
			 	$(this).find('.now').css('display','block');
			 	$(this).find('.yiruh').css('display','none');
			 	$(this).find('.tip').css('display','none');
				$(this).find('.app').css('display','none');
			 });

			 
			 // 计算器
			 $(".iframe-xuanfu").contents().find("#jisuanqi").mouseover(function(){
				 $(this).addClass('yiru');
				 $(this).find('.now').css('display','none');
				 $(this).find('.yiruh').css('display','none');
				 $(this).find('.tip').css('display','block');
			 });
			 $(".iframe-xuanfu").contents().find("#jisuanqi").mouseout(function(){
				 $(this).removeClass('yiru');
				 $(this).find('.now').css('display','block');
				 $(this).find('.yiruh').css('display','none');
				 $(this).find('.tip').css('display','none');
			 });
             $(".iframe-xuanfu").contents().find("#jisuanqi").click(function(){

                 $(this).addClass('yiru');
                 $(this).find('.now').css('display','none');
                 $(this).find('.yiruh').css('display','none');
                 $(this).find('.tip').css('display','block');
                 $('.iframe-jisuanqi').css('display','block');
                 $('.iframe-jisuanqi').css('top',t);
                 unScroll();

             });
             $(".iframe-jisuanqi").contents().find("#close").click(function(){
                 $(".iframe-jisuanqi").css('display','none');
                 removeUnScroll();
             })

			 // 意见反馈
			 $(".iframe-xuanfu").contents().find("#yijianfankui").mouseover(function(){
				 $(this).addClass('yiru');
				 $(this).find('.now').css('display','none');
				 $(this).find('.yiruh').css('display','none');
				 $(this).find('.tip').css('display','block');
			 });
			 $(".iframe-xuanfu").contents().find("#yijianfankui").mouseout(function(){
			 
				 $(this).removeClass('yiru');
				 $(this).find('.now').css('display','block');
				 $(this).find('.yiruh').css('display','none');
				 $(this).find('.tip').css('display','none');
			
			 });
			 $(".iframe-xuanfu").contents().find("#yijianfankui").click(function(){
			 
				 $(this).addClass('yiru');
				 $(this).find('.now').css('display','none');
				 $(this).find('.yiruh').css('display','none');
				 $(this).find('.tip').css('display','block');
				 $('.iframe-yijianfankui').css('display','block');
				 $('.iframe-yijianfankui').css('top',t);
				 unScroll();
				 
			 });
			 $(".iframe-yijianfankui").contents().find("#exit").click(function(){
				 $(".iframe-yijianfankui").css('display','none');
				 removeUnScroll();
			 })
			 
			 // 置顶
			 var kaiguan5 = false;
			 $(".iframe-xuanfu").contents().find("#go-top").mouseover(function(){
				$(this).addClass('yiru');
				$(this).find('.now').css('display','none');
				$(this).find('.yiruh').css('display','none');
				$(this).find('.tip').css('display','block');
			 });
			 $(".iframe-xuanfu").contents().find("#go-top").mouseout(function(){
			 	$(this).removeClass('yiru');
			 	$(this).find('.now').css('display','block');
			 	$(this).find('.yiruh').css('display','none');
			 	
			 });
			 $(".iframe-xuanfu").contents().find("#go-top").click(function(){
			 
				 $(this).addClass('yiru');
				 $(this).find('.now').css('display','none');
				 $(this).find('.yiruh').css('display','none');
				 $(this).find('.tip').css('display','block');
				 $('html').animate({scrollTop: '0px'}, 800, );
			 
			 });
			 
			 
			 // 滚动条的禁用和启动
			function unScroll() {
					var top = $(document).scrollTop();
					$(document).on('scroll.unable', function (e) {
							$(document).scrollTop(top);
					});
			}
			function removeUnScroll() {
					$(document).unbind("scroll.unable");
			}
		 }
