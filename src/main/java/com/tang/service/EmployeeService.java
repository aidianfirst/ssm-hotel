package com.tang.service;

import com.tang.pojo.Employee;
import com.tang.vo.EmployeeVo;

import java.util.List;

public interface EmployeeService {
    Employee login(String loginName,String loginPwd);

    int getEmployeeCountByDeptId( Integer deptId);

    int getEmployeeCountByRoleId( Integer roleId);

    List<Employee> findEmployeeList(EmployeeVo employeeVo);

    int addEmployee(Employee employee);

    int updateEmployee(Employee employee);

    int deleteById(Integer id);

    int resetPwd(Integer id);

    boolean saveEmployeeRole(String roleIds, Integer eid);
}
