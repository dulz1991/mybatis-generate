package com.demo.backedn.service;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.demo.backend.mapper.${tableName?cap_first}Mapper;
import com.demo.backend.model.${tableName?cap_first};
import com.demo.backend.util.PageUtil;

@Component  
public class ${tableName?cap_first}Service extends AdapterService implements BaseService {
	
	@Autowired
    ${tableName?cap_first}Mapper ${className}Mapper;
    
    public int insert(${tableName?cap_first} ${className}) {
		return ${className}Mapper.insert(${className});
	}
    
    public int update(${tableName?cap_first} ${className}) {
		return ${className}Mapper.update(${className});
	}
	
	public void save(${tableName?cap_first} ${className}) {
		if(${className}.getId()!=null){
			${className}Mapper.update(${className});
		} else {
			${className}Mapper.insert(${className});
		}
	}
	
	public int delete(Long id) {
		return ${className}Mapper.delete(id);
	}

	public ${tableName?cap_first} getById(Long id) {
		return ${className}Mapper.getById(id);
	}
	
	public int countByParm(${tableName?cap_first} ${className}) {
		Map<String, Object> parm = queryParm(${className});
		return ${className}Mapper.countByParm(parm);
	}
	
	public PageUtil<${tableName?cap_first}> getBeanListByParm(${tableName?cap_first} ${className}, int pageNo, Integer pageSize) {
		PageUtil<${tableName?cap_first}> pageUtil = new PageUtil<${tableName?cap_first}>(pageNo, pageSize);
		Map<String, Object> parm = queryParm(${className}, pageUtil);
		
		int count = ${className}Mapper.countByParm(parm);
		pageUtil.setTotalRecords(count);
		
		List<${tableName?cap_first}> list = new ArrayList<${tableName?cap_first}>();
		if(count!=0){
			list = ${className}Mapper.getBeanListByParm(parm);
		}
		pageUtil.setList(list);
		
		return pageUtil;
	}
	
	public PageUtil<Map<String, Object>> getMapListByParm(${tableName?cap_first} ${className},int pageNo, Integer pageSize) {
		PageUtil<Map<String, Object>> pageUtil = new PageUtil<Map<String, Object>>(pageNo, pageSize);
		Map<String, Object> parm = queryParm(${className}, pageUtil);
		
		int count = ${className}Mapper.countByParm(parm);
		pageUtil.setTotalRecords(count);
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(count!=0){
			list = ${className}Mapper.getMapListByParm(parm);
		}
		pageUtil.setList(list);
		
		return pageUtil;
	}
	
	private Map<String, Object> queryParm(${tableName?cap_first} ${className}) {
		Map<String, Object> parm = new HashMap<String, Object>();
		if(${className}!=null){
			
		}
		return parm;
	}
	
	private Map<String, Object> queryParm(${tableName?cap_first} ${className}, PageUtil pageUtil) {
		Map<String, Object> parm = new HashMap<String, Object>();
		if(${className}!=null){
			
		}
		parm.put("start", pageUtil.getStartRow());
		parm.put("limit", pageUtil.getPageSize());
		parm.put("orderby", "id desc" );
		return parm;
	}

}
