package com.atguigu.atcrowdfunding.bean;

public class AJAXResult {

    private boolean success;
    private int succrsss;
    private Object data;

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public int getSuccrsss() {
        return succrsss;
    }

    public void setSuccrsss(int succrsss) {
        this.succrsss = succrsss;
    }
}
