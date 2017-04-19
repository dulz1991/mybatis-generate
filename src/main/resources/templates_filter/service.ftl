package com.sangame.datafilter.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sangame.datafilter.model.${className?cap_first};
import com.sangame.datafilter.mapper.${className?cap_first}Mapper;
import com.sangame.datafilter.util.PageUtil;

@Component  
public class ${className?cap_first}Service {
	
	@Autowired
    private ${className?cap_first}Mapper ${className}Mapper;
    
    public int insert(${className?cap_first} ${className}) {
		return ${className}Mapper.insert(${className});
	}
    
    public int update(${className?cap_first} ${className}) {
		return ${className}Mapper.update(${className});
	}
	
	public int delete(Long id) {
		return ${className}Mapper.delete(id);
	}

	public ${className?cap_first} getById(Long id) {
		return ${className}Mapper.getById(id);
	}
	
	public int countByParm(${className?cap_first} ${className}) {
		Map<String, Object> parm = new HashMap<String, Object>();
		// TODO
		/*if(${className}!=null){
			
		}*/
		return ${className}Mapper.countByParm(parm);
	}
	
	public int countByParm(Map<String, Object> parm) {
		return ${className}Mapper.countByParm(parm);
	}
	
	public PageUtil<${className?cap_first}> getListByParm(${className?cap_first} ${className}, int pageNo, Integer pageSize) {
		PageUtil<${className?cap_first}> pageUtil = new PageUtil<${className?cap_first}>(pageNo, pageSize);
		Map<String, Object> parm = new HashMap<String, Object>();
		// TODO
		/*if(${className}!=null){
			
		}*/
		int count = ${className}Mapper.countByParm(parm);
		pageUtil.setTotalRecords(count);
		if(count!=0){
			List<${className?cap_first}> list = ${className}Mapper.getListByParm(parm, pageUtil);
			pageUtil.setList(list);
		}
		return pageUtil;
	}
	
	public PageUtil<Map<String, Object>> getMapListByParm(Map<String, Object> parm,int pageNo, Integer pageSize) {
		PageUtil<Map<String, Object>> pageUtil = new PageUtil<Map<String, Object>>(pageNo, pageSize);
		int count = ${className}Mapper.countByParm(parm);
		pageUtil.setTotalRecords(count);
		if(count!=0){
			List<Map<String, Object>> list = ${className}Mapper.getMapListByParm(parm, pageUtil);
			pageUtil.setList(list);
		}
		return pageUtil;
	}
	
}
