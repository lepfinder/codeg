package {{project.packageName}}.{{entity.name}};

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

public class {{entity.name|capitalize}}Validator extends Validator {
	
	protected void validate(Controller controller) {
		 
			
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
