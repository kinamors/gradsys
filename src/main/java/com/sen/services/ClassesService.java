package com.sen.services;

import com.sen.beans.Classes;

import java.util.List;

public interface ClassesService {

    List<Classes> getClassesByCId(String cId);

    Classes selectByPrimaryKey(Integer id);

    List<Classes> getAllWithCollege();

    boolean checkClassName(String className);
    void saveClasses(Classes record);

    void deleteBatchSp(List<Integer> del_ids);

    void deleteSelectPaper(Integer id);
}
