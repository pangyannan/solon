package cloud.flystar.solon.commons.bean.constant;

import lombok.Getter;

@Getter
public enum YesOrNo {
    NO(0,"否"),
    YES(1,"是")
    ;
    private Integer key;
    private String value;

    YesOrNo(Integer key, String value) {
        this.key = key;
        this.value = value;
    }

    /**
     * 是
     * 1 是
     * 0 不是
     * null 不是
     */
    public  static boolean isYes(Integer key){
       return YesOrNo.YES.getKey().equals(key);
    }


    public  static boolean isNo(Integer key){
        return !YesOrNo.isYes(key);
    }
}
