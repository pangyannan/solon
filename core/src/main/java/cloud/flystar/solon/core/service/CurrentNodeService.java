package cloud.flystar.solon.core.service;

public interface CurrentNodeService {
    /**
     * 机器ID：0~31
     * 如果不能实现，则返回 -1
     */
    int workerId();

    /**
     * 数据中心ID：0~31
     * 如果不能实现，则返回 -1
     */
    int dataCenterId();

    /**
     * 集群节点数量
     * @return
     */
    int nodeTotal();

    /**
     * 当前节点是否是主节点
     * @return
     */
    boolean currentIsMaster();
}
