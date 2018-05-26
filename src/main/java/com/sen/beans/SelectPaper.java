package com.sen.beans;

import java.util.Date;

public class SelectPaper {
    private Integer selectId;

    private String selectTitle;

    private String selectMsg;

    private String createName;

    private Date addDate;

    @Override
    public String toString() {
        return "SelectPaper{" +
                "selectId=" + selectId +
                ", selectTitle='" + selectTitle + '\'' +
                ", selectMsg='" + selectMsg + '\'' +
                ", createName='" + createName + '\'' +
                ", addDate=" + addDate +
                '}';
    }

    public Integer getSelectId() {
        return selectId;
    }

    public void setSelectId(Integer selectId) {
        this.selectId = selectId;
    }

    public String getSelectTitle() {
        return selectTitle;
    }

    public void setSelectTitle(String selectTitle) {
        this.selectTitle = selectTitle == null ? null : selectTitle.trim();
    }

    public String getSelectMsg() {
        return selectMsg;
    }

    public void setSelectMsg(String selectMsg) {
        this.selectMsg = selectMsg == null ? null : selectMsg.trim();
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