package com.tang.vo;

import com.tang.pojo.CheckIn;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CheckInVo extends CheckIn {
    //当前页码
    private Integer page;
    //每页显示数量
    private Integer limit;
}
