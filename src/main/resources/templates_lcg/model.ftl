package com.org.linchige.model;

import java.io.Serializable;
import java.util.Date;
import java.math.BigDecimal;
import com.org.linchige.model.extend.BaseExtend;

public class ${className} extends BaseExtend implements Serializable {

	private static final long serialVersionUID = ${serialVersionUID}L;

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