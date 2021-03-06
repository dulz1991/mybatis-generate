<?xml version="1.0" encoding="UTF-8" ?>   
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">  
<mapper namespace="com.org.linchige.mybatis.mapper.${className?cap_first}Mapper">

<resultMap type="com.org.linchige.model.${className?cap_first}" id="${className?cap_first}BaseMapper">
	<#list dealField2Column?keys as itemKey>
	<id property="${itemKey}" column="${dealField2Column[itemKey]}" />
	</#list>
</resultMap>  

<insert id="insert">
	<selectKey resultType="long" keyProperty="id">  
   		select LAST_INSERT_ID()
   	</selectKey>
	insert into ${tableName}
	<#assign i=0 />
	<#assign pos=1 />
	(<#list dealField2Column?keys as itemKey><#assign i=i+1 /><#if itemKey!="id"><#if i&gt;pos>,</#if>${dealField2Column[itemKey]}<#else><#assign pos=pos+1 /></#if></#list>)
	values
	<#assign i=0 />
	<#assign pos=1 />
	(<#list dealField2Column?keys as itemKey><#assign i=i+1 /><#if itemKey!="id"><#if i&gt;pos>,</#if><#noparse>#{</#noparse>${itemKey}<#noparse>}</#noparse><#else><#assign pos=pos+1 /></#if></#list>)
</insert>

<update id="update">
	UPDATE ${tableName} 
	<set>
	<#list dealField2Column?keys as itemKey>
		<#if itemKey!="id">
			<if test="${itemKey} != null">  
	        	${dealField2Column[itemKey]}=<#noparse>#{</#noparse>${itemKey}},
	    	</if>
		</#if>
	</#list>
	</set>   
    WHERE id=<#noparse>#{id}</#noparse>
</update>

<delete id="delete">
	delete from ${tableName} where id=<#noparse>#{id}</#noparse>
</delete>

<select id="getById" resultMap="${className?cap_first}BaseMapper">
	SELECT * FROM ${tableName} WHERE id=<#noparse>#{id}</#noparse> 
</select>

<select id="countByParm" resultType="integer">
	select count(*) from ${tableName}  where 1=1 
	<#list dealField2Column?keys as itemKey>
		<#if itemKey!="id">
			<if test="parm.${itemKey} != null">
		     	and ${dealField2Column[itemKey]} = <#noparse>#{parm.</#noparse>${itemKey}}
		   	</if>
		</#if>
	</#list>
</select>

<select id="getBeanListByParm" resultMap="${className?cap_first}BaseMapper">
	select * from ${tableName} where 1=1 
	<#list dealField2Column?keys as itemKey>
		<#if itemKey!="id">
			<if test="parm.${itemKey} != null">
		     	and ${dealField2Column[itemKey]} = <#noparse>#{parm.</#noparse>${itemKey}}
		   	</if>
	   	</#if>
	</#list>
	<#noparse>
		<if test="parm.orderby != null">
	   		order by ${parm.orderby}
	   	</if>
		<if test="parm.start != null">
			limit #{parm.start},#{parm.limit}
		</if>
	</#noparse>
</select>


<select id="getMapListByParm" parameterType="HashMap" resultType="HashMap">
	select * from ${tableName} where 1=1
	<#noparse>
		<if test="parm.orderby != null">
	   		order by ${parm.orderby}
	   	</if>
		<if test="parm.start != null">
			limit #{parm.start},#{parm.limit}
		</if>
	</#noparse> 
</select>


</mapper>