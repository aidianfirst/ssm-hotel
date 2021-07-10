package com.tang.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Room {
    private Integer id;
    private String photo;
    private String roomNum;
    private Integer roomTypeId;
    private Integer floorId;
    //房间状态(1-可预订 2-已预订 3-已入住)
    private Integer status;
    private String roomDesc;
    private String roomRequirement;
    private String remark;

    //用于联表查询
    private String typeName;//房型名称
    private String floorName;//楼层名称
    private Double price;
    private Integer bedNum;

    private String statusStr;//状态字符串

    public String getStatusStr() {
        //判断是否为空
        if(status != null){
            switch(status){
                case 1:
                    statusStr = "可预订";
                    break;
                case 2:
                    statusStr = "已预订";
                    break;
                case 3:
                    statusStr = "已入住";
                    break;
                default:
                    break;
            }
        }
        return statusStr;
    }
}
