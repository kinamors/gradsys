package com.sen.services.impl;

import com.sen.beans.HalfPart;
import com.sen.beans.HalfPartExample;
import com.sen.daos.HalfPartMapper;
import com.sen.services.HalfPartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("halfPartService")
public class HalfPartServiceImpl implements HalfPartService {

    @Autowired
    private HalfPartMapper halfPartMapper;


    @Override
    public void saveHalfPart(HalfPart halfPart) {
        halfPartMapper.insert(halfPart);
    }

    @Override
    public void deleteBatchHP(List<String> ids) {
        HalfPartExample example=new HalfPartExample();
        HalfPartExample.Criteria criteria=example.createCriteria();
        criteria.andSnoIn(ids);
        halfPartMapper.deleteByExample(example);
    }

    @Override
    public void deleteHalfPart(String id) {
        halfPartMapper.deleteByPrimaryKey(id);
    }


    @Override
    public boolean checkProgressHas(String sno) {
        HalfPartExample example=new HalfPartExample();
        HalfPartExample.Criteria criteria=example.createCriteria();
        criteria.andSnoEqualTo(sno);
        long count=halfPartMapper.countByExample(example);
        return count==0;
    }

    @Override
    public HalfPart getProgressBySno(String sno) {
        return halfPartMapper.selectByPrimaryKey(sno);
    }

    @Override
    public List<HalfPart> getAllHalfParts() {
        return halfPartMapper.selectByExample(null);
    }

    @Override
    public HalfPart getHalfPart(String sno) {
        return halfPartMapper.selectByPrimaryKey(sno);
    }

    @Override
    public List<HalfPart> getHalfPartBy(HalfPart halfPart) {
        HalfPartExample example=new HalfPartExample();
        HalfPartExample.Criteria criteria=example.createCriteria();
        if (halfPart.getSno()!=""){
            criteria.andSnoLike("%"+halfPart.getSno()+"%");
        }
        if (halfPart.getCreateName()!=""){
            criteria.andCreateNameLike("%"+halfPart.getCreateName()+"%");
        }
        if (halfPart.getPaperId()!=null){
            criteria.andPaperIdEqualTo(halfPart.getPaperId());
        }
        return halfPartMapper.selectByExample(example);
    }
}
