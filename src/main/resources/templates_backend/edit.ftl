<#noparse><#include "/base-lib/baseMacro.ftl"></#noparse> 
<#noparse><@base base_title="编辑" openIndex=1 activeIndex=0></#noparse>
	
	<#-- @base 中间的内容将嵌套至 base 宏中的#nested处 -->
	<!-- 编辑区 -->
	<div class="row">
		<div class="col-sm-12 panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">编辑</h3>
			</div>
			<div class="panel-body">
				<form class="form-horizontal form" id="form" action="javascript:void(0);">
					<input type="hidden" name="id" value="<#noparse>${entity.id}</#noparse>">
					<div class="form-group">
						<div class="col-sm-3">
						</div>
						<div class="col-sm-3">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<button class="btn btn-info btn-icon" onclick="$.fn.doSaveAndJump('.form','/backend/${className?lower_case}/doSave','/backend/${className?lower_case}/list')">
								<span>提交</span>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 编辑区结束 -->

<script type="text/javascript">
$(function(){
	
});
</script>

<#noparse></@base></#noparse> 