$(function(){
	var headerTop = '<div class="header-top">'+'<div class="center"><div class="contact left"><p>服务热线：400-9690-900</p><a href="#" class="tel"><img src="../img/images/head-tel_03.png"/></a><a href="#" class="weixin"><img src="../img/images/head-weixin_03.png"/></a><a href="#" class="weibo"><img src="../img/images/head-weibo_03.png"/></a></div><div class="nav right"><ul class="nav-item clearfix"><li style="display: none;" id="user"><span  id="username">尊敬的:15900000619</span> <a href="javascript:signout();">【安全退出】</a></li><li style="display: none;" id="xiaoxi"> <span class="head-msg"></span>未读消息1</li><li id="denglu" ><a href="../login.jsp" class="bold">登录</a></li><li  id="zhuce"><a href="../rejister.jsp" class="bold">注册</a></li><li class="app"><a href="" class="org"><img src="..img/head-phone.png"/> 手机APP</a></li><li><a href="#" class="org"><img src="../img/head-vip.png"/> 个人中心 <img class="pull" src="../img/head-pull.png" /></a></li><li><a href="#">帮助中心</a></li><li><a href="#">活动中心</a></li></ul></div></div>'+'</div>'
			
	$("#header").append(headerTop);
			
	var	headerNav = '<div class="header-nav">'+'<div class="center clearfix">
          <div class="logo left">
            <img src="img/logo.png"/>         
          </div>
          <div class="logo-text left">
            <p class="red">新金融倡导者</p>
            <p class="black">营创智慧金融，普享财富人生</p>
          </div>
          
          <div class="nav right">
            <ul class="nav-list clearfix">
              <li><a href=" javascript:tiaozhuan('./index');" >首页</a></li>
              <li><a href="javascript:tiaozhuan('../pc/project/invest');">我要投资</a></li>
              <li><a href=" javascript:tiaozhuan('./borrow');">我要借款</a></li>
              <li><a href="#">安全保障</a></li>
              <li class="nav-pull">
              	<a href="#" class="msg-pilou">信息披露</a>
              	<ul class="">
              		<li><a href="">平台简介</a></li>
              		<li><a href="">运营数据</a></li>
              		<li><a href="">公告动态</a></li>
              		<li><a href="">活动中心</a></li>
              		<li><a href="">产品中心</a></li>
              		<li><a href="">风险教育</a></li>
              		<li><a href="">联系我们</a></li>
              	</ul>
              </li>
              <li><a href="#" class="account"><img src="img/account.png"/> 我的账户</a></li>
            </ul>		
          </div>
        </div>
      </div>'
        
		
	$("#header").append(headerNav);	
})