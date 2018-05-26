package com.sen.services.impl;

import com.sen.beans.Mark;
import com.sen.beans.MarkExample;
import com.sen.daos.MarkMapper;
import com.sen.services.MarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MarkServiceImpl implements MarkService {

    @Autowired
    private MarkMapper markMapper;


    @Override
    public void saveMark(Mark mark) {
        markMapper.insert(mark);
    }

    @Override
    public boolean checkMarkBySno(String sno) {
        MarkExample example=new MarkExample();
        MarkExample.Criteria criteria=example.createCriteria();
        criteria.andSnoEqualTo(sno);
        long count=markMapper.countByExample(example);
        return count==0;
    }

    @Override
    public boolean checkMarkByPaperId(Integer pId) {
        return false;
    }

    @Override
    public List<Mark> getAllMarks() {
        return markMapper.selectByExample(null);
    }

    @Override
    public List<Mark> getMarkBy(Mark mark) {
        MarkExample example=new MarkExample();
        MarkExample.Criteria criteria=example.createCriteria();
        if (mark.getSno()!=""){
            criteria.andSnoLike("%"+mark.getSno()+"%");
        }
        if (mark.getPaperId()!=null){
            criteria.andPaperIdEqualTo(mark.getPaperId());
        }
        return markMapper.selectByExample(example);
    }

    @Override
    public Mark getMarkBySno(String sno) {
        MarkExample example=new MarkExample();
        MarkExample.Criteria criteria=example.createCriteria();
        criteria.andSnoEqualTo(sno);
        List<Mark> marks=markMapper.selectByExample(example);
        if (marks.isEmpty()){
            return null;
        }
        return marks.get(0);
    }
}
