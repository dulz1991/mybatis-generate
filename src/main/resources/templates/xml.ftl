<?xml version="1.0" encoding="UTF-8" ?>   
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">  
<mapper namespace="com.sqe.shop.mapper.${className?cap_first}Mapper">

<resultMap type="com.sqe.shop.model.${className?cap_first}" id="${className?cap_first}BaseMapper">
	<#list dealField2Column?keys as itemKey>
	<id property="${itemKey}" column="${dealField2Column[itemKey]}" />
	</#list>
</resultMap>  

<insert id="insert">
	<selectKey resultType="long" keyProperty="id">  
   		select LAST_INSERT_ID()
   	</selectKey>
	insert into ${tableName}
	(<#list dealField2Column?keys as itemKey>
	${dealField2Column[itemKey]},
	</#list>)
	values
	(<#list dealField2Column?keys as itemKey>
	<#noparse>#{</#noparse>${itemKey}<#noparse>}</#noparse>,
	</#list>)
</insert>

<update id="update">
	UPDATE ${tableName} 
	<set>
	<#list dealField2Column?keys as itemKey>
		<if test="${itemKey} != null">  
        	${dealField2Column[itemKey]}=${itemKey}
    	</if>
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
		<if test="parm.${itemKey} != null">
	     	and ${dealField2Column[itemKey]} = <#noparse>#{parm.</#noparse>${itemKey}}
	   	</if>
	</#list>
</select>

<select id="getBeanListByParm" resultMap="${className?cap_first}BaseMapper">
	select * from ${tableName} where 1=1 
	<#list dealField2Column?keys as itemKey>
		<if test="parm.${itemKey} != null">
	     	and ${dealField2Column[itemKey]} = <#noparse>#{parm.</#noparse>${itemKey}}
	   	</if>
	</#list>
	<#noparse>
		<if test="parm.start != null">
		limit ${parm.start},${parm.limit}
		</if>
	</#noparse>
</select>


<select id="getMapListByParm" parameterType="HashMap" resultType="HashMap">
	select * from ${className} where 1=1 
</select>


</mapper>