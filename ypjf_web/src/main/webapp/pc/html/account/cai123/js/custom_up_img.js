$(document).ready(function(){
        
		$("#up-img-touch").on('mouseover', '.shade', function() {
				$('.shade').stop().animate({opacity : 0.3});
			})
			.on('mouseout', '.shade', function() {
				$('.shade').stop().animate({opacity : 0});
			});
		$("#up-img-touch").click(function(){
				  $("#doc-modal-1").modal({width:'600px'});
		});
		// $('.shade').click(function() {
		// 	$('#up-img-touch').val('').click();
		// });
});
$(function() {
    'use strict';
    // 初始化
    var $image = $('#image');
    $image.cropper({
        aspectRatio: '1',
        autoCropArea:0.8,
        preview: '.up-pre-after',
        
    });

    // 事件代理绑定事件
    $('.docs-buttons').on('click', '[data-method]', function() {
   
        var $this = $(this);
        var data = $this.data();
        var result = $image.cropper(data.method, data.option, data.secondOption);
        switch (data.method) {
            case 'getCroppedCanvas':
            if (result) {
                // 显示 Modal
                $('#cropped-modal').modal().find('.am-modal-bd').html(result);
                $('#download').attr('href', result.toDataURL('image/jpeg'));
            }
            break;
        }
    });
    
    

    // 上传图片
     var $inputImage = $('#inputImage');
     var URL = window.URL || window.webkitURL;
     var blobURL;

     if (URL) {
         $inputImage.change(function () {
             var files = this.files;
             var file;
 
             if (files && files.length) {
                file = files[0];
 
                if (/^image\/\w+$/.test(file.type)) {
                     blobURL = URL.createObjectURL(file);
                     $image.one('built.cropper', function () {
                         // Revoke when load complete
                        URL.revokeObjectURL(blobURL);
                     }).cropper('reset').cropper('replace', blobURL);
                     $inputImage.val('');
                 } else {
                     window.alert('Please choose an image file.');
                 }
             }
 
             // Amazi UI 上传文件显示代码
             var fileNames = '';
             $.each(this.files, function() {
                 fileNames += '<span class="am-badge">' + this.name + '</span> ';
             });
             $('#file-list').html(fileNames);
         });
     } else {
         $inputImage.prop('disabled', true).parent().addClass('disabled');
     }
    
    //绑定上传事件
    $('#up-btn-ok').on('click',function(){
    	var $modal = $('#my-modal-loading');
    	var $modal_alert = $('#my-alert');
    	var img_src=$image.attr("src");
    	if(img_src==""){
    		set_alert_info("没有选择上传的图片");
    		$modal_alert.modal();
    		return false;
    	}
    	// if (!/(?:jpg|png|bmp|jpeg|gif|ico)$/.test($(this).val())) {
    	// 	layer.msg('上传的头像只能是图片格式 (jpg/png/bmp/ico)！');
    	// 	return;
    	// }
    	// 
    	// if (this.files[0] && this.files[0].size > 1024 * 1024) {
    	// 	layer.msg('上传的头像大小不能超过1MB，请重新选择！');
    	// 	return;
    	// }
    	// 
    	
    	
    	$modal.modal();
    	
    	// var url=$(this).attr("url");
    	// var canvas=$("#image").cropper('getCroppedCanvas');
    	// var data=canvas.toDataURL(); //转成base64
		uploadFile($(this).attr('id'), function(data) {
			if (!!data) {
				$('#user-avatar').attr('src', data);
				// console.log($('#user-avatar'));
				// console.log($('#user-avatar').attr('src'));
				updateUserAvatar(data);
			}
		});
		function onError(msg) {
			layer.alert(msg || '上传出错');
		}
		function updateUserAvatar(data) {
			useLoadingShade();
			$.post('../myaccount/doChangeUserAvatar', {
				header : data
			}, function(data) {
				if (data.status == 'success') {
					$("#up-img-touch img").attr("src",data.file);
					                	
					var img_name=data.file.split('/')[2];
					console.log(img_name);
					$("#pic").text(img_name);
				}
				else{
					layer.msg('对不起更换头像失败，请稍后再试！');
				}
				
				cancelLoadingShade();
			}, 'json');
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
		
        // $.ajax( {  
        //         url:"../myaccount/doChangeUserAvatar",  
        //         dataType:'json',  
        //         type: "POST",  
        //         data: {"image":data.toString()},  
        //         success: function(data, textStatus){
        //         	$modal.modal('close');
        //         	set_alert_info(data.result);
        //         	$modal_alert.modal();
        //         	if(data.result=="ok"){
        //         		$("#up-img-touch img").attr("src",data.file);
        //         	
        //         		var img_name=data.file.split('/')[2];
        //         		console.log(img_name);
        //         		$("#pic").text(img_name);
        //         	}
        //         },
        //         error: function(){
        //         	$modal.modal('close');
        //         	set_alert_info("上传文件失败了！");
        //         	$modal_alert.modal();
        //         	//console.log('Upload error');  
        //         }  
        //  });  
    	
    });
    
});

function rotateimgright() {
$("#image").cropper('rotate', 90);
}


function rotateimgleft() {
$("#image").cropper('rotate', -90);
}

function set_alert_info(content){
	$("#alert_content").html(content);
}



 
  
 	
 	
 	
 	
 	
     
