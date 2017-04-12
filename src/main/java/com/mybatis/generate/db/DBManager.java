package com.mybatis.generate.db;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.mybatis.generate.util.PropertiesUtil;
import com.mybatis.generate.util.SqlUtil;

public class DBManager {
	
	private static final DBManager instance=new DBManager();    
    private static ComboPooledDataSource cpds=new ComboPooledDataSource(true);     
        
    /**  
     * 此处可以不配置，采用默认也行  
     */    
    static{    
        cpds.setDataSourceName("mydatasource");    
        cpds.setJdbcUrl(PropertiesUtil.getProperty("jdbc.url"));    
        try {    
            cpds.setDriverClass(PropertiesUtil.getProperty("jdbc.driverClassName"));    
        } catch (PropertyVetoException e) {    
            e.printStackTrace();    
        }    
        cpds.setUser(PropertiesUtil.getProperty("jdbc.username"));    
        cpds.setPassword(PropertiesUtil.getProperty("jdbc.password"));    
        cpds.setMaxPoolSize(Integer.valueOf(PropertiesUtil.getProperty("jdbc.maxPoolSize")));    
        cpds.setMinPoolSize(Integer.valueOf(PropertiesUtil.getProperty("jdbc.minPoolSize")));    
        cpds.setAcquireIncrement(Integer.valueOf(PropertiesUtil.getProperty("jdbc.acquireIncrement")));    
        cpds.setInitialPoolSize(Integer.valueOf(PropertiesUtil.getProperty("jdbc.initialPoolSize")));    
        cpds.setMaxIdleTime(Integer.valueOf(PropertiesUtil.getProperty("jdbc.maxIdleTime")));    
    }    
        
    private DBManager(){}    
        
    public static DBManager getInstance(){    
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
