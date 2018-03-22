package com.mybatis.generate.generate;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.mybatis.generate.util.FreemarkerUtil;
import com.mybatis.generate.util.PropertiesUtil;

public abstract class AbstractGenerate extends BaseGenerate {
	
	/**
	 * 根据表字段的值获取对应的Java字段
	 * @param value
	 * @return
	 */
	public abstract String getColumnType(Object value);
	public abstract String getColumnComment(Object value);
	/**
	 * 获取表数据
	 * @param tableName
	 * @param tableColumsList
	 * @param field2Type
	 * @param field2Column
	 * @param field2Comment 
	 */
	public abstract void getTable(String tableName, List<String> tableColumsList,Map<String, Object> field2Type, Map<String, Object> field2Column, Map<String, Object> field2Comment);
	
	public void generate(String[] tables) {
		for(String table : tables){
			if(StringUtils.isBlank(table)){
				continue;
			}
			//清空数据
			tableColumsList.clear();
			field2Type.clear();
			field2Column.clear();
			field2Comment.clear();
			
			//获取表字段
			getTable(table, tableColumsList, field2Type, field2Column,field2Comment);
			if(tableColumsList.isEmpty()){
				continue;
			}
			
			//生成模板
			excuteGenerate(table);	
		}
	}
	public void excuteGenerate(String tableName) {
		System.out.println("==================>开始创建文件");
		this.generateModel(tableName, field2Type, field2Comment);
		this.generateController(tableName);
		this.generateService(tableName);
		/*this.generateMapper(tableName);*/
		this.generateXml(tableName, tableColumsList, field2Type, field2Column);
		this.generateList(tableName,field2Type);
		this.generateEdit(tableName,field2Type);
		this.generateDetail(tableName,field2Type);
		System.out.println("==================>结束创建文件");
	}
	
