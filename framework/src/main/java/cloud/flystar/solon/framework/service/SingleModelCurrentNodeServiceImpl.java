package cloud.flystar.solon.framework.service;


public class SingleModelCurrentNodeServiceImpl implements CurrentNodeService {
    @Override
    public int workerId() {
        return -1;
    }

    @Override
    public int dataCenterId() {
        return -1;
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
