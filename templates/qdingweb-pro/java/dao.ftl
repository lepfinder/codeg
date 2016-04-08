package {{project.packageName}}.dao;
{% set entityName = entity.name[0].upper() + entity.name[1:]%}
import {{project.packageName}}.domain.{{entityName}};

import java.util.HashMap;
import java.util.List;

public interface I{{entityName}}Dao {

    public Long insert({{entityName}} {{entity.name}});

    public Long batchInsert(List<{{entityName}}> list);

    public {{entityName}} selectById(Long id);

    public List<{{entityName}}> getPageListByParam(HashMap<String, Object> param);

    public Integer getPageCountByParam(HashMap<String, Object> paramMap);

    public void deleteById(Long id);

}
