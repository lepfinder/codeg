package {{project.packageName}}.domain;

import java.io.Serializable;
import java.util.List;

{% set entityName = entity.name | capitalize%}
public class {{entityName}} implements Serializable{

    {% for field in entity.fieldList %}
    /**
    * {{field.label}}
    */
    private {{field.javaType}} {{field.javaName }};
    {% endfor %}
    {% for field in entity.fieldList %}
    public {{field.javaType}} get{{field.javaName | capitalize}}(){
        return {{field.javaName}};
    }

    public void set{{field.javaName | capitalize}}({{field.javaType}} {{field.javaName}}){
        this.{{field.javaName}} = {{field.javaName}};
    }
    {% endfor %}
    
}