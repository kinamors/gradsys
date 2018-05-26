package com.sen.services;

import com.sen.beans.Student;

import java.util.List;

public interface StudentService {

    public void updateStuByPaperId(Student student);

    Student selectByPrimaryKey(String sno);

    List<Student> getAllStudents();

    List<Student> getStudentsBy(Student student);

    void deleteBatchSp(List<String> del_ids);

    void deleteSelectPaper(String id);

    void updatePwd(Student student);

    Student getStudentBySno(String sno);

    void updateStudentBySno(Student student);
}
