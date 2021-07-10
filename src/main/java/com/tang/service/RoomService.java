package com.tang.service;

import com.tang.pojo.Room;
import com.tang.vo.RoomVo;

import java.util.List;

public interface RoomService {

    List<Room> findRoomListByPage(RoomVo roomVo);

    int addRoom(Room room);

    int updateRoom(Room room);

    int deleteById(Integer id);

    List<Room> findRoomList();

    Room findRoomDetailsById(Integer id);

}
