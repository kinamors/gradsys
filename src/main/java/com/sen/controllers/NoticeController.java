package com.sen.controllers;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.Msg;
import com.sen.beans.Notice;
import com.sen.services.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RequestMapping("/noticeController")
@Controller
public class NoticeController {

    @Autowired
    NoticeService noticeServiceImpl;

    @ResponseBody
    @RequestMapping("/getAllNotices")
    public Msg getAllNotices(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,15);
        List<Notice> selectPapers=noticeServiceImpl.getAllNotices();

        PageInfo pageInfo=new PageInfo(selectPapers,5);
        return Msg.success().add("pageInfo",pageInfo);
    }
    @ResponseBody
    @RequestMapping("getNotice")
    public Msg getNotice(@RequestParam("noticeId")Integer id){
        Notice notice=noticeServiceImpl.getNotice(id);
        return Msg.success().add("notice",notice);

    }

    @ResponseBody
    @RequestMapping("/saveNotice")
    public Msg saveNotice(Notice notice){
        notice.setNoticeTime(new Date(System.currentTimeMillis()));
        noticeServiceImpl.saveNotice(notice);
        return Msg.success();
    }

    @RequestMapping(value = "/notice/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteSelectPaperById(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            String[] strs=ids.split("-");
            List<Integer> del_ids=new ArrayList<>();
            for (String str : strs) {
                del_ids.add(Integer.parseInt(str));
            }
            noticeServiceImpl.deleteBatchSp(del_ids);

        }else{
            Integer id=Integer.parseInt(ids);
            noticeServiceImpl.deleteSelectPaper(id);

        }
        return Msg.success();
    }



}
