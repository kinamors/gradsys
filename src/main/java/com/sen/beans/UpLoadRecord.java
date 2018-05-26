package com.sen.beans;

import java.util.Date;

public class UpLoadRecord {
    private Integer upId;

    private String upFilename;

    private String upFileType;

    private String upUrl;

    private String upUserName;

    private Date upTime;

    private String upSno;

    @Override
    public String toString() {
        return "UpLoadRecord{" +
                "upId=" + upId +
                ", upFilename='" + upFilename + '\'' +
                ", upFileType='" + upFileType + '\'' +
                ", upUrl='" + upUrl + '\'' +
                ", upUserName='" + upUserName + '\'' +
                ", upTime=" + upTime +
                ", upSno='" + upSno + '\'' +
                '}';
    }

    public Integer getUpId() {
        return upId;
    }

    public void setUpId(Integer upId) {
        this.upId = upId;
    }

    public String getUpFilename() {
        return upFilename;
    }

    public void setUpFilename(String upFilename) {
        this.upFilename = upFilename == null ? null : upFilename.trim();
    }

    public String getUpFileType() {
        return upFileType;
    }

    public void setUpFileType(String upFileType) {
        this.upFileType = upFileType == null ? null : upFileType.trim();
    }

    public String getUpUrl() {
        return upUrl;
    }

    public void setUpUrl(String upUrl) {
        this.upUrl = upUrl == null ? null : upUrl.trim();
    }

    public String getUpUserName() {
        return upUserName;
    }

    public void setUpUserName(String upUserName) {
        this.upUserName = upUserName == null ? null : upUserName.trim();
    }

    public Date getUpTime() {
        return upTime;
    }

    public void setUpTime(Date upTime) {
        this.upTime = upTime;
    }

    public String getUpSno() {
        return upSno;
    }

    public void setUpSno(String upSno) {
        this.upSno = upSno == null ? null : upSno.trim();
    }
}