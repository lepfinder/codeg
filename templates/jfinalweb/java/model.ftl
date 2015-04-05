package {{project.packageName}}.{{entity.name}};

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import java.util.Date;
import com.jfinal.log.Logger;

{% set entityName = entity.name | capitalize%}
@SuppressWarnings("serial")
public class {{entityName}} extends Model<{{entityName}}> {

    private static final Logger LOG = Logger.getLogger({{entityName}}.class);

	public static final {{entityName}} DAO = new {{entityName}}();
	{% for field in entity.fieldList %}
	public {{field.javaType}} get{{field.javaName | capitalize}}(){
		return get("{{field.javaName}}");
	}

	public void set{{field.javaName | capitalize}}({{field.javaType}} {{field.javaName}}){
		set("{{field.javaName}}",{{field.javaName}});
	}
	{% endfor %}
	public Page<{{entityName}}> page(int pageNumber, int pageSize) {
		return paginate(pageNumber, pageSize, "select *","from {{entity.name}} order by id asc");
	}
}