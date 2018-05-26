package com.sen.beans;

public class Paper {
    private Integer pId;

    private String author;

    private String pName;

    private String sno;

    private String tecName;

    private String college;

    @Override
    public String toString() {
        return "Paper{" +
                "pId=" + pId +
                ", author='" + author + '\'' +
                ", pName='" + pName + '\'' +
                ", sno='" + sno + '\'' +
                ", tecName='" + tecName + '\'' +
                ", college='" + college + '\'' +
                '}';
    }

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName == null ? null : pName.trim();
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno == null ? null : sno.trim();
    }

    public String getTecName() {
        return tecName;
    }

    public void setTecName(String tecName) {
        this.tecName = tecName == null ? null : tecName.trim();
    }

    public String getCollege() {
        return college;
    }

    public void setCollege(String college) {
        this.college = college == null ? null : college.trim();
    }
}