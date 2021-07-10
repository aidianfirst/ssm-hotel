package com.tang.dao;

import com.tang.pojo.Room;
import com.tang.vo.RoomVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoomMapper {
    List<Room> findRoomListByPage(RoomVo roomVo);

    int addRoom(Room room);

    int updateRoom(Room room);

    int deleteById(Integer id);

    List<Room> findRoomList();

    /**
     * 查询房间详情
     * @param id
     * @return
     */
    Room findRoomDetailsById(Integer id);
}
