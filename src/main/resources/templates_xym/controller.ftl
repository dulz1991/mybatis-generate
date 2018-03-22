package ${packet};

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import ${servicePacket}.${className?cap_first}Service;
import ${modelPacket}.${className?cap_first}Info;
import com.iTouch.store.commons.controller.BaseController;
import com.iTouch.store.commons.entity.Page;
import com.iTouch.store.commons.utils.PageData;
import com.iTouch.store.commons.utils.PopupMsgUtil;
import com.iTouch.store.commons.utils.UuidUtil;
import com.iTouch.store.commons.result.BaseResult;

@Controller
@RequestMapping("/${className?uncap_first}")
public class ${className?cap_first}Controller extends BaseController {
	private static final Log log = LogFactory.getLog(${className?cap_first}Controller.class);
	
	@Autowired
	private ${className?cap_first}Service ${className?uncap_first}Service;
	
	/**
	 * 访问列表页面
	 * @return 返回页面
	 */
	@RequestMapping(value="/listPage")
	public ModelAndView index() {
		ModelAndView model = new ModelAndView("${className?uncap_first}/${className?uncap_first}_list.jsp");
		return model;
	}
	/**
	 * 异步查询列表数据
	 * @param page
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/getList")
	public Map<String, Object> getList(Page page) {
		try {
			Map<String, Object> map = BaseResult.responseOK("");
			PageData pd = this.getPageData(); 
			page.setPd(pd);
			// 如果是多表查询使用PageData key使用小写 驼峰式
			List<${className?cap_first}Info> list = ${className?uncap_first}Service.getEntitylistPage(page);
			map.put("list", list);
			map.put("page", page);
			return map;
		} catch (Exception e) {
			return BaseResult.responseSystemError(e);
		}
	}
	
	/**
	 * 详情页
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/toDetail")
	public ModelAndView toDetail(String ${primaryKey2Java}) {
		try {
			ModelAndView model = new ModelAndView("report/${className?uncap_first}_detail.jsp");
			if(StringUtils.isNotBlank(id)){
				${className?cap_first}Info entity = ${className?uncap_first}Service.getEntityById(${primaryKey2Java});
				model.addObject("entity", entity);
			} else {
				PopupMsgUtil.alertMsg(response, "参数异常");
				return null;
			}
			return model;
		} catch (Exception e) {
			PopupMsgUtil.alertMsg(response, "系统异常");
			return null;
		}
	}
	
	/**
	 * 编辑页面
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/toEdit")
	public ModelAndView toEdit(String ${primaryKey2Java}) {
		try {
			ModelAndView model = new ModelAndView("${className?uncap_first}/${className?uncap_first}_edit.jsp");
			if(StringUtils.isNotBlank(${primaryKey2Java})){
				${className?cap_first}Info entity = ${className?uncap_first}Service.getEntityById(id);
				model.addObject("entity", entity);
			} else {
				model.addObject("entity", new ${className?cap_first}Info());
			}
			return model;
		} catch (Exception e) {
			PopupMsgUtil.alertMsg(response, "系统异常");
			return null;
		}
	}
	
	/**
	* 保存数据
	*/
	@ResponseBody
	@RequestMapping(value="/doSave")
	public Map<String, Object> save(${className?cap_first}Info ${className?uncap_first}) {
		// TODO 后台校验
		
		try {
			Boolean result = false; 
			if(StringUtils.isBlank(${className?uncap_first}.get${primaryKey2Java?cap_first}())){
				orderLordReport.setId(UuidUtil.get32UUID());
				result = ${className?uncap_first}Service.addEntity(${className?uncap_first});
			} else {
				result = ${className?uncap_first}Service.updateEntity(${className?uncap_first});
			}
			if(result){
				return BaseResult.responseOK("");
			} else {
				return BaseResult.responseGeneralError("保存失败");
			}
		} catch (Exception e) {
			return BaseResult.responseSystemError(e);
		}
	}
	
	/**
     * 根据id批量删除
     */
    @RequestMapping("toDelete")
    @ResponseBody
    public Map<String, Object> toDelete(String ids) {
        if(StringUtils.isNotBlank(ids)){
            return BaseResult.responseGeneralError("请选择需要删除的记录！");
        }
        
        if (ids.charAt(ids.length() - 1) == ',') {
			ids = ids.substring(0, ids.length() - 1);
		}
		String idArry[] = ids.split(",");
		if (idArry == null || idArry.length == 0) {
			return BaseResult.responseGeneralError("请选择需要删除的记录！");
		}
		List<String> idsList = new ArrayList<String>();
		for (int i = 0; i < idArry.length; i++) {
			try {
				String id = idArry[i];
				idsList.add(id);
			} catch (Exception e) {
				continue;
			}
		}
		if (idsList == null || idsList.size() == 0) {
			return BaseResult.responseGeneralError("请选择需要删除的记录！");
		}
		
        Boolean delResult = false;
        try {
        	PageData pd = new PageData();
        	pd.put("idsList", idsList);
            delResult = ${className?uncap_first}Service.doDelete(pd);
            if (delResult) {
                return BaseResult.responseOK("");
            } else {
            	return BaseResult.responseGeneralError("删除失败，请重试！");
            }
        } catch (Exception e) {
            return BaseResult.responseSystemError(e);
        }
    }

}
