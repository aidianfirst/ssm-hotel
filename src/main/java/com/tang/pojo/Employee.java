package com.tang.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Employee {
    private Integer id;
    private String loginName;
    private String loginPwd;
    private String name;
    private Integer sex;
    private Integer deptId;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date hireDate;
    private String salt;//加密的盐值，即加密随机数
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createDate;
    private Integer createBy;
    private Date modifyDate;
    private Integer modifyBy;
    private String remark;

    private String deptName;
}
