package com.sen.services.impl;

import com.sen.beans.Classes;
import com.sen.beans.ClassesExample;
import com.sen.daos.ClassesMapper;
import com.sen.services.ClassesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("classesService")
public class ClassesServiceImpl implements ClassesService {

    @Autowired
    private ClassesMapper classesMapper;

    @Override
    public List<Classes> getClassesByCId(String cId) {
        ClassesExample example=new ClassesExample();
        ClassesExample.Criteria criteria=example.createCriteria();
        criteria.andCIdEqualTo(cId);
        return classesMapper.selectByExample(example);
    }

    @Override
    public Classes selectByPrimaryKey(Integer id) {
        return classesMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Classes> getAllWithCollege() {
        return classesMapper.selectByExampleWithCollege(null);
    }

    @Override
    public boolean checkClassName(String className) {
        ClassesExample example=new ClassesExample();
        ClassesExample.Criteria criteria=example.createCriteria();
        criteria.andClassNameEqualTo(className);
        long count=classesMapper.countByExample(example);
        return count==0;
    }

    @Override
    public void saveClasses(Classes record) {
        classesMapper.insert(record);
    }

    @Override
    public void deleteBatchSp(List<Integer> del_ids) {
        ClassesExample example=new ClassesExample();
        ClassesExample.Criteria criteria=example.createCriteria();
        criteria.andIdIn(del_ids);
        classesMapper.deleteByExample(example);
    }

    @Override
    public void deleteSelectPaper(Integer id) {
        classesMapper.deleteByPrimaryKey(id);
    }

}
