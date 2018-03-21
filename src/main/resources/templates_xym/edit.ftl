<#noparse><%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%></#noparse>
			
<form id="editForm" class="form-horizontal col-sm-12">
	<input type="hidden" name="${primaryKey2Java}" value="<#noparse>${entity.</#noparse>${primaryKey2Java}}">

	<#list fieldlist?keys as itemKey>
	<#if itemKey!=primaryKey2Java><div class="form-group">
		<label class="col-sm-12 control-label">${itemKey}</label>
		<div class="col-sm-12">
			<input class="form-control" name="${itemKey}" value="<#noparse>${entity.</#noparse>${itemKey}}" type="text">
		</div>
	</div></#if>
		
	</#list>
</form>
