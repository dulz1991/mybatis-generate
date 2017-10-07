package com.demo.my.backend.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.demo.my.base.service.${className?cap_first}Service;
import com.demo.my.base.model.${className?cap_first};
import com.demo.my.backend.common.BaseBackendController;
import com.demo.my.base.util.Page;

@Controller
@RequestMapping("/backend/${className?lower_case}")
public class ${className?cap_first}Controller extends BaseBackendController {
	
	private static final Logger logger = LoggerFactory.getLogger(${className?cap_first}Controller.class);
	
	@Autowired
	private ${className?cap_first}Service ${className?lower_case}Service;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ModelAndView index() {
		ModelAndView model = new ModelAndView("${className?lower_case}/${className?lower_case}_list");
		return model;
	}
	
	@RequestMapping(value="/edit", method = RequestMethod.GET)
	public ModelAndView edit(Long id) {
		ModelAndView model = new ModelAndView("${className?lower_case}/${className?lower_case}_edit");
		if(id!=null){
			${className?cap_first} entity = ${className?lower_case}Service.getById(id);
			model.addObject("entity", entity);
		} else {
			model.addObject("entity", new ${className?cap_first}());
		}
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="/getList", method = RequestMethod.GET)
	public Map<String, Object> getList(${className?cap_first} ${className?lower_case},
			@RequestParam(name="pageNo", defaultValue="1") int pageNo,  
			@RequestParam(name="pageSize", defaultValue="10") int pageSize) {
		//查询参数
		Map<String, Object> parmMap =  this.getParmMap(${className?lower_case});
		parmMap.put("orderBy", "");
		parmMap.put("pageNo", pageNo);
		parmMap.put("pageSize", pageSize);
		
		//查询
		Page<Map<String, Object>> page = ${className?lower_case}Service.getPageMapByParm(parmMap);

		//返回参数
		Map<String, Object> resMap = responseOK("");
		resMap.put("list", page.getList());
		resMap.put("page", page);
		
		return resMap;
	}
	
	@ResponseBody
	@RequestMapping(value="/doSave", method = RequestMethod.POST)
	public Map<String, Object> save(${className?cap_first} ${className?lower_case}) {
		${className?lower_case}Service.save(${className?lower_case});
		return responseOK("保存成功");
	}
	
	@ResponseBody
	@RequestMapping(value="/doDelete", method = RequestMethod.GET)
	public Map<String, Object> doDelete(Long id) {
		if(id==null){
			return responseError(-1, "删除的记录不存在");
		}
		int i = ${className?lower_case}Service.delete(id);
		if(i==0){
			return responseError(-1, "删除失败");
		}
		return responseOK("删除成功");
	}

}
