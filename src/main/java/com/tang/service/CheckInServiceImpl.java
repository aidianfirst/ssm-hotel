package com.tang.service;

import com.tang.dao.CheckInMapper;
import com.tang.dao.OrdersMapper;
import com.tang.dao.RoomTypeMapper;
import com.tang.pojo.CheckIn;
import com.tang.pojo.Orders;
import com.tang.pojo.RoomType;
import com.tang.vo.CheckInVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class CheckInServiceImpl implements CheckInService {
    @Resource
    private CheckInMapper checkInMapper;

    @Resource
    private OrdersMapper ordersMapper;

    @Resource
    private RoomTypeMapper roomTypeMapper;
    /**
     * 查询入住列表
     * @param checkInVo
     * @return
     */
    public List<CheckIn> findCheckInList(CheckInVo checkInVo) {
        return checkInMapper.findCheckInList(checkInVo);
    }


    @Transactional(rollbackFor = RuntimeException.class)
    public int addCheckIn(CheckIn checkIn) {
        checkIn.setStatus(3);
        checkIn.setCreateDate(new Date());

        //添加入住信息
        int count = checkInMapper.addCheckIn(checkIn);

        if(count > 0){
            //修改预订订单的状态（已入住——3）
            Orders orders = new Orders();
            orders.setId(checkIn.getOrdersId());//修改需要主键，获取订单ID
            orders.setStatus(3);//修改状态为已入住
            ordersMapper.updateOrders(orders);

            //修改房型表的数量（已入住++）
            RoomType roomType = roomTypeMapper.findById(checkIn.getRoomTypeId());
            roomType.setLivedNum(roomType.getLivedNum() + 1);

            roomTypeMapper.updateRoomType(roomType);
        }
        return count;
    }
}
