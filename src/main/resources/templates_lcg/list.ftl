<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>xxx</title>
	<jsp:include page="../include/meta.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../include/head.jsp"></jsp:include>
	
	<div class="down-main">
		<jsp:include page="../include/left.jsp"></jsp:include>
		
		<!-- 主内容区 -->
		<div class="right-product view-product right-full">
    		<div class="container-fluid">
    			<div class="info-center">
    				<div class="page-header">
	                      <div class="pull-left">
							<h4>xxx</h4>      
						</div>
	                </div>
    			</div>
    			<br>
    			
	   			<!-- table区 -->
	   			<div class="table-margin">
	   				<div class="margin-bottom">
   						<a href="javascript:;" class="navbar-mystyle padding hover-color-white" onclick="edit()">
							<i class="glyphicon glyphicon-plus"></i>添加
						</a>
					</div>
					<table id="datatable" class="table table-bordered table-hover bg-white">
						<thead class="navbar-mystyle" >
							<tr>
								<th field="check_box" value="${primaryKey2Java}">
									<input type="checkbox" id="chkAll" />
								</th>
								<th field="index_no" width="50">序号</th>
								<#list fieldlist?keys as itemKey>
								<th field="${itemKey}">${itemKey}</th>
								</#list>
								<th field="button" btn_list='[
				                {fnName:"edit",args:"${primaryKey2Java}",name:"修改",cls:"button bg-orange button-xs margin-right-5"},
				                {fnName:"$.fn.deleteById",args:"${primaryKey2Java}",name:"删除",cls:"button bg-red button-xs"}
				                ]'>操作</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
					<div id="pageDiv"></div>
	   			</div>
	   			<!-- table区 结束 -->
			</div>
		</div>
		<!-- 主内容区 结束 -->
	</div>
	
	<script type="text/javascript">
		$(function(){
			$('#datatable').datatable({
				url_load : '/${className?uncap_first}/getList',
				backFn : function(p) {
					
				}
			}); 
		});
		
		// 修改
		function edit(id){
			var parm = {};
			if($.common.isNotBlank(id)){
				parm.loadUrl = '/${className?uncap_first}/edit?id='+id;
			} else {
				parm.loadUrl = '/${className?uncap_first}/edit';
			}
			$.common.dialog(parm, editVerify, function(data){
				$.common.success("保存成功");
				$.fn.reload();
			});
		}
		function editVerify(){
			var formData = $.common.getFormJson('#editForm');
			var rst = '';
			$.common.postSync(formData, '/${className?uncap_first}/doSave', function(data){
				if(data.errorNo!=0){
					rst = data.errorInfo;
				}
			});
			return rst;
		}
	</script>
	
</body>
</html>