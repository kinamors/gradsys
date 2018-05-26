package com.sen.services.impl;

import com.sen.beans.Teacher;
import com.sen.beans.TeacherExample;
import com.sen.daos.TeacherMapper;
import com.sen.services.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("teacherService")
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public List<Teacher> getAllTeachers() {
        return teacherMapper.selectByExample(null);
    }

    @Override
    public List<Teacher> getTeachersBy(Teacher teacher) {
        TeacherExample example=new TeacherExample();
        TeacherExample.Criteria criteria=example.createCriteria();
        if (teacher.getTno()!=""){
            criteria.andTnoLike("%"+teacher.getTno()+"%");
        }
        if (teacher.getTname()!=null){
            criteria.andTnameLike("%"+teacher.getTname()+"%");
        }
        if (teacher.getEducation()!=""){
            criteria.andEducationEqualTo(teacher.getEducation());
        }
        if (teacher.getPost()!=""){
            criteria.andPostEqualTo(teacher.getPost());
        }
        return teacherMapper.selectByExample(example);
    }

    @Override
    public void deleteBatchSp(List<String> tnos) {
        TeacherExample example=new TeacherExample();
        TeacherExample.Criteria criteria=example.createCriteria();
        criteria.andTnoIn(tnos);
        teacherMapper.deleteByExample(example);
    }

    @Override
    public void deleteSelectPaper(String tno) {
        teacherMapper.deleteByPrimaryKey(tno);
    }

    @Override
    public void updatePwd(Teacher teacher) {
        teacherMapper.updateByPrimaryKeySelective(teacher);
    }

    @Override
    public Teacher getTeacherByTno(String tno) {
        return teacherMapper.selectByPrimaryKey(tno);
    }

    @Override
    public void updateTeacherByTno(Teacher teacher) {
        teacherMapper.updateByPrimaryKeySelective(teacher);
    }
}
