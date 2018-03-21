<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
	"http://mybatis.org/dtd/mybatis-3-mapper.dtd">  
<mapper namespace="${className?cap_first}Mapper">

<resultMap type="${modelPacket}.${className?cap_first}Info" id="${className?cap_first}BaseMapper">
	<#list dealField2Column?keys as itemKey>
	<id property="${itemKey}" column="${dealField2Column[itemKey]}" />
	</#list>
</resultMap>  

<!-- 新增 -->
<insert id="add" parameterType="pd">
	<selectKey resultType="java.lang.String" order="BEFORE" keyProperty="tmpId">
            SELECT 1 AS tmpId FROM DUAL
        </selectKey>
	insert into ${tableName}
	<#assign i=0 />
	<#assign pos=1 />
	(<#list dealField2Column?keys as itemKey><#assign i=i+1 />
	<#if i&gt;pos>,</#if>${dealField2Column[itemKey]}</#list>)
	values
	<#assign i=0 />
	<#assign pos=1 />
	(<#list dealField2Column?keys as itemKey><#assign i=i+1 />
				<#if i&gt;pos>,</#if><#noparse>#{</#noparse>${itemKey}<#noparse>}</#noparse></#list>)
</insert>

<!-- 修改 -->
<update id="update" parameterType="pd">
	UPDATE ${tableName} 
	<set>
	<#list dealField2Column?keys as itemKey>
		<#if itemKey!=primaryKey2Java>
			<if test="${itemKey} != null and ${itemKey} != ''">  
	        	${dealField2Column[itemKey]}=<#noparse>#{</#noparse>${itemKey}},
	    	</if>
		</#if>
	</#list>
	</set>   
    WHERE ${primaryKey}=<#noparse>#{</#noparse>${primaryKey2Java}<#noparse>}</#noparse>
</update>

<!-- 删除 -->
<delete id="delete" parameterType="pd" flushCache="false">
	DELETE FROM ${tableName}
	WHERE
		${primaryKey} in
	<foreach item="item" index="index" collection="idsList" open="(" separator="," close=")">
		<#noparse>#{item,jdbcType=VARCHAR}</#noparse>
	</foreach>
</delete>

<!-- 单个数据查询 返回Java对象 -->
<select id="getEntity" resultMap="${className?cap_first}BaseMapper">
	SELECT * FROM ${tableName} WHERE ${primaryKey}=<#noparse>#{</#noparse>${primaryKey2Java}<#noparse>}</#noparse> 
</select>
<!-- 单个数据查询 返回PageData对象 字段统一驼峰式 -->
<select id="getEntityForPd" resultType="pd">
	SELECT 
	<#list dealField2Column?keys as itemKey>
	t1.${dealField2Column[itemKey]} ${itemKey} 
	</#list>
 	FROM ${tableName} t1 
 	WHERE t1.${primaryKey}=<#noparse>#{</#noparse>${primaryKey2Java}<#noparse>}</#noparse> 
</select>

<!-- 分页查询 返回实体对象 -->
<select id="getEntitylistPage" parameterType="page" resultMap="${className?cap_first}BaseMapper">
	select * from ${tableName} 
	where 1=1 
	<#list dealField2Column?keys as itemKey>
		<#if itemKey!=primaryKey2Java>
			<if test="pd.${itemKey} != null and pd.${itemKey} != ''">
		     	and ${dealField2Column[itemKey]} = <#noparse>#{pd.</#noparse>${itemKey}}
		   	</if>
	   	</#if>
	</#list>
	<#noparse>
		<if test="pd.orderby != null and pd.orderby != ''">
	   		order by ${parm.orderby}
	   	</if>
	</#noparse>
</select>

<!-- 分页查询 返回PageData对象 -->
<select id="getPageDatalistPage" parameterType="page" resultType="pd"> 
	SELECT 
	<#list dealField2Column?keys as itemKey>
	t1.${dealField2Column[itemKey]} ${itemKey} 
	</#list>
 	FROM ${tableName} t1 
 	where 1=1
 	<#list dealField2Column?keys as itemKey>
		<#if itemKey!=primaryKey2Java>
			<if test="pd.${itemKey} != null and pd.${itemKey} != ''">
		     	and t1.${dealField2Column[itemKey]} = <#noparse>#{pd.</#noparse>${itemKey}}
		   	</if>
	   	</#if>
	</#list>
	<#noparse>
		<if test="pd.orderby != null and pd.orderby != ''">
	   		order by ${parm.orderby}
	   	</if>
	</#noparse> 
</select>

</mapper>