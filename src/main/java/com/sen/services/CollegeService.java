package com.sen.services;

import com.sen.beans.College;

import java.util.List;

public interface CollegeService {
    List<College> getAllColleges();
    College selectByPrimaryKey(String cid);

    boolean checkCId(String cid);

    boolean checkCName(String cname);

    void saveCollege(College college);
}
