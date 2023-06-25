package cloud.flystar.solon.framework.service.impl.cluster;


import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.commons.util.IpUtil;
import cloud.flystar.solon.framework.config.cluster.ClusterProperties;
import cloud.flystar.solon.framework.config.pool.ThreadPoolHolder;
import cloud.flystar.solon.framework.service.CurrentNodeService;
import cloud.flystar.solon.framework.util.RedisKeyUtil;
import cn.hutool.extra.spring.SpringUtil;
import lombok.Data;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.data.redis.core.RedisTemplate;

import javax.annotation.PostConstruct;
import java.time.Duration;
import java.util.Optional;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.ReentrantLock;

@Slf4j
public class ClusterRedisModelCurrentNodeServiceImpl implements CurrentNodeService {
    /**
     * workerId可以是0-1023
     */
    private final int MAX_WORKER_ID = 32;
    private final String REDIS_PREFIX = "clusterNode";

    private volatile NodeInfo nodeInfo;
    private int workerId;


    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    private ClusterProperties clusterProperties;
    @Autowired
    private RedissonClient redissonClient;


    @PostConstruct
    public void init() {
        this.nodeInfo = this.nodeInfoBuild();
        workerId = this.getSnowFlaskWorkerId();

        Duration heartBeatDuration = Duration.ofSeconds(this.clusterProperties.getWorkIdRedisHeartBeat());
        ThreadPoolHolder.schedulerExecutor().scheduleAtFixedRate(this::heartBeat, heartBeatDuration);
    }


    private NodeInfo nodeInfoBuild(){
        NodeInfo nodeInfo = new NodeInfo();
        nodeInfo.setNodeIp(IpUtil.getHostIp());
        nodeInfo.setServerPort(SpringUtil.getProperty("server.port"));
        log.info("当前进程节点nodeInfo=[{}]", JsonUtil.json(nodeInfo));
        return nodeInfo;
    }

    /**
     * 获得可用workerId
     * @return 可用workerId
     */
    @SneakyThrows
    private int getSnowFlaskWorkerId() {
        String lockKey = RedisKeyUtil.nameSpaceJoinKey(this.getClass().getName(), "initWorkIdLock");
        RLock lock = redissonClient.getLock(lockKey);
        boolean tryLock = lock.tryLock(10, 30, TimeUnit.SECONDS);
        if(!tryLock){
            log.error("加锁失败,无法获取到WorkerId");
            this.shutdownApp();
            return -1;
        }

        try {
            //先轮训下当前数据中心下所有的workId，如果info一样，则直接使用
            for (int i = 0; i < MAX_WORKER_ID; i++) {
                String workerKey = this.getWorkerKey(i);
                NodeInfo nodeInfoRedis = (NodeInfo)redisTemplate.opsForValue().get(workerKey);
                if(nodeInfoRedis == null){
                    continue;
                }
                if(nodeInfo.equals(nodeInfoRedis)){
                    log.info("设置workerId[{}]成功,原因:查询历史NodeInfo[{}]一致", i, JsonUtil.json(nodeInfo));
                    redisTemplate.expire(workerKey, clusterProperties.getWorkIdRedisTimeOut(), TimeUnit.SECONDS);
                    return i;
                }
            }

            //如果没有历史的,则重新创建一个
            for (int i = 0; i < MAX_WORKER_ID ; i++) {
                log.debug("尝试锁定workerId[{}]", i);
                String workerKey = this.getWorkerKey(i);
                Boolean success = redisTemplate.opsForValue().setIfAbsent(workerKey, nodeInfo, clusterProperties.getWorkIdRedisTimeOut(), TimeUnit.SECONDS);
                if(success){
                    log.info("设置workerId[{}]成功",i);
                    return i;
                }
            }
        }finally {
            lock.unlock();
        }
        // 无法找到workerId，抛出异常
        log.error("无法获取到WorkerId");
        this.shutdownApp();
        return -1;
    }



    /**
     * 获取workerId对应的Redis主键
     */
    private String getWorkerKey(Integer workerId) {
        Integer dataCenterId = Optional.ofNullable(clusterProperties.getDataCenterId()).orElse(0);
        return RedisKeyUtil.nameSpaceJoinKey(REDIS_PREFIX, "dataCenter",dataCenterId.toString() , "workerId",workerId.toString());
    }

    /**
     * 心跳
     */
    private void heartBeat(){
        log.debug("workerId心跳开始,workerId[{}],dataCenterId[{}],nodeInfo=[{}]",workerId,clusterProperties.getDataCenterId(),JsonUtil.json(nodeInfo));
        String workerKey = this.getWorkerKey(this.workerId);
        NodeInfo nodeInfoRedis = (NodeInfo)redisTemplate.opsForValue().get(workerKey);
        if(nodeInfoRedis == null){
            log.error("workerId心跳失败,原因:workerKey[{}]对应的redis节点信息不存在", workerKey);
            redisTemplate.opsForValue().setIfAbsent(workerKey, nodeInfo, clusterProperties.getWorkIdRedisTimeOut(), TimeUnit.SECONDS);
            return;
        }

        if(!nodeInfo.equals(nodeInfoRedis)){
            log.error("workerId心跳失败,原因:workerKey[{}]对应的redis节点信息不一致。当前节点信息nodeInfo[{}], nodeInfoRedis=[{}]"
                    , workerKey,JsonUtil.json(this.nodeInfo), JsonUtil.json(nodeInfoRedis));
            log.error("workerId心跳失败,强制关闭系统!!!!!");
            this.shutdownApp();

        }else{
            redisTemplate.expire(workerKey, clusterProperties.getWorkIdRedisTimeOut(), TimeUnit.SECONDS);
        }
    }

    private void shutdownApp(){
        ConfigurableApplicationContext context = (ConfigurableApplicationContext) SpringUtil.getApplicationContext();
        context.close();
    }

    @Override
    public int workerId() {
        return this.workerId;
    }

    @Override
    public int dataCenterId() {
        return this.clusterProperties.getDataCenterId();
    }

    @Override
    public int nodeTotal() {
        return 1;
    }

    @Override
    public boolean currentIsMaster() {
        return true;
    }


    @Data
    public static class NodeInfo{
        private String nodeIp;
        private String serverPort;
    }
}
