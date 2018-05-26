package com.sen.beans;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    //100 处理成功 101 处理失败
    private int code;

    private String Msg;

    private Map<String, Object> extendMap = new HashMap<>();

    public static Msg success() {
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }
    public static Msg failure() {
        Msg result = new Msg();
        result.setCode(101);
        result.setMsg("处理失败");
        return result;
    }
    public Msg add(String str,Object obj){
        this.extendMap.put(str,obj);
        return this;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return Msg;
    }

    public void setMsg(String msg) {
        Msg = msg;
    }

    public Map<String, Object> getExtendMap() {
        return extendMap;
    }

    public void setExtendMap(Map<String, Object> extendMap) {
        this.extendMap = extendMap;
    }
}
