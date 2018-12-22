package com.love.model;

import java.util.HashMap;
import java.util.Map;

import com.love.util.MD5;

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
}
