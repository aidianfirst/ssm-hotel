package com.tang.service;

import com.tang.dao.*;
import com.tang.pojo.*;
import com.tang.utils.UUIDUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

@Service
@Transactional
public class CheckOutServiceImpl implements CheckOutService {
    @Resource
    private CheckOutMapper checkOutMapper;

    @Resource
    private CheckInMapper checkInMapper;

    @Resource
    private OrdersMapper ordersMapper;

    @Resource
    private RoomTypeMapper roomTypeMapper;

    @Resource
    private RoomMapper roomMapper;

    /**
     * CheckOut拿不到订单ID和房型ID，需要用CheckIn来拿
     * @param checkOut
     * @return
     */
    public int addCheckOut(CheckOut checkOut) {
        //新增一条退房记录
        checkOut.setCreateDate(new Date());//退房时间
        checkOut.setCheckOutNumber(UUIDUtils.randomUUID());//订单流水号
        int count = checkOutMapper.addCheckOut(checkOut);
        if(count > 0){
            //修改 checkin表中状态 —— 已离店
            CheckIn checkIn = checkInMapper.findById(checkOut.getCheckInId());
            checkIn.setStatus(4);
            checkInMapper.updateCheckIn(checkIn);

            //修改 订单表状态 —— 已完成
            Orders orders = new Orders();
            orders.setStatus(4);
            orders.setId(checkIn.getOrdersId());
            ordersMapper.updateOrders(orders);

            //修改房间的状态 —— 可预订
            Room room = new Room();
            room.setStatus(1);
            //获取主键ID以便查询，由于check相关ID设计成了大数据Long，这里需要转换一下
            Long num = checkIn.getRoomId();
            room.setId(num.intValue());
            roomMapper.updateRoom(room);


            //修改 房型表数量（可用数++ 入住数--）
            RoomType roomType = roomTypeMapper.findById(checkIn.getRoomTypeId());
            roomType.setAvailableNum(roomType.getAvailableNum() + 1);//可用++
            roomType.setReservedNum(roomType.getReservedNum() - 1);//入住--
            roomTypeMapper.updateRoomType(roomType);

        }

        return count;
    }
}
