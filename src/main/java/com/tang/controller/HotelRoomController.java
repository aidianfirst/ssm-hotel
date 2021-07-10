package com.tang.controller;

import com.tang.pojo.Room;
import com.tang.pojo.RoomType;
import com.tang.service.RoomService;
import com.tang.service.RoomTypeService;
import com.tang.vo.RoomVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/room")
public class HotelRoomController {
    @Resource
    private RoomService roomService;

    @Resource
    private RoomTypeService roomTypeService;
    /**
     * 查询房间详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/{id}.html")
    public String detail(@PathVariable Integer id, Model model){
        //调用查询房间详情方法
        Room room = roomService.findRoomDetailsById(id);
        model.addAttribute("room",room);
        return "detail";
    }

    /**
     * 查询全部房间列表
     * @param model
     * @return
     */
    @RequestMapping("/list")
    public String list(Model model){
        List<RoomType> roomTypeList = roomTypeService.findRoomTypeList(null);

        RoomVo roomVo = new RoomVo();
        roomVo.setStatus(1);//只展示可预订的房间

        List<Room> roomList = roomService.findRoomListByPage(roomVo);

        model.addAttribute("roomTypeList",roomTypeList);
        model.addAttribute("roomList",roomList);
        return "/hotelList";
    }

    /**
     * 只显示对应类型的房间
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/list/{id}")
    public String list(@PathVariable Integer id,Model model){
        List<RoomType> roomTypeList = roomTypeService.findRoomTypeList(null);

        //点击房型分类时，只出现对应的roomTypeId的房间
        RoomVo roomVo = new RoomVo();
        roomVo.setStatus(1);//只展示可预订的房间
        roomVo.setRoomTypeId(id);

        List<Room> roomList = roomService.findRoomListByPage(roomVo);

        model.addAttribute("roomTypeList",roomTypeList);
        model.addAttribute("roomList",roomList);
        //保存选中的房型ID，以便页面判断当前房型的选中值
        model.addAttribute("typeId",id);
        return "/hotelList";
    }

}
