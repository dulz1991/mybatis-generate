package com.mybatis.generate.generate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.mybatis.generate.util.PropertiesUtil;

public class BaseGenerate {
	
	static List<String> tableColumsList = new ArrayList<String>(); //列名列表
	static Map<String, Object> field2Type = new HashMap<String, Object>(); //数据库列名	   对应    类型
	static Map<String, Object> field2Column = new HashMap<String, Object>(); //数据库列名	对应	 数据库列名
	static Map<String, Object> field2Comment = new HashMap<String, Object>(); //数据库列名	对应	数据库注释
	static String primaryKey = "";
	
	/**
	 * 数据库字段转Java字段
	 * 例：ID->id
	 * 例：USER_STATUS -> UserStatus -> userStatus
	 * @param value
	 * @return
	 */
	public String databaseField2JavaField(String value){
		if(StringUtils.isBlank(value)){
			return "";
		}
		
		if(value.contains("_")){
			//包含下划线的字段，先根据下划线分离字段
			String[] arr = value.split("_");
			StringBuilder sb = new StringBuilder();
			for(String str :arr){
				//分离后的字段 先全部转换成小写，再将首字母大写
				sb.append(firstWord2UpperCase(str.toLowerCase()));
			}
			//返回之前 将重新组合的字段 首字母小写 因为之前的操作 所有的首字母都是大写 
			return firstWord2LowerCase(sb.toString());
		} else {
			//如果是单个单词，直接返回小写字母
			return value.toLowerCase();
		}
	}
	
	/**
	 * 数据库表名转Java类名
	 * @param value
	 * @return
	 */
	public String dataTableName2ClassName(String value){
		if(StringUtils.isBlank(value)){
			return "";
		}
		
		if(value.contains("_")){
			String[] arr = value.split("_");
			StringBuilder sb = new StringBuilder();
			for(String str :arr){
				sb.append(firstWord2UpperCase(str.toLowerCase()));
			}
			return sb.toString();
		} else {
			return firstWord2UpperCase(value.toLowerCase());
		}
	}
	
	/**
	 * 首字母大写
	 * @param value
	 * @return
	 */
	public String firstWord2UpperCase(String value) {
		if(StringUtils.isBlank(value)){
			return "";
		}
		return value.substring(0, 1).toUpperCase()+value.substring(1,value.length());
	}
	
	/**
	 * 首字母小写
	 * @param value
	 * @return
	 */
	public String firstWord2LowerCase(String value) {
		if(StringUtils.isBlank(value)){
			return "";
		}
		return value.substring(0, 1).toLowerCase()+value.substring(1,value.length());
	}

	/**
	 * 生成模板文件的路径
	 * @param templateName
	 * @param fileName
	 * @return
	 */
	public String targetFilePath(String templateName, String fileName) {
		if(StringUtils.isBlank(fileName) || StringUtils.isBlank(templateName)){
			return null;
		}
		StringBuilder sb = new StringBuilder();
		sb.append(PropertiesUtil.getProperty("generate.path"));
		sb.append(templateName);
		sb.append(System.getProperty("file.separator"));
		sb.append(fileName);
		return sb.toString();
	}

}
