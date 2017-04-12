package com.mybatis.generate.main;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mybatis.generate.db.DBManager;
import com.mybatis.generate.util.SqlUtil;

public class main {
	
	private static String tableName = "t_product";
	static List<String> tableColumsList = new ArrayList<String>();
	static Map<String, Object> field2Type = new HashMap<String, Object>();
	static Map<String, Object> field2Column = new HashMap<String, Object>();
	
	public static void main(String[] args) {
		//获取表字段
		getTable(tableName);
		if(tableColumsList.isEmpty()){
			System.out.println("表字段不存在");
			return;
		}
		//创建模板
		generate();
    }
	
	private static void generate() {
		System.out.println("==================>开始创建文件");
		Generate.generateModel(tableName, tableColumsList, field2Type);
		Generate.generateService(tableName);
		Generate.generateMapper(tableName);
		Generate.generateXml(tableName, tableColumsList, field2Type, field2Column);
		System.out.println("==================>结束创建文件");
	}

	/**
     * // 获得所有列的数目及实际列数
            	int columnCount = data.getColumnCount();
            	// 获得指定列的列名
            	String columnName = data.getColumnName(i);
            	// 获得指定列的列值
            	int columnType = data.getColumnType(i);
            	// 获得指定列的数据类型名
            	String columnTypeName = data.getColumnTypeName(i);
            	// 所在的Catalog名字
            	String catalogName = data.getCatalogName(i);
            	// 对应数据类型的类
            	String columnClassName = data.getColumnClassName(i);
            	// 在数据库中类型的最大字符个数
            	int columnDisplaySize = data.getColumnDisplaySize(i);
            	// 默认的列的标题
            	String columnLabel = data.getColumnLabel(i);
            	// 获得列的模式
            	String schemaName = data.getSchemaName(i);
            	// 某列类型的精确度(类型的长度)
            	int precision = data.getPrecision(i);
            	// 小数点后的位数
            	int scale = data.getScale(i);
            	// 获取某列对应的表名
            	String tableName = data.getTableName(i);
            	// 是否自动递增
            	boolean isAutoInctement = data.isAutoIncrement(i);
            	// 在数据库中是否为货币型
            	boolean isCurrency = data.isCurrency(i);
            	// 是否为空
            	int isNullable = data.isNullable(i);
            	// 是否为只读
            	boolean isReadOnly = data.isReadOnly(i);
            	// 能否出现在where中
            	boolean isSearchable = data.isSearchable(i);
     * @param tableName
     * @return
     */
    public static void getTable(String tableName) {
    	System.out.println("==================>开始查询表字段");
		Connection conn = null;
		Statement statement = null;
        ResultSet rs = null;
        try {
        	//1.获取Connection
        	conn = DBManager.getConnection();
        	//2.获取Statement
            statement = conn.createStatement();
            //3.准备Sql
            String sql = SqlUtil.sql_columns.replace("{0}", tableName);
            //4.执行查询，得到ResultSet
            rs = statement.executeQuery(sql);
            //5.处理ResultSet
            ResultSetMetaData data = rs.getMetaData();
            for (int i = 1; i <= data.getColumnCount(); i++) {
            	String columnName = data.getColumnName(i);
            	int columnType = data.getColumnType(i);
            	tableColumsList.add(columnName);
            	field2Type.put(columnName, columnType);
            	field2Column.put(columnName, data.getColumnName(i));
            }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
        System.out.println("==================>结束查询表字段");
	}
	
}
