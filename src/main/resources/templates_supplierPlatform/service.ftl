package com.iTouch.store.supplier.platform.service.${baseServiceName?uncap_first};

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.iTouch.store.supplier.platform.model.${className?cap_first};
import com.iTouch.store.supplier.platform.mapper.accountsMapper.${className?cap_first}Mapper;


@Component  
public class ${className?cap_first}Service extends ${baseServiceName}BaseService {
	
	@Autowired
    ${className?cap_first}Mapper ${className?uncap_first}Mapper;
    
    public boolean insert(${className?cap_first} ${className?uncap_first}) {
		int count =  ${className?uncap_first}Mapper.insert(${className?uncap_first});
		if(count>0){
    		return true;
    	}
		return false;
	}
    
    public boolean update(${className?cap_first} ${className?uncap_first}) {
		int count = ${className?uncap_first}Mapper.update(${className?uncap_first});
		if(count>0){
    		return true;
    	}
		return false;
	}
	
	public boolean delete(String id) {
		int count = ${className?uncap_first}Mapper.delete(id);
		if(count>0){
			return true;
		}
		return false;
	}
	
	public boolean save(${className?cap_first} ${className?uncap_first}) {
		int count = 0;
		if(${className?uncap_first}.getId()!=null){
			count = ${className?uncap_first}Mapper.update(${className?uncap_first});
		} else {
			count = ${className?uncap_first}Mapper.insert(${className?uncap_first});
		}
		if(count>0){
    		return true;
    	}
		return false;
	}

	public ${className?cap_first} getById(String id) {
		return ${className?uncap_first}Mapper.getById(id);
	}
	
	public List<Map<String, Object>> getListByParm(Map<String, Object> parm) {
		return  ${className?uncap_first}Mapper.getListByParm(parm);
	}
	
	public List<${className?cap_first}> getBeanListByParm(Map<String, Object> parm) {
		return ${className?uncap_first}Mapper.getBeanListByParm(parm);
	}
	
}
