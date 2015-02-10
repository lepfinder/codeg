package {{project.packageName}}.{{entity.name}};

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class {{entity.name|capitalize}}Validator extends Validator {
	
	protected void validate(Controller controller) {
		 {% for field in entity.fieldList %}
    		{% if field.isPrimaryKey!="1" %}
				{% if field.type=="String" %}
			validateString("{{entity.name}}.{{field.name}}", 0, {{field.longness}}, "{{field.name}}ErrMsg", "长度超过指定范围");
				{% endif %}
			 {% endif %}
    	{% endfor %}
			
	}
	
	protected void handleError(Controller controller) {
		
		controller.keepModel({{entity.name|capitalize}}.class);
		
		String actionKey = getActionKey();
		if (actionKey.equals("/{{entity.name}}/save")){
			controller.render("add.html");
		}
		else if (actionKey.equals("/{{entity.name}}/update")){
			controller.render("edit.html");
		}
	}
}
