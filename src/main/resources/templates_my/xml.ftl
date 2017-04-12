<?xml version="1.0" encoding="UTF-8" ?>   
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">  
<mapper namespace="com.demo.my.base.mybatis.mapper.ds1mapper.${className?cap_first}Mapper">

<resultMap type="com.demo.my.base.bean.${className?cap_first}" id="${className?cap_first}BaseMapper">
	<#list dealField2Column?keys as itemKey>
	<id property="${itemKey}" column="${dealField2Column[itemKey]}" />
	</#list>
</resultMap>  

<insert id="insert">
	<selectKey resultType="long" keyProperty="id">  
   		select LAST_INSERT_ID()
   	</selectKey>
	insert into ${className}
	(<#list dealField2Column?keys as itemKey>
	${dealField2Column[itemKey]},
	</#list>)
	values
	(<#list dealField2Column?keys as itemKey>
	<![CDATA[#]]>{${itemKey}},
	</#list>)
</insert>

<update id="update">
	UPDATE ${className} SET UPDATE_TIME=now()
	<if test="xx != null and xx != ''">  
        ,xx=<![CDATA[#]]>{xx}  
    </if>
    
    WHERE ID=<![CDATA[#]]>{id}
</update>

<delete id="delete">
	delete from ${className} where ID=<![CDATA[#]]>{id}
</delete>

<select id="getById" resultMap="${className?cap_first}BaseMapper">
	SELECT * FROM ${className} WHERE ID=<![CDATA[#]]>{id}
</select>

<select id="getBeanListByParm" resultMap="${className?cap_first}BaseMapper">
	
</select>

<select id="getBeanListByParm_count" resultType="integer">
	
</select>

<select id="getMapListByParm" parameterType="HashMap" resultType="HashMap">
	
</select>

<select id="getMapListByParm_count" resultType="integer">
	
</select>



</mapper>