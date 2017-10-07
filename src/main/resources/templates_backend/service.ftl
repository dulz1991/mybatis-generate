package com.demo.my.base.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.demo.my.base.util.Page;

import com.demo.my.base.model.${className?cap_first};
import com.demo.my.base.mybatis.mapper.ds1mapper.${className?cap_first}Mapper;

import com.demo.my.base.service.common.AdapterService;


@Component  
public class ${className?cap_first}Service extends AdapterService {
	
	@Autowired
    ${className?cap_first}Mapper ${className?lower_case}Mapper;
    
    public int insert(${className?cap_first} ${className?lower_case}) {
		return ${className?lower_case}Mapper.insert(${className?lower_case});
	}
    
    public int update(${className?cap_first} ${className?lower_case}) {
		return ${className?lower_case}Mapper.update(${className?lower_case});
	}
	
	public int delete(Long id) {
		return ${className?lower_case}Mapper.delete(id);
	}
	
	public void save(${className?cap_first} ${className?lower_case}) {
		if(${className?lower_case}.getId()!=null){
			${className?lower_case}Mapper.update(${className?lower_case});
		} else {
			${className?lower_case}Mapper.insert(${className?lower_case});
		}
	}

	public ${className?cap_first} getById(Long id) {
		return ${className?lower_case}Mapper.getById(id);
	}
	
	public int countByParm(Map<String, Object> parmMap) {
		return ${className?lower_case}Mapper.countByParm(parmMap);
	}
	
	public List<Map<String, Object>> getMapListByParm(Map<String, Object> parm) {
		return  ${className?lower_case}Mapper.getMapListByParm(parm);
	}
	
	public List<${className?cap_first}> getBeanListByParm(Map<String, Object> parm) {
		return ${className?lower_case}Mapper.getBeanListByParm(parm);
	}
	
	public Page<${className?cap_first}> getPageBeanByParm(Map<String, Object> parm) {
		Page<${className?cap_first}> page = new Page<${className?cap_first}>((Integer)parm.get("pageNo"), (Integer)parm.get("pageSize"));
		parm.put("start", page.getStartRow());
		parm.put("limit", page.getPageSize());
		
		int count = this.countByParm(parm);
		page.setTotalRecords(count);
		
		List<${className?cap_first}> list = new ArrayList<${className?cap_first}>();
		if(count!=0){
			list = this.getBeanListByParm(parm);
		}
		page.setList(list);
		
		return page;
	}
	
	public Page<Map<String, Object>> getPageMapByParm(Map<String, Object> parm) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>((Integer)parm.get("pageNo"), (Integer)parm.get("pageSize"));
		parm.put("start", page.getStartRow());
		parm.put("limit", page.getPageSize());
		
		int count = this.countByParm(parm);
		page.setTotalRecords(count);
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(count!=0){
			list = this.getMapListByParm(parm);
		}
		page.setList(list);
		
		return page;
	}
	
}
