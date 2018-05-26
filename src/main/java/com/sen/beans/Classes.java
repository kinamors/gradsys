package com.sen.beans;

public class Classes {
    private Integer id;

    private String className;

    private String cId;

    private College college;

    public College getCollege() {
        return college;
    }

    public void setCollege(College college) {
        this.college = college;
    }

    public Classes() {
    }


    public Classes(Integer id, String className, String cId) {
        super();
        this.id = id;
        this.className = className;
        this.cId = cId;
    }

    @Override
    public String toString() {
        return "Classes{" +
                "id=" + id +
                ", className='" + className + '\'' +
                ", cId='" + cId + '\'' +
                ", college=" + college +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className == null ? null : className.trim();
    }

    public String getcId() {
        return cId;
    }

    public void setcId(String cId) {
        this.cId = cId == null ? null : cId.trim();
    }
}