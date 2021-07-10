package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.tang.pojo.CheckOut;
import com.tang.service.CheckOutService;
import com.tang.utils.SystemConstant;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/admin/checkout")
public class CheckOutController {
    @Resource
    private CheckOutService checkOutService;

    @RequestMapping("/addCheckOut")
    public String addCheckOut(CheckOut checkOut){
        Map<String, Object> map = new HashMap<String, Object>();
        if(checkOutService.addCheckOut(checkOut) > 0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"退房办理成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"退房办理失败");
        }
        return JSON.toJSONString(map);
    }
}
