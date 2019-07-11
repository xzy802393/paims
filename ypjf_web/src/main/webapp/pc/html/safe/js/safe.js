var fix = $('#fix');


//  $(function(){
//         $(window).scroll(function() {
//             var s = $(window).scrollTop();
//             if(s>300){
//                 $("#hiden").show();
//             }else{
//                 $("#hiden").hide();
//             }
//         });
//     })

$(window).scroll(function() {
  //为了保证兼容性，这里取两个值，哪个有值取哪一个
  //scrollTop就是触发滚轮事件时滚轮的高度
  var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
  // console.log("滚动距离" + scrollTop);
  
	if(scrollTop>600){
		fix.show();
		if(700<scrollTop <5040){
			fix.find('img').attr('src','/yingpu/pc/html/safe/img/title1.jpg');
			if(700<scrollTop){
				fix.find('img').attr('src','/yingpu/pc/html/safe/img/title1.jpg');
				if(1400<scrollTop){
					fix.find('img').attr('src','/yingpu/pc/html/safe/img/title2.jpg');
					if(1700<scrollTop){
						fix.find('img').attr('src','/yingpu/pc/html/safe/img/title3.jpg');
						if(2200<scrollTop){
							fix.find('img').attr('src','/yingpu/pc/html/safe/img/title4.jpg');
							if(2600<scrollTop){
								fix.find('img').attr('src','/yingpu/pc/html/safe/img/title5.jpg');
								if(3300<scrollTop){
									fix.find('img').attr('src','/yingpu/pc/html/safe/img/title6.jpg');
									if(3700<scrollTop){
										fix.find('img').attr('src','/yingpu/pc/html/safe/img/title7.jpg');
										if(3950<scrollTop){
											fix.find('img').attr('src','/yingpu/pc/html/safe/img/title8.jpg');
											if(4440<scrollTop){
												fix.find('img').attr('src','/yingpu/pc/html/safe/img/title9.jpg');
											}
										}
									}
								}
							}
							
						} 
					}
				}
			}
		}
	}else{
		fix.hide();
	}
  
})
