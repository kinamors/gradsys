package com.sen.services;

import com.sen.beans.Admin;

import java.util.List;

public interface AdminService {

    List<Admin> getAllAdmins();

    void deleteBatchSp(List<Integer> ids);

    void deleteSelectPaper(Integer id);

    boolean checkUsername(String username);

    void saveAdmin(Admin admin);

    void updatePwd(Admin admin);
}
