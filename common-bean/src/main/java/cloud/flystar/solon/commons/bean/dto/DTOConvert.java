package cloud.flystar.solon.commons.bean.dto;


import java.util.Collections;
import java.util.List;
import java.util.Objects;
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

    public  A defaultDoBackward(B b){
        throw new AssertionError("不支持逆向转化方法!");
    }

    /**
     * 批量正向转换
     * @param aList
     * @return
     */
    public List<B> doForward(List<A> aList){
        if(aList == null || aList.isEmpty()){
            return Collections.emptyList();
        }
        return aList.stream().filter(Objects::nonNull).map(this::doForward).filter(Objects::nonNull).collect(Collectors.toList());
    }


    /**
     * 批量正向转换
     * @param bList
     * @return
     */
    public  List<A> doBackward(List<B> bList){
        if(bList == null || bList.isEmpty()){
            return Collections.emptyList();
        }
        return bList.stream().filter(Objects::nonNull).map(this::doBackward).filter(Objects::nonNull).collect(Collectors.toList());
    }
}
