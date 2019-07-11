$(document).ready(function(){
	$("#luck").find(".pao").find('.bgadd').show();
		var luck={
			index:-1,	//当前转动到哪个位置，起点位置
			count:8,	//总共有多少个位置
			timer:0,	//setTimeout的ID，用clearTimeout清除
			speed:1,	//初始转动速度
			times:0,	//转动次数
			cycle:36,	//转动基本次数：即至少需要转动多少次再进入抽奖环节
			prize:-1,	//中奖位置
			
			init:function(id){
				if ($("#"+id).find(".pao").length>0) {
					$luck = $("#"+id);
					$units = $luck.find(".pao");
					this.obj = $luck;
					this.count = $units.length;
					$luck.find(".pao").find('.bgadd').show();
					$luck.find(".pao-"+this.index).find('.bgadd').hide();
				};
			},
			
			
			roll:function(){
				var index = this.index;
				var count = this.count;
				var luck = this.obj;
				$(luck).find(".pao-"+index).find('.bgadd').show();
				index += 1;
				if (index>count-1) {
					index = 0;
				};
				$(luck).find(".pao-"+index).find('.bgadd').hide();
				this.index=index;
				// console.log(index);
				return false;
			},
			stop:function(index){
				this.prize=index;
				// console.log(index)
				return false;
			}
		};
			
			
		function roll(){
			luck.times += 1;
			luck.roll();//转动过程调用的是luck的roll方法，这里是第一次调用初始化
			if (luck.times > luck.cycle+10 && luck.prize==luck.index) {
				clearTimeout(luck.timer);
				luck.prize=-1;
				luck.times=0;
				click=false;
				onRollingFinish();
			}else{
				if (luck.times<luck.cycle) {
					luck.speed -= 10;
				}else if(luck.times==luck.cycle) {
					var index = Math.random()*(luck.count)|0;
					luck.prize = index;        
				}else{
					if (luck.times > luck.cycle+10 && ((luck.prize==0 && luck.index==7) || luck.prize==luck.index+1)) {
						luck.speed += 110;
					}else{
						luck.speed += 20;
					}
				}
				if (luck.speed<40) {
					luck.speed=40;
				};
				//console.log(luck.times+'^^^^^^'+luck.speed+'^^^^^^^'+luck.prize);
				luck.timer = setTimeout(roll,luck.speed);//循环调用
			}
			return false;
		}
		$("#luck").find(".pao").find('.bgadd').show();
		var click=false;
		window.onload = function(){
			$("#startPao").click(function(){
				$('.pao').find('.bgadd').show();
				if (click) {//click控制一次抽奖过程中不能重复点击抽奖按钮，后面的点击不响应
					return false;
				}else{
					luck.init('luck');
					luck.prize=-1;
					luck.speed=100;
					roll();    //转圈过程不响应click事件，会将click置为false
					click=true; //一次抽奖完成后，设置click为true，可继续抽奖
					
					return false;
				};
				
			});
			
		}		
		
		
		
		// 关闭中奖弹框
		$("#tankuang").click(function () {
			$("#tankuang").hide();
			$("#tankuang .content1").hide();
			$("#tankuang .content2").hide();
		});
		
		/** 转动光标到指定奖品。 */
		function rollCursorToPosition(pos) {
			luck.prize = pos;
		    roll();
		}
		
		// 中奖
		function zhong(src,name) {
			$("#tankuang").show();
			$("#tankuang .content1").show();
			// 奖品图片
			$("#tankuang .content1 .tu").attr("src",src);
			// 奖品名称
			$("#tankuang .content1 .jiang").html(name);
		}
		
		// 未中奖
		function weizhong(numm) {
			$("#tankuang").show();
			$("#tankuang .content2").show();
		}
		
		
		
		// 如果中奖。zhong = true;
		var zhongjiang=true;
		
		
		
		/** 滚动结束时。 */
		function onRollingFinish() {
			luck.speed = 200;
			
			setTimeout(function() {
				if(zhongjiang){
					zhong("img/jiangkongtiao.png","美的空调");
				}else{
					weizhong();
				}
				
			}, 1000);
		}	
	});	