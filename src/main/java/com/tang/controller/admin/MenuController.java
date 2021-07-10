package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tang.pojo.Employee;
import com.tang.pojo.Menu;
import com.tang.service.MenuService;
import com.tang.utils.*;
import com.tang.vo.MenuVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/menu")
public class MenuController {
    @Resource
    private MenuService menuService;

    /**
     * 首页侧左侧的菜单导航
     * @return
     */
    @RequestMapping("/loadMenuList")
    public String loadMenuList(HttpSession session){
        /*
         * 创建Map集合，保存homeInfo、logoInfo、menuInfo信息
         * 对应的是statics/layui/api/init.json的文件规定写法
         */
        Map<String,Object> homeInfo = new HashMap<String, Object>();
        Map<String,Object> logoInfo = new HashMap<String, Object>();
        Map<String,Object> menuInfo = new HashMap<String, Object>();

        /*
         * 调用查询所有菜单列表的方法
         * List<Menu> menuList = menuService.findMenuList();
         * 后续优化:我们用不同账号登录，只能显示该用户权限范围内的菜单列表
         * 使用session获取当前用户ID
         */
        Employee employee = (Employee) session.getAttribute(SystemConstant.LOGINUSER);
        List<Menu> menuList = menuService.findMenuListByEmployeeId(employee.getId());

        //创建集合，保存菜单关系
        List<MenuNode> menuNodeList = new ArrayList<MenuNode>();
        //遍历菜单列表--创建菜单的父子层级关系
        for(Menu menu : menuList){
            //菜单节点
            MenuNode menuNode = new MenuNode();

            menuNode.setId(menu.getId());//菜单编号
            menuNode.setPid(menu.getPid());//父级菜单编号
            menuNode.setTitle(menu.getTitle());//菜单标题
            menuNode.setHref(menu.getHref());//菜单链接
            menuNode.setSpread(menu.getSpread());//是否展开
            menuNode.setTarget(menu.getTarget());//打开方式
            menuNode.setIcon((menu.getIcon()));//菜单图标

            menuNodeList.add(menuNode);//将菜单节点存入列表
        }

        //保存homeInfo信息
        homeInfo.put("title","首页");
        homeInfo.put("href","/admin/index.html");
        //保存logoInfo
        logoInfo.put("title","酒店管理系统");
        logoInfo.put("image","/statics/layui/images/logo.png");
        logoInfo.put("href","/admin/home.html");

        //菜单信息添加到menuInfo
        menuInfo.put("menuInfo", TreeUtil.toTree(menuNodeList,0));
        menuInfo.put("homeInfo", homeInfo);
        menuInfo.put("logoInfo",logoInfo);

        return JSON.toJSONString(menuInfo);
    }

    /**
     * 菜单管理页面，左侧导航树
     * @return
     */
    @RequestMapping("/loadMenuTree")
    public DataGridViewResult loadMenuTree(){
        List<Menu> menuList = menuService.findMenuList();//加载菜单列表
        List<TreeNode> treeNodes = new ArrayList<TreeNode>();//菜单结点信息
        for(Menu menu :menuList){
            //判断菜单是否展开，0-否，1-是
            Boolean spread = (menu.getSpread() == null || menu.getSpread() == 1) ? true : false;
            treeNodes.add(new TreeNode(menu.getId(),menu.getPid(),menu.getTitle(),spread) );
        }
        return new DataGridViewResult(treeNodes);
    }

    /**
     * 分页查询菜单
     * @param menuVo
     * @return
     */
    @RequestMapping("/list")
    public DataGridViewResult list(MenuVo menuVo){
        PageHelper.startPage(menuVo.getPage(),menuVo.getLimit());//分页信息
        List<Menu> menuList = menuService.findMenuListByPage(menuVo);//调用方法
        PageInfo<Menu> pageInfo = new PageInfo<Menu>(menuList);
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/addMenu")
    public String addMenu(Menu menu){
        Map<String, Object> map = new HashMap<String, Object>();
        if(menuService.addMenu(menu) > 0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"添加成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/updateMenu")
    public String updateMenu(Menu menu){
        Map<String, Object> map = new HashMap<String, Object>();
        if(menuService.updateMenu(menu) > 0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"修改成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 判断菜单是否有子菜单
     * @param id
     * @return
     */
    @RequestMapping("/checkMenuHasChild")
    public String checkMenuHasChild(Integer id){
        Map<String, Object> map = new HashMap<String, Object>();
        if(menuService.getMenuCountByMenuId(id) > 0){
            map.put(SystemConstant.EXIST,true);
            map.put(SystemConstant.MESSAGE,"有子菜单，无法删除");
        }else {
            map.put(SystemConstant.EXIST,false);
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/deleteById")
    public String deleteById(int id){
        Map<String, Object> map = new HashMap<String, Object>();
        if(menuService.deleteById(id) > 0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return JSON.toJSONString(map);
    }



}
