//添加侧导航


$(function(){
	var html = '';
	    html+='<div class="zt_click">';
	    html+='<div class="click_tp"></div>';
	    html+='<div class="click_ptjj">';
	    html+=' <div class="ptjj_a"></div>';
	    html+='<div class="ptjj_b cute">';
	    html+='<a class="cuteo" href="platform_intro.html">平台简介</a></div>';
	    html+='</div>';
// 	    html+='<div class="click_ggjs">';
// 	    html+='<div class="ptjj_a"></div>';
// 	    html+='<div class="ptjj_b ">';
// 	    html+='<a class="" href="team_intro.html">高管介绍</a></div>';
// 	    html+='</div>';
// 	    html+='<div class="click_ggjs">';
// 	    html+='<div class="ptjj_a"></div>';
// 	    html+='<div class="ptjj_b ">';
// 	    html+='<a class="" href="yingpu_events.html">发展历程</a></div>';
// 	    html+='</div>';
// 	    html+='<div class="click_ggjs">';
// 	    html+='<div class="ptjj_a"></div>';
// 	    html+='<div class="ptjj_b ">';
// 	    html+='<a class="" href="com_process.html">合规进程</a></div>';
// 	    html+='</div>';
	    html+='<div class="click_ggjs">';
	    html+='<div class="ptjj_a"></div>';
	    html+='<div class="ptjj_b ">';
	    html+='<a class="" href="cooperation.html">合作机构</a></div>';
	    html+='</div>';
	    html+='<div class="click_ggjs">';
	    html+='<div class="ptjj_a"></div>';
	    html+='<div class="ptjj_b ">';
	    html+='<a class="" href="contacts_us.html">联系我们</a></div>';
	    html+='</div></div>';
	    
		$("#navBar").html(html);
	
	var urlstr = location.href;   //通过js中的location.href得到当前页面的地址
  //alert((urlstr + '/').indexOf($(this).attr('href')));
	  var urlstatus=false;
	  $("#navBar a").each(function () {
	    if ((urlstr + '/').indexOf($(this).attr('href')) > -1&&$(this).attr('href')!='') {
	      $(this).addClass('cuteo'); 
	      $(this).parent().addClass('cute');
	      urlstatus = true;
	    } else {
	      $(this).removeClass('cuteo');
	       $(this).parent().removeClass('cute');   //为此句有或没有都可以正常显示
	    }
	  });
	  if (!urlstatus) {$("#navBar a").eq(0).addClass('cuteo'); }

	
	
	
});