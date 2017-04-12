package com.demo.my.base.mybatis.mapper.ds1mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.demo.my.base.bean.${className?cap_first};
import com.demo.my.base.util.PageUtil;

public interface ${className?cap_first}Mapper extends BaseMapper {

	void insert(${className?cap_first} ${className?uncap_first});
	
	void update(${className?cap_first} ${className?uncap_first});
	
	${className?cap_first} getById(@Param("id") Long id);
	
	List<Map<String, Object>> getMapListByParm(@Param("page") PageUtil page, @Param("parm") Map<String, Object> paramMap);
	
	Integer getMapListByParm_count(@Param("parm") Map<String, Object> paramMap);
	
	List<${className?cap_first}> getBeanListByParm(@Param("page") PageUtil page, @Param("parm") Map<String, Object> paramMap);

	Integer getBeanListByParm_count(@Param("parm") Map<String, Object> parmMap);

	Integer delete(@Param("id") Long id);
	
}
