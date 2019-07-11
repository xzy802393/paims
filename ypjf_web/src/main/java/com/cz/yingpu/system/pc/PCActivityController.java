package com.cz.yingpu.system.pc;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.CalculationUtil;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.frame.util.StringUtil;
import com.cz.yingpu.system.entity.Activity;
import com.cz.yingpu.system.entity.Activity201806DragonBoatInfo;
import com.cz.yingpu.system.entity.ActivityUser;
import com.cz.yingpu.system.entity.ActivityUserGroup;
import com.cz.yingpu.system.entity.ActivityUserQualification;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.entity.WorldCupMatch;
import com.cz.yingpu.system.entity.WorldCupScoreInfo;
import com.cz.yingpu.system.entity.WorldCupTeam;
import com.cz.yingpu.system.lib.WorldCup2018DataCreeper;
import com.cz.yingpu.system.service.IBaseSpringrainService;
import com.cz.yingpu.system.service.IDrawService;
import com.google.gson.Gson;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import javax.annotation.Resource;
import javax.management.RuntimeErrorException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
@RequestMapping(value = "/pc/activity")
public class PCActivityController extends BaseController{

	@Resource
	HttpServletRequest request;

	@Resource
	IBaseSpringrainService baseSpringrainService;

	@Resource
	IDrawService drawService;


	public AppUser getSessionUser() {
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		return user;
	}

	Activity getActivity(Integer actId) throws Exception {
		String msg = "";
		Date now = new Date();
		Activity activity = new Activity();

		activity.setId(actId);
		activity = baseSpringrainService.queryForObject(activity);
		if (activity != null) {
			if (now.before(activity.getStarttime())) {
				msg = "活动暂未开始！";
			} else if (now.after(activity.getEndtime())) {
				msg = "活动已经结束！";
			}
			if (StringUtils.isNotBlank(msg)) {
				activity = null;
				System.out.println(msg);
			}
		}

		return activity;
	}



	private Map<String, String> getQualificationMap(List<ActivityUserQualification> qualificationList) {
		Map<String, String> map = new HashMap<>();
		for (ActivityUserQualification qualification : qualificationList) {
			map.put(qualification.getQualificationName(), qualification.getQualificationValue());
		}

		return map;
	}

	private void checkLogin(AppUser user) throws Throwable {
		if (user == null) {
			throw new Error("您尚未登录，请登录后再进行抽奖");
		}
	}

	/**
	 * 计算活动小队用户年化
	 * @param au 用户
	 */
	public void updateGroupInvestAnnualized(AppUser au, int actId, boolean hasActId) {
		int activityId = actId;

		try {
			Activity activity = getActivity(activityId);
			if (activity == null) {
				System.out.println("找不到ID为" + activityId + "的活动");
				return;
			}

			ActivityUser actUser = new ActivityUser();
			Finder actFinder = new Finder("SELECT * FROM t_activity_user WHERE userId = :uId")
					.setParam("uId", au.getId());
			if (hasActId) {
				actFinder.append(" AND activityId = :actId")
						 .setParam("actId", activityId);
			}
			else {
				actFinder.append(" AND activityId IS NULL");
			}
			
			actUser = baseSpringrainService.queryForObject(actFinder, ActivityUser.class);
			if (actUser == null) {
				System.out.println("ID为" + au.getId() + "的用户暂未参加此活动!");
				return;
			}

			Finder finder = new Finder("SELECT * FROM t_user_project WHERE userId = :uid")
					.append(" AND status = 2 AND createTime BETWEEN :start AND :end")
					.setParam("start", activity.getStarttime())
					.setParam("end", activity.getEndtime())
					.setParam("uid", au.getId());

			List<UserProject> userProjectList = baseSpringrainService.queryForList(finder, UserProject.class);
			if (userProjectList.isEmpty()) {
				return;
			}

			double totalInvestMoney = 0, annualizedInvestment = 0;
			int drawTimes = 0;
			for (UserProject _up : userProjectList) {
				Double cardPrize = _up.getCardPrice() == null ? 0 : _up.getCardPrice();
				totalInvestMoney = CalculationUtil.addition(totalInvestMoney, _up.getMoney() + cardPrize);
				annualizedInvestment = CalculationUtil.addition(
						annualizedInvestment, CalculationUtil.multiply(
								CalculationUtil.divide(_up.getMoney() + cardPrize, 12D),
								(double) _up.getDeadLine()));
			}

			actUser.setInvestAmount(totalInvestMoney);
			actUser.setAnnualized(annualizedInvestment);
			baseSpringrainService.updateValidValue(actUser);

			Finder uf = new Finder("UPDATE t_activity_user_group up, t_activity_user au")
					.append(" SET up.totalAnnualized = IFNULL(totalAnnualized, 0) + IFNULL(au.annualized, 0)")
					.append(" WHERE up.id = au.groupId AND up.id = :gId AND au.userId = :uId")
					.setParam("gId", actUser.getGroupId())
					.setParam("uId", actUser.getUserId());

			baseSpringrainService.update(uf);
		}
		catch(Exception e) {
			if (e instanceof RuntimeErrorException) {
				System.err.println(e.getMessage());
				return;
			}
			e.printStackTrace();
		}
	}

