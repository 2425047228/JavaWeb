package com.love.util;

import java.util.Random;

public class Utils {
	
	public static boolean isNumeric(String str)
	{
		for (int i = 0; i < str.length(); i++) {
			if (!Character.isDigit(str.charAt(i))) {
				return false;
			}
		}
		return true;
	}
	
    public static String getRandomString(int len){
        //定义一个字符串（A-Z，a-z，0-9）即62位；
        String str="zxcvbnmlkjhgfdsaqwertyuiopQWERTYUIOPASDFGHJKLZXCVBNM1234567890";
        //由Random生成随机数
        Random random = new Random();  
        StringBuffer sb = new StringBuffer();
        int num;
        //长度为几就循环几次
        for (int i = 0;i < len;++i) {
            //产生0-61的数字
            num = random.nextInt(63);
            //将产生的数字通过length次承载到sb中
            sb.append(str.charAt(num));
        }
        //将承载的字符转换成字符串
        return sb.toString();
    }
}
