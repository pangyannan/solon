package cloud.flystar.solon.core.util;

import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.datasource.pooled.PooledDataSourceFactory;

/**
 * TODO
 *
 * @author: pangyannan
 */
public class MyPooledDataSourceFactory extends PooledDataSourceFactory {
    public MyPooledDataSourceFactory(){
        this.dataSource = new HikariDataSource();
    }
}
