package {{project.packageName}}.SearchParams;
{% set entityName = entity.name | capitalize%}
import com.google.common.collect.Maps;
import {{project.packageName}}.domain.{{entityName}};

import java.lang.reflect.Field;
import java.util.HashMap;

/**
 * Created by xiexiyang on 15/4/12.
 */
public class {{entityName}}Params extends {{entityName}}{

    public HashMap<String,Object> toParamsMap(){
        HashMap<String,Object> paramsMap = Maps.newHashMap();
        Field[] fieldList = this.getClass().getDeclaredFields();

        for(Field field : fieldList){
            try {
                field.setAccessible(true);
                paramsMap.put(field.getName(), field.get(this));
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }

        fieldList = this.getClass().getSuperclass().getDeclaredFields();

        for(Field field : fieldList){
            try {
                field.setAccessible(true);
                paramsMap.put(field.getName(), field.get(this));
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }

        return paramsMap;
    }
}
