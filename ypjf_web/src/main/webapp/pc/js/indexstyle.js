window.onload = function () {
    var header =document.getElementById("iframeHead").contentWindow.document.getElementById('header');
    $(header).css({
    	"width": "100%",
	    "position": "fixed",
	    "top": 0,
	    "z-index": 10,
	    "background": "rgba(0, 0, 0, 0.4)",
	    "color": "#fff"
    });
    var headerNav = $(header).find(".header-nav");
    $(headerNav).css("background","none");
    
}