	/** 用户加入分组 */
	@RequestMapping("/20180501/activity_group/join/json")
	@ResponseBody
	public ReturnDatas joinActivityGroup_20180501(Integer groupId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser au = getSessionUser();

		try {
			if (au == null) {
				throw new Error("请先登录后再进行此操作！");
			}
			if (groupId == null) {
				throw new Error("操作异常！");
			}

			ActivityUser actUser = new ActivityUser();
			actUser.setUserId(au.getId());
			actUser.setActivityId(null);
			ActivityUser dbActUser = baseSpringrainService.queryForObject(
					new Finder("SELECT * FROM t_activity_user WHERE userId = :uId")
							.append(" AND activityId IS NULL")
							.setParam("uId", au.getId()), ActivityUser.class);
			if (dbActUser != null && dbActUser.getGroupId() != null) {
				throw new Error("您已经加入了小队，不能重复加入！");
			}

			actUser.setAnnualized(0D);
			actUser.setInvestAmount(0D);
			actUser.setJoinTime(new Date());
			actUser.setGroupId(groupId);
			baseSpringrainService.save(actUser);

			baseSpringrainService.update(new Finder("UPDATE t_activity_user_group")
					.append(" SET userNum = IF(userNum IS NULL, 0, userNum) + 1")
					.append(" WHERE id = :gId")
					.setParam("gId", groupId));

			updateGroupInvestAnnualized(au, 23, false);
		}
		catch(Throwable e) {
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}

			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}

