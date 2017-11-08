package {{project.packageName}}.service.log;

import com.qding.framework.common.log.LogAspect;
import com.qding.framework.common.log.LogTypeEnum;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

/**
 *
 * 日志输出切面实现：
 * 类型：http/rpc/resouce:
 */
@Aspect
public class TracerLogAspect extends LogAspect {

    /**
     *
     * @Title
     * @Description: 环绕触发
     * @param pjp
     * @return
     * @throws Throwable
     */
    @Around("execution(* {{project.packageName}}.controller..*.*(..))"
            +"execution(* {{project.packageName}}.common.service..*.*(..))  "
    )
    public Object doAround(ProceedingJoinPoint pjp) throws Throwable {
        Object result =doAroundService(pjp);
        return result;
    }

    public String fetchTypeByPath(String path){
        String type = null;
        if (path.contains("{{project.name}}bg")) {
            type = LogTypeEnum.HTTP.getValue();
        }else if (path.contains("{{project.name}}-web"))  {
            type = LogTypeEnum.RPC.getValue();
        }
        return type;
    }

}
