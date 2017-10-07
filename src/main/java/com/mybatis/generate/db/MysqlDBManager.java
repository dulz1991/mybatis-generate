package com.mybatis.generate.db;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.mybatis.generate.util.PropertiesUtil;

public class MysqlDBManager {
	
	private static MysqlDBManager instance= null;    
    private static ComboPooledDataSource cpds = new ComboPooledDataSource(true);     
        
    static{    
        cpds.setDataSourceName("mysqlDatasource");    
        cpds.setJdbcUrl(PropertiesUtil.getProperty("jdbc.mysql.url"));    
        try {    
            cpds.setDriverClass(PropertiesUtil.getProperty("jdbc.mysql.driverClassName"));    
        } catch (PropertyVetoException e) {    
            e.printStackTrace();    
        }    
        cpds.setUser(PropertiesUtil.getProperty("jdbc.mysql.username"));    
        cpds.setPassword(PropertiesUtil.getProperty("jdbc.mysql.password"));    
        cpds.setMaxPoolSize(Integer.valueOf(PropertiesUtil.getProperty("jdbc.maxPoolSize")));    
        cpds.setMinPoolSize(Integer.valueOf(PropertiesUtil.getProperty("jdbc.minPoolSize")));    
        cpds.setAcquireIncrement(Integer.valueOf(PropertiesUtil.getProperty("jdbc.acquireIncrement")));    
        cpds.setInitialPoolSize(Integer.valueOf(PropertiesUtil.getProperty("jdbc.initialPoolSize")));    
        cpds.setMaxIdleTime(Integer.valueOf(PropertiesUtil.getProperty("jdbc.maxIdleTime")));    
    }    
        
    private MysqlDBManager(){}    
        
    public static MysqlDBManager getInstance(){
    	if(instance==null){
    		instance = new MysqlDBManager();
    	}
        return instance;    
    }    
        
    public static Connection getConnection(){    
        try {    
            return cpds.getConnection();    
        } catch (SQLException e) {    
            e.printStackTrace();    
        }    
        return null;    
    }
    
}
