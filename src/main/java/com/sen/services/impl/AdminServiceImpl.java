package com.sen.services.impl;

import com.sen.beans.Admin;
import com.sen.beans.AdminExample;
import com.sen.daos.AdminMapper;
import com.sen.services.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;


    @Override
    public List<Admin> getAllAdmins() {
        return adminMapper.selectByExample(null);
    }

    @Override
    public void deleteBatchSp(List<Integer> ids) {
        AdminExample example=new AdminExample();
        AdminExample.Criteria criteria=example.createCriteria();
        criteria.andIdIn(ids);
        adminMapper.deleteByExample(example);
    }

    @Override
    public void deleteSelectPaper(Integer id) {
        adminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public boolean checkUsername(String username) {
        AdminExample example=new AdminExample();
        AdminExample.Criteria criteria=example.createCriteria();
        criteria.andUsernameEqualTo(username);
        long count=adminMapper.countByExample(example);

        return count==0;
    }

    @Override
    public void saveAdmin(Admin admin) {
        adminMapper.insert(admin);
    }

    @Override
    public void updatePwd(Admin admin) {
        adminMapper.updateByPrimaryKeySelective(admin);
    }
}
