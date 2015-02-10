package {{project.packageName}}.{{entity.name}};

import com.jfinal.ext.interceptor.pageinfo.PageInfoInterceptor;

public class {{entity.name|capitalize}}Searcher extends PageInfoInterceptor {
	public void config() {
		setModel({{entity.name|capitalize}}.class);
	}
}