	/**
	 * 创建model
	 * @param field2Comment 
	 * @param fileName
	 * @param tableColumsList
	 * @param columnMap
	 */
	public void generateModel(String tableName, Map<String, Object> field2Type, Map<String, Object> field2Comment) {
		//填充ftl的数据
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		String className = dataTableName2ClassName(tableName); //类名
		String fileName = className + ".java"; //文件名
		if(PropertiesUtil.getProperty("template_folder_name").equals("templates_xym")){
			fileName = className + "Info.java";
		}
		
		resMap.put("packet", PropertiesUtil.getProperty("model_packet"));//包名后缀
		try {
			//文件生成路径
			String targetFile = targetFilePath("model", fileName);
			//类名
			resMap.put("className", className);
			resMap.put("publicClassName", className);
			if(PropertiesUtil.getProperty("template_folder_name").equals("templates_xym")){
				resMap.put("publicClassName", className+"Info");
			}
			//字段map
			Map<String, Object> typeMap = new HashMap<String, Object>();
			//注释map
			Map<String, Object> commentMap = new HashMap<String, Object>();
			
			for(String column : field2Type.keySet()){
				//java字段
				String javaField = databaseField2JavaField(column);
				//java字段对应的字段类型
				typeMap.put(javaField, getColumnType(field2Type.get(column)));
				//Java字段对应的注解
				commentMap.put(javaField, field2Comment.get(column));
			}
			resMap.put("fieldlist", typeMap);
			resMap.put("commentMap", commentMap);
			
			resMap.put("serialVersionUID", "-" + new Date().getTime() );
			
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
			//包名后缀
			resMap.put("packet", PropertiesUtil.getProperty("service_packet"));
			//类名
			resMap.put("className", className);
			resMap.put("modelPacket", PropertiesUtil.getProperty("model_packet"));
			
			String mysqlUrl = PropertiesUtil.getProperty("jdbc.mysql.url","");
			if(mysqlUrl.contains("account")){
				resMap.put("baseServiceName", "Accounts");
			} else if(mysqlUrl.contains("other")){
				resMap.put("baseServiceName", "Other");
			} else if(mysqlUrl.contains("base")){
				resMap.put("baseServiceName", "Base");
			} else if(mysqlUrl.contains("goods")){
				resMap.put("baseServiceName", "Goods");
			} else if(mysqlUrl.contains("logs")){
				resMap.put("baseServiceName", "Logs");
			} else if(mysqlUrl.contains("order")){
				resMap.put("baseServiceName", "Order");
			} else {
				resMap.put("baseServiceName", "");
			}
			
			//主键
			resMap.put("primaryKey", primaryKey);
			resMap.put("primaryKey2Java", this.databaseField2JavaField(primaryKey));
			
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
			
			String mysqlUrl = PropertiesUtil.getProperty("jdbc.mysql.url","");
			if(mysqlUrl.contains("account")){
				resMap.put("baseServiceName", "Accounts");
			} else if(mysqlUrl.contains("other")){
				resMap.put("baseServiceName", "Other");
			} else if(mysqlUrl.contains("base")){
				resMap.put("baseServiceName", "Base");
			} else if(mysqlUrl.contains("goods")){
				resMap.put("baseServiceName", "Goods");
			} else if(mysqlUrl.contains("logs")){
				resMap.put("baseServiceName", "Logs");
			} else if(mysqlUrl.contains("order")){
				resMap.put("baseServiceName", "Order");
			} else {
				resMap.put("baseServiceName", "");
			}
			
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
			String db = PropertiesUtil.getProperty("generate.database");
			String targetFile = "";
			if(db.equals("mysql")){
				targetFile = targetFilePath("xml_mysql", fileName);
			} else if(db.equals("sqlserver")){
				targetFile = targetFilePath("xml_sqlserver", fileName);	
			}
			
			resMap.put("modelPacket", PropertiesUtil.getProperty("model_packet"));
			//主键
			resMap.put("primaryKey", primaryKey);
			resMap.put("primaryKey2Java", this.databaseField2JavaField(primaryKey));
			//类名
			resMap.put("className", className);
			resMap.put("tableName", tableName);
			
			String mysqlUrl = PropertiesUtil.getProperty("jdbc.mysql.url","");
			if(mysqlUrl.contains("account")){
				resMap.put("baseMapperName", "accountsMapper");
			} else if(mysqlUrl.contains("other")){
				resMap.put("baseMapperName", "otherMapper");
			} else if(mysqlUrl.contains("base")){
				resMap.put("baseMapperName", "baseMapper");
			} else if(mysqlUrl.contains("goods")){
				resMap.put("baseMapperName", "goodsMapper");
			} else if(mysqlUrl.contains("log")){
				resMap.put("baseMapperName", "logMapper");
			} else if(mysqlUrl.contains("order")){
				resMap.put("baseMapperName", "orderMapper");
			} else {
				resMap.put("baseMapperName", "");
			}
			
			//字段列表
			Map<String, Object> resultColumnMap = new HashMap<String, Object>();
			for(String column : columnMap.keySet()){
				//java字段
				String javaField = databaseField2JavaField(column);
				//java字段对应的字段类型
				resultColumnMap.put(javaField, columnMap.get(column));
			}
			resMap.put("dealField2Column", resultColumnMap);
			
			//自动生成文件
			if(db.equals("mysql")){
				FreemarkerUtil.createFile("xml_mysql.ftl", resMap, targetFile);
			} else if(db.equals("sqlserver")){
				FreemarkerUtil.createFile("xml_sqlserver.ftl", resMap, targetFile);
			}
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
			//表名
			resMap.put("tableName", tableName);
			//类名
			resMap.put("className", className);
			//包名后缀
			String packet = PropertiesUtil.getProperty("controller_packet");  
			resMap.put("packet", packet);
			resMap.put("modelPacket", PropertiesUtil.getProperty("model_packet"));
			resMap.put("servicePacket", PropertiesUtil.getProperty("service_packet"));
			
			//主键
			resMap.put("primaryKey", primaryKey);
			resMap.put("primaryKey2Java", this.databaseField2JavaField(primaryKey));
			
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
	public void generateList(String tableName,Map<String, Object> columnMap) {
		String className = dataTableName2ClassName(tableName);
		
		String fileName = firstWord2LowerCase(className) + "_list.ftl";
		if(PropertiesUtil.getProperty("template_folder_name").equals("templates_xym")){
			fileName = firstWord2LowerCase(className) + "_list.jsp";
		}
		
		try {
			tableName = tableName.toLowerCase();
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("page", fileName);
			//主键
			resMap.put("primaryKey", primaryKey);
			resMap.put("primaryKey2Java", this.databaseField2JavaField(primaryKey));
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
			resMap.put("fieldlist", resultColumnMap);
			
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
	 * @param field2Type 
	 */
	public void generateEdit(String tableName, Map<String, Object> columnMap) {
		String className = dataTableName2ClassName(tableName);
		
		String fileName = firstWord2LowerCase(className) + "_edit.ftl";
		if(PropertiesUtil.getProperty("template_folder_name").equals("templates_xym")){
			fileName = firstWord2LowerCase(className) + "_edit.jsp";
		}
		
		try {
			tableName = tableName.toLowerCase();
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("page", fileName);
			
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
			resMap.put("fieldlist", resultColumnMap);
			
			//主键
			resMap.put("primaryKey", primaryKey);
			resMap.put("primaryKey2Java", this.databaseField2JavaField(primaryKey));
			
			//自动生成文件
			FreemarkerUtil.createFile("edit.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + fileName + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + fileName + "失败!");
			System.out.println(e.getMessage());
		}	
	}
	
	/**
	 * detail
	 * @param tableName
	 * @param field2Type
	 */
	private void generateDetail(String tableName, Map<String, Object> field2Type) {
		String className = dataTableName2ClassName(tableName);
		
		String fileName = firstWord2LowerCase(className) + "_detail.ftl";
		if(PropertiesUtil.getProperty("template_folder_name").equals("templates_xym")){
			fileName = firstWord2LowerCase(className) + "_detail.jsp";
		}
		
		try {
			tableName = tableName.toLowerCase();
			//填充ftl的数据
			Map<String, Object> resMap = new HashMap<String, Object>();
			//文件生成路径
			String targetFile = targetFilePath("page", fileName);
			
			//字段列表
			Map<String, Object> resultColumnMap = new HashMap<String, Object>();
			for(String column : field2Type.keySet()){
				//java字段
				String javaField = databaseField2JavaField(column);
				//java字段对应的字段类型
				resultColumnMap.put(javaField, getColumnType(field2Type.get(column)));
			}
			resMap.put("fieldlist", resultColumnMap);
			
			//主键
			resMap.put("primaryKey", primaryKey);
			resMap.put("primaryKey2Java", this.databaseField2JavaField(primaryKey));
			
			//自动生成文件
			FreemarkerUtil.createFile("detail.ftl", resMap, targetFile);
			System.out.println("==================>创建文件 " + fileName + "成功!");	
		} catch (Exception e) {
			System.out.println("==================>创建文件 " + fileName + "失败!");
			System.out.println(e.getMessage());
		}	
	}

}
