package com.tang.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CheckOut {
    private Long id;
    private String checkOutNumber;
    private Long checkInId;
    private Double consumerPrice;
    private Date createDate;
    private Integer createdBy;
    private String remark;


}
