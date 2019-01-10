package com.love.model;

import java.util.HashMap;
import java.util.Map;

import com.love.util.DateUtil;
import com.love.util.MD5;
import com.love.util.Utils;

public final class User extends Model {
	private Map data = null;
	public User() {

	}
	
	public boolean verify(String pwd) {
		if (
		    !this.data.isEmpty()
			&&
			this.data.containsKey("salt") 
			&& 
			this.data.containsKey("reg_time") 
			&& 
			this.data.containsKey("pwd")
		) {
			return MD5.encode(pwd + this.data.get("salt") + this.data.get("reg_time")).equals(this.data.get("pwd"));
		} else {
			return false;
		}
	}
	
	public boolean verify(String pwd, Map map) {
		if (map.containsKey("salt") && map.containsKey("reg_time") && map.containsKey("pwd")) {
			return MD5.encode(pwd + map.get("salt") + map.get("reg_time")).equals(map.get("pwd"));
		} else {
			return false;
		}
	}
	
	public Map getByPhone(String phone) {
		this.data = this.where("`phone` = '" + phone + "'").get();
		return this.data;
	}
	
	public boolean register(Map map) {
		String reg_time = String.valueOf(DateUtil.timeStamp());
		String salt = Utils.getRandomString(64);
		map.put("for_sex", map.get("sex").equals("1") ? "2" : "1");
		map.put("salt", salt);
		map.put("reg_time", reg_time);
		map.put("pwd", MD5.encode(map.get("pwd") + salt + reg_time));
		return this.insert(map);
	}
	
	public int modify(Map map) {
		String where = "id = '" + map.get("id") + "'"
		,      pwd = (String) map.get("pwd");
		map.remove("id");
		if (null == pwd || pwd.equals("")) {
			map.remove("pwd");
		} else {
			Map data = this.fields("salt, reg_time").where(where).get();
			map.put("pwd", MD5.encode((String) map.get("pwd") + data.get("salt") + data.get("reg_time")));
		}
		return this.where(where).update(map);
	}
	
	public int uploadAvatar(String id, String path) {
		Map<String, String> map = new HashMap();
		map.put("avatar", path);
		return this.where("id = '" + id + "'").update(map);
	}
	
	public String sex(int code) {
		//0-不限,1-男,2-女
		if (code > 2 || code < 0) {
			return "";
		} else {
			String[] array = {"不限", "男", "女"};
			return array[code];
		}
	}
	
	public String edu(int code) {
		//0-不限,1-高中及以下,2-中专,3-大专,4-大学本科,5-硕士,6-博士
		if (code > 2 || code < 0) {
			return "";
		} else {
			String[] array = {"不限", "高中及以下", "中专", "大专", "大学本科", "硕士", "博士"};
			return array[code];
		}
	}
	
	public String marital(int code) {
		//0-不限,1-未婚,2-离婚,3-丧偶
		if (code > 2 || code < 0) {
			return "";
		} else {
			String[] array = {"不限", "未婚", "离婚", "丧偶"};
			return array[code];
		}
	}
}
