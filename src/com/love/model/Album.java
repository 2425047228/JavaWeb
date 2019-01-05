package com.love.model;

import java.util.List;

public final class Album extends Model {
	public List getPhotosByUid(String uid) {
		return this.fields("id, path").where("uid = '" + uid + "' AND status = 1").getAll();
	}
}
