package com.tang.dao;

import com.tang.pojo.Dept;
import com.tang.pojo.Employee;
import com.tang.vo.EmployeeVo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface EmployeeMapper {
    Employee findEmployeeByLoginName(@Param("loginName") String loginName);

    int getEmployeeCountByDeptId(@Param("deptId") Integer deptId);

    int getEmployeeCountByRoleId(@Param("roleId") Integer roleId);

    List<Employee> findEmployeeList(EmployeeVo employeeVo);

    int addEmployee(Employee employee);

    int updateEmployee(Employee employee);

    int deleteById(Integer id);

    /**
     * 删除员工关系数据
     * @param id
     */
    void deleteEmployeeAndRole(Integer id);

    /**
     * 分配员工角色关系表
     * 因为有两个参数，使用注解方便
     * @param roleId
     * @param eid
     */
    @Insert("insert into sys_role_employee (eid,rid) values (#{eid},#{rid})")
    void addEmployeeRole(@Param("rid") String roleId,@Param("eid") Integer eid);
}
