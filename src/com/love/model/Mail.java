package com.love.model;

public final class Mail extends Model  {
	
	public int getCountByUid(String id) {
		return this.where("uid = '" + id + "' AND status = '1'").count("id");
	}
}
