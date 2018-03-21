package ${packet};

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.iTouch.store.commons.dao.${baseServiceName}DaoSupport;
import com.iTouch.store.commons.entity.Page;
import com.iTouch.store.commons.utils.PageData;
import ${modelPacket}.${className?cap_first}Info;
import com.iTouch.store.services.BaseBizService;

@Component  
public class ${className?cap_first}Service extends BaseBizService {
	@Resource(name = "${baseServiceName?uncap_first}DaoSupport")
    private ${baseServiceName}DaoSupport dao;
	
    /**
	 * 新增
	 * @param ${className?cap_first}Info 实体类
	 * @return
	 * @throws Exception
	 */
	public Boolean addEntity(${className?cap_first}Info ${className?uncap_first}) throws Exception {
		Object result = dao.save("${className?cap_first}Mapper.add", ${className?uncap_first});
		return crudResult(result);
	}
	public Boolean add(PageData pd) throws Exception {
		Object result = dao.save("${className?cap_first}Mapper.add", pd);
		return crudResult(result);
	}
    
    /**
	 * 更新
	 * @param ${className?cap_first}Info
	 * @return
	 * @throws Exception
	 */
    public Boolean updateEntity(${className?cap_first}Info ${className?uncap_first}) throws Exception {
		Object result = dao.update("${className?cap_first}Mapper.update", ${className?uncap_first});
		return crudResult(result);
	}
	public Boolean update(PageData pd) throws Exception {
		Object result = dao.update("${className?cap_first}Mapper.update", pd);
		return crudResult(result);
	}
	
	/**
	 * 根据ID获取实体
	 * @param ${primaryKey2Java} 主键ID
	 * @return
	 * @throws Exception
	 */
	public ${className?cap_first}Info getEntityById(String ${primaryKey2Java}) throws Exception {
		${className?cap_first}Info ${className?uncap_first} = (${className?cap_first}Info) dao.findForObject("${className?cap_first}Mapper.getEntity", ${primaryKey2Java});
		return ${className?uncap_first};
	}
	public PageData getEntityByPd(String ${primaryKey2Java}) throws Exception  {
		return (PageData) dao.findForObject("${className?cap_first}Mapper.getEntityForPd", ${primaryKey2Java});
	}
	
	/**
	 * 删除
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Boolean doDelete(PageData pd) throws Exception {
		if(pd==null){
			return false;
		}
		Object result = dao.delete("${className?cap_first}Mapper.delete", pd);
		return crudResult(result);
	}
	
	/**
	 * 分页查询
	 * 
	 * @param page 查询条件
	 * @return
	 * @throws Exception
	 */
	public List<${className?cap_first}Info> getEntitylistPage(Page page) throws Exception {
		return (List<${className?cap_first}Info>) dao.findForList("${className?cap_first}Mapper.getEntitylistPage", page);
	}
	public List<PageData> getPageDatalistPage(Page page) throws Exception {
		return (List<PageData>) dao.findForList("${className?cap_first}Mapper.getPageDatalistPage", page);
	}
	
}
