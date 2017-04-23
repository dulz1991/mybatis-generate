package com.sqe.shop.controller.backend;

import java.util.HashMap;
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

import com.sqe.shop.common.BaseController;
import com.sqe.shop.model.${tableName?cap_first};
import com.sqe.shop.service.${tableName?cap_first}Service;
import com.sqe.shop.util.PageUtil;

@Controller
@RequestMapping("/backend/${className}")
public class ${tableName?cap_first}Controller extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(${tableName?cap_first}Controller.class);
	
	@Autowired
	private ${tableName?cap_first}Service ${className}Service;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public ModelAndView index() {
		ModelAndView model = new ModelAndView("backend/${className}/list");
		return model;
	}
	
	@RequestMapping(value="/edit", method = RequestMethod.GET)
	public ModelAndView edit(Long id) {
		ModelAndView model = new ModelAndView("backend/${className}/edit");
		if(id!=null){
			${tableName?cap_first} entity = ${className}Service.getById(id);
			model.addObject("entity", entity);
		}
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="/getList", method = RequestMethod.GET)
	public Map<String, Object> getList(${tableName?cap_first} ${className},
			@RequestParam(name="pageNo", defaultValue="1") int pageNo,  @RequestParam(name="pageSize", defaultValue="10") int pageSize) {
		Map<String, Object> resMap = new HashMap<String, Object>();
		PageUtil<${tableName?cap_first}> page = ${className}Service.getBeanListByParm(${className}, pageNo, pageSize);
		resMap.put("list", page.getList());
		resMap.put("page", page);
		return resMap;
	}
	
	@ResponseBody
	@RequestMapping(value="/doSave", method = RequestMethod.POST)
	public Map<String, Object> save(${tableName?cap_first} ${className}) {
		${className}Service.save(${className});
		return responseOK(bundle.getString("save_success"));
	}
	
	@ResponseBody
	@RequestMapping(value="/doDelete", method = RequestMethod.GET)
	public Map<String, Object> doDelete(Long id) {
		if(id==null){
			return responseError(-1, bundle.getString("error_no_item"));
		}
		int i = ${className}Service.delete(id);
		if(i==0){
			return responseError(-1, bundle.getString("error_del_failed"));
		}
		return responseOK(bundle.getString("op_success"));
	}

}
