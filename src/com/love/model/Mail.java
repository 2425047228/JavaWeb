package com.love.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class Mail extends Model  {
	
	public int getCountByUid(String id) {
		return this.where("uid = '" + id + "' AND status = '1'").count("id");
	}
	
	//发送信息方法
	public boolean sayHi(String from_uid, String uid) {
		Map hasSayHi = this.where("uid = '" + uid + "' AND from_uid = '" + from_uid + "' AND status <> 0").get();
		if (hasSayHi.isEmpty()) {
			Map<String, String> data = new HashMap();
			data.put("uid", uid);
			data.put("from_uid", from_uid);
			data.put("send_time", String.valueOf(System.currentTimeMillis() / 1000));
			return this.insert(data);
		} else {
			return false;
		}
	}
	
	public List getMails(String uid) {
		return this.as("m")
				.fields("u.*, m.status, m.send_time, m.id mail_id")
				.leftJoin("user u on u.id = m.from_uid")
				.where("m.uid = '" + uid + "' AND m.status <> 0")
				.getAll();
	}
	
	public int read(String mail_id, String uid) {
		Map map = new HashMap();
		map.put("status", "2");
		return this.where("id = '" + mail_id + "' AND uid = '" + uid + "'").update(map);
	}
	
	public int del(String mail_id, String uid) {
		Map map = new HashMap();
		map.put("status", "0");
		return this.where("id = '" + mail_id + "' AND uid = '" + uid + "'").update(map);
	}
}
