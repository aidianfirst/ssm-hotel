package com.tang.dao;

import com.tang.pojo.Orders;
import com.tang.vo.OrdersVo;

import java.util.List;

public interface OrdersMapper {
    int addOrders(Orders orders);

    List<Orders> findOrdersList(OrdersVo ordersVo);

    int updateOrders(Orders orders);
}
