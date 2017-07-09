package com.demo.my.base.model;

import java.io.Serializable;
import java.util.Date;

public class ${className} implements Serializable {

	private static final long serialVersionUID = 1L;

	<#list fieldlist?keys as itemKey>
	private ${fieldlist[itemKey]} ${itemKey};
	</#list>	
	
	<#list fieldlist?keys as itemKey>
	public ${fieldlist[itemKey]} get${itemKey?cap_first}() {
		return ${itemKey};
	}
	public void set${itemKey?cap_first}(${fieldlist[itemKey]} ${itemKey}) {
		this.${itemKey} = ${itemKey};
	}
	</#list>
	
	
	
}