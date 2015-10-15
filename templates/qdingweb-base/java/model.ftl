package {{project.packageName}}.domain;

import java.io.Serializable;
import java.util.*;


{% set entityName = entity.name[0].upper() + entity.name[1:]%}
/**
* {{entity.label}}
*/
public class {{entityName}} implements Serializable{
    {% for field in entity.fieldList %}
    /**
    * {{field.label}}
    */
    private {{field.javaType}} {{field.javaName }};
    {% endfor %}
    {% for field in entity.fieldList %}
    public {{field.javaType}} get{{field.javaName[0].upper() + field.javaName[1:]}}(){
        return {{field.javaName}};
    }

    public void set{{field.javaName[0].upper() + field.javaName[1:]}}({{field.javaType}} {{field.javaName}}){
        this.{{field.javaName}} = {{field.javaName}};
    }
    {% endfor %}
}