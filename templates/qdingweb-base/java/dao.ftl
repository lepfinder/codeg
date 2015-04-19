package {{project.packageName}}.dao;
{% set entityName = entity.name | capitalize%}
import {{project.packageName}}.domain.{{entityName}};

import java.util.HashMap;
import java.util.List;

public interface I{{entityName}}Dao {

    public Long insert({{entityName}} {{entity.name}});

    public Long insertSelective({{entityName}} {{entity.name}});

    public void updateById({{entityName}} {{entity.name}});
    
    public void updateByIdSelective({{entityName}} {{entity.name}});

    public {{entityName}} selectById(Long id);

    public List<{{entityName}}> getPageListByParam(HashMap<String, Object> param);

    public Integer getPageCountByParam(HashMap<String, Object> paramMap);

    public void deleteById(Long id);

}
