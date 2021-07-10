package com.tang.service;

import com.tang.pojo.CheckIn;
import com.tang.vo.CheckInVo;

import java.util.List;

public interface CheckInService {
    List<CheckIn> findCheckInList(CheckInVo checkInVo);

    int addCheckIn(CheckIn checkIn);
}
