package com.sen.services;

import com.sen.beans.Mark;

import java.util.List;

public interface MarkService {


    void saveMark(Mark mark);

    boolean checkMarkBySno(String sno);
    boolean checkMarkByPaperId(Integer pId);

    List<Mark> getAllMarks();

    List<Mark> getMarkBy(Mark mark);

    Mark getMarkBySno(String sno);
}
