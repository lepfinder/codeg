package {{project.packageName}}.SearchParams;
{% set entityName = entity.name[0].upper() + entity.name[1:]%}
import com.google.common.collect.Maps;
import {{project.packageName}}.domain.{{entityName}};

import java.lang.reflect.Field;
import java.util.HashMap;

/**
 * Created by xiexiyang on 15/4/12.
 */
public class {{entityName}}Params extends {{entityName}}{
    private int page;

    private int size;

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

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
