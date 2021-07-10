package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tang.pojo.Orders;
import com.tang.service.OrdersService;
import com.tang.utils.DataGridViewResult;
import com.tang.utils.SystemConstant;
import com.tang.vo.OrdersVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/orders")
public class AdminOrdersController {
    @Resource
    private OrdersService ordersService;

    /**
     * 查询订单列表
     * @param ordersVo
     * @return
     */
    @RequestMapping("/list")
    public DataGridViewResult list(OrdersVo ordersVo){
        PageHelper.startPage(ordersVo.getPage(),ordersVo.getLimit());
        List<Orders> ordersList = ordersService.findOrdersList(ordersVo);
        PageInfo<Orders> pageInfo = new PageInfo<Orders>(ordersList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    /**
     * 修改订单状态
     * @param orders
     * @return
     */
    @RequestMapping("/confirmOrders")
    public String confirmOrders(Orders orders){
        Map<String, Object> map = new HashMap<String, Object>();
        orders.setStatus(2);//修改状态为已确认
        if(ordersService.updateOrders(orders)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"订单确认成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"订单确认失败");
        }
        return JSON.toJSONString(map);
    }


    /**
     * 批量确认
     * @param ids
     * @return
     */
    @RequestMapping("/batchConfirm")
    public String batchConfirm(String ids){
        Map<String, Object> map = new HashMap<String, Object>();
        int count = 0;
        //字符串拆分为数组
        String[] idsStr = ids.split(",");
        for(int i = 0;i < idsStr.length;i++){
            //Orders对象保存
            Orders orders = new Orders();
            orders.setStatus(2);
            orders.setId(Integer.valueOf(idsStr[i]));

            //修改
            count = ordersService.updateOrders(orders);
            if(count>0){
                map.put(SystemConstant.SUCCESS,true);
                map.put(SystemConstant.MESSAGE,"订单确认成功");
            }
        }
        if(count <= 0){
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"订单确认失败");
        }
        return JSON.toJSONString(map);
    }



}
