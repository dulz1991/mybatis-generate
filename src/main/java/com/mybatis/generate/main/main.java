package com.mybatis.generate.main;

import org.apache.commons.lang3.StringUtils;

import com.mybatis.generate.generate.MySqlGenerate;
import com.mybatis.generate.generate.SqlServerGenerate;
import com.mybatis.generate.util.PropertiesUtil;

public class main {
	
	//private static String[] tables = {"user_thumb","advertisement","permission","role","user","comment","image","inform","message","news","post","product","product_type","question_answer","questions","section","shop","topic","thread"};
	/*private static String[] tables = {"collection","comment","discovery","demo","demo_menu","sys_cfg","code_menu","code_sub_menu",
		"code","blog","blog_menu","blog_log","demo","demo_menu","user_log","user_role","user","active","active_user"};*/
	/*private static String[] tables = {"goods"};*/
	
	public static void main(String[] args) {
		String dbNames = PropertiesUtil.getProperty("db_names");
		if(StringUtils.isBlank(dbNames)){
			System.out.println("无数据表配置");
			return;
		} 
		String[] tables = dbNames.split(",");
		String db = PropertiesUtil.getProperty("generate.database");
		if(db.equals("mysql")){
			MySqlGenerate generate = new MySqlGenerate();
			generate.generate(tables);
		} else if(db.equals("sqlserver")){
			SqlServerGenerate generate = new SqlServerGenerate();
			generate.generate(tables);
		} 
    }
	
	

}
