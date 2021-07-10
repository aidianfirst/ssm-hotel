package com.tang.dao;

import com.tang.pojo.Role;
import com.tang.vo.RoleVo;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RoleMapper {
    /**
     * 查询角色列表
     * @param roleVo
     * @return
     */
    List<Role> findRoleList(RoleVo roleVo);

    int addRole(Role role);

    int updateRole(Role role);

    int deleteById(Integer id);

    /**
     * 删除原有角色的表关系
     * @param roleId
     */
    @Delete("delete from sys_role_menu where rid = #{roleId}")
    void deleteRoleMenu(Integer roleId);

    /**
     * 添加角色菜单关系数据
     * @param roleId
     * @param menuId
     */
    @Insert("insert into sys_role_menu (mid,rid) values(#{menuId},#{roleId})")
    void addRoleMenu(@Param("roleId") Integer roleId, @Param("menuId") String menuId);

    /**
     * 查询角色列表
     * 这里是由于角色
     * @return
     */
    List<Map<String,Object>> findRoleListByMap();

    /**
     * 根据员工ID查其员工角色关系表
     * @return
     */
    List<Integer> findEmployeeRoleByEmployeeId(Integer eid);
}
