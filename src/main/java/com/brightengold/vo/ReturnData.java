package com.brightengold.vo;

import java.io.Serializable;
import java.util.List;

/**
 * @author niange
 * @ClassName: ReturnData
 * @desp:
 * @date: 2018/4/14 下午9:37
 * @since JDK 1.7
 */
public class ReturnData<T> implements Serializable {
    /**
     * serialVersionUID:序列化
     * @since JDK 1.7
     */
    private static final long serialVersionUID = 5452016958372450765L;

    private long total;
    private List<T> rows;

    public ReturnData(){}

    public ReturnData(long total, List<T> rows) {
        this.total = total;
        this.rows = rows;
    }

    public long getTotal() {
        return total;
    }
    public void setTotal(long total) {
        this.total = total;
    }
    public List<T> getRows() {
        return rows;
    }
    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
