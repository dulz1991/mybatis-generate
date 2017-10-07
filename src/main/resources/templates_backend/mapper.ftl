package com.demo.my.base.mybatis.mapper.ds1mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.demo.my.base.model.${className?cap_first};
import com.demo.my.base.mybatis.mapper.base.BaseMapper;

public interface ${className?cap_first}Mapper extends BaseMapper {

	int insert(${className?cap_first} ${className?lower_case});
	
	int delete(@Param("id") Long id);
	
	int update(${className?cap_first} ${className?lower_case});
	
	${className?cap_first} getById(@Param("id") Long id);
	
	int countByParm(@Param("parm") Map<String, Object> paramMap);
	
	List<${className?cap_first}> getBeanListByParm(@Param("parm") Map<String, Object> paramMap);

	List<Map<String, Object>> getMapListByParm( @Param("parm") Map<String, Object> paramMap);

}
