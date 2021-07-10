package com.tang.service;

import com.tang.pojo.Orders;
import com.tang.vo.OrdersVo;

import java.util.List;

public interface OrdersService {
    int addOrders(Orders orders);

    List<Orders> findOrdersList(OrdersVo ordersVo);

    int updateOrders(Orders orders);
}
