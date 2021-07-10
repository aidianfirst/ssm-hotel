package com.tang.dao;

import com.tang.pojo.CheckOut;

public interface CheckOutMapper {
    /**
     * 添加退房记录
     * @param checkOut
     * @return
     */
    int addCheckOut(CheckOut checkOut);
}
