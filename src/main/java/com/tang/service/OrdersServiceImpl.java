package com.tang.service;

import com.tang.dao.OrdersMapper;
import com.tang.dao.RoomMapper;
import com.tang.dao.RoomTypeMapper;
import com.tang.pojo.Orders;
import com.tang.pojo.Room;
import com.tang.pojo.RoomType;
import com.tang.utils.UUIDUtils;
import com.tang.vo.OrdersVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class OrdersServiceImpl implements OrdersService {
    @Resource
    private OrdersMapper ordersMapper;

    @Resource
    private RoomMapper roomMapper;

    @Resource
    private RoomTypeMapper roomTypeMapper;

    /**
     * 添加订单
     * @param orders
     * @return
     */
    @Transactional(rollbackFor = RuntimeException.class)
    public int addOrders(Orders orders) {
        orders.setStatus(1);//状态1--待确认
        orders.setOrdersNo(UUIDUtils.randomUUID());
        orders.setReserveDate(new Date());//设置预定时间是当前时刻
        //添加成功则修改房间状态
        int count = ordersMapper.addOrders(orders);
        if(count>0){
            //修改房间状态为已预订（2）
            Room room = roomMapper.findRoomDetailsById(orders.getRoomId());
            room.setStatus(2);
            roomMapper.updateRoom(room);

            //该房型可用数量修改
            RoomType roomType = roomTypeMapper.findById(orders.getRoomTypeId());
            roomType.setAvailableNum(roomType.getAvailableNum() - 1);//可预定--
            roomType.setReservedNum(roomType.getReservedNum() + 1);//已预定++
            roomTypeMapper.updateRoomType(roomType);
        }
        return count;
    }

    public List<Orders> findOrdersList(OrdersVo ordersVo) {
        return ordersMapper.findOrdersList(ordersVo);
    }

    public int updateOrders(Orders orders) {
        return ordersMapper.updateOrders(orders);
    }
}
