<#noparse><#include "/base-lib/baseMacro.ftl"></#noparse> 
<#noparse><@base base_title="后台管理" active_index=0 sub_active_index=0 data_type="widgets"></#noparse>
    <div class="row widget am-cf">
        <div class="widget-body am-fr">
            <form class="am-form search-form" role="form" javascript:;>
            	
            	<#list fieldlist?keys as itemKey>
				<div class="am-form-group am-u-sm-3">
			    	<input type="text" name="${itemKey}" class="am-form-field" placeholder="${itemKey}">
			  	</div>
			  	</#list>
			  	
			  	<div class="am-form-group am-form-select am-u-sm-3">
			  		<#noparse><@select id="selectId" datas={"0":"选项1","1":"选项2"} value="0" /></#noparse>
			  	</div>
				
				<button type="button" class="am-btn am-btn-default" onclick="$.fn.autoSearch('.search-form')">搜索</button>
			</form>
        </div>
	</div>
        
     <div class="row widget am-cf">
        <div class="am-u-sm-12 am-u-md-12 am-u-lg-12">
            <div class="">
                
                <div class="widget-body  am-fr">
                    <div class="am-u-sm-12">
                        <table width="100%" class="am-table am-table-compact am-table-striped tpl-table-black"  id="dataTable">
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
                        </table>
                    </div>
                    <div id="pageDiv"></div>
                </div>
                
            </div>
        </div>
    </div>
    
    <script>
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