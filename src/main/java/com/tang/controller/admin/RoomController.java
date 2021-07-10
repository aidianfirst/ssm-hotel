package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tang.pojo.Room;
import com.tang.service.RoomService;
import com.tang.utils.DataGridViewResult;
import com.tang.utils.SystemConstant;
import com.tang.vo.RoomVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/room")
public class RoomController {
    @Resource
    private RoomService roomService;

    @RequestMapping("/list")
    public DataGridViewResult findRoomListByPage(RoomVo roomVo){
        PageHelper.startPage(roomVo.getPage(),roomVo.getLimit());
        List<Room> roomList = roomService.findRoomListByPage(roomVo);
        PageInfo<Room> pageInfo = new PageInfo<Room>(roomList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/addRoom")
    public String addRoom(Room room){
        Map<String, Object> map = new HashMap<String, Object>();
        if(roomService.addRoom(room)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"添加成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/updateRoom")
    public String updateRoom(Room room){
        Map<String, Object> map = new HashMap<String, Object>();
        if(roomService.updateRoom(room)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"修改成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/deleteById")
    public String deleteById(Integer id){
        Map<String, Object> map = new HashMap<String, Object>();
        if(roomService.deleteById(id)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return JSON.toJSONString(map);
    }

}
