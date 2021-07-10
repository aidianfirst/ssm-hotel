package com.tang.dao;

import com.tang.pojo.RoomType;
import com.tang.vo.RoomTypeVo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RoomTypeMapper {
    /**
     * 查询房型列表
     * @param roomTypeVo
     * @return
     */
    List<RoomType> findRoomTypeList(RoomTypeVo roomTypeVo);

    int addRoomtype(RoomType roomType);

    int updateRoomType(RoomType roomType);

    /**
     * 房型ID查房型
     * @param roomTypeId
     */
    @Select("select * from t_room_type where id = #{id}")
    RoomType findById(@Param("id") Integer roomTypeId);
}
