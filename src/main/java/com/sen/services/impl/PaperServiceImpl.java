package com.sen.services.impl;

import com.sen.beans.Paper;
import com.sen.beans.PaperExample;
import com.sen.beans.SelectPaper;
import com.sen.beans.SelectPaperExample;
import com.sen.daos.PaperMapper;
import com.sen.daos.SelectPaperMapper;
import com.sen.services.PaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("paperService")
public class PaperServiceImpl implements PaperService {

    @Autowired
    private SelectPaperMapper selectPaperMapper;
    @Autowired
    private PaperMapper paperMapper;

    //SelectPaperMapper
    @Override
    public List<SelectPaper> getAllSelectPapers() {
        return selectPaperMapper.selectByExample(null);
    }

    @Override
    public boolean checkPaperId(Integer id) {
        SelectPaperExample selectPaperExample=new SelectPaperExample();
        SelectPaperExample.Criteria criteria=selectPaperExample.createCriteria();
        criteria.andSelectIdEqualTo(id);
        long count=selectPaperMapper.countByExample(selectPaperExample);
        return count==0;
    }

    @Override
    public boolean checkPaperTitle(String title) {
        SelectPaperExample selectPaperExample=new SelectPaperExample();
        SelectPaperExample.Criteria criteria=selectPaperExample.createCriteria();
        criteria.andSelectTitleEqualTo(title);
        long count=selectPaperMapper.countByExample(selectPaperExample);
        return count==0;
    }

    @Override
    public void saveSp(SelectPaper paper) {
        selectPaperMapper.insert(paper);
    }

    @Override
    public void deleteSelectPaper(Integer id) {
        selectPaperMapper.deleteByPrimaryKey(id);

    }

    @Override
    public void deleteBatchSp(List<Integer> ids) {
        SelectPaperExample example=new SelectPaperExample();
        SelectPaperExample.Criteria criteria=example.createCriteria();
        criteria.andSelectIdIn(ids);
        selectPaperMapper.deleteByExample(example);
    }

    @Override
    public void updateSelectPaper(SelectPaper paper) {
        selectPaperMapper.updateByPrimaryKeySelective(paper);
    }

    @Override
    public SelectPaper getSelectPaperById(Integer id) {
        SelectPaper paper=selectPaperMapper.selectByPrimaryKey(id);
        return paper;
    }

    @Override
    public List<SelectPaper> getSelectPapersNotChoose() {
        return selectPaperMapper.selectPaperNotChoose();
    }

    @Override
    public List<SelectPaper> getSelectPapersHasChoose() {
        return selectPaperMapper.selectPaperHasChoose();
    }




    //PaperMapper
    @Override
    public void savePaper(Paper paper) {
        paperMapper.insert(paper);
    }

    @Override
    public void deleteBatchPaper(List<Integer> ids) {
        PaperExample example=new PaperExample();
        PaperExample.Criteria criteria=example.createCriteria();
        criteria.andPIdIn(ids);
        paperMapper.deleteByExample(example);
    }

    @Override
    public void deletePaperById(Integer id) {
        paperMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Paper> getAllPapers() {
        return paperMapper.selectByExample(null);
    }

    @Override
    public boolean checkPaperHas(Integer id) {
        PaperExample example=new PaperExample();
        PaperExample.Criteria criteria=example.createCriteria();
        criteria.andPIdEqualTo(id);
        long count=paperMapper.countByExample(example);
        return count==0;
    }

    @Override
    public List<Paper> getPaperBy(Paper paper) {
        PaperExample example=new PaperExample();
        PaperExample.Criteria criteria=example.createCriteria();
        if (paper.getpId()!=null){
            criteria.andPIdEqualTo(paper.getpId());
        }
        if (paper.getAuthor()!=""){
            criteria.andAuthorLike("%"+paper.getAuthor()+"%");
        }
        if (paper.getSno()!=""){
            criteria.andSnoLike("%"+paper.getSno()+"%");
        }
        if (paper.getTecName()!=""){
            criteria.andTecNameLike("%"+paper.getTecName()+"%");
        }
        if (paper.getCollege()!=null){
            criteria.andCollegeEqualTo(paper.getCollege());
        }
        return paperMapper.selectByExample(example);
    }

    @Override
    public Paper getPaperByPId(Integer pId) {
        return paperMapper.selectByPrimaryKey(pId);
    }
}
