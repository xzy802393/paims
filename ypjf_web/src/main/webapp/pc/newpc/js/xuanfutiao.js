		// 悬浮条的滚动
		var t=$(window).scrollTop();
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
				 $('.iframe-jisuanqi').css('display','inline');
				 
// 				var jsq = 	layer.open({
// 							type: 2,
// 							title: false,
// 							closeBtn: 0,
// 							// maxmin: true,
// 							resize:false,
// 							shadeClose: true, //点击遮罩关闭层
// 							shade: [0.8, '#393D49'],
// 							area : ['1000px' , '660px'],
// 							content: '/yingpu/pc/jisuanqi/jisuanqi.html',
// 							success: function (layero, index)
// 									{
// 											var body = layer.getChildFrame('body', index);
// 											var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
// 											console.log(body.html()) //得到iframe页的body内容
// 											body.find("#close").click(function(){
// 												layer.close(jsq);
// 											});
// 									}
// 					});

			 });
			 $('.iframe-jisuanqi').contents().find("#close").click(function(){
				$('.iframe-jisuanqi').css('display','none'); 
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
				var yjfk = 	layer.open({
							type: 2,
							title: false,
							closeBtn: 0,
							// maxmin: true,
							resize:false,
							shadeClose: true, //点击遮罩关闭层
							shade: [0.8, '#393D49'],
							area : ['930px' , '800px'],
							content: '/yingpu/pc/yijianfankui.jsp',
							success: function (layero, index)
									{
											var body = layer.getChildFrame('body', index);
											var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
											console.log(body.html()) //得到iframe页的body内容
											body.find("#exit").click(function(){
												layer.close(yjfk)
											});
									}
				});
				 
			 });
			
			 
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
