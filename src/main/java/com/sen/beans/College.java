package com.sen.beans;

public class College {
    private String cid;

    private String cname;

    private String stuCount;

    public College() {
    }

    public College(String cid, String cname, String stuCount) {
        super();
        this.cid = cid;
        this.cname = cname;
        this.stuCount = stuCount;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid == null ? null : cid.trim();
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname == null ? null : cname.trim();
    }

    public String getStuCount() {
        return stuCount;
    }

    public void setStuCount(String stuCount) {
        this.stuCount = stuCount == null ? null : stuCount.trim();
    }
}