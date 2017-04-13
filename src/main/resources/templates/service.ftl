package com.sqe.shop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sqe.shop.mapper.${tableName?cap_first}Mapper;

@Component  
public class ${tableName?cap_first}Service extends AdapterService implements BaseService {
	
	@Autowired
    ${tableName?cap_first}Mapper ${tableName}Mapper;

}
