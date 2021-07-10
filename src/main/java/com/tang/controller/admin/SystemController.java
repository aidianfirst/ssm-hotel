package com.tang.controller.admin;

import com.tang.utils.SystemConstant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class SystemController {
    /**
     * 后台登录
     * @return
     */
    @RequestMapping("/login.html")
    public String login(){
        return "admin/login";
    }

    /**
     * 后台首页的框架界面
     * @return
     */
    @RequestMapping("/home.html")
    public String home(){
        return "admin/home";
    }

    /**
     * 后台首页的首页界面
     * @return
     */
    @RequestMapping("/index.html")
    public String index(){
        return "admin/index";
    }

    /**
     * 后台退出
     * @param session
     * @return
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute(SystemConstant.LOGINUSER);
        //重定向
        return "redirect:/admin/login.html";
    }

    /**
     * 部门管理界面
     * @return
     */
    @RequestMapping("/toDeptManage")
    public String toDeptManage(){
        return "admin/dept/deptManage";
    }

    /**
     * 角色管理界面
     * @return
     */
    @RequestMapping("/toRoleManage")
    public String toRoleManage(){
        return "admin/role/roleManage";
    }

    /**
     * 员工管理
     * @return
     */
    @RequestMapping("/toEmployeeManage")
    public String toEmployeeManage(){
        return "admin/employee/employeeManage";
    }

    /**
     * 菜单管理
     * @return
     */
    @RequestMapping("/toMenuManage")
    public String toMenuManage(){
        return "admin/menu/menuManage";
    }

    /**
     * 楼层管理
     * @return
     */
    @RequestMapping("/toFloorManage")
    public String toFloorManage(){
        return "admin/floor/floorManage";
    }

    /**
     * 房型管理
     * @return
     */
    @RequestMapping("/toRoomTypeManage")
    public String toRoomTypeManage(){
        return "admin/roomType/roomTypeManage";
    }

    /**
     * 房间管理
     * @return
     */
    @RequestMapping("/toRoomManage")
    public String toRoomManage(){
        return "admin/room/roomManage";
    }

    /**
     * 预订管理
     * @return
     */
    @RequestMapping("/toOrdersManage")
    public String toOrdersManage(){
        return "/admin/orders/ordersManage";
    }

    /**
     * 入住管理
     * @return
     */
    @RequestMapping("/toCheckInManage")
    public String toCheckInManage(){
        return "/admin/checkin/checkinManage";
    }
}
