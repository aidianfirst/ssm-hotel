package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tang.pojo.CheckIn;
import com.tang.service.CheckInService;
import com.tang.utils.DataGridViewResult;
import com.tang.utils.SystemConstant;
import com.tang.vo.CheckInVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/checkin")
public class CheckInController {
    @Resource
    private CheckInService checkInService;

    @RequestMapping("/list")
    public DataGridViewResult list(CheckInVo checkInVo){
        PageHelper.startPage(checkInVo.getPage(),checkInVo.getLimit());
        List<CheckIn> checkInList = checkInService.findCheckInList(checkInVo);
        PageInfo<CheckIn> pageInfo = new PageInfo<CheckIn>(checkInList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/addCheckIn")
    public String addCheckIn(CheckIn checkIn){
        Map<String, Object> map = new HashMap<String, Object>();
        if(checkInService.addCheckIn(checkIn) > 0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"入住办理成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"入住办理失败");
        }
        return JSON.toJSONString(map);
    }
}
