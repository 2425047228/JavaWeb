package com.love.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
		if (code > 6 || code < 0) {
			return "";
		} else {
			String[] array = {"不限", "高中及以下", "中专", "大专", "大学本科", "硕士", "博士"};
			return array[code];
		}
	}
	
	public String marital(int code) {
		//0-不限,1-未婚,2-离婚,3-丧偶
		if (code > 3 || code < 0) {
			return "";
		} else {
			String[] array = {"不限", "未婚", "离婚", "丧偶"};
			return array[code];
		}
	}
	
	//通过用户的择偶标准匹配用户列表
	public List getUsers(Map<String, String> user) {
		String where = "user.id <> '" + user.get("id") + "' AND user.avatar <> ''";
	    if (!user.get("for_sex").equals("0")) {    //性取向
	    	where += " AND user.sex = '" + user.get("for_sex") + "'";
	    }
	    if (!user.get("for_edu").equals("0")) {    //学历
	    	where += " AND user.edu = '" + user.get("for_edu") + "'";
	    }
	    if (!user.get("for_marital").equals("0")) {    //婚姻状态
	    	where += " AND user.marital = '" + user.get("for_marital") + "'";
	    }
	    String min_age = user.get("min_age");
	    if (!min_age.equals("0")) {    //最小年龄
	    	String min_birthday = String.valueOf( Utils.getBirthdayByAge( Integer.valueOf( min_age ) ) );
	    	where += " AND user.birthday <= '" + min_birthday + "'";
	    }
	    String max_age = user.get("max_age");
	    if (!max_age.equals("0")) {    //最大年龄
	    	String max_birthday = String.valueOf( Utils.getBirthdayByAge( Integer.valueOf( max_age ) ) );
	    	where += " AND user.birthday >= '" + max_birthday + "'";
	    }
	    if (!user.get("min_height").equals("0")) {    //最低身高
	    	where += " AND user.height >= '" + user.get("min_height") + "'";
	    }
	    if (!user.get("max_height").equals("0")) {    //最高身高
	    	where += " AND user.height <= '" + user.get("max_height") + "'";
	    }
	    if (!user.get("min_income").equals("0")) {    //最低收入
	    	where += " AND user.income >= '" + user.get("min_income") + "'";
	    }
	    if (!user.get("max_income").equals("0")) {    //最高收入
	    	where += " AND user.income <= '" + user.get("max_income") + "'";
	    }
	    return this.fields("user.*, mail.from_uid").leftJoin("mail on mail.uid = user.id AND from_uid = '" + user.get("id") + "'").where(where).getAll();
	}
}
