package cloud.flystar.solon.commons.page;

import lombok.Data;

import java.util.List;

@Data
public class PageResult<T>{
    /**
     * 当前页码
     */
    private int pageNum;
    /**
     * 每页数量
     */
    private int pageSize;
    /**
     * 记录总数
     */
    private long total;
    /**
     * 页码总数
     */
    private int pages;
    /**
     * 数据模型
     */
    private List<T> list;
}
