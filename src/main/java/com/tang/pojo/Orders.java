package com.tang.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Orders {
    private Integer id;//订单主键
    private String ordersNo;//订单号
    private Integer accountId;//用户id
    private Integer roomTypeId;//房型ID
    private Integer roomId;//房间ID
    private String reservationName;//预订人姓名
    private String idCard;//身份证号码
    private String phone;//电话
    private Integer status;//订单状态 1-待确认 2-已确认
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")//Jackson
    private Date reserveDate;//预订时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date arriveDate;//入住时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date leaveDate;//离店时间
    private Double reservePrice;//预订房价
    private String remark;//备注

    private Room room;
    private RoomType roomType;
}
