package cloud.flystar.solon.common.log.aspect;

import cloud.flystar.solon.common.log.Log;
import cloud.flystar.solon.common.log.LogType;
import cn.hutool.core.util.ObjectUtil;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.core.io.InputStreamSource;
import org.springframework.util.StopWatch;

import java.lang.reflect.Method;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @Author: pangyannan
 * @Data: 2021/6/5
 * @Description: 日志切面类
 */
@Aspect
@Order(Integer.MIN_VALUE)
public class LogAspect {
    /**
     * 切点描述
     * 凡事有@Log注解的
     */
    @Pointcut("@annotation(cloud.flystar.solon.common.log.Log)")
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
        Log log = method.getAnnotation(Log.class);
        if(log == null){
            log = (Log) clazz.getAnnotation(Log.class);
        }

        LogObject logObject = new LogObject();
        logObject.setModuleName(ObjectUtil.isEmpty(log.moduleName())? clazz.getSimpleName() : log.moduleName());
        logObject.setMethodName(ObjectUtil.isEmpty(log.methodName())? method.getName() : log.methodName());

        //获取传入目标方法的参数对象
        Map<String, Object> paramNameValueMap = new LinkedHashMap<>();
        for (int i = 0; i < parameterNames.length; i++) {
            Class parameterType = parameterTypes[i];
            //如果数据流,就不打印了
            if(!InputStreamSource.class.isAssignableFrom(parameterType)){
                paramNameValueMap.put(parameterNames[i], args[i]);
            }
        }

        //日志对象采用目标对象日志，这样方便日志查询
        Logger logger = LoggerFactory.getLogger(clazz);

        if(log.paramLog()){
            logObject.setParam(paramNameValueMap);
        }

        LogType logType = log.preLog();
        if(logType == LogType.PRE){
            logger.info(logObject.preLog());
            return joinPoint.proceed();
        }

        if(logType == LogType.PRE_AND_POST){
            logger.info(logObject.preLog());
        }


        StopWatch stopWatch = new StopWatch();
        stopWatch.start();
        Object result;
        boolean isError = false;
        try {
            result = joinPoint.proceed();
            if(log.responseLog()){
                logObject.setResult(result);
            }
        } catch (Throwable throwable) {
            isError = true;
            //不吃掉异常，向上抛出
            throw  throwable;
        }finally {
            stopWatch.stop();
            logObject.setCostTime(stopWatch.getTotalTimeMillis());
            if(isError){
                logger.error(logObject.postLog());
            }else{
                logger.info(logObject.postLog());
            }
        }
        //处理日志
        return result;
    }


}
