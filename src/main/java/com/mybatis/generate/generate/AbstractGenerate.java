package com.mybatis.generate.generate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.mybatis.generate.util.FreemarkerUtil;

public abstract class AbstractGenerate extends BaseGenerate {
	
	/**
	 * 根据表字段的值获取对应的Java字段
	 * @param value
	 * @return
	 */
	public abstract String getColumnType(Object value);
	/**
	 * 获取表数据
	 * @param tableName
	 * @param tableColumsList
	 * @param field2Type
	 * @param field2Column
	 */
	public abstract void getTable(String tableName, List<String> tableColumsList,Map<String, Object> field2Type, Map<String, Object> field2Column);
	
	public void generate(String[] tables) {
		for(String table : tables){
			//清空数据
			tableColumsList.clear();
			field2Type.clear();
			field2Column.clear();
			
			//获取表字段
			getTable(table, tableColumsList, field2Type, field2Column);
			if(tableColumsList.isEmpty()){
				continue;
			}
			
			//生成模板
			excuteGenerate(table);	
		}
	}
	public void excuteGenerate(String tableName) {
		System.out.println("==================>开始创建文件");
		this.generateModel(tableName, field2Type);
		this.generateService(tableName);
		this.generateController(tableName);
		this.generateMapper(tableName);
		this.generateXml(tableName, tableColumsList, field2Type, field2Column);
		this.generateList(tableName);
		this.generateEdit(tableName);
		System.out.println("==================>结束创建文件");
	}
	
	/**
	 * 创建model
	 * @param fileName
	 * @param tableColumsList
	 * @param columnMap
	 */
	public void generateModel(String tableName, Map<String, Object> columnMap) {
		String className = dataTableName2ClassName(tableName);
		String fileName = className + ".java";
		try {
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("model", fileName);
			
			//类名
			resMap.put("className", className);
			//字段列表
			Map<String, Object> resultColumnMap = new HashMap<String, Object>();
			for(String column : columnMap.keySet()){
				//java字段
				String javaField = databaseField2JavaField(column);
				//java字段对应的字段类型
				resultColumnMap.put(javaField, getColumnType(columnMap.get(column)));
			}
			resMap.put("fieldlist", resultColumnMap);
			
			resMap.put("serialVersionUID", UUID.randomUUID().toString().replaceAll("-", ""));
			
			//生成文件
			FreemarkerUtil.createFile("model.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + fileName + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + fileName + "失败!");
			System.out.println(e.getMessage());
		}
	}
	
	/**
	 * service
	 * @param tableName
	 */
	public void generateService(String tableName) {
		String className = dataTableName2ClassName(tableName);
		String fileName = className + "Service.java";
		try {
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("service", fileName);
			
			//类名
			resMap.put("className", className);
			
			//自动生成文件
			FreemarkerUtil.createFile("service.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + fileName + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + fileName + "失败!");
			System.out.println(e.getMessage());
		}		
	}
	
	/**
	 * mapper
	 * @param tableName
	 */
	public void generateMapper(String tableName) {
		String className = dataTableName2ClassName(tableName);
		String fileName = className + "Mapper.java";
		try {
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("mapper", fileName);
			
			//类名
			resMap.put("className", className);
			
			//自动生成文件
			FreemarkerUtil.createFile("mapper.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + fileName + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + fileName + "失败!");
			System.out.println(e.getMessage());
		}	
	}
	
	/**
	 * xml
	 * @param tableName
	 * @param tableColumsList
	 * @param field2Type
	 * @param field2Column
	 */
	public void generateXml(String tableName,
			List<String> tableColumsList, Map<String, Object> field2Type,
			Map<String, Object> columnMap) {
		String className = dataTableName2ClassName(tableName);
		String fileName = className + "Mapper.xml";
		try {
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("xml", fileName);
			
			//类名
			resMap.put("className", className);
			resMap.put("tableName", tableName);
			
			//字段列表
			Map<String, Object> resultColumnMap = new HashMap<String, Object>();
			for(String column : columnMap.keySet()){
				//java字段
				String javaField = databaseField2JavaField(column);
				//java字段对应的字段类型
				resultColumnMap.put(javaField, getColumnType(columnMap.get(column)));
			}
			resMap.put("dealField2Column", resultColumnMap);
			
			//自动生成文件
			FreemarkerUtil.createFile("xml.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + fileName + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + fileName + "失败!");
			System.out.println(e.getMessage());
		}
	}
	
	/**
	 * controller
	 * @param tableName
	 */
	public void generateController(String tableName) {
		String className = dataTableName2ClassName(tableName);
		String fileName = className + "Controller.java";
		try {
			tableName = tableName.toLowerCase();
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("controller", fileName);
			
			//类名
			resMap.put("tableName", tableName);
			resMap.put("className", className);
			
			//自动生成文件
			FreemarkerUtil.createFile("controller.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + fileName + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + fileName + "失败!");
			System.out.println(e.getMessage());
		}	
	}
	
	/**
	 * list
	 * @param tableName
	 */
	public void generateList(String tableName) {
		String className = dataTableName2ClassName(tableName);
		String fileName = firstWord2LowerCase(className) + "_list.ftl";
		try {
			tableName = tableName.toLowerCase();
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("page", fileName);
			
			//类名
			resMap.put("className", className);
			resMap.put("tableName", tableName);
			
			//自动生成文件
			FreemarkerUtil.createFile("list.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + fileName + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + fileName + "失败!");
			System.out.println(e.getMessage());
		}	
	}
	
	/**
	 * edits
	 * @param tableName
	 */
	public void generateEdit(String tableName) {
		String className = dataTableName2ClassName(tableName);
		String fileName = firstWord2LowerCase(className) + "_edit.ftl";
		try {
			tableName = tableName.toLowerCase();
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("page", fileName);
			
			//类名
			resMap.put("className", className);
			resMap.put("tableName", tableName);
			
			//自动生成文件
			FreemarkerUtil.createFile("edit.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + fileName + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + fileName + "失败!");
			System.out.println(e.getMessage());
		}	
	}

}
