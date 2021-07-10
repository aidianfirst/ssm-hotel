package com.tang.dao;

import com.tang.pojo.Floor;
import com.tang.vo.FloorVo;

import java.util.List;

public interface FloorMapper {
    /**
     * 查询楼层列表
     * @return
     */
    List<Floor> findFloorList(FloorVo floorVo);

    /**
     * 添加楼层
     * @param floor
     * @return
     */
    int addFloor(Floor floor);

    int updateFloor(Floor floor);

}
