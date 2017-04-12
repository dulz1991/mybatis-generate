package com.mybatis.generate.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.mybatis.generate.util.FreemarkerUtil;
import com.mybatis.generate.util.PropertiesUtil;

public class Generate {
	
	//数据表字段转换成java字段
	public static String convertText(String value){
		String[] arr;
		if(value.contains("_")){
			arr = value.split("_");
			StringBuilder sb = new StringBuilder();
			for(String str :arr){
				sb.append(firstWord2UpperCase(str));
			}
			return sb.toString();
		} else {
			return firstWord2UpperCase(value);
		}
	}
	//首字母大写
	public static String firstWord2UpperCase(String value) {
		if(StringUtils.isBlank(value)){
			return "";
		}
		return value.substring(0, 1).toUpperCase()+value.substring(1,value.length());
	}
	//首字母小写
	public static String firstWord2LowerCase(String value) {
		if(StringUtils.isBlank(value)){
			return "";
		}
		return value.substring(0, 1).toLowerCase()+value.substring(1,value.length());
	}
	//获取列名
	private static String getColumnType(Integer value) {
		if(value.equals(-5)){
			return "Long";
		} else if(value.equals(12)) {
			return "String";
		} else if(value.equals(93)) {
			return "Date";
		} else if(value.equals(4)) {
			return "Integer";
		}
		return "String";
	}

	public static void generateModel(String fileName, List<String> tableColumsList, Map<String, Object> columnMap) {
		try {
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = PropertiesUtil.getProperty("generate.path") + "model\\" + convertText(fileName) + ".java";
			
			//类名
			resMap.put("className", convertText(fileName));
			//字段列表
			Map<String, Object> dealColumnMap = new HashMap<String, Object>();
			for(String column : columnMap.keySet()){
				String str = convertText(column.toLowerCase());
				dealColumnMap.put(firstWord2LowerCase(str), getColumnType((Integer) columnMap.get(column)));
			}
			resMap.put("fieldlist", dealColumnMap);
			
			//自动生成文件
			FreemarkerUtil.createFile("model.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + convertText(fileName) + ".java" + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + convertText(fileName) + ".java" + "失败!");
			System.out.println(e.getCause());
		}
	}
	public static void generateService(String tableName) {
		try {
			tableName = tableName.toLowerCase();
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = PropertiesUtil.getProperty("generate.path") + "service\\" + convertText(tableName) + "ServiceBean.java";
			
			//类名
			resMap.put("tableName", convertText(tableName));
			
			//自动生成文件
			FreemarkerUtil.createFile("service.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + convertText(tableName) + "ServiceBean.java" + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + convertText(tableName) + "ServiceBean.java" + "失败!");
			System.out.println(e.getCause());
		}		
	}
	public static void generateMapper(String tableName) {
		try {
			tableName = tableName.toLowerCase();
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = PropertiesUtil.getProperty("generate.path") + "mapper\\" + convertText(tableName) + "Mapper.java";
			
			//类名
			resMap.put("className", convertText(tableName));
			
			//自动生成文件
			FreemarkerUtil.createFile("mapper.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + convertText(tableName) + "Mapper.java" + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + convertText(tableName) + "Mapper.java" + "失败!");
			System.out.println(e.getCause());
		}	
	}
	public static void generateXml(String tableName,
			List<String> tableColumsList, Map<String, Object> field2Type,
			Map<String, Object> field2Column) {
		try {
			tableName = tableName.toLowerCase();
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = PropertiesUtil.getProperty("generate.path") + "xml\\" + convertText(tableName) + "Mapper.xml";
			
			//类名
			resMap.put("className", convertText(tableName));
			resMap.put("tableName", tableName);
			//字段列表
			Map<String, Object> dealField2Column = new HashMap<String, Object>();
			for(String column : field2Column.keySet()){
				String str = convertText(column.toLowerCase());
				dealField2Column.put(firstWord2LowerCase(str), field2Column.get(column));
			}
			resMap.put("dealField2Column", dealField2Column);
			
			//自动生成文件
			FreemarkerUtil.createFile("xml.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + convertText(tableName) + "Mapper.xml" + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + convertText(tableName) + "Mapper.xml" + "失败!");
			System.out.println(e.getCause());
		}
	}

}
