package com.sen.controllers;

import com.sen.beans.College;
import com.sen.beans.Msg;
import com.sen.services.CollegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/collegeController")
@Controller
public class CollegeController {

    @Autowired
    CollegeService collegeServiceImpl;

    @ResponseBody
    @RequestMapping("/getAllColleges")
    public Msg getAllColleges(){
        List<College> colleges=collegeServiceImpl.getAllColleges();

        return Msg.success().add("colleges",colleges);
    }

    @ResponseBody
    @RequestMapping("checkCName")
    public Msg checkCName(@RequestParam("cname")String cname){
        boolean b=collegeServiceImpl.checkCName(cname);
        if (b==true){
            return Msg.success();
        }else {
            return Msg.failure().add("va_msg","学院名称已存在");
        }
    }

    @ResponseBody
    @RequestMapping("checkCId")
    public Msg checkCId(@RequestParam("cid")String cid){
        boolean b=collegeServiceImpl.checkCId(cid);
        if (b==true){
            return Msg.success();
        }else {
            return Msg.failure().add("va_msg","学院编号已存在");
        }
    }

    @ResponseBody
    @RequestMapping("/saveCollege")
    public Msg saveCollege(College college){
        collegeServiceImpl.saveCollege(college);

        return Msg.success();
    }
}
