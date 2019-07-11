package com.cz.yingpu.system.pc;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.Activity1History;
import com.cz.yingpu.system.entity.Activity1Prize;
import com.cz.yingpu.system.entity.Activity1User;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.service.IActivity1HistoryService;
import com.cz.yingpu.system.service.IActivity1PrizeService;
import com.cz.yingpu.system.service.IActivity1UserService;

@Controller
@RequestMapping(value = "/pc/activity1")
public class _Activity1Controller extends BaseController{
	
	@Resource
	IActivity1UserService activity1UserService;
	@Resource
	IActivity1PrizeService activity1PrizeService;
	@Resource
	IActivity1HistoryService activity1HistoryService;
	//到达站点加速
	@RequestMapping("accelerate/json")
	@ResponseBody
	public ReturnDatas accelerate(Integer siteId,HttpServletRequest request){
		try {
			AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
			if(user==null){
				return new ReturnDatas(ReturnDatas.SUCCESS, "用户未登录",new ArrayList<>());
			}
			return activity1PrizeService.accelerate(user.getId(),siteId);
		//	return activity1PrizeService.accelerate(12871,1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;	
	}
	
	//到达站点抽奖
	@RequestMapping("draw/json")
	@ResponseBody
	public ReturnDatas draw(Integer siteId,HttpServletRequest request){
		try {
			AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
			if(user==null){
				return new ReturnDatas(ReturnDatas.SUCCESS, "用户未登录",new ArrayList<>());
			}
			return activity1PrizeService.draw(user.getId(),siteId);
			//return activity1PrizeService.draw(12871,1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;	
	}
	@RequestMapping("test")
	@ResponseBody
	public String test(){
		Activity1User activity1User=new Activity1User();
		activity1User.setUserId(12871);
		activity1User.setTolmoney(200000.00);
		activity1User.setMileage(1000.00);
		try {
			return activity1UserService.save(activity1User,1).toString();
		} catch (Exception e) {

			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "no";	
	}
	//送小英最快的10个人
	@RequestMapping("activityUserTop10/json")
	@ResponseBody
	public ReturnDatas activityUserTop10(HttpServletRequest request){
		ReturnDatas data=new ReturnDatas(ReturnDatas.SUCCESS, "成功");
		Page page=newPage(request);
		page.setOrder("tau.mileage");
		page.setSort("desc");
		Finder finder=new Finder("select tau.*,au.phone,au.header from t_activity1_user  tau  inner join  t_app_user au on tau.userId = au.id ");
		try {
			List<Map<String, Object>> aulist=activity1UserService.queryForList(finder,page);
		data.setData(aulist);
		data.setPage(page);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
	//轮播加速信息（最近10条）
	@RequestMapping("lunboTop10/json")
	@ResponseBody
	public ReturnDatas lunboTop10(){
		ReturnDatas data=new ReturnDatas(ReturnDatas.SUCCESS, "成功");
		Finder finder=new Finder("select tau.*,au.phone,ts.name  sitename from t_activity1_history  tau inner join t_app_user au on tau.userId = au.id inner join t_activity1_site as ts on tau.siteId=ts.id  where drawtype >-1 order by tau.id desc limit 0,10");
		try {
			List<Map<String, Object>> aulist=	 activity1HistoryService.queryForList(finder);
			data.setData(aulist);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
	
	//初始化城市信息
		@RequestMapping("initcityinfo/json")
		@ResponseBody
		public ReturnDatas initcityinfo(HttpServletRequest request){
			ReturnDatas data=new ReturnDatas(ReturnDatas.SUCCESS, "成功");
			Finder finder=new Finder("select * from t_activity1_site where  route=1");
			try {
				AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
				List<Map<String, Object>> aulist= activity1HistoryService.queryForList(finder);
				//当前排名
				if(user!=null){
					finder=new Finder("select  count(1) as num from t_activity1_user where userId=:userId");
					finder.setParam("userId", user.getId());
					if(activity1HistoryService.queryForList(finder).get(0).get("num").toString().equals("0")){
						data.setMessage("无");
					}else{
						finder=new Finder("SELECT COUNT(1) as num FROM `t_activity1_user` WHERE mileage > (SELECT mileage FROM `t_activity1_user` WHERE userId=:userId)");
						finder.setParam("userId", user.getId());
						Integer num=  Integer.parseInt(activity1HistoryService.queryForObject(finder).get("num").toString());
						data.setMessage(num+1+"");
					}
				}
				data.setData(aulist);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return data;
		}
	//获取自己的行进信息
	@RequestMapping("getMyActivity1UserInfo/json")
	@ResponseBody
	public ReturnDatas getMyActivity1UserInfo(HttpServletRequest request){
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		
		if(user==null){
			return new ReturnDatas(ReturnDatas.SUCCESS, "用户未登录",new ArrayList<>());
		}
		ReturnDatas data=new ReturnDatas(ReturnDatas.SUCCESS, "成功");
		Finder finder=new Finder("select tau.*,au.phone from t_activity1_user  tau inner join t_app_user au on tau.userId = au.id where tau.userId=:userId");
		finder.setParam("userId", user.getId());
		try {
		List<Map<String, Object>> aulist=	activity1HistoryService.queryForList(finder);
		data.setData(aulist);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
	
	//领取终极大奖
	@RequestMapping("bigPrize/json")
	@ResponseBody
	public ReturnDatas bigPrize(HttpServletRequest request){
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		if(user==null){
			return new ReturnDatas(ReturnDatas.SUCCESS, "用户未登录",new ArrayList<>());
		}
		ReturnDatas data=new ReturnDatas(ReturnDatas.SUCCESS, "领取成功");
		Finder finder=new Finder("select * from t_activity1_user where userId=:userId");
		finder.setParam("userId", user.getId());
		try {
		List<Activity1User> aulist=	activity1HistoryService.queryForList(finder,Activity1User.class);
		if(aulist.size()>0){
			if(aulist.get(0).getMileage()>=aulist.get(0).getTolmileage()){
				finder=new Finder("select count(1) num from t_activity1_history where userId=:userId and drawtype =888888");
				finder.setParam("userId", user.getId());
				Map<String, Object> omap=  activity1HistoryService.queryForObject(finder);
				if(omap!=null){
					if(Double.parseDouble(omap.get("num").toString())<=0){
						Activity1History activity1History=new Activity1History();
						activity1History.setMileage(0.00);
						activity1History.setMoney(0.00);
						activity1History.setUserId(user.getId());
						activity1History.setType(1);
						activity1History.setCreateTime(new Date());
						activity1History.setSiteId(888888);
						activity1History.setDrawtype(888888);
						activity1History.setAcceleratetype(-1);
						activity1HistoryService.save(activity1History);
					}
				}else{
					data.setStatus(ReturnDatas.SUCCESS);
					data.setMessage("不能重复领取终极大奖");
				}
			}
		}else{
			data.setStatus(ReturnDatas.SUCCESS);
			data.setMessage("您尚未到达终点,不能领取终极大奖");
		}
		//data.setData(aulist);
		} catch (Exception e) {
			data.setStatus(ReturnDatas.SUCCESS);
			data.setMessage(e.getMessage());
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
	
	//加载站点奖品信息
	@RequestMapping("getMyActivity1PrizeInfo/json")
	@ResponseBody
	public ReturnDatas getMyActivity1PrizeInfo(Activity1Prize activity1Prize,HttpServletRequest request){
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		if(user==null){
			return new ReturnDatas(ReturnDatas.SUCCESS, "用户未登录",new ArrayList<>());
		}
		Object[] a =new Object[2];
		ReturnDatas data=new ReturnDatas(ReturnDatas.SUCCESS, "成功");
		Finder finder=new Finder("select * from t_activity1_prize   where (siteId=:siteId or  siteId=-1) and type=1");
		finder.setParam("siteId", activity1Prize.getSiteId());
		try {
			List<Activity1Prize> aulist=	 activity1PrizeService.queryForList(finder,Activity1Prize.class);
			finder=new Finder("select * from t_activity1_history   where (siteId=:siteId or  siteId=-1 ) and (drawtype > 0  or acceleratetype>0) and userId =:userId");
			System.out.println(activity1Prize.getSiteId()+">>>>>>>>>>>>>>>>>>>>>");
			finder.setParam("siteId", activity1Prize.getSiteId());
			finder.setParam("userId", user.getId());
			List<Activity1History> alist=	  activity1HistoryService.queryForList(finder,Activity1History.class );
			
			for (int i = 0; i < aulist.size(); i++) {
				 if(  alist.get(0).getDrawtype()==aulist.get(i).getId()){
					 aulist.get(i).setProbability("已中奖");
				 }else{
					 aulist.get(i).setProbability("未中奖");	
				 }
			}
			a[0] = aulist;
			finder=new Finder("select * from t_activity1_prize   where (siteId=:siteId or  siteId=-1) and type=2");
			finder.setParam("siteId", activity1Prize.getSiteId());
			finder.setParam("userId", user.getId());
			aulist=	  activity1PrizeService.queryForList(finder,Activity1Prize.class );
			for (int i = 0; i < aulist.size(); i++) {
				 if(  alist.get(0).getAcceleratetype()==aulist.get(i).getId()){
					 aulist.get(i).setProbability("已中奖");
				 }else{
					 aulist.get(i).setProbability("未中奖");
				 }
			}
			a[1] =  aulist;
			data.setData(a);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
	
	//加载自己抽奖记录
	@RequestMapping("getMyActivity1HistoryInfo/json")
	@ResponseBody
	public ReturnDatas getMyActivity1HistoryInfo(HttpServletRequest request){
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		if(user==null){
			return new ReturnDatas(ReturnDatas.SUCCESS, "用户未登录",new ArrayList<>());
		}
		ReturnDatas data=new ReturnDatas(ReturnDatas.SUCCESS, "成功");
		Finder finder=new Finder("select tau.*,tap1.prizeimg as img1,tap2.prizeimg as img2 from t_activity1_history  tau left join t_activity1_prize tap1 on tau.drawtype =tap1.id   left join t_activity1_prize tap2 on tau.acceleratetype =tap2.id  where tau.userId=:userId and (drawtype > -1) order by tau.siteId desc");
		finder.setParam("userId", user.getId());
		try {
		List<Map<String, Object>> aulist=	 activity1HistoryService.queryForList(finder);
		data.setData(aulist);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
}
