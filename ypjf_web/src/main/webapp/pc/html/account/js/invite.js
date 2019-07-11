
 
// 微信分享
$(".linkRight .weixin").hover(function (){  
	$(".linkRight .icon-wechat .wechat-qrcode").show();
	$(this).attr('src','img/invite-img/weixinc.jpg');
},function (){  
	$(".linkRight .icon-wechat .wechat-qrcode").hide();
	 $(this).attr('src','img/invite-img/weixin.jpg'); 
});  

// 微博分享
$(".linkRight .weibo").on('mouseover',function(){
	$(this).attr('src','img/invite-img/weiboc.jpg');
});
$(".linkRight .weibo").on('mouseout',function(){
	$(this).attr('src','img/invite-img/weibo.jpg');
});


// qq分享
$(".linkRight .qq").on('mouseover',function(){
	$(this).attr('src','img/invite-img/qqc.jpg');
});
$(".linkRight .qq").on('mouseout',function(){
	$(this).attr('src','img/invite-img/qq.jpg');
});



// 兑换按钮
$('.items .item .zheng .btn').on('click',function(){
	$(this).parent().parent().find('#share_box').show();
	// 兑换区域微信分享
	$(this).parent().parent().find('#share_box .social-share .icon-wechat').hover(function(){
		console.log(111)
		$(this).find(".wechat-qrcode").show();
	},function(){
		$(this).find(".wechat-qrcode").hide();
	});
});




 