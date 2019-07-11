package com.cz.yingpu.system.pc;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cz.yingpu.frame.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.frame.annotation.SecurityApi;
import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.system.entity.Announce;
import com.cz.yingpu.system.entity.AppUser;
import com.cz.yingpu.system.entity.Borrower;
import com.cz.yingpu.system.entity.Loan;
import com.cz.yingpu.system.entity.CompanyState;
import com.cz.yingpu.system.entity.LunboPic;
import com.cz.yingpu.system.entity.News;
import com.cz.yingpu.system.entity.Project;
import com.cz.yingpu.system.entity.Token;
import com.cz.yingpu.system.entity.UserCard;
import com.cz.yingpu.system.entity.UserProject;
import com.cz.yingpu.system.exception.CardNotUseException;
import com.cz.yingpu.system.exception.MoneyException;
import com.cz.yingpu.system.exception.NotCertificationException;
import com.cz.yingpu.system.exception.ParameterErrorException;
import com.cz.yingpu.system.exception.PhoneNotExistException;
import com.cz.yingpu.system.exception.ProjectAmountNotEnoughException;
import com.cz.yingpu.system.exception.UserPorjectExistException;
import com.cz.yingpu.system.service.IAnnounceService;
import com.cz.yingpu.system.service.IAppUserService;
import com.cz.yingpu.system.service.IBorrowerService;
import com.cz.yingpu.system.service.ILunboPicService;
import com.cz.yingpu.system.service.IProjectService;
import com.cz.yingpu.system.service.IUserCardService;
import com.cz.yingpu.system.service.IUserProjectService;


/**
 * 用户管理Controller,PC和手机浏览器用ACE自适应,APP提供JSON格式的数据接口
 *
 * @copyright {@link 9iu.org}
 * @author 9iu.org<Auto generate>
 * @version 2017-10-09 11:36:47
 * @see
 */
