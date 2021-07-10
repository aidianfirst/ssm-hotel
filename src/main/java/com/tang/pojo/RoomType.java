package com.tang.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RoomType {
    private Integer id;
    private String typeName;
    private String photo;
    private Double price;
    private Integer liveNum;
    private Integer bedNum;
    private Integer roomNum;
    private Integer reservedNum;
    private Integer availableNum;
    private Integer livedNum;
    private Integer status;
    private String remark;
}
