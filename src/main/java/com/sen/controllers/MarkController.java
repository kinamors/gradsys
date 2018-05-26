package com.sen.controllers;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.Mark;
import com.sen.beans.Msg;
import com.sen.services.MarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/markController")
@Controller
public class MarkController {

    @Autowired
    MarkService markServiceImpl;

    @RequestMapping("/checkMarkBySno")
    @ResponseBody
    public Msg checkMarkBySno(@RequestParam("sno")String sno){
        boolean b=markServiceImpl.checkMarkBySno(sno);

        if (b==true){
            return Msg.success();
        }else{
            return Msg.failure().add("va_msg","该学生已录入成绩");
        }
    }

    @ResponseBody
    @RequestMapping("/saveMark")
    public Msg saveMark(Mark mark){
        markServiceImpl.saveMark(mark);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping("/marks")
    public Msg getAllMarks(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,15);
        List<Mark> marks=markServiceImpl.getAllMarks();

        PageInfo pageInfo=new PageInfo(marks,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("/getMarkBy")
    public Msg getMarkBy(@RequestParam(value = "page",defaultValue = "1")Integer page, Mark mark){
        PageHelper.startPage(page,12);
        List<Mark> marks=markServiceImpl.getMarkBy(mark);
        if (marks.isEmpty()){
            return Msg.failure().add("s_result","没找到结果，请重新填写");
        }
        PageInfo pageInfo=new PageInfo(marks,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("/getMarkBySno")
    public Msg getMarkBySno(@RequestParam("sno")String sno) {
        Mark mark = markServiceImpl.getMarkBySno(sno);

        if (mark != null) {
            return Msg.success().add("mark", mark);

        }
        return Msg.failure().add("va_result", "你的成绩还没录入");
    }
}
