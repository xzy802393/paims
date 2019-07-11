<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

    String[] pTypes = {
            "", "", "", "", "", "", "", "", "", "", "", "",
            "qi", "che", "fang"
    };
    request.setAttribute("types", pTypes);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=1220"/>
    <title>九趣贷 — 贷快乐，更带梦想</title>
    <link rel="shortcut icon" href="/yingpu/pc/img/logo.icon.png"/>
    <link rel="stylesheet" type="text/css" href="../account/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="../account/css/sanbiao.css"/>
    <link rel="stylesheet" type="text/css" href="../account/css/style.css"/>

</head>
<body>
<!--顶部-->
<iframe src="/yingpu/pc/head3.html?index=6" height="110px" width="100%" scrolling="no" name="head"
        style="border:0px;"></iframe>
<div id="accountBox" class="clearFix">
    <!-- 左边导航 -->
    <div id="aside">
        <iframe src="../../myaccount/account_sidebar.html" width="100%" height="850px" scrolling="no"
                style="border:0px;"></iframe>
    </div>
    <!-- 右边内容 -->
    <div id="account">
        <div class="trans-records">
            <div class="nav">
                <span type="1"class="active">消费贷</span>
                <span type="0">车融贷</span>
                <span type="2">房融贷</span>
                <span type="3">商企贷</span>
            </div>
            <div class="trans-choice">
                <dl class="trans-choice-date clearfix">
                    <dt>项目期限:</dt>
                    <dd class="active">全部</dd>
                    <dd >1个月</dd>
                    <dd >3个月</dd>
                    <dd >6个月</dd>
                    <dd >9个月</dd>
                    <dd >12个月</dd>

                <%--<div class="trans-choice-date-box">
                        时间:
                        <div class="calendarWarp">
                            <input type="text" class="ECalendar" id="ECalendar_date" value="起止日">
                        </div>
                        <span>至</span>
                        <div class="calendarWarp">
                            <input type="text" class="ECalendar" id="ECalendar_date2" value="截止日">
                        </div>
                        <input type="submit" name="" id="search" value="查询记录"/>
                    </div>--%>
                </dl>

                <dl class="trans-choice-type clearfix">
                    <dt>项目状态:</dt>
                    <dd class="active">投标中</dd>
                    <dd >还款中</dd>
                    <dd >已完结</dd>
                </dl>
            </div>
            <!-- 投标中 -->
            <div id="toubiao" style="display: block;">
                <table border="0" id="trans-list">
                    <tr class="title">
                        <th>项目名称</th>
                        <th>预期年化利率</th>
                        <th>投资日期</th>
                        <th>期限(月)</th>
                        <th>到期时间</th>
                        <th>本金(元)</th>
                        <th>利息(元)</th>
                        <th>优惠券(元)</th>
                        <th>本息合计(元)</th>
                        <th id="hetong">&nbsp;&nbsp;&nbsp;&nbsp;</th>
                    </tr>
                    <tbody id="userprojectinfo"></tbody>
                </table>

            </div>
            <!-- 回款中 -->
            <div id="huikuan" style="display: none;">
                <table border="0">
                    <tr class="title">
                        <th>项目名称</th>
                        <th>预期年化利率</th>
                        <th>投资日期</th>
                        <th>期限(月)</th>
                        <th>下个回款日</th>
                        <th>利息(元)</th>
                        <th>本金(元)</th>
                        <th>本息合计(元)</th>
                        <th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
                    </tr>
                    <tbody id="huikaunprojectinfo"></tbody>
                </table>
            </div>
            <!-- 完结中 -->
            <div id="wanjie" style="display: none;">
                <table border="0">
                    <tr class="title">
                        <th>项目名称</th>
                        <th>预期年化利率</th>
                        <th>投资日期</th>
                        <th>期限(月)</th>
                        <th>到期时间</th>
                        <th>本金(元)</th>
                        <th>利息(元)</th>
                        <th>优惠券(元)</th>
                        <th>本息合计(元)</th>
                    </tr>
                </table>
            </div>
            <!--页码-->
            <div class="page">
                <div class="page-list" id="pageList">
                    <a onclick="go('home')">首页</a>
                    <a onclick="go('prev')">上一页</a>
                    <span id="page-nav-btn"></span>
                    <a onclick="go('next')">下一页</a>
                    <!-- <a onclick="go('tail')">尾页</a> -->
                </div>
            </div>
        </div>
    </div>
