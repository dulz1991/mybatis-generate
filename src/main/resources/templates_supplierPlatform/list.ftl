<#noparse><#include "/base-lib/baseMacro.ftl"></#noparse> 
<#noparse><@base base_title="后台管理" active_index=0 sub_active_index=0 data_type="widgets"></#noparse>
    
    <#noparse><@searchForm></#noparse>
    	<#list fieldlist?keys as itemKey>
		<div class="am-form-group am-u-sm-3">
	    	<input type="text" name="${itemKey}" class="am-form-field" placeholder="${itemKey}">
	  	</div>
	  	</#list>
	  	
	  	<div class="am-form-group am-form-select am-u-sm-3">
	  		<#noparse><@select id="selectId" datas={"0":"选项1","1":"选项2"} value="0" /></#noparse>
	  	</div>
		
		<div class="am-form-group am-u-sm-3">
			<#noparse><@btnSearch onclick="$.fn.autoSearch('.search-form')" /></#noparse>
		</div>	
	<#noparse><@searchForm></#noparse>
        
    <#noparse><@dataTable pageId="pageDiv" tableClass="am-table am-table-striped am-table-hover am-table-bordered"></#noparse>
		<thead>
            <tr>
            	<#list fieldlist?keys as itemKey>
            		<th field="${itemKey}">${itemKey}</th>
            	</#list>
            	<th field="button" btn_list='[{fnName:"edit",keys:"id",name:"编辑"}]'>操作</th>
            </tr>
        </thead>
        <tbody>
        	<tr>
        		<td>数据加载中...</td>
        	</tr>
        </tbody>
    <#noparse><@dataTable></#noparse>
    
    <script>
    //数据绑定
    $('#dataTable').datatable({
		url_load : '/${className?uncap_first}/getList',
		parm:{
			pageNo : 1,
			pageSize : 10
		},
		backFn : function(p) {
			// console.log(p);
		}
	}); 
	
	
	function edit(obj){
	}
	
    </script>
    
<#noparse></@base></#noparse>