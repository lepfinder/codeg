package {{project.packageName}}.service;
{% set entityName = entity.name | capitalize%}
import com.qding.framework.common.basemodel.ResultPage;
import {{project.packageName}}.SearchParams.{{entityName}}Params;
import {{project.packageName}}.common.ModelResult;
import {{project.packageName}}.domain.{{entityName}};

/**
 * Created by xiexiyang on 15/4/11.
 */
public interface I{{entityName}}Service {

    /**
     * 获取分页数据
     * @param {{entity.name}}Params
     * @return
     */
    ResultPage<{{entityName}}> getResultPage({{entityName}}Params {{entity.name}}Params);

    /**
     * 保存{{entity.name}}
     * @param {{entity.name}}
     * @return
     */
    ModelResult save{{entityName}}({{entityName}} {{entity.name}});

    /**
     * 更新{{entity.name}}
     * @param user {{entity.label}}
     * @return
     */
    ModelResult update{{entityName}}({{entityName}} {{entity.name}});

    /**
     * 根据ID获取{{entity.name}}
     * @param id
     * @return
     */
    ModelResult getById(Long id);

    /**
     * 删除{{entity.name}}
     * @param id
     * @return
     */
    ModelResult deleteById(Long id);
}
