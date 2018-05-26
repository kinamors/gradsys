package com.sen.services;

import com.sen.beans.Admin;
import com.sen.beans.Student;
import com.sen.beans.Teacher;

public interface LoginService {

    public boolean checkAdmin(String user,String password);
    public boolean checkStudent(String sno,String password);
    public boolean checkTeacher(String tno,String password);


    public void saveStudent(Student student);
    public void saveTeacher(Teacher teacher);
    public void saveAdmin(Admin admin);




    public Admin selectAdminByName(String username);
    public Student selectStudentBySno(String sno);
    public Teacher selectTeacherByTno(String tno);



}