</div>
<!--底部导航-->
<iframe src="/yingpu/pc/footer2.html" class="iframe-foot" width="100%" scrolling="no" style="border:0px;height:326px;"></iframe>
<script src="/yingpu/pc/my-invest/js/jquery-1.11.0.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../account/js/utils.js" type="text/javascript" charset="utf-8"></script>
<script src="../account/js/jquery.js" type="text/javascript" charset="utf-8"></script>
<script src="../account/js/calendar2.js" type="text/javascript" charset="utf-8"></script>
<script src="../account/js/sanbiao.js" type="text/javascript" charset="utf-8"></script>
<script src="../account/js/numfenge.js" type="text/javascript" charset="utf-8"></script>
<script src="/yingpu/layer-v3.0.3/layer/layer.js"></script>

<script type="text/javascript">

    $(function() {
        $("#ECalendar_date").ECalendar({
            type: "time",
            stamp: false,
            offset: [0, 2],   //弹框手动偏移量;
            skin: '#ff7f01',
            format: "yyyy/mm/dd",
            callback: function (v, e) {
                $(".callback span").html(v)
            }
        });
        $("#ECalendar_date2").ECalendar({
            type: "time",
            stamp: false,
            offset: [0, 2],   //弹框手动偏移量;
            skin: '#ff7f01',
            format: "yyyy/mm/dd",
            callback: function (v, e) {
                $(".callback span").html(v)
            }
        });
    });
