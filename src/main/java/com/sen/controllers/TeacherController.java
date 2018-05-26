package com.sen.controllers;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.Msg;
import com.sen.beans.Teacher;
import com.sen.services.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("/teacherController")
@Controller
public class TeacherController {

    @Autowired
    TeacherService teacherServiceImpl;

    @ResponseBody
    @RequestMapping("/getAllTeachers")
    public Msg getAllTeachers(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,12);
        List<Teacher> students=teacherServiceImpl.getAllTeachers();

        PageInfo pageInfo=new PageInfo(students,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping("/getTeachersBy")
    public Msg getTeachersBy(@RequestParam(value = "page",defaultValue = "1")Integer page,
                             Teacher teacher){
        PageHelper.startPage(page,12);
        List<Teacher> students=teacherServiceImpl.getTeachersBy(teacher);
        if (students.isEmpty()){
            return Msg.failure().add("s_result","没找到结果，请重新选择");
        }
        PageInfo pageInfo=new PageInfo(students,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping(value = "/teacher/{ids}",method = RequestMethod.DELETE)
    public Msg deleteTeacher(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            String[] strs=ids.split("-");
            List<String> del_ids=new ArrayList<>();
            for (String str : strs) {
                del_ids.add(str);
            }
            teacherServiceImpl.deleteBatchSp(del_ids);

        }else{
            teacherServiceImpl.deleteSelectPaper(ids);

        }
        return  Msg.success();
    }


    @ResponseBody
    @RequestMapping("/updatePwd")
    public Msg updatePwd(Teacher teacher, HttpSession session){
        teacherServiceImpl.updatePwd(teacher);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/teacher/{id}",method = RequestMethod.GET)
    public Msg getTeacherByTno(@PathVariable("id")String tno){
        Teacher teacher=teacherServiceImpl.getTeacherByTno(tno);
        return Msg.success().add("teacher",teacher);

    }

    @ResponseBody
    @RequestMapping(value = "/teacher/{id}",method = RequestMethod.PUT)
    public Msg updateTeacherByTno(@PathVariable("id")String tno,Teacher teacher){
        teacher.setTno(tno);
        teacherServiceImpl.updateTeacherByTno(teacher);
        return Msg.success();

    }

}
