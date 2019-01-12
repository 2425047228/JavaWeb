package com.love.model;

import java.util.Map;

import com.love.util.MD5;

public final class Admin extends Model  {
	//登陆验证,返回登陆账户的id
	public String sign(String account, String pwd) {
		Map<String, String> data = this.getAdminByAccount(account);
		if (!data.isEmpty() && MD5.encode(pwd + data.get("salt") + data.get("create_time")).equals(data.get("pwd"))) {
			return data.get("id");
		} else {
			return "";
		}
	}
	
	public Map getAdminById(String id) {
		return this.where("id = '" + id + "'").get();
	}
	public Map getAdminByAccount(String account) {
		return this.where("account = '" + account + "'").get();
	}
}
