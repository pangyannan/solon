package cloud.flystar.solon.commons.dto;

import cn.hutool.core.collection.CollectionUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public abstract class DTOConvert<A,B>  {
    /**
     * 正向转换
     * @param a
     * @return
     */
    public abstract B doForward(A a);

    /**
     * 反向转换
     * @param b
     * @return
     */
    public abstract A doBackward(B b);


    /**
     * 批量正向转换
     * @param aList
     * @return
     */
    public List<B> doForward(List<A> aList){
        if(CollectionUtil.isEmpty(aList)){
            return new ArrayList<>();
        }
        return aList.stream().map(this::doForward).collect(Collectors.toList());
    }


    /**
     * 批量正向转换
     * @param bList
     * @return
     */
    public  List<A> doBackward(List<B> bList){
        if(CollectionUtil.isEmpty(bList)){
            return new ArrayList<>();
        }
        return bList.stream().map(this::doBackward).collect(Collectors.toList());
    }
}
