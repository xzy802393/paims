package com.cz.yingpu.system.pc;

import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.persistence.Table;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.Finder;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.Announce;
import com.cz.yingpu.system.entity.CompanyState;
import com.cz.yingpu.system.entity.ContractSample;
import com.cz.yingpu.system.entity.LawRule;
import com.cz.yingpu.system.entity.LunboPic;
import com.cz.yingpu.system.entity.News;
import com.cz.yingpu.system.service.IAnnounceService;
import com.cz.yingpu.system.service.IAppUserService;
import com.cz.yingpu.system.service.IBorrowerService;
import com.cz.yingpu.system.service.ILunboPicService;
import com.cz.yingpu.system.service.IProjectService;
import com.cz.yingpu.system.service.ISmsService;
import com.cz.yingpu.system.service.IUserCardService;
import com.cz.yingpu.system.service.IUserProjectService;
import com.cz.yingpu.system.web.AppUserController;
import com.sun.star.lang.IllegalArgumentException;



/**
 * 用户管理Controller,PC和手机浏览器用ACE自适应,APP提供JSON格式的数据接口
 *
 * @copyright {@link 9iu.org}
 * @author 9iu.org<Auto generate>
 * @version 2017-10-09 11:36:47
 * @see
 */
@Controller
@RequestMapping(value = "/pc/infomation")
public class PCAnnounceController extends BaseController {
	
	/** 验证码Session key。*/
	public final static String VALIDATION_CODE_KEY = "VALIDATION_CODE_KEY";

	
	@Resource
	private ILunboPicService lunboPicService;
	
	@Resource
	private IAnnounceService announceService;
	
	@Resource
	private IProjectService projectService;
	
	@Resource
	private IAppUserService appUserService;
	
	@Resource
	private IAnnounceService companyStateService;
	
	@Resource
	private IAnnounceService newsService;
	
	@Resource
	private AppUserController appUserController;
	
	@Resource
	private ISmsService smsService;
	
	
	@Resource
	private IUserCardService userCardService;
	
	@Resource
	private IBorrowerService borrowerService;
	
	@Resource
	private IUserProjectService userProjectService;
	
	@Resource
	private IAnnounceService lawRuleService;
	
