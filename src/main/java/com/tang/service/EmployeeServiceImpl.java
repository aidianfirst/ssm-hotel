package com.tang.service;

import com.tang.dao.EmployeeMapper;
import com.tang.pojo.Employee;
import com.tang.utils.PasswordUtil;
import com.tang.utils.SystemConstant;
import com.tang.utils.UUIDUtils;
import com.tang.vo.EmployeeVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class EmployeeServiceImpl implements EmployeeService {
    @Resource
    private EmployeeMapper employeeMapper;

    public Employee login(String loginName, String loginPwd) {
        Employee employee = employeeMapper.findEmployeeByLoginName(loginName);
        if(employee != null){
            //密码加密
            String newPassword = PasswordUtil.md5(loginPwd,employee.getSalt(), SystemConstant.PASSWORD_COUNT);
            //比较密码是否一致
            if(employee.getLoginPwd().equals(newPassword)){
                return employee;
            }
        }
        //登录失败
        return null;
    }

    public int getEmployeeCountByDeptId(Integer deptId) {
        return employeeMapper.getEmployeeCountByDeptId(deptId);
    }

    public int getEmployeeCountByRoleId(Integer roleId) {
        return employeeMapper.getEmployeeCountByRoleId(roleId);
    }

    public List<Employee> findEmployeeList(EmployeeVo employeeVo) {
        return employeeMapper.findEmployeeList(employeeVo);
    }

    public int addEmployee(Employee employee) {
        employee.setCreateDate(new Date());
        employee.setSalt(UUIDUtils.randomUUID());
        employee.setLoginPwd(PasswordUtil.md5(SystemConstant.DEFAULT_LOGIN_PWD,employee.getSalt(),SystemConstant.PASSWORD_COUNT));
        return employeeMapper.addEmployee(employee);
    }

    public int updateEmployee(Employee employee) {
        employee.setModifyDate(new Date());
        return employeeMapper.updateEmployee(employee);
    }

    public int deleteById(Integer id) {
        //删除员工角色关系表的数据
        employeeMapper.deleteEmployeeAndRole(id);

        return employeeMapper.deleteById(id);
    }

    public int resetPwd(Integer id) {
        Employee employee = new Employee();
        employee.setSalt(UUIDUtils.randomUUID());
        employee.setLoginPwd(PasswordUtil.md5(SystemConstant.DEFAULT_LOGIN_PWD,employee.getSalt(),SystemConstant.PASSWORD_COUNT));
        employee.setId(id);//员工编号，修改需要ID
        return employeeMapper.updateEmployee(employee);//重复利用update方法
    }

    public boolean saveEmployeeRole(String roleIds, Integer eid) {
        try {
            //先删除员工关系表数据
            employeeMapper.deleteEmployeeAndRole(eid);
            //然后保存员工关系
            String[] idStr = roleIds.split(",");
            for(int i = 0; i<idStr.length;i++){
                employeeMapper.addEmployeeRole(idStr[i],eid);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


}
