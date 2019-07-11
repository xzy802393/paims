$(function(){
	
	

	a = function(e){
	    e.preventDefault();
	},
	b =  function(e){
	    e.preventDefault();
	};
	
	$(".iframe-xuanfutiao").on("load", function(event){

		doc = $('.iframe-jisuanqi')[0].contentWindow.document;
		
		
		// left: 37, up: 38, right: 39, down: 40,
		// spacebar: 32, pageup: 33, pagedown: 34, end: 35, home: 36
		var keys = [37, 38, 39, 40];
		
		function preventDefault(e) {
		  e = e || window.event;
		  if (e.preventDefault)
		      e.preventDefault();
		  e.returnValue = false;  
		}
		
		function keydown(e) {
		    for (var i = keys.length; i--;) {
		        if (e.keyCode === keys[i]) {
		            preventDefault(e);
		            return;
		        }
		    }
		}
		
		function wheel(e) {
		  preventDefault(e);
		}
		
		function disable_scroll() {
		  if (window.addEventListener) {
		      window.addEventListener('DOMMouseScroll', wheel, false);
		  }
		  window.onmousewheel = document.onmousewheel = wheel;
		  document.onkeydown = keydown;
		}
		
		function enable_scroll() {
		    if (window.removeEventListener) {
		        window.removeEventListener('DOMMouseScroll', wheel, false);
		    }
		    window.onmousewheel = document.onmousewheel = document.onkeydown = null;  
		}
		
		
		$(this).hover(function(){
			$(".iframe-xuanfutiao").css("width","204px");
		},function(){
			$(".iframe-xuanfutiao").css("width","60px");
		});
		
	　　$("#jisuanqi", this.contentDocument).click(function(){
			disable_scroll();
			$(".iframe-jisuanqi").height($(window).height()).css({
			  "overflow-y": "hidden"  
			});


			console.log(doc);
			doc.addEventListener('mousewheel',a, true);
			
//		    $("html").css("overflow","hidden");

	　　　　$(".iframe-jisuanqi").show();	
	　　});

	
	　$(doc).find("#close").click(function(){
			console.log(a);
			enable_scroll();
			doc.removeEventListener('mousewheel', a, true);
		    //$("html").css("overflow","scroll");

	　　　　$(".iframe-jisuanqi").hide();	
	　　});
	
	  $("#goTop",this.contentDocument).click(function(){
	　　　　$(window).scrollTop(0);	
	　　});
	});
	
	$(".iframe-jisuanqi").on("load", function(event){
	　$("#close",this.contentDocument).click(function(){
		    $("html").css("overflow","scroll");
	　　　　$(".iframe-jisuanqi").hide();	
	　　});
	});
});





	
	
	
	
	
	

	