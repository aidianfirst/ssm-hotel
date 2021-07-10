package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tang.pojo.RoomType;
import com.tang.service.RoomTypeService;
import com.tang.utils.DataGridViewResult;
import com.tang.utils.SystemConstant;
import com.tang.vo.RoomTypeVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/roomType")
public class RoomTypeController {
    @Resource
    private RoomTypeService roomTypeService;

    @RequestMapping("/list")
    public DataGridViewResult list(RoomTypeVo roomTypeVo){
        PageHelper.startPage(roomTypeVo.getPage(),roomTypeVo.getLimit());
        List<RoomType> roomTypeList = roomTypeService.findRoomTypeList(roomTypeVo);
        PageInfo<RoomType> pageInfo = new PageInfo<RoomType>(roomTypeList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/addRoomType")
    public String addRoomType(RoomType roomType){
        Map<String, Object> map = new HashMap<String, Object>();
        if(roomTypeService.addRoomtype(roomType)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"添加成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/updateRoomType")
    public String updateRoomType(RoomType roomType){
        Map<String, Object> map = new HashMap<String, Object>();
        if(roomTypeService.updateRoomType(roomType)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"修改成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 所有房间类型
     * @return
     */
    @RequestMapping("/findAll")
    public String findAll(){
        return JSON.toJSONString(roomTypeService.findRoomTypeList(null));
    }
}
