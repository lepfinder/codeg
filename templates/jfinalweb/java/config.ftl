package {{project.packageName}};

{% for entity in project.entityList %}
import {{project.packageName}}.{{entity.name}}.*;
{% endfor %}

import com.alibaba.druid.filter.stat.StatFilter;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.tx.TxByRegex;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.activerecord.dialect.MysqlDialect;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.render.ViewType;
public class {{project.name | capitalize}}Config extends JFinalConfig {
	
	public void configConstant(Constants me) {
		loadPropertyFile("config.txt");
		me.setDevMode(getPropertyToBoolean("devMode", false));
		me.setViewType(ViewType.FREE_MARKER);
	}
	
	public void configRoute(Routes me) {
		me.add("/",IndexController.class);
		{% for entity in project.entityList %}
		me.add("/{{entity.name}}", {{entity.name | capitalize}}Controller.class);
		{% endfor %}
	}
	
	public void configPlugin(Plugins me) {
		DruidPlugin druidPlugin = new DruidPlugin(getProperty("jdbcurl"),getProperty("username"),getProperty("password").trim(),getProperty("driver"));
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		arp.setDialect(new MysqlDialect());
		arp.setContainerFactory(new CaseInsensitiveContainerFactory()).setShowSql(true);
	{% for entity in project.entityList %}
		{% for field in entity.fieldList %}
		{% if field.isPrimaryKey=="1" and field.name !="id" %}
		arp.addMapping("{{entity.name}}","{{field.name}}", {{entity.name| capitalize}}.class);	
		{% elif field.isPrimaryKey=="1"%}
		arp.addMapping("{{entity.name}}", {{entity.name| capitalize}}.class);
		{% endif %}
		{% endfor %}
	{% endfor %}
	
		me.add(druidPlugin);
		me.add(arp);
	}
	
	public void configInterceptor(Interceptors me) {
        me.add(new TxByRegex("/.*[save|delete|update].*"));
    }
	
	public void configHandler(Handlers me) {
		me.add(new ContextPathHandler("PATH"));
	}
	
	public static void main(String[] args) {
		JFinal.start("src/main/webapp", {{project.port}}, "/{{project.name}}", 5);
	}
}