</script>
<script>
   var gParams = {
        type : '',
        status : '',
        deadLine:''
    };
    loadList();
    function loadList() {
        $.post('/yingpu/pc/myaccount/getInvestOrder', {
            pageIndex: pageIndex,
            id: '${pcuser.id}',
            status:gParams.status,
            type:gParams.type,
            deadLine:gParams.deadLine,
            pageSize: 8
        }, function (data) {
            // console.log(data)
            var dat = data;
            pageIndex = dat.page.pageIndex;
            pageCount = data.page.pageCount;
            pageSize = data.page.pageSize;
            data = data.data;
            var html = '';

            if (data==undefined || data.length == 0 ){
                html = '<span style="display: block; text-align: center; width:988px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
                $('#userprojectinfo').empty();
                $('#userprojectinfo').append(html);
                $('.page').css('display','none');
                generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
            }else {
                // var len = data.length;

                $.each(data, function (i, o) {
                    html += '<tr>';
                    html += '<td title="'+ o.name+o.code + '"><a style="color: #7b7b7b;" href="/yingpu/pc/projectdetails?projectid='+o.projectId+'">' + o.name+o.code + '</a></td>';
                    html += '<td>' + (o.rate * 100).toFixed(2) + '%</td>';
                    html += '<td>' + new Date(o.createTime).Format('yyyy-MM-dd') + '</td>';
                    html += '<td>' + o.deadLine + '个月</td>';
                    if (o.Etime == undefined) {
                        html += '<td>暂无</td>';
                    } else {
                        html += '<td>' + new Date(o.Etime).Format('yyyy-MM-dd') + '</td>';
                    }
                    html += '<td>' + commafy(returnFloat(o.money)) + '</td>';
                    html += '<td>' + commafy(returnFloat(o.totolInterest)) + '</td>';
//							html+='<td>'+new Date(o.createTime).Format('yyyy-MM-dd hh:mm:ss')+'</td>';

                    if(o.cardType== null){
                        html += '<td class="yuan5"><span>无</span></td>';
                    }else if (o.cardType == 1) {
                        html += '<td class="yuan5"><span>' + commafy(returnFloat(o.cardPrice)) + '元抵现券</span></td>';
                    } else if (o.cardType == 2) {
                        html += '<td class="yuan5"><span>' + (accMul(o.cardRate, 100)) + '%加息券</span></td>';
                    }else if(o.cardType ==3){
                        html += '<td class="yuan5"><span>' + (accMul(o.dikouRate, 100)) + '%抵扣率</span></td>';
                    }
                    html += '<td>' + commafy(returnFloat(o.sumMoney)) + '</td>';
                    if(o.status != 4){
                        html +='<td onclick="viewContract(${pcuser.id},pid='+o.projectId+',id='+o.id+')"><span style="cursor:pointer; color:coral;">查看合同</span></td>';
                    }
                    html += '</tr>';
                });
                $('#userprojectinfo').empty();
                $('#userprojectinfo').append(html);
                $('.page').css('display','block');
                generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
            }
        });
    }

   function huikuanList(){
       $.post('/yingpu/pc/myaccount/getInvestOrder', {
           pageIndex: pageIndex,
           id: '${pcuser.id}',
           status:gParams.status,
           type:gParams.type,
           deadLine:gParams.deadLine,
           pageSize: 8
       }, function (data) {
           // console.log(data);
           var dat = data;
           pageIndex = dat.page.pageIndex;
           pageCount = data.page.pageCount;
           pageSize = data.page.pageSize;
           data = data.data;
           var html = '';

           // console.log(data)
           if (data == undefined || data.length == 0) {
               html = '<span style="display: block; text-align: center; width:988px;"><img src="/yingpu/pc/img/zanwu.png" alt=""></span>';
               $('#huikaunprojectinfo').empty();
               $('#huikaunprojectinfo').append(html);
               $('.page').css('display','none');
               generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
           }else {
               // var len = data.length;

               $.each(data, function (i, o) {
                   html += '<tr>';
                   html += '<td title="'+ o.name+o.code +'"><a style="color: #7b7b7b;" href="/yingpu/pc/projectdetails?projectid='+o.projectId+'">' + o.name+o.code+ '</a></td>';
                   html += '<td>' + (o.rate * 100).toFixed(2) + '%</td>';
                   html += '<td>' + new Date(o.createTime).Format('yyyy-MM-dd') + '</td>';
                   html += '<td>' + o.deadLine + '个月</td>';
                   if (o.nextInterest== undefined) {
                       html += '<td>暂无</td>';
                   } else {
                       html += '<td>' + new Date(o.nextInterest).Format('yyyy-MM-dd') + '</td>';
                   }
                   // html += '<td>' + o.money+ '</td>';
                   html += '<td>' + commafy(returnFloat(o.totolInterest)) + '</td>';
//							html+='<td>'+new Date(o.createTime).Format('yyyy-MM-dd hh:mm:ss')+'</td>';
//                if (o.cardPrice == null) {
//                    html += '<td class="yuan5"><span>无</span></td>';
//                } else{
//                    html += '<td class="yuan5"><span>' + o.cardPrice + '</span></td>';
//                }
                   html+='<td>'+ commafy(returnFloat(o.money))+'</td>';
                   html += '<td>' + commafy(returnFloat(o.sumMoney)) + '</td>';
                   html +='<td onclick="viewContract(${pcuser.id},pid='+o.projectId+',id='+o.id+')"><span style="cursor:pointer; color:coral;">查看合同</span></td>';
                   html += '</tr>';
               });
               $('#huikaunprojectinfo').empty();
               $('#huikaunprojectinfo').append(html);
               $('.page').css('display','block');
               generatePaginationNav(dat.page.pageIndex, dat.page.pageCount, '#page-nav-btn');
           }
       });
   }
   function viewContract(ud,pd,d){
        param = 'userid='+ud+'&projectid='+pd+'&id='+d;
       layer.open({
           type: 2,
           title: '查看合同',
           shadeClose: true,
           shade: 0.8,
           area: ['50%', '80%'],
           content: '<%=basePath%>app/userproject/gethetong/json?' + param
       });
   }
</script>
</body>

</html>
