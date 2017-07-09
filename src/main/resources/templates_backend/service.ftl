package com.demo.my.base.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.demo.my.base.util.Page;

import com.demo.my.base.model.${tableName?cap_first};
import com.demo.my.base.mybatis.mapper.ds1mapper.${tableName?cap_first}Mapper;

import com.demo.my.base.service.common.AdapterService;


@Component  
public class ${tableName?cap_first}Service extends AdapterService {
	
	@Autowired
    ${tableName?cap_first}Mapper ${className}Mapper;
    
    public int insert(${tableName?cap_first} ${className}) {
		return ${className}Mapper.insert(${className});
	}
    
    public int update(${tableName?cap_first} ${className}) {
		return ${className}Mapper.update(${className});
	}
	
	public int delete(Long id) {
		return ${className}Mapper.delete(id);
	}
	
	public void save(${tableName?cap_first} ${className}) {
		if(${className}.getId()!=null){
			${className}Mapper.update(${className});
		} else {
			${className}Mapper.insert(${className});
		}
	}

	public ${tableName?cap_first} getById(Long id) {
		return ${className}Mapper.getById(id);
	}
	
	public int countByParm(Map<String, Object> parmMap) {
		return ${className}Mapper.countByParm(parmMap);
	}
	
	public List<Map<String, Object>> getMapListByParm(Map<String, Object> parm) {
		return  ${className}Mapper.getMapListByParm(parm);
	}
	
	public List<${tableName?cap_first}> getBeanListByParm(Map<String, Object> parm) {
		return ${className}Mapper.getBeanListByParm(parm);
	}
	
	public Page<${tableName?cap_first}> getPageBeanByParm(Map<String, Object> parm) {
		Page<${tableName?cap_first}> page = new Page<${tableName?cap_first}>((Integer)parm.get("pageNo"), (Integer)parm.get("pageSize"));
		parm.put("start", page.getStartRow());
		parm.put("limit", page.getPageSize());
		
		int count = this.countByParm(parm);
		page.setTotalRecords(count);
		
		List<${tableName?cap_first}> list = new ArrayList<${tableName?cap_first}>();
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
