package com.tang.service;

import com.tang.dao.RoleMapper;
import com.tang.pojo.Role;
import com.tang.vo.RoleVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {
    @Resource
    private RoleMapper roleMapper;

    public List<Role> findRoleList(RoleVo roleVo) {
        return roleMapper.findRoleList(roleVo);
    }

    public int addRole(Role role) {
        return roleMapper.addRole(role);
    }

    public int updateRole(Role role) {
        return roleMapper.updateRole(role);
    }

    public int deleteById(Integer id) {
        return roleMapper.deleteById(id);
    }

    public int saveRoleMenu(String ids, Integer roleId) {
        try {
            //先删除原有菜单关系
            roleMapper.deleteRoleMenu(roleId);
            //ids拆分数组，循环调用
            String[] idsStr = ids.split(",");
            for(int i = 0;i < idsStr.length;i++){
                roleMapper.addRoleMenu(roleId,idsStr[i]);
            }
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<Map<String, Object>> findRoleListByMap() {
        return roleMapper.findRoleListByMap();
    }

    public List<Integer> findEmployeeRoleByEmployeeId(Integer eid) {
        return roleMapper.findEmployeeRoleByEmployeeId(eid);
    }
}
