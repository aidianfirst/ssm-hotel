package com.tang.service;

import com.tang.pojo.Role;
import com.tang.vo.RoleVo;

import java.util.List;
import java.util.Map;

public interface RoleService {
    List<Role> findRoleList(RoleVo roleVo);

    int addRole(Role role);

    int updateRole(Role role);

    int deleteById(Integer id);

    int saveRoleMenu(String ids, Integer roleId);

    List<Map<String,Object>> findRoleListByMap();

    List<Integer> findEmployeeRoleByEmployeeId(Integer eid);
}
