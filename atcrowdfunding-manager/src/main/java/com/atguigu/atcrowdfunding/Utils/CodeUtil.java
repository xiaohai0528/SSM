package com.atguigu.atcrowdfunding.Utils;

import java.util.UUID;

public class CodeUtil {
    //生成唯一的激活码
    public String generateUniqueCode(){
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
