package com.sen.beans;

public class Teacher {
    private String tno;

    private String password;

    private String tname;

    private String mobile;

    private String education;

    private String post;

    private String email;

    private String descs;

    @Override
    public String toString() {
        return "Teacher{" +
                "tno='" + tno + '\'' +
                ", password='" + password + '\'' +
                ", tname='" + tname + '\'' +
                ", mobile='" + mobile + '\'' +
                ", education='" + education + '\'' +
                ", post='" + post + '\'' +
                ", email='" + email + '\'' +
                ", descs='" + descs + '\'' +
                '}';
    }

    public String getTno() {
        return tno;
    }

    public void setTno(String tno) {
        this.tno = tno == null ? null : tno.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname == null ? null : tname.trim();
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile == null ? null : mobile.trim();
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education == null ? null : education.trim();
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post == null ? null : post.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getDescs() {
        return descs;
    }

    public void setDescs(String descs) {
        this.descs = descs == null ? null : descs.trim();
    }
}