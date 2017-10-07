package com.mybatis.generate.db;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.mybatis.generate.util.PropertiesUtil;

public class SqlServerDBManager {
	
	private static SqlServerDBManager instance=null;    
    private static ComboPooledDataSource cpds=new ComboPooledDataSource(true);     
        
    static{    
        cpds.setDataSourceName("sqlServerDatasource");    
        cpds.setJdbcUrl(PropertiesUtil.getProperty("jdbc.sqlserver.url"));    
        try {    
            cpds.setDriverClass(PropertiesUtil.getProperty("jdbc.sqlserver.driverClassName"));    
        } catch (PropertyVetoException e) {    
            e.printStackTrace();    
        }    
        cpds.setUser(PropertiesUtil.getProperty("jdbc.sqlserver.username"));    
        cpds.setPassword(PropertiesUtil.getProperty("jdbc.sqlserver.password"));    
        cpds.setMaxPoolSize(Integer.valueOf(PropertiesUtil.getProperty("jdbc.maxPoolSize")));    
        cpds.setMinPoolSize(Integer.valueOf(PropertiesUtil.getProperty("jdbc.minPoolSize")));    
        cpds.setAcquireIncrement(Integer.valueOf(PropertiesUtil.getProperty("jdbc.acquireIncrement")));    
        cpds.setInitialPoolSize(Integer.valueOf(PropertiesUtil.getProperty("jdbc.initialPoolSize")));    
        cpds.setMaxIdleTime(Integer.valueOf(PropertiesUtil.getProperty("jdbc.maxIdleTime")));    
    }    
        
    private SqlServerDBManager(){}    
        
    public static SqlServerDBManager getInstance(){    
    	if(instance==null){
    		instance = new SqlServerDBManager();
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
