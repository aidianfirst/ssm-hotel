package com.tang.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CheckIn {
    private Long id;
    private Integer roomTypeId;
    private Long roomId;
    private String customerName;
    private String idCard;
    private String phone;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date arriveDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date leaveDate;
    private BigDecimal payPrice;
    private Integer status;
    private String remark;
    private Integer ordersId;
    private Integer createdBy;
    private Date createDate;
    private Integer modifyBy;
    private Date modifyDate;

    private Room room;
    private RoomType roomType;
}
