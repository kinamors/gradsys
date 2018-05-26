package com.sen.controllers;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.Msg;
import com.sen.beans.UpLoadRecord;
import com.sen.services.UpRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("/upLoadRecordController")
@Controller
public class UpLoadRecordController {

    @Autowired
    UpRecordService upRecordServiceImpl;

    @ResponseBody
    @RequestMapping("/getAllUpRecord")
    public Msg getAllUpRecord(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,12);
        List<UpLoadRecord> upLoadRecords=upRecordServiceImpl.getAllUpRecord();

        PageInfo pageInfo=new PageInfo(upLoadRecords,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("/getReportUpRecord")
    public Msg getReportUpRecord(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,12);
        List<UpLoadRecord> upLoadRecords=upRecordServiceImpl.getReportUpRecord();

        PageInfo pageInfo=new PageInfo(upLoadRecords,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping("/getTransUpRecord")
    public Msg getTransUpRecord(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,12);
        List<UpLoadRecord> upLoadRecords=upRecordServiceImpl.getTransUpRecord();

        PageInfo pageInfo=new PageInfo(upLoadRecords,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping("/getPaperUpRecord")
    public Msg getPaperUpRecord(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,12);
        List<UpLoadRecord> upLoadRecords=upRecordServiceImpl.getPaperUpRecord();

        PageInfo pageInfo=new PageInfo(upLoadRecords,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("/getUpRecordBy")
    public Msg getUpRecordBy(@RequestParam(value = "page",defaultValue = "1")Integer page, UpLoadRecord upLoadRecord){
        PageHelper.startPage(page,12);
        List<UpLoadRecord> upLoadRecords=upRecordServiceImpl.getUpRecordBy(upLoadRecord);
        System.out.println(upLoadRecord.toString());
        if (upLoadRecords.isEmpty()){
            return Msg.failure().add("s_result","没找到结果，请重新选择");
        }
        PageInfo pageInfo=new PageInfo(upLoadRecords,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping(value = "/deleteFile")
    public Msg deleteFiles(HttpServletRequest request,@RequestParam("id")Integer id, @RequestParam("url")String url){

        String path = request.getServletContext().getRealPath("/files/");
        File file = new File(path + File.separator + url);

        System.out.println(file.toString());

        if (file.delete()){
            System.out.println("test");
            upRecordServiceImpl.deleteFiles(id);
            return  Msg.success();
        }



        return  Msg.failure();
    }


}
