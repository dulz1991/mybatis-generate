package com.org.linchige.service;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.org.linchige.model.${className?cap_first};
import com.org.linchige.mybatis.mapper.${className?cap_first}Mapper;
import com.org.linchige.util.Page;
import com.org.linchige.service.base.AdapterService;


@Component  
public class ${className?cap_first}Service extends AdapterService {
	
	@Autowired
    ${className?cap_first}Mapper ${className?uncap_first}Mapper;
    
    public boolean insert(${className?cap_first} ${className?uncap_first}) {
		int result = ${className?uncap_first}Mapper.insert(${className?uncap_first});
		return result > 0;
	}
    
    public boolean update(${className?cap_first} ${className?uncap_first}) {
    	int result = ${className?uncap_first}Mapper.update(${className?uncap_first});
		return result > 0;
	}
	
	public boolean delete(Long id) {
		int result = ${className?uncap_first}Mapper.delete(id);
		return result > 0;
	}
	
	public ${className?cap_first} getById(Long id) {
		return ${className?uncap_first}Mapper.getById(id);
	}
	
	public int countByParm(Map<String, Object> parmMap) {
		if(parmMap == null){
			parmMap = new HashMap<String, Object>();
		}
		return ${className?uncap_first}Mapper.countByParm(parmMap);
	}
	
	public List<Map<String, Object>> getMapListByParm(Map<String, Object> parmMap) {
		if(parmMap == null){
			parmMap = new HashMap<String, Object>();
		}
		return  ${className?uncap_first}Mapper.getMapListByParm(parmMap);
	}
	
	public List<${className?cap_first}> getBeanListByParm(Map<String, Object> parmMap) {
		if(parmMap == null){
			parmMap = new HashMap<String, Object>();
		}
		return ${className?uncap_first}Mapper.getBeanListByParm(parmMap);
	}
	
	public Page<${className?cap_first}> getList(Map<String, Object> parmMap) {
		return this.getPage(" ${className?uncap_first}Mapper.getList", parmMap);
	}
}