		return rt;
	}

	/** 获取小队中的用户数据 */
	@RequestMapping("/20180501/activity_group_user/list/json")
	@ResponseBody
	public ReturnDatas queryActivityGroupUsers_20180501(Integer groupId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();

		try {
			if (groupId == null) {
				throw new Error("操作异常！");
			}

			Finder finder = new Finder("SELECT ag.*, au.*, u.realName, u.phone FROM")
					.append(" t_activity_user_group ag, t_activity_user au, t_app_user u")
					.append(" WHERE au.groupId = ag.id AND ag.id = :gId AND u.id = au.userId")
					.setParam("gId", groupId);
			Page page = newPage(request);
			page.setSort("DESC");
			page.setOrder("au.annualized/ag.totalAnnualized");
			List<Map<String, Object>> actUserList = baseSpringrainService.queryForList(finder, page);
			rt.setData(actUserList);
		}
		catch(Throwable e) {
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}

			e.printStackTrace();
		}

		return rt;
	}

	/** 获取小队中的用户数据 */
	@RequestMapping("/20180501/user_info/list/json")
	@ResponseBody
	public ReturnDatas queryUserInfo() {
		AppUser user = getSessionUser();
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();

		try {
			if (user == null) {
				throw new Error("登录后才可以进行此操作!");
			}

			Finder finder = new Finder("SELECT aug.groupName, au.* ")
					.append(" FROM t_activity_user_group aug, t_activity_user au")
					.append(" WHERE aug.id = au.groupId AND au.userId = :uId AND au.activityId IS NULL")
					.setParam("uId", user.getId());
			rt.setData(baseSpringrainService.queryForObject(finder));
		}
		catch(Throwable e) {
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}

		return rt;
	}

	/** 获取所有小队数据 */
	@RequestMapping("/20180501/activity_group/list/json")
	@ResponseBody
	public ReturnDatas abc(Integer groupId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();

		try {
			ReturnDatas data = queryUserInfo();
			Map<String, Object> actUser = (Map) data.getData();
			if (actUser == null || actUser.get("groupId") == null) {
				throw new Error("此用户暂未加入小队！");
			}

			List<ActivityUserGroup> actUserList = baseSpringrainService.queryForListByEntity(
					new ActivityUserGroup(), null);
			rt.setData(actUserList);
		}
		catch(Throwable e) {
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}

			e.printStackTrace();
		}

		return rt;
	}

	/** 201806赛龙舟 用户加入分组 */
	@RequestMapping("/201806/dragon_boat/activity_group/join/json")
	@ResponseBody
	public ReturnDatas joinActivityGroup_20180601DragonBoat(Integer groupId, Integer actId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser au = getSessionUser();

		try {
			if (au == null) {
				throw new Error("请先登录后再进行此操作！");
			}
			if (groupId == null) {
				throw new Error("操作异常！");
			}
			if (null == getActivity(actId)) {
				throw new Error("活动未开始或已结束！");
			}

			ActivityUser actUser = new ActivityUser();
			actUser.setUserId(au.getId());
			actUser.setActivityId(actId);
			ActivityUser dbActUser = baseSpringrainService.queryForObject(actUser);
			if (dbActUser != null && dbActUser.getGroupId() != null) {
				throw new Error("您已经加入了小队，不能重复加入！");
			}

			actUser.setActivityId(actId);
			actUser.setAnnualized(0D);
			actUser.setInvestAmount(0D);
			actUser.setJoinTime(new Date());
			actUser.setGroupId(groupId);
			baseSpringrainService.save(actUser);

			baseSpringrainService.update(new Finder("UPDATE t_activity_user_group")
					.append(" SET userNum = IF(userNum IS NULL, 0, userNum) + 1")
					.append(" WHERE id = :gId")
					.setParam("gId", groupId));

			updateGroupInvestAnnualized(au, 39, true);
			
			int MOVE_BASE_ANNUALIZED = 800, MOVE_DISTANCE_BASE_NUMBER = 80;
			Activity201806DragonBoatInfo dragonBoatInfo = new Activity201806DragonBoatInfo();
			dragonBoatInfo.setGroupId(actUser.getGroupId());
			Activity201806DragonBoatInfo dbDragonBoatInfo = baseSpringrainService.queryForObject(dragonBoatInfo);
			if (dbDragonBoatInfo == null) {
				baseSpringrainService.save(dragonBoatInfo);
			}

			baseSpringrainService.update(new Finder("UPDATE t_activity_201806_dragon_boat_info augdbi, t_activity_user_group aug")
					.append(" SET augdbi.moveDistance = FLOOR(ROUND(aug.totalAnnualized / "
							+ MOVE_BASE_ANNUALIZED + ", 2) * " + MOVE_DISTANCE_BASE_NUMBER + ")")
					.append(" WHERE aug.id = augdbi.groupId AND augdbi.groupId = :gId")
					.setParam("gId", actUser.getGroupId()));
		}
		catch(Throwable e) {
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}

			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}

		return rt;
	}

	/** 获取用户抽奖信息 */
	@RequestMapping("/201806/worldcup/draw/info/json")
	@ResponseBody
	public ReturnDatas throwBowlDrawInfo_20180501(Integer activityId, HttpServletRequest request) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<ActivityUserQualification> qualificationList = null;
		ActivityUserQualification qualification = new ActivityUserQualification();
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			checkLogin(user);
			qualification.setUserId(user.getId());
			qualification.setActivityId(activityId);
			qualificationList = baseSpringrainService.queryForListByEntity(qualification, null);
			rt.setData(getQualificationMap(qualificationList));
		} catch (Throwable e) {
			rt = ReturnDatas.getErrorReturnDatas();
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
			e.printStackTrace();
		}

		return rt;
	}

	/**  世界杯抽奖 */
	@RequestMapping("/201806/worldcup/draw/json")
	@ResponseBody
	public ReturnDatas throwBowlDraw_20180501(HttpServletRequest request) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		Integer actId = StringUtil.str2Int(request.getParameter("activityId"), 0);
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		List<ActivityUserQualification> qualificationList = null;
		ActivityUserQualification qualification = null;

		try {
			checkLogin(user);
			if (actId != 0) {
				qualification = new ActivityUserQualification();
				qualification.setActivityId(actId);
				qualification.setUserId(user.getId());
				qualificationList = baseSpringrainService.queryForListByEntity(qualification, null);
			}

			Map<String, String> qlfMap = getQualificationMap(qualificationList);
			Double totalDrawTimes = StringUtil.str2Double(qlfMap.get("totalDrawTimes"), 0D),
				usedDrawTimes = StringUtil.str2Double(qlfMap.get("usedDrawTimes"), 0D),
				remainTimes = totalDrawTimes - usedDrawTimes;

			if (remainTimes <= 0) {
				throw new Error("您的剩余抽奖次数不足！");
			}
			if (qlfMap.get("usedDrawTimes") == null) {
				qualification.setQualificationName("usedDrawTimes");
				qualification.setQualificationValue("0");
				baseSpringrainService.save(qualification);
			}

			rt = drawService.draw(user, request);
			if ("error".equals(rt.getStatus())) {
				throw new Error(rt.getMessage());
			}

			drawService.update(new Finder("UPDATE t_activity_user_qualification SET")
					.append(" qualificationValue = IF(qualificationValue IS NULL, 0, qualificationValue + 1)")
					.append(" WHERE userId = :uid AND activityId = :actId")
					.append(" AND qualificationName = :name")
					.setParam("uid", user.getId()).setParam("actId", actId)
					.setParam("name", "usedDrawTimes"));
		} catch (Throwable e) {
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
			rt.setStatus("error");
			e.printStackTrace();
		}

		return rt;
	}

	/** 201806赛龙舟 获取龙舟信息 */
	@RequestMapping("/201806/dragon_boat/info/json")
	@ResponseBody
		public ReturnDatas dragonBoatInfo_201806(Integer activityId, HttpServletRequest request) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		Finder finder = null;

		try {
			checkLogin(user);
			finder = new Finder("SELECT ug.*, dbi.*, au.annualized userAnnualized FROM t_activity_user_group ug")
					.append(" LEFT JOIN t_activity_user au ON au.groupId = ug.id AND au.activityId = ug.activityId")
					.append(" AND au.userId = :uId LEFT JOIN t_activity_201806_dragon_boat_info dbi ON dbi.groupId = ug.id")
					.append(" WHERE ug.activityId = :actId")
					.setParam("actId", activityId)
					.setParam("uId", user.getId());

			rt.setData(baseSpringrainService.queryForList(finder));
		}
		catch (Throwable e) {
			rt = ReturnDatas.getErrorReturnDatas();
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
			e.printStackTrace();
		}

		return rt;
	}

	/** 201806赛龙舟 用户呐喊助威 */
	@RequestMapping("/201806/dragon_boat/cheerfor/json")
	@ResponseBody
	public ReturnDatas cheerForDragonBoat_201806(Integer activityId, Integer userId, Integer groupId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		int FORWARD_DISTANCE_BY_CHEER = 10;
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			checkLogin(user);
			ActivityUser actUser = new ActivityUser();
			actUser.setUserId(user.getId());
			actUser.setGroupId(groupId);

			ActivityUserQualification queryQlf = new ActivityUserQualification();
			queryQlf.setUserId(user.getId());
			queryQlf.setActivityId(activityId);
			queryQlf.setQualificationName("dragonBoatForwardTimes");
			queryQlf = baseSpringrainService.queryForObject(queryQlf);

			int cheerTimes = 0;
			if (queryQlf == null || queryQlf.getQualificationValue() == null
					|| (cheerTimes = Integer.parseInt(queryQlf.getQualificationValue())) <= 0) {
				throw new Error("您没有为小队呐喊助威的机会！");
			}
			if (null == (actUser = baseSpringrainService.queryForObject(actUser))) {
				throw new Error("只能为用户所在的龙舟小队呐喊助威！");
			}

			queryQlf.setQualificationValue(--cheerTimes + "");
			baseSpringrainService.updateValidValue(queryQlf);

			Finder upFinder = new Finder("UPDATE t_activity_201806_dragon_boat_info ")
					.append(" SET moveDistance = IFNULL(moveDistance, 0) + " + FORWARD_DISTANCE_BY_CHEER)
					.append(" WHERE groupId = :groupId")
					.setParam("groupId", groupId);
			baseSpringrainService.update(upFinder);
			rt.setData(FORWARD_DISTANCE_BY_CHEER);
		}
		catch (Throwable e) {
			rt = ReturnDatas.getErrorReturnDatas();
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
			e.printStackTrace();
		}

		return rt;
	}

	/** 获取龙舟小队中的用户数据 */
	@RequestMapping("/201806/dragonboat/userinfo/json")
	@ResponseBody
	public ReturnDatas queryDragonBoatUserInfo(Integer activityId) {
		AppUser user = getSessionUser();
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();

		try {
			if (user == null) {
				throw new Error("登录后才可以进行此操作!");
			}

			Finder finder = new Finder("SELECT aug.groupName, au.* ")
					.append(" FROM t_activity_user_group aug, t_activity_user au")
					.append(" WHERE aug.id = au.groupId AND au.userId = :uId AND aug.activityId = :actId")
					.setParam("uId", user.getId())
					.setParam("actId", activityId);
			rt.setData(baseSpringrainService.queryForObject(finder));
		}
		catch(Throwable e) {
			if (e instanceof Error) {
				rt.setMessage(e.getMessage());
			}
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}

		return rt;
	}

	/**
	 * 世界杯数据抓取
	 */
	@RequestMapping("/worldcup2018/data/fetch/json")
	public void fetchWorldCup2018Match(HttpServletRequest request, Model model, HttpServletResponse resp) {
		WorldCup2018DataCreeper creeper = new WorldCup2018DataCreeper();
		try {
			LogFactory.getFactory().setAttribute("org.apache.commons.logging.Log","org.apache.commons.logging.impl.NoOpLog");
			java.util.logging.Logger.getLogger("com.gargoylesoftware").setLevel(Level.OFF);

			List<WorldCupMatch> matches = new ArrayList<>();
			List<WorldCupScoreInfo> scoreInfos = new ArrayList<>();
			List<Map> dataum = creeper.fetchMatches(
					creeper.fetchPage(WorldCup2018DataCreeper.DATA_SOURCE_URL));
			List<WorldCupMatch> dbMatches = baseSpringrainService.queryForList(
					Finder.getSelectFinder(WorldCupMatch.class), WorldCupMatch.class);

			for (Map<String, List<?>> data : dataum) {
				for (WorldCupMatch match : (List<WorldCupMatch>)data.get("matches")) {
					baseSpringrainService.save(match);
				}
				for (WorldCupScoreInfo info : (List<WorldCupScoreInfo>)data.get("scoreInfos")) {
					baseSpringrainService.save(info);
				}
			}

//			List<Map> teams = new Gson().fromJson(WorldCup2018DataCreeper.TEAM_INFO_JSON, List.class);
//			WorldCupTeam team = null;
//			for (Map<String, Object> map : teams) {
//				team = new WorldCupTeam();
//				team.setName((String)map.get("name"));
//				team.setId(Integer.parseInt((String)map.get("id")));
//				baseSpringrainService.save(team);
//			}
		}
		catch(Throwable e) {
			e.printStackTrace();
		}
	}

	/**
	 * 201806赛龙舟活动小队数据列表
	 */
	@RequestMapping("/201806/dragonboat/user/details/json")
	@ResponseBody
	public ReturnDatas dragonBoat201806UserDetails(Integer groupId) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		try {
			List<Map<String, Object>> userDetails = baseSpringrainService.queryForList(
					new Finder("SELECT up.groupName, u.realName, u.phone, au.annualized, au.investAmount, up.totalAnnualized,")
							.append(" ROUND(au.annualized / up.totalAnnualized, 4) annualizedPercent")
							.append(" FROM t_activity_user_group up, t_activity_user au, t_app_user u")
							.append(" WHERE au.groupId = up.id AND au.userId = u.id AND au.groupId = :gId")
							.append(" ORDER BY ROUND(au.annualized / up.totalAnnualized, 4) DESC")
							.setParam("gId", groupId));

			rt.setData(userDetails);
		}
		catch(Throwable e) {
			rt.setStatus(ReturnDatas.ERROR);
			rt.setMessage(e.getMessage());
			e.printStackTrace();
		}
		return rt;
	}
}
