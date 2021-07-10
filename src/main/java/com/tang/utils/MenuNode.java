package com.tang.utils;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 菜单节点工具类
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MenuNode {
    private Integer id;//菜单编号
    private Integer pid;//父级菜单编号
    private String title;//菜单名称
    private String href;//菜单链接
    private Integer spread;//是否展开链接
    private String target;//打开方式
    private String icon;//菜单图标
    private List<MenuNode> child;//子菜单的集合列表
}
