package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tang.pojo.Floor;
import com.tang.service.FloorService;
import com.tang.utils.DataGridViewResult;
import com.tang.utils.SystemConstant;
import com.tang.vo.FloorVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/floor")
public class FloorController {
    @Resource
    private FloorService floorService;

    /**
     * 分页查询楼层列表
     * @param floorVo
     * @return
     */
    @RequestMapping("/list")
    public DataGridViewResult list(FloorVo floorVo){
        PageHelper.startPage(floorVo.getPage(),floorVo.getLimit());
        List<Floor> floorList = floorService.findFloorList(floorVo);
        PageInfo<Floor> pageInfo = new PageInfo<Floor>(floorList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/addFloor")
    public String addFloor(Floor floor){
        Map<String, Object> map = new HashMap<String, Object>();
        if(floorService.addFloor(floor) > 0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"添加成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/updateFloor")
    public String updateFloor(Floor floor){
        Map<String, Object> map = new HashMap<String, Object>();
        if(floorService.updateFloor(floor) > 0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"修改成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/findAll")
    public String findAll(){
        return JSON.toJSONString(floorService.findFloorList(null));
    }

}
