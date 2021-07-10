package com.tang.service;

import com.tang.dao.MenuMapper;
import com.tang.pojo.Menu;
import com.tang.vo.MenuVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {
    @Resource
    private MenuMapper menuMapper;

    public List<Menu> findMenuList() {
        return menuMapper.findMenuList();
    }

    public List<Integer> findMenuIdListByRoleId(int roleId) {
        return menuMapper.findMenuIdListByRoleId(roleId);
    }

    public List<Menu> findMenuByMenuId(List<Integer> roleMenuIds) {
        return menuMapper.findMenuByMenuId(roleMenuIds);
    }

    public List<Menu> findMenuListByPage(MenuVo menuVo) {
        return menuMapper.findMenuListByPage(menuVo);
    }

    public int addMenu(Menu menu) {
        //如果没有设置父级菜单，则它就是父级菜单
        if(menu.getPid() == null){
            menu.setPid(0);
        }
        menu.setTarget(null);
        return menuMapper.addMenu(menu);
    }

    public int updateMenu(Menu menu) {
        return menuMapper.updateMenu(menu);
    }

    public int deleteById(int id) {
        return menuMapper.deleteById(id);
    }

    public int getMenuCountByMenuId(Integer id) {
        return menuMapper.getMenuCountByMenuId(id);
    }

    public List<Menu> findMenuListByEmployeeId(Integer eid) {
        return menuMapper.findMenuListByEmployeeId(eid);
    }


}
