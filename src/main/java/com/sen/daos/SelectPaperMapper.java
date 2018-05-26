package com.sen.daos;

import com.sen.beans.SelectPaper;
import com.sen.beans.SelectPaperExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SelectPaperMapper {
    int countByExample(SelectPaperExample example);

    int deleteByExample(SelectPaperExample example);

    int deleteByPrimaryKey(Integer selectId);

    int insert(SelectPaper record);

    int insertSelective(SelectPaper record);

    List<SelectPaper> selectByExample(SelectPaperExample example);

    SelectPaper selectByPrimaryKey(Integer selectId);

    int updateByExampleSelective(@Param("record") SelectPaper record, @Param("example") SelectPaperExample example);

    int updateByExample(@Param("record") SelectPaper record, @Param("example") SelectPaperExample example);

    int updateByPrimaryKeySelective(SelectPaper record);

    int updateByPrimaryKey(SelectPaper record);
    List<SelectPaper> selectPaperNotChoose();
    List<SelectPaper> selectPaperHasChoose();
}