package com.tang.service;

import com.tang.pojo.Dept;
import com.tang.vo.DeptVo;

import java.util.List;

public interface DeptService {
    List<Dept> findDeptListByPage(DeptVo deptVo);

    int addDept(Dept dept);

    int updateDept(Dept dept);

    int deleteById(Integer id);

    List<Dept> findDeptList();
}
