package com.sen.services.impl;

import com.sen.beans.*;
import com.sen.daos.AdminMapper;
import com.sen.daos.StudentMapper;
import com.sen.daos.TeacherMapper;
import com.sen.services.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("loginService")
public class LoginServiceImpl implements LoginService {

    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public boolean checkAdmin(String user, String password) {
        AdminExample adminExample=new AdminExample();
        AdminExample.Criteria criteria=adminExample.createCriteria();
        criteria.andUsernameEqualTo(user);
        criteria.andPasswordEqualTo(password);
        List<Admin> admins= adminMapper.selectByExample(adminExample);
        return !admins.isEmpty();
    }

    @Override
    public boolean checkStudent(String sno, String password) {
        StudentExample studentExample=new StudentExample();
        StudentExample.Criteria criteria=studentExample.createCriteria();
        criteria.andSnoEqualTo(sno);
        criteria.andPasswordEqualTo(password);
        List<Student> students=studentMapper.selectByExample(studentExample);
        return !students.isEmpty();
    }

    @Override
    public boolean checkTeacher(String tno, String password) {
        TeacherExample teacherExample=new TeacherExample();
        TeacherExample.Criteria criteria=teacherExample.createCriteria();
        criteria.andTnoEqualTo(tno);
        criteria.andPasswordEqualTo(password);
        List<Teacher> teachers=teacherMapper.selectByExample(teacherExample);
        return !teachers.isEmpty();
    }

    @Override
    public void saveStudent(Student student) {
        studentMapper.insert(student);
    }

    public void saveTeacher(Teacher teacher){
        teacherMapper.insert(teacher);
    }

    @Override
    public void saveAdmin(Admin admin) {
        adminMapper.insert(admin);
    }


    @Override
    public Admin selectAdminByName(String username) {
        return adminMapper.selectByUsername(username);
    }

    @Override
    public Student selectStudentBySno(String sno) {
        return studentMapper.selectByPrimaryKey(sno);
    }

    @Override
    public Teacher selectTeacherByTno(String tno) {
        return teacherMapper.selectByPrimaryKey(tno);
    }
}