<#noparse><%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../basePage/basePage.jsp" %></#noparse>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>【未命名列表】</title>
</head>
<body>
	<div class="container-fluid">
		
		<!--标题栏-->
		<div class="page-header clearfix">
			<div class="title pull-left">
				<h4>【未命名列表】</h4>
			</div>
			<div class="pull-right">
				<div class="btn-group">
					<input type="button" value="新增" class="btn btn-success margin-right-5 " onclick="toEdit()" />
					<input type="button" value="删除" onclick="$.fn.deleteByIds()" class="btn btn-danger" />
				</div>
			</div>
		</div>
		<!--标题栏 结束-->

		<!--搜索区-->
		<div>
			<div class="page-search">
				<div class="search-row">
				<form class="form">
				<table style="border-collapse:separate; border-spacing:0px 10px;">
					<tr>
						<td>
							<label class="search-title" style="margin-left: 12px;">搜索内容</label>
							<input type="text" style="width:150px;" name="" class="form-control" />
						</td>
				 	</tr>
				</table>
				</form>  
				</div>
				<div class="search-rows-btn-bar">
					<input type="button" value=" 搜 索 " onclick="$.fn.autoSearch('.form')" class="btn btn-success rows-search-btn" />
				</div>
			</div>
			<!--搜索区 结束-->
			
			<!--列表区-->
			<div class='page-list'>
				<table id="GvList" class="table table-condensed">
					<thead>
						<tr>
							<th field="check_box" value="${primaryKey2Java}">
								<input type="checkbox" id="chkAll" />
							</th>
							<th field="index_no">排序号</th>
							<#list fieldlist?keys as itemKey>
							<th field="${itemKey}">${itemKey}</th>
							</#list>
							<th field="button" btn_list='[
			                {fnName:"toEdit",args:"${primaryKey2Java},【修改此字段】",name:"修改",cls:"btn btn-warning btn-xs margin-right-5"},
			                {fnName:"$.fn.deleteById",args:"${primaryKey2Java}",name:"删除",cls:"btn btn-danger btn-xs"}
			                ]'>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<div id="pageDiv"></div>
			</div>
		</div>
		<!-- 列表区 结束-->
	
	</div>

<script type="text/javascript">
	//渲染table
	$('#GvList').datatable({
	    url_load: '/${className?uncap_first}/getList.do', //加载数据
	    url_delete: '/${className?uncap_first}/toDelete.do' //删除
	});
	
	//编辑
	var saveUrl = '/${className?uncap_first}/doSave';
	function toEdit(${primaryKey2Java}, name){
		var title = "新增";
		var loadFormUrl = "/${className?uncap_first}/toEdit.do"; 
		if($.common.isNotBlank(${primaryKey2Java})){
			title = "修改 -- "+name;
			loadFormUrl += "?${primaryKey2Java}=" +${primaryKey2Java};
		}
		$.common.dialog(title,'',function(data){
			$.common.tip('保存成功');
			$.fn.reload();
		})
		$('#formId').load(loadFormUrl);
	}
	function formVerify(){
		var formData = $.common.getFormJson('#editForm');
		var result = "";
		$.common.postRequestSync(formData, saveUrl, function(res){
			if(res.errorNo!=0){
				result = res.errorInfo;
			}
		})
		return result;
	}
    </script>

</body>
</html>