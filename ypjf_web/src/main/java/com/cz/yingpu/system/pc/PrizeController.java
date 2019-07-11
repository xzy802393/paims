package com.cz.yingpu.system.pc;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.DateUtils;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.frame.util.StringUtil;
import com.cz.yingpu.system.entity.ActivityUserQualification;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.Prize;
import com.cz.yingpu.system.entity.UserPrizeHistory;
import com.cz.yingpu.system.service.IDrawService;
import com.cz.yingpu.system.service.IUserPrizeHistoryService;
import com.cz.yingpu.system.web.ActivityController;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/pc/prize")
public class PrizeController extends BaseController {


	@Resource
	IDrawService drawService;
	@Resource
	IUserPrizeHistoryService userPrizeHistoryService;

	@Resource
	ActivityController activityController;


	//抽奖
	@RequestMapping("/draw/json")
	@ResponseBody
	public ReturnDatas draw(HttpServletRequest request) {
		ReturnDatas data = new ReturnDatas();
		try {
			AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
			if (user == null) {
				data.setMessage("请先登录");
				data.setStatus("login");
				return data;
			}

			data = drawService.draw(user, request);


		} catch (Exception e) {
			data.setStatus("error");
			// TODO: handle exception
			e.printStackTrace();
		}
		return data;
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
	 * 根据用户抽奖次数抽取指定奖品
	 *
	 * @param userId    用户ID
	 * @param drawTimes 用户抽奖次数
	 * @return 抽中的奖品
	 */
	private Prize specialWayDraw_20180501(int userId, int drawTimes) {
		int prizeId = 0;
		switch (drawTimes) {
			case 0:
				prizeId = 65; // 5元京东e卡
				break;

			case 1:
				prizeId = 64; // 谢谢参与
				break;

			case 2:
				prizeId = 63; // 跑步机
				break;
		}
		if (prizeId == 0) {
			return null;
		}

		Prize prize = new Prize();
		prize.setId(prizeId);
		try {
			prize = userPrizeHistoryService.queryForObject(prize);
			if (prize == null) {
				throw new Error("ID:" + prizeId + "的奖品不存在!");
			}

			UserPrizeHistory userPrizeHistory = new UserPrizeHistory();
			userPrizeHistory.setCreateTime(new Date());
			userPrizeHistory.setNumber(DateUtils.getnumber());
			userPrizeHistory.setPrizeid(prizeId);
			userPrizeHistory.setUserid(userId);
			userPrizeHistoryService.save(userPrizeHistory);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return prize;
	}


	//摔碗抽奖
	@RequestMapping("/20180501/throwbowl/json")
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
				qualificationList = drawService.queryForListByEntity(qualification, null);
			}

			Map<String, String> qlfMap = getQualificationMap(qualificationList);
			int totalDrawTimes = StringUtil.str2Int(qlfMap.get("totalDrawTimes"), 0),
					usedDrawTimes = StringUtil.str2Int(qlfMap.get("usedDrawTimes"), 0),
					remainTimes = totalDrawTimes - usedDrawTimes;

			if (remainTimes <= 0) {
				throw new Error("您的剩余抽奖次数不足！");
			}
			if (qlfMap.get("usedDrawTimes") == null) {
				qualification.setQualificationName("usedDrawTimes");
				qualification.setQualificationValue("0");
				drawService.save(qualification);
			}

			Finder specialUserFinder = new Finder("SELECT * FROM t_activity_user_qualification ")
					.append(" WHERE qualificationName = 'specialDrawWayUser'")
					.append(" AND userId = :uid AND qualificationValue = 'true'")
					.append(" AND activityId = :actId")
					.setParam("uid", user.getId()).setParam("actId", actId);

			specialUserFinder.setEscapeSql(false);
			List<Map<String, Object>> specialDrawWayQlfs = drawService.queryForList(specialUserFinder);
			if (!specialDrawWayQlfs.isEmpty() && usedDrawTimes >= 17 && usedDrawTimes < 20) {
				// 使用特殊抽奖方式
				rt.setData(specialWayDraw_20180501(user.getId(), usedDrawTimes - 17));
			} else {
				rt = drawService.draw(user, request);
				if ("error".equals(rt.getStatus())) {
					throw new Error(rt.getMessage());
				}
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


	//获取用户抽奖信息
	@RequestMapping("/20180501/throwbowl/info/json")
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
			qualificationList = drawService.queryForListByEntity(qualification, null);
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


	//红包雨抽奖
	@RequestMapping("/Reddraw/json")
	@ResponseBody
	public ReturnDatas Reddraw(HttpServletRequest request) {
		ReturnDatas data = new ReturnDatas();
		try {
			AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
			if (user == null) {
				data.setMessage("请先登录");
				data.setStatus("login");
				return data;
			}
			data = drawService.reddraw(user, request);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return data;
	}
	//中奖纪录


	/**
	 * 自己中奖记录
	 */
	@RequestMapping("/prizeHis/list/json")
	@ResponseBody
	public ReturnDatas acquirePrizeList(HttpServletRequest request, Model model) {
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("SELECT uph.*, au.realName userName, p.prizename prizeName, act.name actName" +
                " FROM t_user_prize_history uph, t_app_user au, t_prize p, t_activity act WHERE p.activityId = act.id")
				.append(" AND  au.id = uph.userid AND p.id = uph.prizeid and uph.userid=:userid");
		finder.setParam("userid", user.getId());
		Map<String, Object> map = new HashMap<>();
		Page page = newPage(request);
		page.setOrder("uph.createTime");
		page.setSort("DESC");
		try {
			data = userPrizeHistoryService.queryForList(finder, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		rt.setData(data);
		rt.setPage(page);

		rt.setQueryBean(map);
		model.addAttribute(GlobalStatic.returnDatas, rt);

		return rt;
	}

	//中奖纪录


	/**
	 * 自己中奖记录
	 */
	@RequestMapping("/yueprizeHis/list/json")
	@ResponseBody
	public ReturnDatas yuePrizeList(HttpServletRequest request, Model model) {
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("SELECT uph.*, au.realName userName, p.prizename prizeName FROM t_activity1_history uph, t_app_user au, t_activity1_prize p WHERE 1 = 1")
				.append(" AND  au.id = uph.userid AND p.id = uph.drawtype and uph.userid=:userid and uph.drawtype > 0");
		finder.setParam("userid", user.getId());
		Map<String, Object> map = new HashMap<>();
		Page page = newPage(request);
		page.setOrder("uph.createTime");
		page.setSort("DESC");
		try {
			data = userPrizeHistoryService.queryForList(finder, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		rt.setData(data);
		rt.setPage(page);

		rt.setQueryBean(map);
		model.addAttribute(GlobalStatic.returnDatas, rt);
		return rt;
	}


	//随机中奖纪录
	@RequestMapping("/randprizeHis/list/json")
	@ResponseBody
	public ReturnDatas randacquirePrizeList(HttpServletRequest request, Model model) {
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("SELECT uph.*, au.realName userName, p.prizename prizename,au.phone phone")
				.append(" FROM t_user_prize_history uph, t_app_user au, t_prize p WHERE 1 = 1")
				.append(" AND au.id = uph.userid AND p.id = uph.prizeid");

		String actId = request.getParameter("activityId");
		if (StringUtils.isNotBlank(actId)) {
			finder.append(" AND p.activityId = :actId")
					.setParam("actId", actId);
		} else {
			finder.append("  and p.type=:type");
			if (request.getParameter("type") != null && !request.getParameter("type").equals("")) {
				finder.setParam("type", request.getParameter("type"));
			} else {
				finder.setParam("type", "1yue");
			}
		}

		Map<String, Object> map = new HashMap<>();
		Page page = newPage(request);
		page.setOrder("uph.createTime");
		page.setSort("DESC");
		try {
			page.setPageSize(10);
			page.setPageIndex(1);
			data = userPrizeHistoryService.queryForList(finder, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		rt.setData(data);
		rt.setPage(page);

		rt.setQueryBean(map);
		model.addAttribute(GlobalStatic.returnDatas, rt);
		return rt;
	}


	//奖品列表
	@RequestMapping("/list/json")
	@ResponseBody
	public ReturnDatas PrizeList(HttpServletRequest request, Model model) {
		List<Map<String, Object>> data = null;
		Finder finder = new Finder("  SELECT `prizename`,`prizeimg`,`prizeicon`,`prizeurl`," +
				"`prizedesc`,price,activityId FROM   `t_prize` where ");
		String activityId = request.getParameter("activityId");

		if (StringUtils.isBlank(activityId)) {
			finder.append(" type=:type");
			if (request.getParameter("type") != null && !request.getParameter("type").equals("")) {
				finder.setParam("type", request.getParameter("type"));
			} else {
				finder.setParam("type", "1yue");
			}
		} else {
			finder.append(" activityId = :activityId")
					.setParam("activityId", activityId);
		}
		Map<String, Object> map = new HashMap<>();
		Page page = newPage(request);
		try {
			data = userPrizeHistoryService.queryForList(finder, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		rt.setData(data);
		rt.setPage(page);
		rt.setQueryBean(map);
		model.addAttribute(GlobalStatic.returnDatas, rt);
		return rt;
	}


	//奖品列表
	@RequestMapping("/time/check/json")
	@ResponseBody
	public ReturnDatas timeCheck(long time, HttpServletRequest request) {
		long maxDuration = 600 * 1000;
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		long now = new Date().getTime();
		if (now - time > maxDuration || now - time < -maxDuration) {
			rt.setStatus("error");
		}

		System.out.println(now - time);
		rt.setData(new Date().getTime());
		return rt;
	}


	//设置红包雨开始时间
	@RequestMapping("/redpack-rain/time/get/json")
	@ResponseBody
	public ReturnDatas getTimeOfRedpackRain(HttpServletRequest request) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		Calendar dateStart = Calendar.getInstance();
		Calendar dateEnd = Calendar.getInstance();
		Calendar dateNow = Calendar.getInstance();
		Map<String, Object> data = new HashMap<>();

		dateStart.set(dateNow.get(Calendar.YEAR), dateNow.get(Calendar.MONTH), 11, 00, 00, 00);
		dateEnd.set(dateNow.get(Calendar.YEAR), dateNow.get(Calendar.MONTH), 15, 23, 59, 59);
		if (dateNow.compareTo(dateStart) < 0 || dateNow.compareTo(dateEnd) > 0) {
			rt = ReturnDatas.getErrorReturnDatas();
		} else {
			dateNow.set(Calendar.MINUTE, 30);
			dateNow.set(Calendar.SECOND, 0);
			if (dateNow.get(Calendar.HOUR_OF_DAY) < 11) {
				dateNow.set(Calendar.HOUR_OF_DAY, 10);
			} else if (dateNow.get(Calendar.HOUR_OF_DAY) < 20) {
				dateNow.set(Calendar.HOUR_OF_DAY, 14);
			} else {
				rt = ReturnDatas.getErrorReturnDatas();
			}

			data.put("timestamp", dateNow.getTimeInMillis());
			data.put("duration", 60 * 1000);
			rt.setData(data);
		}

		System.out.println(dateNow.get(Calendar.HOUR_OF_DAY));

		return rt;
	}

	//获取用户抽奖信息
	@RequestMapping("/draw/info/json")
	@ResponseBody
	public ReturnDatas drawInfo(Integer activityId, HttpServletRequest request) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		List<ActivityUserQualification> qualificationList = null;
		ActivityUserQualification qualification = new ActivityUserQualification();
		AppUser user = (AppUser) request.getSession().getAttribute(GlobalStatic.PCUSER);

		try {
			checkLogin(user);
			qualification.setUserId(user.getId());
			qualification.setActivityId(activityId);
			qualificationList = drawService.queryForListByEntity(qualification, null);
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

    /**
     * 根据用户抽奖次数抽取指定奖品
     *
     * @param userId    用户ID
     * @param drawTimes 用户抽奖次数
     * @return 抽中的奖品
     */
    private Prize specialWayDraw_201812xx(int userId, int drawTimes) {
        int prizeId = 0;
        switch (drawTimes) {
            case 0:
                prizeId = 65; // 5元京东e卡
                break;
        }

        if (prizeId == 0) {
            return null;
        }

        Prize prize = new Prize();
        prize.setId(prizeId);
        try {
            prize = userPrizeHistoryService.queryForObject(prize);
            if (prize == null) {
                throw new Error("ID:" + prizeId + "的奖品不存在!");
            }

            UserPrizeHistory userPrizeHistory = new UserPrizeHistory();
            userPrizeHistory.setCreateTime(new Date());
            userPrizeHistory.setNumber(DateUtils.getnumber());
            userPrizeHistory.setPrizeid(prizeId);
            userPrizeHistory.setUserid(userId);
            userPrizeHistoryService.save(userPrizeHistory);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return prize;
    }

    //摔碗抽奖
    @RequestMapping("/201812xx/draw/json")
    @ResponseBody
    public ReturnDatas draw201812xx(HttpServletRequest request) {
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
                qualificationList = drawService.queryForListByEntity(qualification, null);
            }

            Map<String, String> qlfMap = getQualificationMap(qualificationList);
            int totalDrawTimes = StringUtil.str2Int(qlfMap.get("totalDrawTimes"), 0),
                    usedDrawTimes = StringUtil.str2Int(qlfMap.get("usedDrawTimes"), 0),
                    remainTimes = totalDrawTimes - usedDrawTimes;

            if (remainTimes <= 0) {
                throw new Error("您的剩余抽奖次数不足！");
            }
            if (qlfMap.get("usedDrawTimes") == null) {
                qualification.setQualificationName("usedDrawTimes");
                qualification.setQualificationValue("0");
                drawService.save(qualification);
            }

            Finder specialUserFinder = new Finder("SELECT * FROM t_activity_user_qualification ")
                    .append(" WHERE qualificationName = 'specialDrawWayUser'")
                    .append(" AND userId = :uid AND qualificationValue = 'true'")
                    .append(" AND activityId = :actId")
                    .setParam("uid", user.getId()).setParam("actId", actId);

            specialUserFinder.setEscapeSql(false);
            List<Map<String, Object>> specialDrawWayQlfs = drawService.queryForList(specialUserFinder);
            if (!specialDrawWayQlfs.isEmpty() && usedDrawTimes == 0) {
                // 使用特殊抽奖方式
                rt.setData(specialWayDraw_201812xx(user.getId(), usedDrawTimes));
            } else {
                rt = drawService.draw(user, request);
                if ("error".equals(rt.getStatus())) {
                    throw new Error(rt.getMessage());
                }
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

    //通用的活动抽奖
    @RequestMapping("/generic/draw/json")
    @ResponseBody
    public ReturnDatas genericDraw(HttpServletRequest request) {
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
                qualificationList = drawService.queryForListByEntity(qualification, null);
            }

            Map<String, String> qlfMap = getQualificationMap(qualificationList);
            int totalDrawTimes = StringUtil.str2Int(qlfMap.get("totalDrawTimes"), 0),
                    usedDrawTimes = StringUtil.str2Int(qlfMap.get("usedDrawTimes"), 0),
                    remainTimes = totalDrawTimes - usedDrawTimes;

            if (remainTimes <= 0) {
                throw new Error("您的剩余抽奖次数不足！");
            }
            if (qlfMap.get("usedDrawTimes") == null) {
                qualification.setQualificationName("usedDrawTimes");
                qualification.setQualificationValue("0");
                drawService.save(qualification);
            }

            Finder specialUserFinder = new Finder("SELECT * FROM t_activity_user_qualification ")
                    .append(" WHERE qualificationName = 'specialDrawWayUser'")
                    .append(" AND userId = :uid AND qualificationValue = 'true'")
                    .append(" AND activityId = :actId")
                    .setParam("uid", user.getId()).setParam("actId", actId);

            specialUserFinder.setEscapeSql(false);
            List<Map<String, Object>> specialDrawWayQlfs = drawService.queryForList(specialUserFinder);
            if (!specialDrawWayQlfs.isEmpty() && usedDrawTimes == 0) {
                // 使用特殊抽奖方式
                //rt.setData(specialWayDraw_201812xx(user.getId(), usedDrawTimes));
            } else {
                rt = drawService.draw(user, request);
                if ("error".equals(rt.getStatus())) {
                    throw new Error(rt.getMessage());
                }
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

}
