package com.sen.controllers;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sen.beans.Msg;
import com.sen.beans.Student;
import com.sen.services.ClassesService;
import com.sen.services.CollegeService;
import com.sen.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("/studentController")
@Controller
public class StudentController {

    @Autowired
    StudentService studentServiceImpl;
    @Autowired
    CollegeService collegeServiceImpl;
    @Autowired
    ClassesService classesServiceImpl;


    @ResponseBody
    @RequestMapping(value = "/choosePaper/{id}",method = RequestMethod.PUT)
    public Msg updateStuByPaperId(@PathVariable("id")String sno, @RequestParam("paperId") Integer paperId){
        Student student=new Student();
        student.setSno(sno);
        student.setPaperNum(paperId);
        studentServiceImpl.updateStuByPaperId(student);

        return Msg.success();
    }

    @ResponseBody
    @RequestMapping("/checkStuIsSelected")
    public Msg checkStuIsSelected(@RequestParam("sno")String sno){
        Student student=studentServiceImpl.selectByPrimaryKey(sno);
        if (student.getPaperNum()==null){
            return Msg.success();
        }else {
            return Msg.failure();
        }
    }

    @ResponseBody
    @RequestMapping("/getAllStudents")
    public Msg getAllStudents(@RequestParam(value = "page",defaultValue = "1")Integer page){
        PageHelper.startPage(page,12);
        List<Student> students=studentServiceImpl.getAllStudents();

        PageInfo pageInfo=new PageInfo(students,5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("/getStudentsBy")
    public Msg getStudentsBy(@RequestParam(value = "page",defaultValue = "1")Integer page, Student student,
                             @RequestParam("collegeId")String collegeId,
                             @RequestParam("classesId")Integer classId){
        PageHelper.startPage(page,12);
        student.setClasses(classesServiceImpl.selectByPrimaryKey(classId).getClassName());
        student.setCollName(collegeServiceImpl.selectByPrimaryKey(collegeId).getCname());
        List<Student> students=studentServiceImpl.getStudentsBy(student);
        if (students.isEmpty()){
            return Msg.failure().add("s_result","没找到结果，请重新选择");
        }
        PageInfo pageInfo=new PageInfo(students,5);
        return Msg.success().add("pageInfo",pageInfo);
    }
    @ResponseBody
    @RequestMapping(value = "/student/{ids}",method = RequestMethod.DELETE)
    public Msg deleteStudent(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            String[] strs=ids.split("-");
            List<String> del_ids=new ArrayList<>();
            for (String str : strs) {
                del_ids.add(str);
            }
            studentServiceImpl.deleteBatchSp(del_ids);

        }else{
            studentServiceImpl.deleteSelectPaper(ids);

        }
        return  Msg.success();
    }


    @ResponseBody
    @RequestMapping("/updatePwd")
    public Msg updatePwd(Student student, HttpSession session){
        studentServiceImpl.updatePwd(student);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/student/{id}",method = RequestMethod.GET)
    public Msg getStudentBySno(@PathVariable("id")String sno){
        Student student=studentServiceImpl.getStudentBySno(sno);
        return Msg.success().add("student",student);

    }

    @ResponseBody
    @RequestMapping(value = "/freshStudent/{id}",method = RequestMethod.POST)
    public Msg freshStudent(@PathVariable("id")String sno,HttpSession session){
        Student student=studentServiceImpl.getStudentBySno(sno);
        session.setAttribute("user",student);
        return Msg.success();

    }

    @ResponseBody
    @RequestMapping(value = "/student/{id}",method = RequestMethod.PUT)
    public Msg updateStudentBySno(@PathVariable("id")String sno,Student student){
        student.setSno(sno);
        studentServiceImpl.updateStudentBySno(student);
        return Msg.success();

    }

}
