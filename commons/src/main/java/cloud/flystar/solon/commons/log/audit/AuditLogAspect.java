package cloud.flystar.solon.commons.log.audit;

import cloud.flystar.solon.commons.util.IpUtil;
import cloud.flystar.solon.commons.util.RequestUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.annotation.Order;
import org.springframework.core.io.InputStreamSource;
import org.springframework.util.StopWatch;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 审计日志切面类
 */
@Aspect
@Order(Integer.MIN_VALUE)
public class AuditLogAspect {
    private AuditLogStore auditLogStore;
    public AuditLogAspect(AuditLogStore auditLogStore){
        this.auditLogStore = auditLogStore;
    }
    /**
     * 切点描述
     * 凡事有@Log注解的
     */
    @Pointcut("@annotation(cloud.flystar.solon.commons.log.audit.Audit)")
    public void logPrintAnnotation(){}


    @Around("logPrintAnnotation()")
    public Object doAround(ProceedingJoinPoint joinPoint) throws Throwable {

        //获取封装了署名信息的对象,在该对象中可以获取到目标方法名,所属类的Class等信息
        MethodSignature ms = (MethodSignature)joinPoint.getSignature();
        //类名称
        Class clazz = ms.getDeclaringType();
        //方法名称
        Method method = ms.getMethod();
        //方法参数
        Object[] args = joinPoint.getArgs();
        String[] parameterNames = ms.getParameterNames();
        Class[] parameterTypes = ms.getParameterTypes();
        //注解
        Audit audit = method.getAnnotation(Audit.class);
        if(audit == null){
            audit = (Audit) clazz.getAnnotation(Audit.class);
        }

        AuditLog auditLog = new AuditLog();
        auditLog.setTime(LocalDateTime.now());

        String[] label = audit.label();
        if(label != null && label.length > 0){
            StrUtil.join(",",label);
        }
        auditLog.setModule(ObjectUtil.isEmpty(audit.moduleName())? clazz.getSimpleName() : audit.moduleName());
        auditLog.setMethod(ObjectUtil.isEmpty(audit.methodName())? method.getName() : audit.methodName());

        HttpServletRequest request = RequestUtil.getRequest();
        auditLog.setPath(request.getServletPath());
        auditLog.setIp(IpUtil.getIp(request));
        auditLog.setLocation(IpUtil.getCityInfo(auditLog.getIp()));


        //获取传入目标方法的参数对象
        Map<String, Object> paramNameValueMap = new LinkedHashMap<>();
        for (int i = 0; i < parameterNames.length; i++) {
            Class parameterType = parameterTypes[i];
            //如果数据流,就不打印了
            if(!InputStreamSource.class.isAssignableFrom(parameterType)){
                paramNameValueMap.put(parameterNames[i], args[i]);
            }
        }

        if(audit.paramLog()){
            auditLog.setParam(paramNameValueMap);
        }


        StopWatch stopWatch = new StopWatch();
        stopWatch.start();
        Object result;
        try {
            result = joinPoint.proceed();
            if(audit.responseLog()){
                auditLog.setResult(result);
            }
            auditLog.setSuccess(Boolean.TRUE);
        } catch (Throwable throwable) {
            auditLog.setSuccess(Boolean.FALSE);
            auditLog.setErrorMsg(throwable.getLocalizedMessage());
            //不吃掉异常，向上抛出
            throw  throwable;
        }finally {
            stopWatch.stop();
            auditLog.setCostTime(stopWatch.getTotalTimeMillis());
            auditLogStore.save(auditLog);
        }
        //处理日志
        return result;
    }


}
