package com.cz.yingpu.system.web;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cz.yingpu.frame.controller.BaseController;
import com.cz.yingpu.frame.service.IBaseService;
import com.cz.yingpu.frame.util.GlobalStatic;
import com.cz.yingpu.frame.util.Page;
import com.cz.yingpu.frame.util.ReturnDatas;
import com.cz.yingpu.system.entity.SMSTemplate;

@RequestMapping("/sms-template")
@Controller
public class SMSTemplateController extends BaseController {
	@Resource
	private IBaseService smsTemplateService;
	
	
	@RequestMapping("/add/view")
	public String addTemplate(HttpServletRequest req) {
		req.setAttribute("action", "add");
		return "sms-template/edit";
	}
	
	
	@RequestMapping("/add/json")
	@ResponseBody
	public ReturnDatas addTemplate(SMSTemplate st) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		try {
			st.setCreate_date(new Date());
			smsTemplateService.save(st);
		} catch (Exception e) {
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}
		
		return rt;
	}
	
	
	@RequestMapping("/edit/view")
	public String editTemplate(HttpServletRequest req, SMSTemplate st) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		try {
			if (st.getId() == null) {
				throw new NullPointerException("ID不能为空！");
			}
			
			st = smsTemplateService.findById(st.getId(), st.getClass());
			rt.setData(st);
		}
		catch(Exception e) {
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}
		
		req.setAttribute(GlobalStatic.returnDatas, rt);
		req.setAttribute("action", "edit");
		return "sms-template/edit";
	}
	
	
	@RequestMapping("/edit/json")
	@ResponseBody
	public ReturnDatas editTemplate(SMSTemplate st) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		try {
			if (st.getId() == null) {
				throw new NullPointerException("ID不能为空！");
			}
			smsTemplateService.update(st, true);
		} catch (Exception e) {
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}
		
		return rt;
	}
	
	
	@RequestMapping("/delete/json")
	@ResponseBody
	public ReturnDatas delete(SMSTemplate st) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		try {
			smsTemplateService.deleteByEntity(st);
		} catch (Exception e) {
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}
		
		return rt;
	}
	

	@RequestMapping("/list/view")
	public String listView(HttpServletRequest req) {
		ReturnDatas rt = ReturnDatas.getSuccessReturnDatas();
		Page page = newPage(req);
		page.setOrder("create_date");
		page.setSort("DESC");
		try {
			rt.setData(smsTemplateService.findListDataByFinder(null, page, SMSTemplate.class, new SMSTemplate()));
		}
		catch(Exception e) {
			rt.setStatus(ReturnDatas.ERROR);
			e.printStackTrace();
		}
		
		rt.setPage(page);
		req.setAttribute(GlobalStatic.returnDatas, rt);
		return "sms-template/list";
	}
	
	
	@RequestMapping("/list/export")
	public void listExport(HttpServletRequest req, HttpServletResponse response) {
		Page page = newPage(req);
		page.setPageSize(10000);
		page.setOrder("create_date");
		page.setSort("DESC");
		try {
			List<SMSTemplate> list = smsTemplateService.findListDataByFinder(null, page, SMSTemplate.class, new SMSTemplate());
			File file = smsTemplateService.findDataExportExcel(list,"sms-template/list", page, null);
			String fileName="短信模板"+GlobalStatic.excelext;
			downFile(response, file, fileName,true);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
