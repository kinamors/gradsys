package com.sen.services.impl;

import com.sen.beans.Student;
import com.sen.beans.StudentExample;
import com.sen.daos.StudentMapper;
import com.sen.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("studentService")
public class StudentServiceImpl implements StudentService{

    @Autowired
    private StudentMapper studentMapper;


    @Override
    public void updateStuByPaperId(Student student) {
        studentMapper.updateByPrimaryKeySelective(student);
    }

    @Override
    public Student selectByPrimaryKey(String sno) {
        return studentMapper.selectByPrimaryKey(sno);
    }

    @Override
    public List<Student> getAllStudents() {
        return studentMapper.selectByExample(null);
    }

    @Override
    public List<Student> getStudentsBy(Student student) {
        StudentExample example=new StudentExample();
        StudentExample.Criteria criteria=example.createCriteria();
        if (student.getSno()!=""){
            criteria.andSnoLike("%"+student.getSno()+"%");
        }
        if (student.getsName()!=""){
            criteria.andSNameLike("%"+student.getsName()+"%");
        }
        if (student.getPaperNum()!=null){
            criteria.andPaperNumEqualTo(student.getPaperNum());
        }
        if (student.getCollName()!=null){
            criteria.andCollNameEqualTo(student.getCollName());
        }
        if (student.getClasses()!=null){
            criteria.andClassesEqualTo(student.getClasses());
        }
        if (student.getSex()!=null){
            criteria.andSexEqualTo(student.getSex());
        }
        return studentMapper.selectByExample(example);
    }

    @Override
    public void deleteBatchSp(List<String> del_ids) {
        StudentExample example=new StudentExample();
        StudentExample.Criteria criteria=example.createCriteria();
        criteria.andSnoIn(del_ids);
        studentMapper.deleteByExample(example);
    }

    @Override
    public void deleteSelectPaper(String id) {
        studentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void updatePwd(Student student) {
        studentMapper.updateByPrimaryKeySelective(student);
    }

    @Override
    public Student getStudentBySno(String sno) {
        return studentMapper.selectByPrimaryKey(sno);
    }

    @Override
    public void updateStudentBySno(Student student) {
        studentMapper.updateByPrimaryKeySelective(student);
    }
}
