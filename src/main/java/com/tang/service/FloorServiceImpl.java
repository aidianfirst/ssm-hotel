package com.tang.service;

import com.tang.dao.FloorMapper;
import com.tang.pojo.Floor;
import com.tang.vo.FloorVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class FloorServiceImpl implements FloorService {
    @Resource
    private FloorMapper floorMapper;

    public List<Floor> findFloorList(FloorVo floorVo) {
        return floorMapper.findFloorList(floorVo);
    }

    public int addFloor(Floor floor) {
        return floorMapper.addFloor(floor);
    }

    public int updateFloor(Floor floor) {
        return floorMapper.updateFloor(floor);
    }
}
