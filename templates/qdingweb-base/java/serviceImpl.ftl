package {{project.packageName}}.service.impl;
{% set entityName = entity.name[0].upper() + entity.name[1:]%}
import com.qding.framework.common.basemodel.ResultPage;
import {{project.packageName}}.SearchParams.{{entityName}}Params;
import {{project.packageName}}.common.ModelResult;
import {{project.packageName}}.common.PageUtil;
import {{project.packageName}}.dao.I{{entityName}}Dao;
import {{project.packageName}}.domain.{{entityName}};
import {{project.packageName}}.service.I{{entityName}}Service;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * Created by xiexiyang on 15/4/11.
 */
@Service("{{entity.name}}Service")
public class {{entityName}}ServiceImpl implements I{{entityName}}Service {

    @Resource(name="{{entity.name}}Dao")
    private I{{entityName}}Dao {{entity.name}}Dao;

    @Override
    public ResultPage<{{entityName}}> getResultPage({{entityName}}Params {{entity.name}}Params) {
        ResultPage<{{entityName}}> resultPage = null;
        HashMap<String, Object> param = {{entity.name}}Params.toParamsMap();
        //格式化分页数据
        param = PageUtil.getPageMap(param);
        //查询总数
        Integer totalCount = {{entity.name}}Dao.getPageCountByParam(param);
        //查询列表
        List<{{entityName}}> list = {{entity.name}}Dao.getPageListByParam(param);
        resultPage = new ResultPage<{{entityName}}>(totalCount, (Integer) param.get("pageSize"), (Integer) param.get("pageNo"), list);
        return resultPage;
    }

    @Override
    public {{entityName}} save{{entityName}}({{entityName}} {{entity.name}}) {
        {{entity.name}}Dao.insert({{entity.name}});

        return {{entity.name}};
    }

    @Override
    public {{entityName}} update{{entityName}}({{entityName}} {{entity.name}}) {
        {{entity.name}}Dao.updateByIdSelective({{entity.name}});

        return {{entity.name}};
    }

    @Override
    public {{entityName}} getById(Long id) {
        
        {{entityName}} {{entity.name}} = {{entity.name}}Dao.selectById(id);

        return {{entity.name}};
    }

    @Override
    public void deleteById(Long id) {
       
        {{entity.name}}Dao.deleteById(id);

    }
}
