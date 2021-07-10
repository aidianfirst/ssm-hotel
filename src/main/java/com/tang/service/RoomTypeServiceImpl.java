package com.tang.service;

import com.tang.dao.RoomTypeMapper;
import com.tang.pojo.RoomType;
import com.tang.vo.RoomTypeVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class RoomTypeServiceImpl implements RoomTypeService {
    @Resource
    private RoomTypeMapper roomTypeMapper;

    public List<RoomType> findRoomTypeList(RoomTypeVo roomTypeVo) {
        return roomTypeMapper.findRoomTypeList(roomTypeVo);
    }

    public int addRoomtype(RoomType roomType) {
        //预定和已入住都要赋初值，防止空指针
        roomType.setReservedNum(0);
        roomType.setLivedNum(0);
        //可入住房间数默认为全部房间
        roomType.setAvailableNum(roomType.getRoomNum());
        return roomTypeMapper.addRoomtype(roomType);
    }

    public int updateRoomType(RoomType roomType) {
        roomType.setReservedNum(0);
        roomType.setLivedNum(0);
        roomType.setAvailableNum(roomType.getRoomNum());
        return roomTypeMapper.updateRoomType(roomType);
    }


}
