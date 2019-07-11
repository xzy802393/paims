<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=1220"/>
		<title>九趣贷 — 贷快乐，更带梦想</title>
		<link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="../../layui/css/layui.css"/>
		<link rel="stylesheet" href="font/iconfont.css"/>
		<link rel="stylesheet" type="text/css" href="css/points_submit.css"/>
		<link rel="stylesheet" type="text/css" href="/yingpu/pc/css/common4.css"/>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>	
	</head>
	<body>
		<!--顶部-->
		
		<iframe src="../head3.html?num=8" class="iframe-head" width="100%" scrolling="no"  style="border:0px;"></iframe>
		
		<!--主体-->
		<div class="mall">
			<div class="banner">
				<div class="center">
					<!--登录之前-->
					
				</div>
			</div>
			<!--提交内容-->
			<div class="content">
				<div class="navbar-text">
					<p>你现在的位置：
						<a href="/yingpu/pc/index">首页</a>&gt;
						<a href="points_mall.jsp">九趣商城</a>&gt;
						<a href="#">提交订单</a>
					</p>
				</div>
				<div class="main">
					<div class="layui-form-itemi">
						<h3 class="p1">
							<span class="left"><b>选择收货地址</b></span>
							<span class="right guanlishouhuodizhi"><b>管理收货地址</b></span>
						</h3>
						<div class="layui-form" id="address-list">
                            <c:forEach items="${addresses}" var="item">
                                <div class="defaultDZ${item.isDefault == 0 ? ' defaultDZ2' : ''}">
                                    <p class="p1">
                                        <span class="post-to-marker" ${item.isDefault == 0 ? 'style="display:none;"' : ''}>
                                            <i class="iconfont icon-dingwei" style="color:#FF7F01;font-size: 20px;"></i>
                                            <b>寄送至</b>
                                        </span>
                                        <span class="address-des">
                                            <input type="radio" name="addressId" value="${item.id}" title=" ">
                                            <span class="address-province">${item.province}</span> 
                                            <span class="address-city">${item.city}</span> 
                                            <span class="address-region">${item.region}</span> 
                                            <span class="address-detail">${item.detailAddress}</span> 
                                                                                    （<span class="address-name">${item.receiverName}</span>收） 
                                            <span class="address-phone">${item.receiverPhone}</span>
                                        </span>
                                        <span class="set-as-default" style="display:none;">
                                            	默认地址
                                        </span>
                                        <span class="right modify-address">修改本地址</span>
                                    </p>
                                </div>
                            </c:forEach>

					</div>
					</div>
				
					<h3 style="margin: 50px 0 10px 0;">
						<b>使用新地址</b>
					</h3>
					
					<div class="add-address">
						<form class="layui-form" action="" onsubmit="return saveAddress();">
							 <div class="layui-form-item">
							    <label class="layui-form-label">
							    	<span>*</span>收货人名：
							    </label>
							    <div class="layui-input-block" style="width: 30%;">
							      <input type="text" name="receiver-name" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
							    </div>
							</div>
						  
						  	<div class="layui-form-item">
						    	<label class="layui-form-label">
                                        <span>*</span>省份城区：
							    </label>
							    <div class="address-choice">
							    	<div class="distpicker2">
								        <div class="form-group">
								          <label class="sr-only" for="province5">Province</label>
								          <select class="form-control" name='province' id="province5"></select>
								        </div>
								        <div class="form-group">
								          <label class="sr-only" for="city5">City</label>
								          <select class="form-control" name='city' id="city5"></select>
								        </div>
								        <div class="form-group">
								          <label class="sr-only" for="district5">District</label>
								          <select class="form-control" name="region" id="district5"></select>
								        </div>
								    </div>
							    </div>
						  	</div>
						  
						  	<div class="layui-form-item">
							    <label class="layui-form-label">
							    	<span>*</span>详细地址：
							    </label>
							    <div class="layui-input-block" style="width: 30%;">
							      <input type="text" name="detail-address" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
							    </div>
						  	</div>
						  <div class="layui-form-item">
	
						    <label class="layui-form-label"><span>*</span>邮政编码：</label>
						    <div class="layui-input-inline">
						      <input type="namber" name="zip-code" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
						    </div>
						    <div class="layui-form-mid layui-word-aux">如果不知道编码请输入000000</div>
						  </div>
						  <div class="layui-form-item">
						    <label class="layui-form-label"><span>*</span>联系电话：</label>
						    <div class="layui-input-inline">
						      <input type="namber" name="receiver-phone" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
						    </div>
						  </div>
						  <div class="layui-form-item">
						    <div class="layui-input-block">
						      <button class="layui-btn layui-btn-warm" btn-id="save-address" lay-submit lay-filter="formDemo" >保存收货地址</button>
						    </div>
						  </div>
						</form>
					</div>
					<div class="peisong">
					      <h3 style="margin: 20px 0;">选择配送时间</h3>
					      <ul>
					      	<li class="active">仅工作日送达</li>
					      	<li>仅周末送达</li>
					      	<li>任何时间均可</li>
					      </ul>
					</div>
					<div class="layui-form-itemi" style="margin: 20px 0;">
						<h3 class="p1">
							<span class="left">礼品清单</span>
							<span class="right"><a href="points_mall.jsp" style="color: #FF7F01;">返回修改订单礼品</a></span>
						</h3>	
					</div>
				<div class="lipin">
					<div class="lipin_hand">
						<ul>

							<li>礼品兑换</li>
							<li>兑换数量</li>
							<li>礼品单价</li>
							<li>礼品小计</li>
						</ul>						
					</div>
					
					<div class="lipinxiaoji">
						<ul>
							<li>
								<div>
									<img src="${goods.smLogo}" alt="" style="width: 50px;"/>
								</div>	
							</li>
							<li>
								<p class="choice" id="num" >${param.goodsNum}</p>
									<!--选择数量：
								<span style="">
									<input type="button" value="-" id="minus"/>
								</span>
								<span>
									<input type="tel" name="" id="num" value="${param.goodsNum}" />
								</span>
								<span>
									<input type="button" name="plus" id="plus" value="+"/>
								</span>-->
							</li>
							<li>${goods.points}银子</li>
							<li>${goods.points * param.goodsNum}</li>
						</ul>
					</div>
					<div class="layui-form-itemi baonangxiaoji">
						<p class="p1" style="margin: 15px;">
							<span class="right"><span style="color: #000000;">包裹小计：</span><span>${goods.points * param.goodsNum}银子</span></span>
						</p>	
					</div>
					
				</div>
			</div>
		

		<div class="layui-input-block" style="width: 80%;text-align: center;background: #f7f7f7;padding: 100px;">
			<button class="layui-btn layui-btn-warm"  id="order-payment">支付订单</button>
		</div>

		
			
		
		
		<!--悬浮条-->
		<iframe src="/yingpu/pc/xuanfutiao1.html" class="iframe-xuanfu" width="100%" scrolling="no"  style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/yijianfankui.jsp" class="iframe-yijianfankui" scrolling="no" width="100%" style="border:0px;display: none;"></iframe>
		<iframe src="/yingpu/pc/jisuanqi/jisuanqi.html" class="iframe-jisuanqi" scrolling="no" width="100%" style="border:0px;display: none;height:100%; overflow-y: hidden;"></iframe>
		<!--底部导航-->
		
		<iframe src="../footer2.html" class="iframe-foot" width="100%" scrolling="no"  style="border:0px;height:326px;"></iframe>
		
		<!--加载js文件-->
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/distpicker.data.js"></script>
		<script src="js/distpicker.js"></script>
		<script type="text/javascript" src="../../layer-v3.0.3/layer/layer.js"></script>
		<script type="text/javascript" src="layer-v3.1.1/layer/layer.js"></script>
		<script src="/yingpu/pc/newpc/js/xuanfutiao.js" type="text/javascript" charset="utf-8"></script>
		
		<script type="text/javascript">
			//Demo
