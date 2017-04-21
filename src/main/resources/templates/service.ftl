package com.sqe.shop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sqe.shop.mapper.${tableName?cap_first}Mapper;
import com.sqe.shop.model.${tableName?cap_first};
import com.sqe.shop.util.PageUtil;

@Component  
public class ${tableName?cap_first}Service extends AdapterService implements BaseService {
	
	@Autowired
    ${tableName?cap_first}Mapper ${tableName}Mapper;
    
    public int insert(${tableName?cap_first} ${tableName}) {
		return ${tableName}Mapper.insert(${tableName});
	}
    
    public int update(${tableName?cap_first} ${tableName}) {
		return ${tableName}Mapper.update(${tableName});
	}
	
	public int delete(Long id) {
		return ${tableName}Mapper.delete(id);
	}

	public ${tableName?cap_first} getById(Long id) {
		return ${tableName}Mapper.getById(id);
	}
	
	public int countByParm(${tableName?cap_first} ${tableName}) {
		Map<String, Object> parm = new HashMap<String, Object>();
		// TODO
		/*if(${tableName}!=null){
		
		}*/
		return ${tableName}Mapper.countByParm(parm);
	}
	
	public int countByParm(Map<String, Object> parm) {
		return ${tableName}Mapper.countByParm(parm);
	}
	
	public PageUtil<${tableName?cap_first}> getBeanListByParm(${tableName?cap_first} ${tableName}, int pageNo, Integer pageSize) {
		PageUtil<${tableName?cap_first}> pageUtil = new PageUtil<${tableName?cap_first}>(pageNo, pageSize);
		Map<String, Object> parm = new HashMap<String, Object>();
		// TODO
		/*if(${tableName}!=null){
			
		}*/
		int count = ${tableName}Mapper.countByParm(parm);
		pageUtil.setTotalRecords(count);
		if(count!=0){
			List<${tableName?cap_first}> list = ${tableName}Mapper.getBeanListByParm(parm);
			pageUtil.setList(list);
		}
		return pageUtil;
	}
	
	public PageUtil<Map<String, Object>> getMapListByParm(Map<String, Object> parm,int pageNo, Integer pageSize) {
		PageUtil<Map<String, Object>> pageUtil = new PageUtil<Map<String, Object>>(pageNo, pageSize);
		int count = ${tableName}Mapper.countByParm(parm);
		pageUtil.setTotalRecords(count);
		if(count!=0){
			List<Map<String, Object>> list = ${tableName}Mapper.getMapListByParm(parm);
			pageUtil.setList(list);
		}
		return pageUtil;
	}

}
