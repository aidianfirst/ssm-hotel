package com.tang.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
    private Integer id;
    private Integer pid;
    private String title;
    private String href;
    private Integer spread;
    private String target;
    private String icon;
}
