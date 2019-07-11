// 日历和项目列表的切换
var btn = $('.money-back .back-box .subTitle .list');
var rili = $('.money-back .back-box .rili');
var tabs = $('.money-back .back-box .tabs');
var nav = $('.money-back .back-box .tabs .nav span');
var items = $('.money-back .back-box .tabs .tab');
var isTrue = true;
btn.on('click',function(){
	if(isTrue){
		btn.find('img').attr('src','/yingpu/pc/html/account/img/listBg2.png');
		rili.hide();
		tabs.show();
		items.hide();
		items.eq(0).show();
		nav.removeClass('active');
		nav.eq(0).addClass('active');
		isTrue = !isTrue;
	}else{
		btn.find('img').attr('src','/yingpu/pc/html/account/img/listBg.png');
		rili.show();
		tabs.hide();
		items.hide();
		nav.removeClass('active');
		isTrue = !isTrue;
	}
	
});
// 标类型转换
nav.on('click',function(){
	nav.removeClass('active');
	items.hide();
	$(this).addClass('active');
	var num = $(this).index();
	items.eq(num).show();
});




// 日历
$('#ca').calendar({
	width: 560,
	height: 310,
// 	data: [
// 		{
// 		  date: '2015/12/24',
// 		  value: 'Christmas Eve'
// 		},
// 		{
// 		  date: '2015/12/25',
// 		  value: 'Merry Christmas'
// 		},
// 		{
// 		  date: '2016/01/01',
// 		  value: 'Happy New Year'
// 		}
// 	]
});

// 获取当前日期
var myDate = new Date();//获取系统当前时间
var year = myDate.getFullYear(); //获取完整的年份(4位,1970-????)
var month = myDate.getMonth()+1; //获取当前月份(0-11,0代表1月)
var data = myDate.getDate(); //获取当前日(1-31)
var $date = $('.money-back .back-box .rili .date');
$date.text(year+"-"+month+"-"+data);
// console.log($date.text());
// var riqi;
// riqi = year +'-'+ month +'-'+ data;

// 日历点击事件
var checked = $('#ca').find(".date-items .days li");

checked.on('click',function(){
    var y,m,d,time;
    d=$(this).html();
    // console.log($(this).text());
    setTimeout(function(){
        m=$('#ca').find(".calendar-display .m").text();
        y=$('#ca').find(".calendar-display").html().substring(0,4);
        time= y+'-'+m+'-'+d;
        $date.text(time);
        $.ajax({
            type:'POST',
            url: '/yingpu/pc/myaccount/getmoney',
            data:{year:y,month:m,day:time,},
            dataType: 'json',
            success:function(data){
                var data = data.map;
                if(data.DMoney == null){
                    $('.you').find(".num:first").text("0.00");
                }else{
                    $('.you').find(".num:first").text(data.DMoney);
                }
                if(data.PaymentMoney == null){
                    $('.you').find(".num:last").text("0.00");
                }else{
                    $('.you').find(".num:last").text(data.PaymentMoney);
                }
                if(data.MMoney == null){
                    $('.bt').find(".money").text("0.00");
                }else{
                    $('.bt').find(".money").text(data.MMoney);
                }

            }
        });
    },50);

});


var prevMonth =$('#ca').find(".prev");
var nextmonth =$('#ca').find(".next");

prevMonth.on('click',function(){
    prevYear1 = $('#ca').find(".calendar-display").html();
    prevMonth2 = $('#ca').find(".calendar-display .m").text();
    // console.log("年份:"+prevMonth2.substring(0,4));
    $.ajax({
		type:'POST',
		url: '/yingpu/pc/myaccount/getmoney',
		data:{year:prevYear1.substring(0,4),month:prevMonth2-1},
		dataType: 'json',
		success:function(data){
            var data = data.map;
            if(data.MMoney == null){
                $('.bt').find(".money").text("0.00");
			}else{
                $('.bt').find(".money").text(data.MMoney);
			}if(data.PaymentMoney == null){
                $('.you').find(".num:last").text("0.00");
            }else{
                $('.you').find(".num:last").text(data.PaymentMoney);
            }

		}
	});

});

nextmonth.on('click',function(){
    nextYear1 = $('#ca').find(".calendar-display").html();
    nextMonth2 = $('#ca').find(".calendar-display .m").text();
    $.ajax({
        type:'POST',
        url: '/yingpu/pc/myaccount/getmoney',
        data:{year:nextYear1.substring(0,4),month:Number(nextMonth2)+Number(1)},
        dataType: 'json',
        success:function(data){
            var data = data.map;
            if(data.MMoney == null){
                $('.bt').find(".money").text("0.00");
            }else{
                $('.bt').find(".money").text(data.MMoney);
            }if(data.PaymentMoney == null){
                $('.you').find(".num:last").text("0.00");
            }else{
                $('.you').find(".num:last").text(data.PaymentMoney);
            }
        }
    });
});



// 问候语
var $wenhou = $('#account .person .left .wenhou');
$wenhou.text(wenhou());
function wenhou(){
	var now = new Date(),hour = now.getHours() 
	if(hour < 6){ return ("早点休息！明天的阳光更灿烂！ ")} 
	else if (hour < 12){ return "早上好，一日之计在于晨！今天要努力哦！"} 
	else if (hour < 18){ return "下午好，做一个微笑挂在嘴边，快乐放在心上的人！"} 
	else if (hour < 24){ return "晚上好，万家灯火，和家人在一起最最幸福！！"}
	else { return ""} 
}



// 上传头像
$('.shade').click(function() {
	$('#file-input').val('').click();
});
 $(document).on('change', '#file-input', function() {
		if (!/(?:jpg|png|bmp|jpeg|gif|ico)$/.test($(this).val())) {
			layer.msg('上传的头像只能是图片格式 (jpg/png/bmp/ico)！');
			return;
		}
		
		if (this.files[0] && this.files[0].size > 1024 * 1024) {
			layer.msg('上传的头像大小不能超过1MB，请重新选择！');
			return;
		}
		
		
		uploadFile($(this).attr('id'), function(data) {
			if (!!data) {
				$('#user-avatar').attr('src', data);
				// console.log($('#user-avatar'));
				// console.log($('#user-avatar').attr('src'));
				updateUserAvatar(data);
			}
		});
	})
	.on('mouseover', '.shade', function() {
		$('.shade').stop().animate({opacity : 0.3});
	})
	.on('mouseout', '.shade', function() {
		$('.shade').stop().animate({opacity : 0});
	});
	
	
	function updateUserAvatar(data) {
		useLoadingShade();
		$.post('../myaccount/doChangeUserAvatar', {
			header : data
		}, function(data) {
			if (data.status == 'success') {
				layer.msg('更换头像成功！');
			}
			else{
				layer.msg('对不起更换头像失败，请稍后再试！');
			}
			
			cancelLoadingShade();
		}, 'json');
	}
	
	
	function onError(msg) {
		layer.alert(msg || '上传出错');
	}
	
	
	function uploadFile(eleId, successCallback) {
		var index = layer.load(2, { shade : [0.5, '#fff'] });
		$.ajaxFileUpload({
            url : '/yingpu/adminFileUpload',
            secureuri : false,
            fileElementId : eleId,
            dataType : 'text',
            data : { from : 'frontend' },
            success : function(data, status) {
            	if (data.indexOf('出错') != -1) {
            		onError(data);
            		return;
            	}
            	successCallback && successCallback(data);
            },
            error : function(data, status, e) {
           		onError(data);
            }, 
            complete : function() {
            	layer.close(index);
            }
        });
	}
    