@Controller
@RequestMapping(value = "/pc/userproject")
public class UserProjectPcController extends BaseController {
	@Resource
	private IUserProjectService userProjectService;
	@Resource
	private IAppUserService appUserService;
	/**
	 * json数据,为APP提供数据
	 * 
	 * @param request
	 * @param model
	 * @param userProject
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list/json")
	public @ResponseBody
	ReturnDatas listjson(HttpServletRequest request, Model model,UserProject userProject) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		// ==构造分页请求
		String  pageSize=request.getParameter("pageSize");
		// ==构造分页请求
		Page page = newPage(request);
		if(null != pageSize && !"".equals(pageSize)){
			page.setPageSize(Integer.parseInt(pageSize));
		}
		// ==执行分页查询
		Finder finder = new Finder("select t.*,au.phone as phone,au.userCode from t_user_project as t inner join t_app_user au on t.userId=au.id where  t.projectId=:projectId"
				);
		finder.setParam("projectId", userProject.getProjectId());
//		if(null != userProject.getProjectStatus()){
//			if(1==userProject.getProjectStatus()){
//				finder = new Finder("select * from t_user_project where projectStatus in (2,3)");
//				userProject.setProjectStatus(null);
//			}else if(2==userProject.getProjectStatus()){
//				userProject.setProjectStatus(4);
//			}else{
//				userProject.setProjectStatus(null);
//			}
//		}
		page.setOrder("t.id");
		page.setSort("desc");
		List<Map<String, Object>> map=  userProjectService.queryForList(finder, page);
	//	List<UserProject> datas=userProjectService.findListDataByFinder(finder,page,UserProject.class,userProject);
		UserProject up = userProjectService.getTotalMoney(userProject);
		userProject.setMoney(up.getMoney());
		returnObject.setQueryBean(userProject);
		returnObject.setPage(page);
		returnObject.setData(map);
		return returnObject;
	}
    /**
     *
     */
    @RequestMapping("/getSmartList/json")
    public @ResponseBody ReturnDatas getSmartList(HttpServletRequest request,Integer projectId)throws Exception{
        ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
        // ==构造分页请求
        String  pageSize=request.getParameter("pageSize");
        // ==构造分页请求
        Page page = newPage(request);
        if(null != pageSize && !"".equals(pageSize)){
            page.setPageSize(Integer.parseInt(pageSize));
        }
        Finder finder = new Finder("SELECT tu.phone phone,tsidp.id, tsidp.investmentAmount money,tsidp.createTime FROM t_smart_investment_dispersed_project tsidp,t_app_user tu WHERE projectId=:projectId");
        finder.setParam("projectId", request.getParameter("projectId"));
        page.setOrder("tsidp.id");
        page.setSort("desc");
        List<Map<String, Object>> map=  userProjectService.queryForList(finder, page);
        returnObject.setPage(page);
        returnObject.setData(map);
        return returnObject;
    }
	/**
	 * 投资
	 */
	@SuppressWarnings("unused")
	@RequestMapping("/touzi")
	public @ResponseBody
	ReturnDatas saveorupdate(Model model,UserProject userProject,HttpServletRequest request,HttpServletResponse response,String tradPassword) throws Exception{
		tradPassword=request.getParameter("tradPassword");
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
 		returnObject.setMessage("投资成功！");
		try {

			if(tradPassword==null){
				returnObject.setStatus(ReturnDatas.ERROR);
				returnObject.setMessage("支付密码不能为空");
				return returnObject;
			}
			AppUser user =(AppUser)request.getSession().getAttribute(GlobalStatic.PCUSER);

			Map<String,Object> map = new HashMap<>();
			Map<String,Object> map1 = new HashMap<>();

			Double sumNew = (Double) getNewSumMoney(user.getId()).get("sumNewMoney");
			Double newSumMoney=50000.0-sumNew;
//			System.out.println("新手剩余投资金额："+newSumMoney);

			if(user.getErrorNum()!=null&&user.getErrorNum()>=5){
				returnObject.setStatus(ReturnDatas.ERROR);
				returnObject.setMessage("您的支付密码已被锁定");
				return returnObject;
			}
			if(!CryptAES.AES_Encrypt(tradPassword).equals(user.getTradPassword())){
				returnObject.setStatus(ReturnDatas.ERROR);
				user.setErrorNum((user.getErrorNum()==null ?0 :user.getErrorNum())+1);
				returnObject.setData(user.getErrorNum());
				returnObject.setMessage("支付密码不正确,你还可以输入"+(5-user.getErrorNum())+"次");
				if(user.getErrorNum()==5){
					returnObject.setMessage("您的支付密码已被锁定");
				}
				appUserService.updateValidValue(user);
				request.getSession().setAttribute(GlobalStatic.PCUSER, user);
				return returnObject;
			}
//			System.out.println("用户投资金额："+userProject.getMoney());
//			System.out.println("用户使用红包："+userProject.getCardPrice());
//			System.out.println("项目ID:"+userProject.getProjectId());
//			Calendar calendar = Calendar.getInstance();
//			calendar.setTime(new Date());
//			int i=1;
//			int mo = calendar.get(Calendar.MONTH)+i;
//			int year = calendar.get(Calendar.YEAR);
//			System.out.println("当前时间："+year+"年"+mo);

			Finder finder1 = new Finder("SELECT isNew FROM t_project WHERE id=:id");
			finder1.setParam("id",userProject.getProjectId());
			map = appUserService.queryForObject(finder1);

			Finder finder2 = new Finder("SELECT DATEDIFF(NOW(),cardTime) dateT FROM t_app_user WHERE id=:uid AND isIdCard=:isIdCard");
			finder2.setParam("uid",user.getId());
			finder2.setParam("isIdCard","是");
			map1 = appUserService.queryForObject(finder2);
//			System.out.println("新注册用户:"+map1.get("isIdCard")+":"+map1.get("cardTime"));
//			System.out.println("标识新手标吗："+map.get("isNew")+":");

			if(map.get("isNew").equals("是")){
				if(map1!=null){
					System.out.println("结果集："+map1.get("dateT"));
					if(Integer.parseInt(map1.get("dateT").toString())<=30){
						if(userProject.getMoney()>newSumMoney){
							returnObject.setStatus(ReturnDatas.ERROR);
							returnObject.setMessage("您的投资金额超出新手投资额度");
							return returnObject;
						}
					}
					else{
						returnObject.setStatus(ReturnDatas.ERROR);
						returnObject.setMessage("您新手专享标的可投期已失效！");
						return returnObject;
					}
				}else{
					returnObject.setStatus(ReturnDatas.ERROR);
					returnObject.setMessage("您尚未实名注册！");
					return returnObject;
				}
			}
			userProject.setUserId(user.getId());
			UserProject project = userProjectService.investProject(userProject);
			user=appUserService.findAppUserById(user.getId());
			request.getSession().setAttribute(GlobalStatic.PCUSER, user);
			returnObject.setData(project);
			if(null!=project.getFalseCode()){
				returnObject.setStatus(ReturnDatas.ERROR);
				returnObject.setMessage(project.getFalseCode());
			}

		}catch (NotCertificationException e) {
			String errorMessage = e.getLocalizedMessage();
			//e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("你还未认证用户，请前去认证");
		}catch (UserPorjectExistException e) {
			String errorMessage = e.getLocalizedMessage();
			//e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("你不能重复购买");
		}catch (CardNotUseException e) {
			String errorMessage = e.getLocalizedMessage();
			//e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(errorMessage);
		} catch (ProjectAmountNotEnoughException e) {
			String errorMessage = e.getLocalizedMessage();
			//e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("你的投资大于项目剩余金额，请重新选择金额");
		} catch (ParameterErrorException e){
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("投资金额必须大于零");
		}catch (MoneyException e){
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage("投资金额必须为100的整倍数");
		}catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;
	
	}
	@RequestMapping("/getNewSumMoney")
	@ResponseBody
	public Map getNewSumMoney(Integer id){
		Map<String,Object> map = new HashMap<>();
		Finder newMonyValue = new Finder("SELECT IFNULL(SUM(IFNULL(money,0) + IFNULL(cardPrice,0)), 0) sumNewMoney FROM t_user_project tup ,t_project tp WHERE tup.projectId=tp.id AND tp.isNew=:isnew AND tup.userId=:userid ");
		newMonyValue.setParam("userid",id);
		newMonyValue.setParam("isnew","是");
		try {
			map = appUserService.queryForObject(newMonyValue);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

}
