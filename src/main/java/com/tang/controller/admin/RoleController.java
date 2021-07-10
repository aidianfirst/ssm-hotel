package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tang.pojo.Menu;
import com.tang.pojo.Role;
import com.tang.service.EmployeeService;
import com.tang.service.MenuService;
import com.tang.service.RoleService;
import com.tang.utils.DataGridViewResult;
import com.tang.utils.SystemConstant;
import com.tang.utils.TreeNode;
import com.tang.vo.RoleVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/role")
public class RoleController {
    @Resource
    private RoleService roleService;
    @Resource
    private EmployeeService employeeService;
    @Resource
    private MenuService menuService;


    @RequestMapping("/list")
    public DataGridViewResult list(RoleVo roleVo){
        //设置分页信息
        PageHelper.startPage(roleVo.getPage(),roleVo.getLimit());
        //调用分页查询的方法
        List<Role> roleList = roleService.findRoleList(roleVo);
        //创建分页对象
        PageInfo<Role> pageInfo = new PageInfo<Role>(roleList);
        //返回数据
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/addRole")
    public String addRole(Role role){
        Map<String, Object> map = new HashMap<String, Object>();
        //调用添加角色方法
        if(roleService.addRole(role)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"添加成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/updateRole")
    public String updateRole(Role role){
        Map<String, Object> map = new HashMap<String, Object>();
        //调用修改角色方法
        if(roleService.updateRole(role)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"修改成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"修改失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/checkRoleHasEmployee")
    public String checkRoleHasEmployee(Integer id){
        Map<String, Object> map = new HashMap<String, Object>();
        if(employeeService.getEmployeeCountByRoleId(id)>0){
            map.put(SystemConstant.EXIST,true);
            map.put(SystemConstant.MESSAGE,"该角色存在员工信息，不可删除");
        }else {
            map.put(SystemConstant.EXIST,false);
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/deleteById")
    public String deleteById(Integer id){
        Map<String, Object> map = new HashMap<String, Object>();
        if(roleService.deleteById(id)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 根据角色ID查询其拥有的权限菜单
     * @param roleId
     * @return
     */
    @RequestMapping("/initMenuTree")
    public DataGridViewResult initMenuTree(Integer roleId){
        //调用查询菜单列表的方法
        List<Menu> menuList = menuService.findMenuList();
        //根据角色ID查询该角色拥有的权限菜单ID的方法
        List<Integer> RoleMenuIds = menuService.findMenuIdListByRoleId(roleId);

        //定义集合,保存菜单信息
        List<Menu> menus = new ArrayList<Menu>();
        //判断集合是否有数据
        if(RoleMenuIds!=null && RoleMenuIds.size()>0){
            //根据菜单ID查询菜单信息
            menus = menuService.findMenuByMenuId(RoleMenuIds);
        }

        //创建集合保存树节点信息
        List<TreeNode> treeNodes = new ArrayList<TreeNode>();
        //循环遍历全部菜单
        for(Menu menu : menuList){
            //表示是否选中的变量
            String checkArr = "0";//复选框，0-不选中，1-选中

            //内循环遍历当前角色的权限菜单
            //从头开始遍历树型菜单，比较两个数据是否相等，若相同则有权限
            for(Menu r_menu : menus){
                if(menu.getId().equals(r_menu.getId())){
                    checkArr = "1";
                    break;
                }
            }

            //判断是否展开
            Boolean spread = (menu.getSpread() == null || menu.getSpread() == 1) ? true :false;
            treeNodes.add(new TreeNode(menu.getId(),menu.getPid(),menu.getTitle(),spread,checkArr));
        }
        return new DataGridViewResult(treeNodes);
    }

    /**
     * 执行菜单分配
     * @param ids
     * @param roleId
     * @return
     */
    @RequestMapping("/saveRoleMenu")
    public String saveRoleMenu(String ids,Integer roleId){
        Map<String, Object> map = new HashMap<String, Object>();
        if(roleService.saveRoleMenu(ids,roleId)>0){
            map.put(SystemConstant.MESSAGE,"菜单分配成功");
        }else{
            map.put(SystemConstant.MESSAGE,"菜单分配失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 根据员工ID查询对应的角色列表
     * @param id
     * @return
     */
    @RequestMapping("/initRoleListByEmployeeId")
    private DataGridViewResult initRoleListByEmployeeId(Integer id){
        List<Map<String, Object>> roleList = roleService.findRoleListByMap();
        List<Integer> roleIds = roleService.findEmployeeRoleByEmployeeId(id);

        //循环比较，相等说明角色符合
        for(Map<String, Object> map : roleList){
            boolean check = false;//复选框默认不选中
            Integer rid = (Integer) map.get("id");
            for (Integer roleId : roleIds){
                if(rid.equals(roleId)){
                    check = true;
                    break;
                }
            }
            //状态保存到map集合，键名称官方规定不可改
            map.put("LAY_CHECKED",check);
        }
        return new DataGridViewResult(Long.valueOf( roleList.size() ),roleList);
    }


}
