package {{project.packageName}}.{{entity.name}};

import com.jfinal.core.Controller;
import com.jfinal.ext.render.excel.PoiRender;
import com.jfinal.aop.Before;
import java.util.List;

import com.jfinal.ext.render.DwzRender;

public class {{entity.name | capitalize}}Controller extends Controller {
    @Before(value = {{entity.name|capitalize}}Searcher.class)
	public void index() {
    //setAttr("page", {{entity.name|capitalize}}.DAO.page(getParaToInt("pageNum",1),getParaToInt("numPerPage",10)));
    }
	
	public void add() {
	}

	@Before(value = {{entity.name|capitalize}}Validator.class)
	public void save() {
		{{entity.name|capitalize}} {{entity.name}} = getModel({{entity.name|capitalize}}.class);
		{{entity.name}}.save();
        render(DwzRender.closeCurrentAndRefresh("rel_{{entity.name}}"));
	}
	
	public void edit() {
		setAttr("{{entity.name}}", {{entity.name|capitalize}}.DAO.findById(getPara(0)));
	}
	public void view() {
		setAttr("{{entity.name}}", {{entity.name|capitalize}}.DAO.findById(getPara(0)));
	}
	
	public void update() {
		getModel({{entity.name|capitalize}}.class).update();
        render(DwzRender.closeCurrentAndRefresh("rel_{{entity.name}}"));
	}
	
	public void delete() {
		{{entity.name|capitalize}}.DAO.deleteById(getPara(0));
		render(DwzRender.success());
	}
	public void excel() {
		List<{{entity.name|capitalize}}> data = {{entity.name|capitalize}}.DAO.page(getParaToInt("pageNum",1),getParaToInt("numPerPage",10)).getList();
		String[] headers = new String[]{ {% for field in entity.fieldList %}{% if field.isPrimaryKey=="1" %}"{{field.name}}",{% endif %}{% endfor %} };
		String[] columns = new String[]{ {% for field in entity.fieldList %}{% if field.isPrimaryKey!="1" %}"{{field.name}}",{% endif %}{% endfor %} };
	    render(PoiRender.me(data).headers(headers).columns(columns).fileName("{{entity.name}}.xls"));
	}
}


