package com.tang.controller;

import com.alibaba.fastjson.JSON;
import com.tang.pojo.Orders;
import com.tang.service.OrdersService;
import com.tang.utils.SystemConstant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/orders")
public class OrdersController {
    @Resource
    private OrdersService ordersService;

    @ResponseBody
    @RequestMapping("/addOrders")
    public String addOrders(Orders orders){
        Map<String, Object> map = new HashMap<String, Object>();
        if(ordersService.addOrders(orders) > 0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"您已成功预订房间");
        }else{
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"预订失败，请重新尝试");
        }
        return JSON.toJSONString(map);
    }
}
