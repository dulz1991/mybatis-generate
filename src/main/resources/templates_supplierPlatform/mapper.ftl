package com.iTouch.store.supplier.platform.mapper.accountsMapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.iTouch.store.supplier.platform.mapper.BaseMapper;
import com.iTouch.store.supplier.platform.model.${className?cap_first};

public interface ${className?cap_first}Mapper extends BaseMapper {

	int insert(${className?cap_first} ${className?lower_case});
	
	int delete(@Param("id") String id);
	
	int update(${className?cap_first} ${className?lower_case});
	
	${className?cap_first} getById(@Param("id") String id);
	
	List<${className?cap_first}> getBeanListByParm(@Param("parm") Map<String, Object> paramMap);
	int getBeanListByParm_count(@Param("parm") Map<String, Object> paramMap);

	List<Map<String, Object>> getListByParm( @Param("parm") Map<String, Object> paramMap);
	int getListByParm_count( @Param("parm") Map<String, Object> paramMap);

}
