package com.sen.services.impl;

import com.sen.beans.UpLoadRecord;
import com.sen.beans.UpLoadRecordExample;
import com.sen.daos.UpLoadRecordMapper;
import com.sen.services.UpRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("upRecordService")
public class UpRecordServiceImpl implements UpRecordService {

    @Autowired
    private UpLoadRecordMapper upLoadRecordMapper;


    @Override
    public void saveUpRecord(UpLoadRecord upLoadRecord) {
        upLoadRecordMapper.insert(upLoadRecord);
    }

    @Override
    public List<UpLoadRecord> getReportUpRecord() {
        UpLoadRecordExample example=new UpLoadRecordExample();
        UpLoadRecordExample.Criteria criteria=example.createCriteria();
        criteria.andUpFileTypeEqualTo("report");
        return upLoadRecordMapper.selectByExample(example);
    }

    @Override
    public List<UpLoadRecord> getTransUpRecord() {
        UpLoadRecordExample example=new UpLoadRecordExample();
        UpLoadRecordExample.Criteria criteria=example.createCriteria();
        criteria.andUpFileTypeEqualTo("trans");
        return upLoadRecordMapper.selectByExample(example);
    }

    @Override
    public List<UpLoadRecord> getPaperUpRecord() {
        UpLoadRecordExample example=new UpLoadRecordExample();
        UpLoadRecordExample.Criteria criteria=example.createCriteria();
        criteria.andUpFileTypeEqualTo("paper");
        return upLoadRecordMapper.selectByExample(example);
    }

    @Override
    public void deleteFiles(Integer id) {
        upLoadRecordMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<UpLoadRecord> getAllUpRecord() {
        return upLoadRecordMapper.selectByExample(null);
    }

    @Override
    public List<UpLoadRecord> getUpRecordBy(UpLoadRecord upLoadRecord) {
        UpLoadRecordExample example=new UpLoadRecordExample();
        UpLoadRecordExample.Criteria criteria=example.createCriteria();
        if (upLoadRecord.getUpSno()!=""){
            criteria.andUpSnoLike("%"+upLoadRecord.getUpSno()+"%");
        }
        if (upLoadRecord.getUpUserName()!=""){
            criteria.andUpUserNameLike("%"+upLoadRecord.getUpUserName()+"%");
        }
        if (upLoadRecord.getUpFileType()!=""){
            criteria.andUpFileTypeEqualTo(upLoadRecord.getUpFileType());
        }


        return upLoadRecordMapper.selectByExample(example);
    }


}
