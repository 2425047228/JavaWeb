package com.love.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.love.util.DateUtil;

public final class Album extends Model {
	public List getPhotosByUid(String uid) {
		return this.fields("id, path, upload_time").where("uid = '" + uid + "' AND status = 1").getAll();
	}
	
	public boolean upload(String uid, String path) {
		int count = this.where("uid = '" + uid + "' AND status = 1").count("id");
		if (count > 5) {
			return false;
		}
		Map<String, String> map = new HashMap();
		map.put("uid", uid);
		map.put("path", path);
		map.put("upload_time", String.valueOf(System.currentTimeMillis() / 1000));
		return this.insert(map);
	}
	
	public int del(String uid, String photo_id) {
		Map<String, String> map = new HashMap();
    	map.put("status", "0");
    	return this.where("id = '" + photo_id + "' AND uid = '" + uid + "'").update(map);
	}
}
