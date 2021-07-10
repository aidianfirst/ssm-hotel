package com.tang.service;

import com.tang.pojo.Room;
import com.tang.pojo.RoomType;
import com.tang.vo.RoomTypeVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoomTypeService {
    List<RoomType> findRoomTypeList(RoomTypeVo roomTypeVo);

    int addRoomtype(RoomType roomType);

    int updateRoomType(RoomType roomType);

}
