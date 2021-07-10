package com.tang.service;

import com.tang.pojo.Floor;
import com.tang.vo.FloorVo;

import java.util.List;

public interface FloorService {

    List<Floor> findFloorList(FloorVo floorVo);

    int addFloor(Floor floor);

    int updateFloor(Floor floor);
}
