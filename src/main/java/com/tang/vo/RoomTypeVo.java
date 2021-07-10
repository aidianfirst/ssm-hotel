package com.tang.vo;

import com.tang.pojo.RoomType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RoomTypeVo extends RoomType {
    //当前页码
    private Integer page;
    //每页显示数量
    private Integer limit;
}
