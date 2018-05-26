package com.sen.beans;

import java.util.Date;

public class HalfPart {
    private String sno;

    private Integer paperId;

    private String paperTitle;

    private String halfProgress;

    private String createName;

    private Date addDate;

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno == null ? null : sno.trim();
    }

    public Integer getPaperId() {
        return paperId;
    }

    public void setPaperId(Integer paperId) {
        this.paperId = paperId;
    }

    public String getPaperTitle() {
        return paperTitle;
    }

    public void setPaperTitle(String paperTitle) {
        this.paperTitle = paperTitle == null ? null : paperTitle.trim();
    }

    public String getHalfProgress() {
        return halfProgress;
    }

    public void setHalfProgress(String halfProgress) {
        this.halfProgress = halfProgress == null ? null : halfProgress.trim();
    }

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName == null ? null : createName.trim();
    }

    public Date getAddDate() {
        return addDate;
    }

    public void setAddDate(Date addDate) {
        this.addDate = addDate;
    }
}