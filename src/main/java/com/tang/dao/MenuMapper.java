package com.tang.dao;

import com.tang.pojo.Menu;
import com.tang.vo.MenuVo;

import java.util.List;

public interface MenuMapper {
    /**
     * 查询所有菜单列表
     * @return
     */
    List<Menu> findMenuList();

    /**
     * 根据角色ID查询角色拥有菜单集合
     * @param roleId
     * @return
     */
    List<Integer> findMenuIdListByRoleId(int roleId);

    /**
     * 根据菜单编号查询菜单信息
     * @param roleMenuIds
     * @return
     */
    List<Menu> findMenuByMenuId(List<Integer> roleMenuIds);

    /**
     * 分页查询菜单
     * @param menuVo
     * @return
     */
    List<Menu> findMenuListByPage(MenuVo menuVo);

    /**
     * 添加菜单
     * @param menu
     * @return
     */
    int addMenu(Menu menu);

    /**
     * 修改菜单
     * @param menu
     * @return
     */
    int updateMenu(Menu menu);

    /**
     * 删除菜单
     * @param id
     * @return
     */
    int deleteById(int id);

    /**
     * 根据菜单ID查询菜单是否有子菜单
     * @param id
     * @return
     */
    int getMenuCountByMenuId(Integer id);

    /**
     * 根据当前用户ID查询对应的菜单
     * @param eid
     * @return
     */
    List<Menu> findMenuListByEmployeeId(Integer eid);

}
