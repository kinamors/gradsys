package com.sen.daos;

import com.sen.beans.HalfPart;
import com.sen.beans.HalfPartExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface HalfPartMapper {
    int countByExample(HalfPartExample example);

    int deleteByExample(HalfPartExample example);

    int deleteByPrimaryKey(String sno);

    int insert(HalfPart record);

    int insertSelective(HalfPart record);

    List<HalfPart> selectByExample(HalfPartExample example);

    HalfPart selectByPrimaryKey(String sno);

    int updateByExampleSelective(@Param("record") HalfPart record, @Param("example") HalfPartExample example);

    int updateByExample(@Param("record") HalfPart record, @Param("example") HalfPartExample example);

    int updateByPrimaryKeySelective(HalfPart record);

    int updateByPrimaryKey(HalfPart record);
}