	@Resource
	private IAnnounceService contractSampleService;
	//公告列表
			@RequestMapping("list/json")
			@ResponseBody
			public ReturnDatas announceListjson(HttpServletRequest request,Model model ,String type ){
				// ==构造分页请求
				/*HashMap<String, List>  map=new HashMap<String, List>();*/
				ReturnDatas  data=new ReturnDatas();
				List<Announce> adata=new ArrayList<>();
				Page page = newPage(request);
				// ==执行分页查询
				try {
					page.setOrder("`weight`DESC,`postTime`DESC");
					page.setSort("`postTime`DESC");
					//公告
					//adata=announceService.findListDataByFinder(null, page, Announce.class, new Announce());
					
					IAnnounceService service = announceService;
					Class<?> clazz = Announce.class;
					Object o=new Object();
					switch(type) {
						//公告
						case "announce":
							service = announceService;
							o=new Announce();
							break;
						//公司动态
						case "companystate":
							service = companyStateService;
							clazz = CompanyState.class;
							o=new CompanyState();
							break;
							//行业新闻
						case "news":
							service = newsService;
							clazz = News.class;
							o=new News();
							break;
						//合同范本
						case "contractsample":
							service = contractSampleService;
							clazz = ContractSample.class;
							o=new ContractSample();
							break;
						//法律法规
						case "lawrule":
							service = lawRuleService;
							clazz = LawRule.class;
							o=new LawRule();
							break;
					}
					Object aadata=service.findListDataByFinder(null, page, clazz, o);
					data.setPage(page);
					data.setData(aadata);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				return data;
			}
	//公告列表
	@RequestMapping("list")
	public String announceList(HttpServletRequest request,Model model){
		// ==构造分页请求
		HashMap<String, List>  map=new HashMap<String, List>();
		Page page = newPage(request);
		String  type = request.getParameter("type");

		// ==执行分页查询
		try {
			LunboPic l=new LunboPic();
			Page p = new Page(1);
			Page p1 = new Page(1);
			Page p2 = new Page(1);
			Page p3 = new Page(1);
			p.setPageSize(7);
			p1.setPageSize(7);
			p2.setPageSize(7);
			p3.setPageSize(7);
			p.setOrder("`weight`DESC,`postTime`DESC");
			p.setSort("`postTime`DESC");
		 	p1.setOrder("`weight`DESC,`postTime`DESC");
			p1.setSort("`postTime`DESC");
			p2.setOrder("`weight`DESC,`postTime`DESC");
			p2.setSort("`postTime`DESC");
			p3.setOrder("`weight`DESC,`postTime`DESC");
			p3.setSort("`postTime`DESC");
			List<Announce> adata=announceService.findListDataByFinder(null, p1, Announce.class, new Announce());
			request.setAttribute("announces", adata);
			request.setAttribute("companystate", companyStateService.findListDataByFinder(null, p2, CompanyState.class, new CompanyState()));
			request.setAttribute("news", companyStateService.findListDataByFinder(null, p, News.class, new News()));
			request.setAttribute("fa",companyStateService.findListDataByFinder(null,p3,LawRule.class,new LawRule()));

			if(type.equals("announce")){
				return "pc/infomation/pingtai-annoce";
			}else if(type.equals("companystate")){
				return "pc/infomation/announcement";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "pc/infomation/announcement";
	}
	

	//公告详情
		@RequestMapping("detail")
		public String announceDetials(HttpServletRequest request,Model model, Integer id, String type ){
			// ==构造分页请求
			HashMap<String, Object>  map=new HashMap<>();
			Page page = newPage(request);
			// ==执行分页查询
			try {
				
				if (id == null || id < 1 || !StringUtils.isNotBlank(type)) {
					throw new IllegalArgumentException();
				}
				
				LunboPic l=new LunboPic();
				Page p = new Page(1);
				Page p1 = new Page(1);
				p.setPageSize(50);
				p1.setPageSize(1);
				p.setOrder("`weight`DESC,`postTime`DESC");
				p.setSort("`postTime`DESC");
				
				p1.setOrder("`weight`DESC,`postTime`DESC");
				p1.setSort("`postTime`DESC");
				
				IAnnounceService service = announceService;
				Class<?> clazz = Announce.class;
				switch(type) {
					case "announce":
						service = announceService;
						break;
					case "companystate":
						service = companyStateService;
						clazz = CompanyState.class;
						break;
					case "news":
						service = newsService;
						clazz = News.class;
						break;
					case "contractsample":
						service = contractSampleService;
						clazz = ContractSample.class;
						break;
						
					case "lawrule":
						service = lawRuleService;
						clazz = LawRule.class;
						break;
				}
				
				Object adata=service.findById(id, clazz);
				Map<String, Object> prev = new HashMap<>();
				Map<String, Object> next = new HashMap<>();
				if (adata == null) {
					throw new RuntimeException();
				}
				
				Method getWeight = clazz.getMethod("getWeight"),
					   getPostTime = clazz.getMethod("getPostTime");
				Finder finder = new Finder("SELECT * FROM " + clazz.getAnnotation(Table.class).name());
				Finder finder2 = new Finder("SELECT * FROM " + clazz.getAnnotation(Table.class).name());
				
				System.out.println(getPostTime.invoke(adata));
				finder.append(" WHERE IF(weight > :weight, 1 = 1, postTime > :postTime) AND id <> :id")
						.setParam("weight", getWeight.invoke(adata))
						.setParam("postTime", getPostTime.invoke(adata))
						.setParam("id", id);
				
				finder2.append(" WHERE IF(weight < :weight, 1 = 1, postTime < :postTime) AND id <> :id")
						.setParam("weight", getWeight.invoke(adata))
						.setParam("postTime", getPostTime.invoke(adata))
						.setParam("id", id);

				List<?> list = service.findListDataByFinder(finder, p, clazz, clazz.newInstance());
				List<?> list2 = service.findListDataByFinder(finder2, p1, clazz, clazz.newInstance());
				prev.put("announce", list != null && list.size() != 0 ? list.get(list.size() - 1) : null);
				next.put("announce", list2 != null && list2.size() != 0 ? list2.get(0) : null);
				request.setAttribute("announce", adata);
				request.setAttribute("prev", prev);
				request.setAttribute("next", next);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return "pc/infomation/announce-details";
		}
	
		
		@RequestMapping("list2")
		public String announceList2(HttpServletRequest request,Model model ){
			// ==构造分页请求
			HashMap<String, List>  map=new HashMap<String, List>();
			Page page = newPage(request);
			// ==执行分页查询
			try {
				LunboPic l=new LunboPic();
				Page p = new Page(1);
				Page p1 = new Page(1);
				Page p2 = new Page(1);
				p.setPageSize(7);
				p1.setPageSize(7);
				p2.setPageSize(7);

				p.setOrder("`weight`DESC,`postTime`DESC");
				p.setSort("`postTime`DESC");

				p1.setOrder("`weight`DESC,`postTime`DESC");
				p1.setSort("`postTime`DESC");

				p2.setOrder("`weight`DESC,`postTime`DESC");
				p2.setSort("`postTime`DESC");
				
				List<LawRule> adata=announceService.findListDataByFinder(null, p1, LawRule.class, new LawRule());
				request.setAttribute("lawrules", adata);
				request.setAttribute("contractsamples", companyStateService.findListDataByFinder(null, p2, ContractSample.class, new ContractSample()));
				request.setAttribute("news", companyStateService.findListDataByFinder(null, p, News.class, new News()));
			} catch (Exception e) {
				e.printStackTrace();
			}

//			return "pc/infomation/risk_education";

			return "pc/infomation/fagui";
		}

}
