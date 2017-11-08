package {{project.packageName}}.dao;
{% set entityName = entity.name[0].upper() + entity.name[1:]%}
import {{project.packageName}}.domain.{{entityName}};
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository("{{entity.name}}Dao")
public interface I{{entityName}}Dao {

    Long insert({{entityName}} {{entity.name}});

    Long updateById({{entityName}} {{entity.name}});

    Long batchInsert(List<{{entityName}}> list);

    {{entityName}} selectById(String id);

    List<{{entityName}}> getPageListByParam(HashMap<String, Object> param);

    Integer getPageCountByParam(HashMap<String, Object> paramMap);

    void deleteById(String id);

}
