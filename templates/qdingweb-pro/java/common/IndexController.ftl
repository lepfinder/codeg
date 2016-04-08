package {{project.packageName}}.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

/**
 * @author xie.xy
 * @date 2013-7-19
 */
@Controller
@RequestMapping("/")
public class IndexController extends MultiActionController {
    private Logger log = Logger.getLogger(IndexController.class);

    /**
     */
    @RequestMapping(value = "",method= RequestMethod.GET)
    public String welcome() throws Exception {
        logger.info("welcome rediect to index.jsp.");
        return "index";
    }

}
