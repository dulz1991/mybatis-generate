package com.iTouch.store.supplier.platform.mapper.${baseServiceName?uncap_first}Mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.iTouch.store.supplier.platform.mapper.BaseMapper;
import com.iTouch.store.supplier.platform.model.${className?cap_first};

public interface ${className?cap_first}Mapper extends BaseMapper {

	int insert(${className?cap_first} ${className?uncap_first});
	
	int delete(@Param("id") String id);
	
	int update(${className?cap_first} ${className?uncap_first});
	
	${className?cap_first} getById(@Param("id") String id);
	
	List<${className?cap_first}> getBeanListPage(@Param("parm") Map<String, Object> paramMap);

}
