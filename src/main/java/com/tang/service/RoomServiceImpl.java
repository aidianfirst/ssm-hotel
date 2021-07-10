package com.tang.service;

import com.tang.dao.RoomMapper;
import com.tang.pojo.Room;
import com.tang.vo.RoomVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class RoomServiceImpl implements RoomService {
    @Resource
    private RoomMapper roomMapper;

    public List<Room> findRoomListByPage(RoomVo roomVo) {
        return roomMapper.findRoomListByPage(roomVo);
    }

    public int addRoom(Room room) {
        return roomMapper.addRoom(room);
    }

    public int updateRoom(Room room) {
        return roomMapper.updateRoom(room);
    }

    public int deleteById(Integer id) {
        return roomMapper.deleteById(id);
    }

    public List<Room> findRoomList() {
        return roomMapper.findRoomList();
    }

    public Room findRoomDetailsById(Integer id) {
        return roomMapper.findRoomDetailsById(id);
    }

}
