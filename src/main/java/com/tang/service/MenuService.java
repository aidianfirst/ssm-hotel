package com.tang.service;

import com.tang.pojo.Menu;
import com.tang.vo.MenuVo;

import java.util.List;

public interface MenuService {
    List<Menu> findMenuList();

    List<Integer> findMenuIdListByRoleId(int roleId);

    /**
     * 根据菜单编号查询菜单信息
     * @param roleMenuIds
     * @return
     */
    List<Menu> findMenuByMenuId(List<Integer> roleMenuIds);

    List<Menu> findMenuListByPage(MenuVo menuVo);

    int addMenu(Menu menu);

    int updateMenu(Menu menu);

    int deleteById(int id);

    int getMenuCountByMenuId(Integer id);

    List<Menu> findMenuListByEmployeeId(Integer eid);

}
