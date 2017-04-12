package com.demo.my.base.servicebean;

import org.springframework.stereotype.Service;

import com.demo.my.base.service.AbstractService;

@Service("${tableName}ServiceBean")  
public class ${tableName?cap_first}ServiceBean extends AbstractService {
	

}
