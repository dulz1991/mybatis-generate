package com.org.linchige.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.org.linchige.service.${className?cap_first}Service;
import com.org.linchige.model.${className?cap_first};
import com.org.linchige.util.Page;
import com.org.linchige.common.BaseController;

@Controller
@RequestMapping("/${className?uncap_first}")
public class ${className?cap_first}Controller extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(${className?cap_first}Controller.class);
	
	@Autowired
	private ${className?cap_first}Service ${className?uncap_first}Service;
	
	/**
	 * 列表页面
	 * @return
	 */
	@RequestMapping(value="/list")
	public ModelAndView index() {
		ModelAndView model = new ModelAndView("${className?uncap_first}/${className?uncap_first}_list");
		return model;
	}
	@ResponseBody
	@RequestMapping(value="/getList")
	public Map<String, Object> getList() {
		//查询参数
		Map<String, Object> parmMap =  getParmMap();
		//查询
		Page<${className?cap_first}> page = ${className?uncap_first}Service.getList(parmMap);
		//返回参数
		Map<String, Object> resMap = responseOK();
		resMap.put("list", page.getList());
		resMap.put("page", page);
		
		return resMap;
	}
	
	/**
	 * 编辑
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(Long id) {
		ModelAndView model = new ModelAndView("${className?uncap_first}/${className?uncap_first}_edit");
		if(id!=null){
			${className?cap_first} entity = ${className?uncap_first}Service.getById(id);
			model.addObject("entity", entity);
			model.addObject("title", "修改【"+x+"】");
		} else {
			model.addObject("entity", new ${className?cap_first}());
			model.addObject("title", "添加");
		}
		return model;
	}
	
	/**
	 * 保存
	 * @param schoolSubject
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/doSave")
	public Map<String, Object> save(${className?cap_first} ${className?uncap_first}) {
		boolean b = false;
		if(${className?uncap_first}.getId()!=null){
			b = ${className?uncap_first}Service.update(${className?uncap_first});
		} else {
			b = ${className?uncap_first}Service.insert(${className?uncap_first});
		}
		if(b){
			return responseOK();			
		}
		return responseGeneralError("保存失败");
	}
	
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/doDelete")
	public Map<String, Object> doDelete(Long id) {
		if(id==null){
			return responseGeneralError("删除的记录不存在");
		}
		if(!${className?uncap_first}Service.delete(id)){
			return responseGeneralError("删除失败");
		}
		return responseOK();
	}

}
