package com.mybatis.generate.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;

public class PropertiesUtil {
	
	public static Properties prop = null;
	static {
		prop = new Properties();
		try{
			//读取属性文件a.properties
			String path = Thread.currentThread().getContextClassLoader().getResource("jdbc.properties").toString(); 
			path = path.replaceAll("file:/", "");
			InputStream in = new BufferedInputStream(new FileInputStream(path));
			
			prop.load(in);     ///加载属性列表
            /*Iterator<String> it=prop.stringPropertyNames().iterator();
            while(it.hasNext()){
                String key=it.next();
                System.out.println(key+":"+prop.getProperty(key));
            }*/
            in.close();
            
            ///保存属性到b.properties文件
            /*FileOutputStream oFile = new FileOutputStream("b.properties", true);//true表示追加打开
            prop.setProperty("phone", "10086");
            prop.store(oFile, "The New properties file");
            oFile.close();*/
        }
        catch(Exception e){
            System.out.println(e);
        }
	}
	      
	public static String getProperty(String key) {
		return prop.getProperty(key);
	}
	
	public static String getProperty(String key, String defaultValue) {
		if(StringUtils.isBlank(defaultValue)){
			defaultValue = StringUtils.EMPTY;
		}
		String result = prop.getProperty(key);
		if(StringUtils.isBlank(result)){
			return defaultValue;
		} else {
			return result;
		}
	}
	          
}
