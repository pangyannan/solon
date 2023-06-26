package cloud.flystar.solon.framework.service.impl.cluster;


import cloud.flystar.solon.framework.service.CurrentNodeService;

public class SingleModelCurrentNodeServiceImpl implements CurrentNodeService {
    @Override
    public int workerId() {
        return 0;
    }

    @Override
    public int dataCenterId() {
        return 0;
    }

    @Override
    public int nodeTotal() {
        return 1;
    }

    @Override
    public boolean currentIsMaster() {
        return true;
    }
}
