package cloud.flystar.solon.core.config;

import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.*;
import org.apache.catalina.session.ManagerBase;
import org.apache.tomcat.util.ExceptionUtils;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;

@Configuration
public class TomcatConfig {

    @Bean
    public TomcatServletWebServerFactory tomcatServletWebServerFactory(){
        return new TomcatServletWebServerFactory(){
            protected void postProcessContext(Context context) {
                context.setManager(new NoSessionManager());
            }
        };
    }


    /**
     * 取消tomcat的 JSESSIONID
     * 1.节约内存
     * 2.在分布式环境或者集群模式下，JSESSIONID 无用
     */
    @Slf4j
    public static class NoSessionManager extends ManagerBase implements Lifecycle {
        @Override
        protected synchronized void startInternal() throws LifecycleException {
            super.startInternal();
            try {
                load();
            } catch (Throwable t) {
                ExceptionUtils.handleThrowable(t);
                t.printStackTrace();
            }
            setState(LifecycleState.STARTING);
        }

        @Override
        protected synchronized void stopInternal() throws LifecycleException {
            setState(LifecycleState.STOPPING);
            try {
                unload();
            } catch (Throwable t) {
                ExceptionUtils.handleThrowable(t);
                t.printStackTrace();
            }
            super.stopInternal();
        }

        @Override
        public void load() throws ClassNotFoundException, IOException {
            log.info("HttpSession为关闭状态");
        }

        @Override
        public void unload() throws IOException {}
        @Override
        public Session createSession(String sessionId) {
            return null;
        }

        @Override
        public Session createEmptySession() {
            return null;
        }

        @Override
        public void add(Session session) {}
        @Override
        public Session findSession(String id) throws IOException {
            return null;
        }
        @Override
        public Session[] findSessions(){
            return null;
        }
        @Override
        public void processExpires() {}
    }
}
