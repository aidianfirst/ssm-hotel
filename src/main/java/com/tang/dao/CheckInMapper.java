package com.tang.dao;

import com.tang.pojo.CheckIn;
import com.tang.vo.CheckInVo;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CheckInMapper {
    /**
     * 入住列表
     * @param checkInVo
     * @return
     */
    List<CheckIn> findCheckInList(CheckInVo checkInVo);

    /**
     * 添加入住信息
     * @param checkIn
     * @return
     */
    int addCheckIn(CheckIn checkIn);

    /**
     * ID查入住信息
     * @param checkInId
     * @return
     */
    @Select("select * from t_checkin where id = #{id}")
    CheckIn findById(Long checkInId);

    /**
     * 修改入住信息列表
     * @param checkIn
     * @return
     */
    int updateCheckIn(CheckIn checkIn);
}
