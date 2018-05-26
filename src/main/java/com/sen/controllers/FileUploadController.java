package com.sen.controllers;


import com.sen.beans.Msg;
import com.sen.beans.UpLoadRecord;
import com.sen.services.UpRecordService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;

@Controller
public class FileUploadController {


    @Autowired
    UpRecordService upRecordServiceImpl;

    @ResponseBody
    @RequestMapping(value="/upload",method= RequestMethod.POST)
    public Msg upload(HttpServletRequest request,
                      @RequestParam("description") String description,
                      @RequestParam("fileType") String upLoadType,
                      @RequestParam("file") MultipartFile file,
                      UpLoadRecord upLoadRecord) throws Exception {

        System.out.println(description);
//        if (upLoadType.equals("trans")){
//            path = request.getServletContext().getRealPath("/files/trans/");
//        }else if (upLoadType.equals("report")){
//            path = request.getServletContext().getRealPath("/files/report/");
//        }else if (upLoadType.equals("paper")){
//            path = request.getServletContext().getRealPath("/files/paper/");
//        }
        //如果文件不为空，写入上传路径
        if(!file.isEmpty()) {
            //上传文件路径
            //上传文件名
            String path=request.getServletContext().getRealPath("/files/");

            String filename = file.getOriginalFilename();

            String fpath="/"+upLoadType+"/"+filename;

            File filepath = new File(path,fpath);


            upLoadRecord.setUpFilename(filename);
            upLoadRecord.setUpUrl(fpath);
            upLoadRecord.setUpFileType(upLoadType);
            upLoadRecord.setUpTime(new Date(System.currentTimeMillis()));

            upRecordServiceImpl.saveUpRecord(upLoadRecord);


            System.out.println(filepath.toString());
            //判断路径是否存在，如果不存在就创建一个
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }
            //将上传文件保存到一个目标文件当中
            file.transferTo(new File(path + File.separator + fpath));
            return Msg.success().add("upLoad","上传成功");
        } else {
            return Msg.failure().add("upLoad","文件为空，请重新选择");
        }

    }


    @RequestMapping(value="/download")
    public ResponseEntity<byte[]> download(HttpServletRequest request,
                                           @RequestParam("filename") String filename,
                                           @RequestParam("url")String url,
                                           Model model)throws Exception {
        //下载文件路径
        String path = request.getServletContext().getRealPath("/files/");
        File file = new File(path + File.separator + url);
        HttpHeaders headers = new HttpHeaders();
        //下载显示的文件名，解决中文名称乱码问题
        String downloadFielName = new String(filename.getBytes("utf-8"),"iso-8859-1");

        //通知浏览器以attachment（下载方式）打开图片
        headers.setContentDispositionFormData("attachment", downloadFielName);
        //application/octet-stream ： 二进制流数据（最常见的文件下载）。
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.CREATED);
    }

}
