package com.sen.services;

import com.sen.beans.Paper;
import com.sen.beans.SelectPaper;

import java.util.List;

public interface PaperService {
    //selectPaper
    public List<SelectPaper> getAllSelectPapers();
    public boolean checkPaperId(Integer id);
    public boolean checkPaperTitle(String title);

    public void saveSp(SelectPaper paper);
    public void deleteSelectPaper(Integer id);
    public void deleteBatchSp(List<Integer> ids);
    public void updateSelectPaper(SelectPaper paper);
    public SelectPaper getSelectPaperById(Integer id);

    public List<SelectPaper> getSelectPapersNotChoose();
    public List<SelectPaper> getSelectPapersHasChoose();


    //Paper

    void savePaper(Paper paper);
    void deleteBatchPaper(List<Integer> ids);
    void deletePaperById(Integer id);
    List<Paper> getAllPapers();

    boolean checkPaperHas(Integer id);

    List<Paper> getPaperBy(Paper paper);

    Paper getPaperByPId(Integer pId);
}
