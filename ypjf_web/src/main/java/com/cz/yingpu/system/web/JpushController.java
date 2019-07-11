package com.cz.yingpu.system.web;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.util.MessageUtils;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.service.JPushService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * TODO 在此加入类描述
 * @copyright {@link 9iu.org}
 * @author springrain<Auto generate>
 * @version  2017-03-21 15:09:44
 * @see com.cz.yingpu.system.web.Bank
 */
@Controller
@RequestMapping(value="/system/push")
public class JpushController extends BaseController {

	@Resource
	private JPushService jPushService;

	/**
	 * 新增/修改 操作吗,返回json格式数据
	 *
	 */
	@RequestMapping("/push")
	public @ResponseBody
	ReturnDatas push(Model model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		ReturnDatas returnObject = ReturnDatas.getSuccessReturnDatas();
		returnObject.setMessage(MessageUtils.UPDATE_SUCCESS);
		try {
			String content = request.getParameter("content");
			jPushService.notify(9,null,null,content);
		} catch (Exception e) {
			String errorMessage = e.getLocalizedMessage();
			e.printStackTrace();
			returnObject.setStatus(ReturnDatas.ERROR);
			returnObject.setMessage(MessageUtils.UPDATE_ERROR);
		}
		return returnObject;

	}

	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model)
			throws Exception {
		return "/push/url";
	}

}
