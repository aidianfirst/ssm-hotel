package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tang.pojo.Employee;
import com.tang.service.EmployeeService;
import com.tang.utils.DataGridViewResult;
import com.tang.utils.SystemConstant;
import com.tang.vo.EmployeeVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/employee")
public class EmployeeController {
    @Resource
    private EmployeeService employeeService;

    /**
     * 员工登录控制
     * @param username
     * @param password
     * @param session
     * @return
     */
    @RequestMapping("/login")
    public String login(String username, String password, HttpSession session){
        Map<String ,Object> map = new HashMap<String, Object>();
        //调用员工登录的方法
        Employee employee = employeeService.login(username, password);
        //判断对象是否为空，不为空则登录成功
        if(employee != null){
            //保存当前登录用户
            session.setAttribute(SystemConstant.LOGINUSER,employee);
            map.put(SystemConstant.SUCCESS,true);//成功
        }else {
            map.put(SystemConstant.SUCCESS,false);//失败
            map.put(SystemConstant.MESSAGE,"账号或密码错误，登录失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 查询员工列表
     * @param employeeVo
     * @return
     */
    @RequestMapping("/list")
    public DataGridViewResult list(EmployeeVo employeeVo){
        PageHelper.startPage(employeeVo.getPage(),employeeVo.getLimit());       //分页信息
        List<Employee> employeeList = employeeService.findEmployeeList(employeeVo);
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(employeeList);     //分页对象
        return new DataGridViewResult(pageInfo.getTotal(),pageInfo.getList());  //返回数据
    }

    @RequestMapping("/addEmployee")
    public String addEmployee(Employee employee,HttpSession session){
        Map<String, Object> map = new HashMap<String, Object>();
        //获取当前登录用户
        Employee loginUser = (Employee) session.getAttribute(SystemConstant.LOGINUSER);
        //设置创建人
        employee.setCreateBy(loginUser.getId());
        if(employeeService.addEmployee(employee)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"添加成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"添加失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/updateEmployee")
    public String updateEmployee(Employee employee,HttpSession session){
        Map<String, Object> map = new HashMap<String, Object>();
        //获取当前登录用户
        Employee loginUser = (Employee) session.getAttribute(SystemConstant.LOGINUSER);
        //设置修改人
        employee.setModifyBy(loginUser.getId());
        if(employeeService.updateEmployee(employee)>0){
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
        if(employeeService.deleteById(id)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"删除成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"删除失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/resetPwd")
    public String resetPwd(Integer id){
        Map<String, Object> map = new HashMap<String, Object>();
        if(employeeService.resetPwd(id)>0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"密码重置成功");
        }else {
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"密码重置失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/saveEmployeeRole")
    public String saveEmployeeRole(String roleIds,Integer eid){
        Map<String, Object> map = new HashMap<String, Object>();
        if(employeeService.saveEmployeeRole(roleIds,eid)){
            map.put(SystemConstant.MESSAGE,"角色分配成功");
        }else {
            map.put(SystemConstant.MESSAGE,"角色分配失败");
        }
        return JSON.toJSONString(map);
    }
}
