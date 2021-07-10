package com.tang.controller.admin;

import com.alibaba.fastjson.JSON;
import com.tang.utils.SystemConstant;
import com.tang.utils.UUIDUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/admin/file")
public class FileController {
    /**
     * 文件上传
     * @param file
     * @return
     */
    @RequestMapping("/upLoadFile")
    public String upLoadFile(MultipartFile file){
        //创建Map保存要返回的JSON数据，数据格式必须和layui官方一致
        Map<String , Object> map = new HashMap<String, Object>();

        //判断是否选中文件
        if(!file.isEmpty()){
            //获取旧文件名称
            String oldFileName = file.getOriginalFilename();
            //获取文件后缀名
            String extension = FilenameUtils.getExtension(oldFileName);
            //重命名旧文件
            String newFileName = UUIDUtils.randomUUID()+"."+extension;

            //以防图片文件过多，分日期文件夹管理
            String datePath = new SimpleDateFormat("yyyyMMdd").format(new Date());
            //组装最终文件名
            String finalName = datePath + "/" + newFileName;
            //创建文件对象，参数1：文件上传路径，参数2：文件名称
            File dest = new File(SystemConstant.IMAGE_UPLOAD_PATH,finalName);
            //如果文件夹不存在，则新建
            if(!dest.getParentFile().exists()){
                dest.getParentFile().mkdirs();
            }

            try {
                //文件上传
                file.transferTo(dest);
                map.put("code",0);//状态码
                map.put("msg","上传成功");//执行信息
                Map<String , Object> dataMap = new HashMap<String, Object>();
                dataMap.put("src","/hotel/show/"+finalName);//路径
                map.put("data",dataMap);//文件数据
                map.put("imagePath",finalName);//隐藏域的值，文件夹日期+最后的名称
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return JSON.toJSONString(map);
    }
}
