package {{project.packageName}}.controller;
{% set entityName = entity.name[0].upper() + entity.name[1:]%}
import com.qding.framework.common.basemodel.ResultPage;
import {{project.packageName}}.SearchParams.{{entityName}}Params;
import {{project.packageName}}.common.ModelResult;
import {{project.packageName}}.domain.{{entityName}};
import {{project.packageName}}.service.I{{entityName}}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import javax.servlet.http.HttpServletRequest;

/**
 */
@Controller
@RequestMapping("/admin/{{entity.name}}")
public class {{entityName}}Controller extends MultiActionController {

    @Autowired
    protected I{{entityName}}Service {{entity.name}}Service;


    /**
     * {{entity.label}}列表
     */
    @RequestMapping(value = "list",method= RequestMethod.GET)
    @ResponseBody
    public Object list(HttpServletRequest request,{{entityName}}Params {{entity.name}}Params) {
        logger.info("find {{entity.name}} list.");


        ModelResult modelResult = new ModelResult(ModelResult.CODE_200);
        ResultPage<{{entityName}}> resultPage = null;
        resultPage = {{entity.name}}Service.getResultPage({{entity.name}}Params);
        modelResult.setMessage("查询成功");
        modelResult.setResultPage(resultPage);

        return modelResult;
    }

    /**
     * 新增{{entity.label}}
     */
    @RequestMapping(value = "save",method= RequestMethod.POST)
    @ResponseBody
    public Object save({{entityName}} {{entity.name}}) {
        logger.info("save {{entity.name}}.");

        ModelResult modelResult = new ModelResult(ModelResult.CODE_200);
        
        {{entityName}} entity = {{entity.name}}Service.save{{entityName}}({{entity.name}});

        modelResult.setMessage("操作成功");
        modelResult.setEntity(entity);

        return modelResult;
    }

    /**
     * 更新{{entity.label}}
     */
    @RequestMapping(value = "update",method= RequestMethod.POST)
    @ResponseBody
    public Object update({{entityName}} {{entity.name}}) {
        logger.info("update {{entity.name}}.");

        ModelResult modelResult = new ModelResult(ModelResult.CODE_200);

        modelResult.setMessage("操作成功");
        return modelResult;
    }

    /**
     * 根据ID获取{{entity.label}}
     */
    @RequestMapping(value = "getById",method= RequestMethod.GET)
    @ResponseBody
    public Object getById(String id) {
        logger.info("get {{entity.name}} by id.");

        ModelResult modelResult = new ModelResult(ModelResult.CODE_200);
        
        {{entityName}} {{entity.name}} = {{entity.name}}Service.getById(id);

        modelResult.setMessage("查询成功");
        modelResult.setEntity({{entity.name}});

        return modelResult;
    }


    /**
     * 删除{{entity.label}}
     */
    @RequestMapping(value = "deleteById",method= RequestMethod.POST)
    @ResponseBody
    public Object deleteById(String id) {
        logger.info("save {{entity.name}}.");
        ModelResult modelResult = new ModelResult(ModelResult.CODE_200);
        
        {{entity.name}}Service.deleteById(id);

        modelResult.setMessage("操作成功");
        
        return modelResult;
    }

}
