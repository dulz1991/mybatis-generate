package com.iTouch.store.supplier.platform.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.iTouch.store.supplier.platform.coommon.BaseResult;
import com.iTouch.store.supplier.platform.model.${className?cap_first};
import com.iTouch.store.supplier.platform.service.${baseServiceName?uncap_first}.${className?cap_first}Service;
import com.iTouch.store.supplier.platform.util.Page;

@Controller
@RequestMapping("/${className?uncap_first}")
public class ${className?cap_first}Controller extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(${className?cap_first}Controller.class);
	
	@Autowired
	private ${className?cap_first}Service ${className?uncap_first}Service;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ModelAndView index() {
		ModelAndView model = new ModelAndView("${className?uncap_first}/list");
		return model;
	}
	
	@RequestMapping(value="/edit")
	public ModelAndView edit(String id) {
		ModelAndView model = new ModelAndView("${className?uncap_first}/edit");
		if(id!=null){
			${className?cap_first} entity = ${className?uncap_first}Service.getById(id);
			model.addObject("entity", entity);
		} else {
			model.addObject("entity", new ${className?cap_first}());
		}
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="/getList")
	public Map<String, Object> getList() {
		//查询参数
		Map<String, Object> parmMap = this.getParmMap();
		
		//查询
		Page<${className?cap_first}> page = ${className?uncap_first}Service.getPage("${className?cap_first}Mapper.getBeanListByParm",parmMap);

		//返回参数
		Map<String, Object> resMap = BaseResult.responseOK("");
		resMap.put("list", page.getList());
		resMap.put("page", page);
		
		return resMap;
	}
	
	@ResponseBody
	@RequestMapping(value="/doSave")
	public Map<String, Object> save(${className?cap_first} ${className?uncap_first}) {
		boolean b = ${className?uncap_first}Service.save(${className?uncap_first});
		if(!b){
			return BaseResult.responseGeneralError("保存失败，请检查数据输入");
		}
		return BaseResult.responseOK("");
	}
	
	@ResponseBody
	@RequestMapping(value="/doDelete")
	public Map<String, Object> doDelete(String id) {
		boolean b = ${className?uncap_first}Service.delete(id);
		if(!b){
			return BaseResult.responseGeneralError("删除失败");
		}
		return BaseResult.responseOK("");
	}

}
