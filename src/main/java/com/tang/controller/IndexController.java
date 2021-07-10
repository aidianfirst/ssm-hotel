package com.tang.controller;

import com.tang.pojo.Floor;
import com.tang.pojo.Room;
import com.tang.pojo.RoomType;
import com.tang.service.FloorService;
import com.tang.service.RoomService;
import com.tang.service.RoomTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class IndexController {
    @Resource
    private RoomTypeService roomTypeService;

    @Resource
    private FloorService floorService;

    @Resource
    private RoomService roomService;

    @RequestMapping({"/","/index.html"})
    public String index(Model model){
        List<RoomType> roomTypeList = roomTypeService.findRoomTypeList(null);

        List<Floor> floorList = floorService.findFloorList(null);

        List<Room> roomList = roomService.findRoomList();

        model.addAttribute("roomTypeList",roomTypeList);
        model.addAttribute("floorList",floorList);
        model.addAttribute("roomList",roomList);
        return "forward:/index.jsp";//不在视图解析器中，使用转发，重定向会丢失数据
    }


}
