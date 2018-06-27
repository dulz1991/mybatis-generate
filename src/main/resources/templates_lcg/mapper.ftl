package com.org.linchige.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.org.linchige.model.${className?cap_first};
import com.org.linchige.mybatis.mapper.BaseMapper;

public interface ${className?cap_first}Mapper extends BaseMapper {

	int insert(${className?cap_first} ${className?uncap_first});
	
	int delete(@Param("id") Long id);
	
	int update(${className?cap_first} ${className?uncap_first});
	
	${className?cap_first} getById(@Param("id") Long id);
	
	int countByParm(@Param("parm") Map<String, Object> paramMap);
	
	List<${className?cap_first}> getBeanListByParm(@Param("parm") Map<String, Object> paramMap);

	List<Map<String, Object>> getMapListByParm( @Param("parm") Map<String, Object> paramMap);

}
