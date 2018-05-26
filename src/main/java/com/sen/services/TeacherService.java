package com.sen.services;

import com.sen.beans.Teacher;

import java.util.List;

public interface TeacherService {

    List<Teacher> getAllTeachers();

    List<Teacher> getTeachersBy(Teacher teacher);

    void deleteBatchSp(List<String> tnos);

    void deleteSelectPaper(String tno);

    void updatePwd(Teacher teacher);

    Teacher getTeacherByTno(String tno);

    void updateTeacherByTno(Teacher teacher);
}
