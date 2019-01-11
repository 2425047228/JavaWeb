package com.love.util;

import java.io.UnsupportedEncodingException;
import java.util.Random;

public class Utils {
	
	public static boolean isNumeric(String str)
	{
		if (null == str) {
			return false;
		} else {
			int len = str.length();
			for (int i = 0; i < len; i++) {
				if (!Character.isDigit(str.charAt(i))) {
					return false;
				}
			}
			return true;
		}
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
            num = random.nextInt(62);
            //将产生的数字通过length次承载到sb中
            sb.append(str.charAt(num));
        }
        //将承载的字符转换成字符串
        return sb.toString();
    }
    
    public static String iso2utf8(String value) throws UnsupportedEncodingException {
    	return new String(value.getBytes("ISO-8859-1"), "UTF-8");
    }
    
    
    public static long getBirthdayByAge(int age) {
    	int year = Integer.valueOf(DateUtil.timeStamp2Date(null, "yyyy"));
    	year = year - age;
    	String md = DateUtil.timeStamp2Date(null, "-MM-dd");
    	return DateUtil.date2TimeStamp(String.valueOf(year) + md, null);
    }
    
    public static int getAgeByBirthday(long birthday) {
    	String timeStamp = String.valueOf(System.currentTimeMillis() / 1000);
    	String timeStamp2 = String.valueOf(birthday);
    	
    	int y = Integer.valueOf(DateUtil.timeStamp2Date(timeStamp, "yyyy"));
    	int m = Integer.valueOf(DateUtil.timeStamp2Date(timeStamp, "MM"));
    	int d = Integer.valueOf(DateUtil.timeStamp2Date(timeStamp, "dd"));
    	
    	int y2 = Integer.valueOf(DateUtil.timeStamp2Date(timeStamp2, "yyyy"));
    	int m2 = Integer.valueOf(DateUtil.timeStamp2Date(timeStamp2, "MM"));
    	int d2 = Integer.valueOf(DateUtil.timeStamp2Date(timeStamp2, "dd"));
    	
    	int age = y - y2;
    	if (m < m2) {
    		age -= 1;
    	} else if (m <= m2 && d < d2) {
    		age -= 1;
    	}
    	
    	return age;
    }
    
}