//			layui.use('form', function(){
//			  var form = layui.form;
//			  
//			  //监听提交
//			  form.on('submit(formDemo)', function(data){
//			    layer.msg(JSON.stringify(data.field));
//			    return false;
//			  });
//			});
			
			$('.distpicker2').distpicker({
			    province: '---- 所在省 ----',
			    city: '---- 所在市 ----',
			    district: '---- 所在区 ----'
			  });
			/**商品数量*/
			$(function(){
				var num = $('#num');
				$('#minus').attr('disabled',true);
				$('#plus').click(function(){
					 // 给获取的val加上绝对值，避免出现负数
					num.val(Math.abs(parseInt(num.val()))+1);
					 if (parseInt(num.val())!=1){
					 	console.log('ceshi')
					  	 $('#minus').attr('disabled',false);
					 };
					if(parseInt(num.val())>=5){
						$("#plus").attr("disabled","disabled");
						layer.msg('数量不能超高5个');
					}else{
						$("#plus").removeAttr("disabled");
					}
				});
				$('#minus').click(function(){
					num.val(Math.abs(parseInt(num.val()))-1);
					$("#plus").removeAttr("disabled");
					if (parseInt(num.val())==1){
					 	$('#minus').attr('disabled',true);
					};
				})
				
			});
			/**选择配送时间*/
			$(".peisong>ul>li").click(function(){
				$(".peisong>ul>li").removeClass();
				$(this).addClass('active');
			});
			/*地址*/
			$(document).on('click', '#address-list>div', function(e, trigger) {
			    e = e || event;
			    var target = e.target || e.srcElement;
			    var classStr = $(target).attr('class') || '';
			    if (classStr.indexOf('layui') != -1 || target.name == 'addressId') {
			        e.stopPropagation();
			        return;
                }

                $('#address-list>div').addClass('defaultDZ2')
                        .find('[type=radio]').trigger('click', ['jq'])
                        .end().find('.post-to-marker,.set-as-default,.modify-address').css('display', 'none');
                $(this).removeClass('defaultDZ2').find('[type=radio]').trigger('click', ['jq'])
                        .end().find('.post-to-marker,.modify-address').css('display', 'inline-block');
			});

            $(document).on('click', '[type=radio]', function(e, trigger) {
                e = e || event;
                e.stopPropagation();
            })
            .on('click', '[btn-id=save-address]', function() {
                //saveAddress();
            })
            .on('click', '#order-payment', function() {
                if (!$('[class=defaultDZ] [name=addressId]').val()) {
                    layer.alert('请选择收货地址！');
                    return;
                }

                    $.post('/yingpu/pc/pointsmall/goods/order/create', {
                    addressId : $('[class=defaultDZ] [name=addressId]').val(),
                    goodsId : '${param.goodsId}',
                    goodsNumber : $('#num').html(),
                    deliverMethod : $('.peisong .active').text()
                }, function(result) {
                    if (result.status == 'success') {
                        $.post('/yingpu/pc/pointsmall/goods/order/payment', {
                            orderNumber : result.data
                        }, function(result2) {
                            if (result2.status == 'success') {
                                layer.alert('订单支付成功!', {title : '温馨提示', btn: ['返回商城首页', '取消']}, function () {
                                    location.href = '/yingpu/pc/pointsmall/points_mall.jsp';
                                }, function () {

                                });
                            }
                            else {
                                layer.alert(result2.message || '支付订单出错！');
                            }
                        }, 'json');
                    }
                    else {
                        layer.alert(result.message || '支付订单出错！');
                    }
                }, 'json');

            })
            .on('click', '[btn-id=modify-address]', function() {
                modifyAddress(addressId, editFromContainer);
            });

            function saveAddress() {
                var valid_rule = /^(13[0-9]|14[5-9]|15[012356789]|166|17[0-8]|18[0-9]|19[8-9])[0-9]{8}$/;// 手机号码校验规则
				if ( ! valid_rule.test($('[name=receiver-phone]').val())) {
                    layer.alert('手机号码格式有误');
                    return false;
                }
				$.post('/yingpu/pc/pointsmall/shopping/address/add', {
                    receiverName : $('[name=receiver-name]').val(),
                    receiverPhone : $('[name=receiver-phone]').val(),
                    province : $('[name=province]').val(),
                    city : $('[name=city]').val(),
                    region : $('[name=region]').val(),
                    zipCode : $('[name=zip-code]').val(),
                    detailAddress : $('[name=detail-address]').val()
                }, function(result) {
                    if (result.status == 'success') {
                        layer.msg('添加成功！', {
                            time: 2000,
                            end: function() {
                                location.reload();
                            }
                        });
                    }
                    else {
                        layer.alert(result.message || '添加收货地址出错！');
                    }
                }, 'json');

                return false;
            }


            /*修改地址*/
            //弹出一个页面层
            $('body').on('click', '.modify-address',function(e){
                var curAddress = $(this).parents('.p1').find('.address-des');
                var curName = curAddress.find('.address-name').text();
                var curProvince = curAddress.find('.address-province').text();
                var curCity = curAddress.find('.address-city').text();
                var curRegion = curAddress.find('.address-region').text();
                var curDetail = curAddress.find('.address-detail').text();
                var curPhone = curAddress.find('.address-phone').text();

                e = e || event;
                var target = e.target || e.srcElement;

                addressId = $(target).parents('div').find('[name=addressId]:checked').val();
                if ($(target).attr('addressId')) {
                    addressId = $(target).attr('addressId');
                }
                editFromContainer = '.layui-layer-content';

                var index = layer.load(2);
                $.get('/yingpu/pc/pointsmall/shopping/address', {id : addressId}, function(result) {
                    layer.close(index);
                    if (!result.data) {
                        return;
                    }

                    layer.open({
                        type: 1,
                        area: ['900px', '560px'],
                        title:'修改地址',
                        shadeClose: true, //点击遮罩关闭
                        content: $('.add-address').html().replace('return saveAddress();', 'return modifyAddress(addressId, editFromContainer);'),

                    });

                    $('body').on('click','.distpicker2',function(){
                        $(this).distpicker({
                            province: "---- 所在省 ----",
                            city: "---- 所在市 ----",
                            district: "---- 所在区 ----"
                        });
                    });
                    $('.layui-layer.layui-layer-page').css('top','150px');

                    var $ele = $(editFromContainer);
                    var data = result.data;

                    $ele.find('[name=receiver-name]').val(data.receiverName);
                    $ele.find('[name=receiver-phone]').val(data.receiverPhone);
                    $ele.find('[name=zip-code]').val(data.zipCode);
                    $ele.find('[name=detail-address]').val(data.detailAddress);

                    $('.distpicker2').click();
                    $ele.find('[name=province] option').prop('selected', false).each(function(i, e) {
                        if ($(e).attr('value') == data.province) {
                            $(e).prop('selected', true)
                            $(e).parent().change().click();
                        }
                    });
                    $ele.find('[name=city] option').prop('selected', false).each(function(i, e) {
                        if ($(e).attr('value') == data.city) {
                            $(e).prop('selected', true);
                            $(e).parent().change().click();
                        }
                    });
                    $ele.find('[name=region] option').prop('selected', false).each(function(i, e) {
                        if ($(e).attr('value') == data.region) {
                            $(e).prop('selected', true);
                            $(e).parent().change();
                        }
                    });
                });
            });

            $(document).on('click', '.guanlishouhuodizhi', function(){
                $(".fade,.succ-pop").css("display","block");
            });
            $(document).on('click', '.fade', function(){
                $(".fade,.succ-pop").css("display","none");
            });

            function deleteAddress(id, ele) {
                $.post('/yingpu/pc/pointsmall/shopping/address/delete', {
                    id : id
                }, function(res) {
                    if (res.status == 'success') {
                        $(ele).parents('tr').remove();
                        layer.msg('删除成功！');
                        setTimeout(function() {
                            location.reload();
                        }, 500);
                    }
                    else {
                        layer.msg(res.message);
                    }
                });
            }

            var addressId, editFromContainer;


            function modifyAddress(id, container) {
                var valid_rule = /^(13[0-9]|14[5-9]|15[012356789]|166|17[0-8]|18[0-9]|19[8-9])[0-9]{8}$/;// 手机号码校验规则
                if ( ! valid_rule.test($(container).find('[name=receiver-phone]').val())) {
                    layer.alert('手机号码格式有误');
                    return false;
                }

                $.post('/yingpu/pc/pointsmall/shopping/address/modify', {
                    id : id,
                    userId : '${pcuser.id}',
                    receiverName : $(container).find('[name=receiver-name]').val(),
                    receiverPhone : $(container).find('[name=receiver-phone]').val(),
                    province : $(container).find('[name=province]').val(),
                    city : $(container).find('[name=city]').val(),
                    region : $(container).find('[name=region]').val(),
                    zipCode : $(container).find('[name=zip-code]').val(),
                    detailAddress : $(container).find('[name=detail-address]').val()
                }, function(result) {
                    if (result.status == 'success') {
                        layer.msg('修改成功！', {
                            time: 2000,
                            end: function() {
                                location.reload();
                            }
                        });
                    }
                    else {
                        layer.alert(result.message || '修改收货地址出错！');
                    }
                }, 'json');

                return false;
            }
		       
		       
		</script>
		<div class="fade" style="display: none"></div>
	    <div class="succ-pop" style="display: none">
	        <table id="mytable" cellspacing="0">   
	            <tr>   
		            <th scope="col">收货人</th>   
		            <th scope="col">所在地址</th>   
		            <th scope="col">详细住址</th>   
		            <th scope="col">邮编</th>   
		            <th scope="col">电话/手机</th>   
		            <th scope="col">操作</th>   
	            </tr>
                <c:forEach items="${addresses}" var="item">
                    <tr>
                        <td class="row">${item.receiverName}</td>
                        <td class="row">
                            <span>${item.province}</span>
                            <span>${item.city}</span>
                            <span>${item.region}</span>
                        </td>
                        <td class="row">${item.detailAddress}</td>
                        <td class="row">${item.zipCode}</td>
                        <td class="row">${item.receiverPhone}</td>
                        <td class="row"><span addressId="${item.id}" class="modify-address">修改</span>&frasl;<span class="del" onclick="deleteAddress(${item.id}, this)">删除</span></td>
                    </tr>
                </c:forEach>
            </table>
	    </div>
	</body>
</html>