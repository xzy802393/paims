<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <title></title>
    <style type="text/css">
        /* css reset */
        body, section, h1, h2, h3, h4, h5, h6, p, ul, ol, li, dl, dd, th, td {
            margin: 0;
            padding: 0;
            font-family: "微软雅黑";
            color: #000;
        }

        body {
            position: relative;
        }

        a {
            text-decoration: none;
        }

        img {
            border: none;
            vertical-align: middle;
        }

        ul {
            list-style: none;
        }

        .clearFix:after {
            content: "";
            display: block;
            clear: both;
        }

        .clearFix {
            zoom: 1;
        }

        html { overflow-y: scroll; }
        html,body{
           /* width:1000px; */
            margin:0 auto;
            text-align: center;
        }
        #yijianfankui{
           /* width:930px; */
            height:768px;
            /* position: relative;
            z-index:100000; */
            /* margin-top:300px; */
        }
        .content{
            /* width:930px; */
            height:768px;
            background: #fff;
            margin:0 auto;


        }
        .title{
            font:24px/76px "微软雅黑";
            color:#848484;
            padding-left:68px;
            text-align: left;
            border-bottom: 1px solid #c2c2c2;
        }

        textarea{
            width:790px;
            height:353px;
            margin-top:47px;
            border:1px solid #c2c2c2;
            resize: none;
            text-align: left;
            font:19px/34px "微软雅黑";
            color:#848484;
            padding:10px;
            letter-spacing: 1px;
            outline:none;
            margin-bottom:16px;
        }
        input[type="text"]{
            width:790px;
            height:55px;
            border:1px solid #c2c2c2;
            padding:10px;
            font:18px/74px "微软雅黑";
            color:#848484;
            margin-bottom:86px;
            outline:none;
        }
        .btn{
            padding-left:580px;
            width:290px;
            height:52px;
        }
        .btn span{
            display: inline-block;
            width:124px;
            height:50px;
            border:1px solid #c2c2c2;
            font:18px/50px "微软雅黑";
            color:#848484;
            cursor: pointer;
        }
        .btn span:nth-of-type(1){
            border:none;
            width:126px;
            height:52px;
            background: url(img/yjfkbtnbg.png) repeat-y 0 0;
            color:#fff;
            margin-right:32px;
        }
    </style>
</head>
<body>
<div id="yijianfankui">
    <div class="content">
        <p class="title">意见反馈</p>
        <textarea placeholder="我们有什么能帮到您？" id="feedback"></textarea>
        <input type="text" placeholder="您的邮箱或手机号">
        <div class="btn">
            <span class="tijiao" onclick="judge()">确定</span>
            <span id="exit">取消</span>
        </div>
    </div>
</div>
<script src="js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../layer-v3.0.3/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

    function judge() {
        if (!isLogin()) {
            window.top.location.href = "/yingpu/pc/login";
        } else {
            loadUserDrawInfo();
        }
    }

    function isLogin() {
        return !!'${pcuser.phone}';
    }

    function loadUserDrawInfo() {
        if ($('#feedback').val() == "") {
            layer.alert('反馈内容不能为空！');
        } else {
            $.post('../system/feedback/update/json', {
                content: $('#feedback').val(),
                userId: "${pcuser.id}"
            }, function (data) {
                if (data.status == "success") {
                    layer.alert('感谢您的反馈！');
                    window.top.location.href = "/yingpu/pc/index";
                }else{
                    layer.alert('反馈失败！')
                }

            });
        }
    }
</script>
</body>
</html>
