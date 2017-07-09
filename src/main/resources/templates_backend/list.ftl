<#noparse><#include "/base-lib/baseMacro.ftl"></#noparse> 
<#noparse><@base base_title="列表" openIndex=1 activeIndex=0></#noparse>
	
	<#-- @base 中间的内容将嵌套至 base 宏中的#nested处 -->
    	<!-- 搜索区 -->
			<div class="row">
				<div class="col-sm-12 panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">搜索区</h3>
					</div>
					<div class="panel-body">
						<form class="form-horizontal form" id="form" action="javascript:void(0);">
							<div class="form-group">
								<div class="col-sm-3">
									title
									<input type="text" class="form-control input" name="title" value="">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-2">
									<button class="btn btn-info btn-icon" onclick="$.fn.doAutoSearch()">
										<i class="fa-search"></i>
										<span>搜索</span>
									</button>
								</div>
							</div>
							
						</form>
					</div>
				</div>
			</div>
			<!-- 搜索区结束 -->
			
			<!-- 列表区 -->
			<div class="row">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">列表</h3>
						<div class="panel-options">
							<a href="#" data-toggle="reload" onclick="$.fn.reload()"><i class="fa-rotate-right"></i></a>
						</div>
					</div>
					<div class="panel-body">
						<table class="table table-bordered table-striped" id="datatable">
							<thead>
								<tr>
									<th width="60" field="index">编号</th>
									<th field="productName">产品名称</th>
									<th field="productTypeName">产品类别</th>
									<th field="productPrice">产品价格</th>
									<th field="productCount">库存数量</th>
									<th field="productStatusStr">产品状态</th>
									<th field="op" field-role="2,0" width="110"></th>
								</tr>
							</thead>
							<tbody class="middle-align"></tbody>
						</table>
						<div class="pagebar"></div>
					</div>
				</div>
			</div>
			<!-- 列表区结束 -->

<script type="text/javascript">
$(function(){
	$('#datatable').datatable({
		url_load : '/backend/${className}/getList',
		url_edit : '/backend/${className}/edit',
		url_remove : '/backend/${className}/doDelete',
		backFn : function(p) {
			// console.log(p);
		}
	}); 
	
});
</script>

<#noparse></@base></#noparse> 