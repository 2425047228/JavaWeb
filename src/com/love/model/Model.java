package com.love.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Model{
	protected String tableName = "";
	protected String _fields = "";
	protected String _join = "";
	protected String _where = "";
	protected String _group = "";
	protected String _order = "";
	protected String _limit = "";
	
	public Model() {
		this.tableName = this.getClass().getSimpleName().toLowerCase();
	}
	public Model(String tableName) {
		this.tableName = tableName;
	}
	
	protected String getQueryString() {
		return "SELECT " + this._fields + " FROM " + this.tableName 
				+ " " + this._join + " " + this._where
				+ " " + this._group + " " + this._order + " " + this._limit;
	}
	
	public Model fields(String fields) {
		this._fields = fields;
		return this;
	}
	
	public Model leftJoin(String join) {
		this._join = this._join + " LEFT JOIN " + join;
		return this;
	}
	
	public Model rightJoin(String join) {
		this._join = this._join + " RIGHT JOIN " + join;
		return this;
	}
	
	public Model innerJoin(String join) {
		this._join = this._join + " INNER JOIN " + join;
		return this;
	}
	
	public Model where(String where) {
		this._where = where;
		return this;
	}
	
	public Model group(String group) {
		this._group = "GROUP BY " + group;
		return this;
	}
	
	public Model order(String order) {
		this._order = "ORDER BY " + order;
		return this;
	}
	public Model limit(int num) {
		this._limit = "LIMIT " + num;
		return this;
	}
	public Model limit(int start, int num) {
		this._limit = "LIMIT " + start + "," + num;
		return this;
	}
	
	
	public Map find() {
		Map map = new HashMap();
		this.getQueryString();
		return map;
	}
	
	public List select() {
		List list = new ArrayList();
		this.getQueryString();
		return list;
	}
	
//	public <M> M test(M m) {
//		System.out.println(this.getClass().getSimpleName().toLowerCase());
//		return m;
//	}
	
	
//	public <M> M test(M m) {
//		System.out.println(m);
//		return m;
//	}
	
	
//	public static <M> M getInstance() {
//		//return ;
//	}
}
