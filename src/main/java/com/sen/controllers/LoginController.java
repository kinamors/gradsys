package com.sen.controllers;

import com.sen.beans.Admin;
import com.sen.beans.Student;
import com.sen.beans.Teacher;
import com.sen.services.ClassesService;
import com.sen.services.CollegeService;
import com.sen.services.LoginService;
import jdk.nashorn.internal.runtime.GlobalConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@RequestMapping("/loginController")
@Controller
public class LoginController {

    @Autowired
    LoginService loginServiceImpl;

    @Autowired
    ClassesService classesServiceImpl;

    @Autowired
    CollegeService collegeServiceImpl;

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(@RequestParam(required = true) String username,
                        @RequestParam(required = true) String password,
                        @RequestParam(value = "loginRadios",required = true)String userType,
                        HttpSession session){
        if (userType.equals("adm")){
            if (loginServiceImpl.checkAdmin(username,password)){
                Admin admin=loginServiceImpl.selectAdminByName(username);
                session.setAttribute("user",admin);
                session.setAttribute("loginType","adm");

                return "admHomePage";
            }

        }else if (userType.equals("stu")){
            if (loginServiceImpl.checkStudent(username,password)){
                Student student=loginServiceImpl.selectStudentBySno(username);
                session.setAttribute("user",student);
                session.setAttribute("loginType","stu");

                return "stuHomePage";
            }

        }else if (userType.equals("tec")){
            if (loginServiceImpl.checkTeacher(username,password)){
                Teacher teacher=loginServiceImpl.selectTeacherByTno(username);
                session.setAttribute("user",teacher);
                session.setAttribute("loginType","tec");

                return "tecHomePage";
            }

        }

        return "loginFail";
    }

    @RequestMapping(value = "/regStudent",method = {RequestMethod.POST,RequestMethod.GET})
    public String regStudent(Student student){
        student.setClasses(classesServiceImpl.selectByPrimaryKey(Integer.parseInt(student.getClasses())).getClassName());
        student.setCollName(collegeServiceImpl.selectByPrimaryKey(student.getCollName()).getCname());
        loginServiceImpl.saveStudent(student);


        return "success";
    }

    @RequestMapping(value = "/regTeacher",method = {RequestMethod.POST,RequestMethod.GET})
    public String regTeacher(Teacher teacher){

        loginServiceImpl.saveTeacher(teacher);

        return "success";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "tologin";
    }

    @RequestMapping("/test")
    public String test(){
        return "success";
    }
}
