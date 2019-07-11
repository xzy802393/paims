var page1 = $('.page1').eq(0);
var page2 = $('.page2').eq(0);
var tj = $('.tj').eq(0);
var jieguo = $('.jieguo');
var list = $('.jieguo .leixing li');





var arr=[];
var arr1=[];
var arr2=[];
var arr3=[];
var num1 = -1;
var num2 = -1;
var newArr = [];
// 多选1
// function countCheckd1() {
// 	
// 	
// 	var $c = $(".page2 .duo1 :checkbox:checked"); //返回被选中的多选框
// 	
// 	$c.each(function() {//循环输出多选框的值
// 		arr1.push(parseInt($(this).val()));
// 		arr1.sort(function (a, b) {
// 		  return a-b;
// 		}); // [5,12,22,25,51,56]
// 		var max = arr1[arr1.length - 1];  // 56
// 		num1 = max;
// 	});
// 	arr.push(num1);
// }
// // 多选2
// function countCheckd2() {
// 	
// 	var $c = $(".page2 .duo2 :checkbox:checked"); //返回被选中的多选框
// 	$c.each(function() {//循环输出多选框的值
// 		arr2.push(parseInt($(this).val()));
// 		arr2.sort(function (a, b) {
// 		  return a-b;
// 		}); // [5,12,22,25,51,56]
// 		var max = arr2[arr2.length - 1];  // 56
// 		num2 = max;
// 	});
// 	arr.push(num2);
// }
// 
// // 单选值
// var sum2=0;
// function single(){
// 	var $d = $(".box :radio:checked"); //返回被选中的单选框
// 	$d.each(function() {//循环输出单选框的值
// 		arr3.push(parseInt($(this).val()));
// 	});
// 	// console.log(arr3);
// 	for (var i=0;i<=arr3.length;i++) {
// 		if (typeof arr3[i]=="number") {
// 			sum2+=arr3[i];
// 		}
// 	}
// 	console.log("sum2==="+sum2);
// }




var uid;
// 下一页
$('.next').on('click',function(){
	page1.hide();
	page2.show();
});

// 上一页
$('.prev').on('click',function(){
	page2.hide();
	page1.show();
});

var sum2=0;
// 显示结果
tj.on('click',function(){
	var a = $('.jieguo .leixing li label input[type="checkbox"]:checked');
	// 单选
	var $d = $(".box :radio:checked"); //返回被选中的单选框
	$d.each(function() {//循环输出单选框的值
		arr3.push(parseInt($(this).val()));
	});
	
	// console.log(arr3.length);
	// console.log(arr3);
	// console.log("sum2 === "+sum2);
	
	// 多选1
	var $c = $(".page2 .duo1 :checkbox:checked"); //返回被选中的多选框
	$c.each(function() {//循环输出多选框的值
		arr1.push(parseInt($(this).val()));
		arr1.sort(function (a, b) {
		  return a-b;
		}); // [5,12,22,25,51,56]
		var max = arr1[arr1.length - 1];  // 56
		num1 = max;
	});
	num1 = parseInt(num1);
	// console.log(num1);
	
	// 多选2
	var $c = $(".page2 .duo2 :checkbox:checked"); //返回被选中的多选框
	$c.each(function() {//循环输出多选框的值
		arr2.push(parseInt($(this).val()));
		arr2.sort(function (a, b) {
		  return a-b;
		}); // [5,12,22,25,51,56]
		var max = arr2[arr2.length - 1];  // 56
		num2 = max;
	});
	num2 = parseInt(num2);
	// console.log(num2);
	
	// 是否全部做完
	if(num1<0||num2<0||arr3.length <13){
		layer.alert('请您完成全部测试题再进行提交');
		return false;
	}else{
		page2.hide();
		page1.hide();
		jieguo.show();
	}
	
	for (var i=0;i<=arr3.length;i++) {
		if (typeof arr3[i]=="number") {
			sum2+=arr3[i];
		}
	};
	
	num = num1 + num2 + sum2;
	// console.log(num)
	total(num);
		
	// ajax  传输总和值
// 	$.ajax({
// 		type: "POST",
// 		url: "",
// 		contentType: 'application/x-www-form-urlencoded;charset=utf-8',
// 		data: {username:$("#username").val(), password:$("#password").val()},
// 		dataType: "json",
// 		success: function(data){
// 					console.log(data);
// 				}，
// 		error:function(e){
// 					console.log(e);
// 		}
// 	});
	
});

// 总和
function add(){
	var sum1=0;
	for (var i=0;i<=arr.length;i++) {
		if (typeof arr[i]=="number") {
			sum1+=arr[i];
		}
	}
	console.log("sum1==="+sum1)
}

// 计算结果
function total(num){
    var val;
    if(0<=num<=100){
		if(num>70){
			list.eq(4).show();
			val = list.eq(4).find(".lx").text();
		}else{
			if(num>=42){
				list.eq(3).show();
                val = list.eq(3).find(".lx").text();
			}else{
				if(num>=25){
					list.eq(2).show();
                    val = list.eq(2).find(".lx").text();
				}else{
					if(num>=15){
						list.eq(1).show();
                        val = list.eq(1).find(".lx").text();;
					}else{
						list.eq(0).show();
                        val = list.eq(0).find(".lx").text();
					}
				}
			}
		}
	}
	$.post('/yingpu/pc/setRiskRating',{id:uid,riskRating:num});
};
function tzurl(url) {
    top.location.href = '/yingpu/pc' + url;
}

$(function(){

	if(JSON.parse(sessionStorage.user).id==undefined){
        uid=JSON.parse(sessionStorage.user).userId;
	}
	if(JSON.parse(sessionStorage.user).userId == undefined){
		uid=JSON.parse(sessionStorage.user).id;
	}
    console.log(uid);
    $.post('/yingpu/pc/setRiskRating',{id:uid},function(data){
        if(data.message!=null){
            // layer.alert(data.message, {title: '温馨提示'});
            page2.hide();
            page1.hide();
            var map= data.map;
            total(map.riskrating);
            jieguo.show();
        }
    });
});

