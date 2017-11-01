<#noparse><#include "/base-lib/baseMacro.ftl"></#noparse> 
<#noparse><@base base_title="编辑数据" active_index=0 sub_active_index=0 data_type="widgets"></#noparse>
	
	 <div class="row widget am-cf">
	 	<div class="widget-head am-cf">
            <div class="widget-title am-fl">编辑页面</div>
        </div>
	 
        <div class="widget-body am-fr">
            <form class="am-form edit-form" role="form" javascript:;>
            	
            	<#list fieldlist?keys as itemKey>
            		<div class="am-form-group am-u-sm-6">
				    	${itemKey}<input type="text" name="${itemKey}" class="am-form-field">
				  	</div>
            	</#list>
            	
				<div class="am-form-group am-u-sm-12">
					<button type="button" class="am-btn am-btn-secondary am-radius" onclick="save()"><i class="am-icon-save"></i> 保存</button>
				</div>
			</form>
        </div>
	</div>

<script>
function save(){
	var parm = $.common.getFormJson('.edit-form');
	$.common.postRequest(parm, '/${className?uncap_first}/doSave?time='+new Date().getTime(), function(data){
		if(data.errorNo==0){
			self.location="/${className?uncap_first}/list";
		} else {
			$.common.tip(data.errorInfo);
		}
	})
}
</script>

<#noparse></@base></#noparse> 