package com.love.util;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class DateUtil {
	/** 
     * 时间戳转换成日期格式字符串 
     * @param seconds 精确到秒的字符串 
     * @param formatStr 
     * @return 
     */  
    public static String timeStamp2Date(String seconds,String format) {  
        if(seconds == null || seconds.isEmpty() || seconds.equals("null")){  
            return "";  
        }  
        if(format == null || format.isEmpty()) format = "yyyy-MM-dd HH:mm:ss";  
        SimpleDateFormat sdf = new SimpleDateFormat(format);  
        return sdf.format(new Date(Long.valueOf(seconds+"000")));  
    }  
    /** 
     * 日期格式字符串转换成时间戳 （精确到秒） 
     * @param date 字符串日期 
     * @param format 如：yyyy-MM-dd HH:mm:ss 
     * @return 
     */  
    public static long date2TimeStamp(String date,String format){  
        try {  
            SimpleDateFormat sdf = new SimpleDateFormat(format);  
            return sdf.parse(date).getTime() / 1000;  
        } catch (Exception e) {
            e.printStackTrace();  
        }  
        return 0;  
    }  
      
    /** 
     * 取得当前时间戳（精确到秒） 
     * @return 
     */  
    public static long timeStamp(){
    	return System.currentTimeMillis() / 1000;
    } 
    
    public static long timeStamp(int hours) {
    	return (System.currentTimeMillis() / 1000 + DateUtil.hours(hours));
    }
    
    public static long hours(int hours) {
    	return hours * 3600;
    }
    
    public static long minutes(int minutes) {
    	return minutes * 60;
    }
}
