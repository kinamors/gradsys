package com.sen.services.impl;

import com.sen.beans.College;
import com.sen.beans.CollegeExample;
import com.sen.daos.CollegeMapper;
import com.sen.services.CollegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("collegeService")
public class CollegeServiceImpl implements CollegeService {

    @Autowired
    private CollegeMapper collegeMapper;

    @Override
    public List<College> getAllColleges() {
        return collegeMapper.selectByExample(null);
    }

    @Override
    public College selectByPrimaryKey(String cid) {
        return collegeMapper.selectByPrimaryKey(cid);
    }

    @Override
    public boolean checkCId(String cid) {
        CollegeExample example=new CollegeExample();
        CollegeExample.Criteria criteria=example.createCriteria();
        criteria.andCidEqualTo(cid);
        long count=collegeMapper.countByExample(example);
        return count==0;
    }

    @Override
    public boolean checkCName(String cname) {
        CollegeExample example=new CollegeExample();
        CollegeExample.Criteria criteria=example.createCriteria();
        criteria.andCnameEqualTo(cname);
        long count=collegeMapper.countByExample(example);
        return count==0;
    }

    @Override
    public void saveCollege(College college) {
        collegeMapper.insert(college);
    }
}
