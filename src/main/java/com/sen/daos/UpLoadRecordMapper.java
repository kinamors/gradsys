package com.sen.daos;

import com.sen.beans.UpLoadRecord;
import com.sen.beans.UpLoadRecordExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UpLoadRecordMapper {
    int countByExample(UpLoadRecordExample example);

    int deleteByExample(UpLoadRecordExample example);

    int deleteByPrimaryKey(Integer upId);

    int insert(UpLoadRecord record);

    int insertSelective(UpLoadRecord record);

    List<UpLoadRecord> selectByExample(UpLoadRecordExample example);

    UpLoadRecord selectByPrimaryKey(Integer upId);

    int updateByExampleSelective(@Param("record") UpLoadRecord record, @Param("example") UpLoadRecordExample example);

    int updateByExample(@Param("record") UpLoadRecord record, @Param("example") UpLoadRecordExample example);

    int updateByPrimaryKeySelective(UpLoadRecord record);

    int updateByPrimaryKey(UpLoadRecord record);
}