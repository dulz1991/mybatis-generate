<#noparse><%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%></#noparse>
			
<div class="page-table" style="width:400px">
	<table class="table-form table-border table-form-col4">
	<#list fieldlist?keys as itemKey>
	<#if itemKey!=primaryKey2Java>
		<tr><th>${itemKey}</th><td><#noparse>${entity.</#noparse>${itemKey}}</td></tr>
	</#if>
	</#list>
	</table>
</div>

