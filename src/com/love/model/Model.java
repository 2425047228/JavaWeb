package com.love.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Model{
	protected DAO dao = DAO.getInstance();
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
	
	protected String getQueryString() {
		String str = "SELECT " + this._fields + " FROM " + this.tableName;
		if (!this._join.equals("")) {
			str += " " + this._join;
		}
		if (!this._where.equals("")) {
			str += " " + this._where;
		}
		if (!this._group.equals("")) {
			str += " " + this._group;
		}
		if (!this._order.equals("")) {
			str += " " + this._order;
		}
		if (!this._limit.equals("")) {
			str += " " + this._limit;
		}
		return str;
	}
	
	//获取单条记录方法
	public Map find() {
		List list = dao.query(this.limit(1).getQueryString());
		Map map = new HashMap();
		if (list.size() > 0) {
			map.putAll((Map) list.get(0));
		}
		return map;
	}
	
	//多条记录的方法
	public List select() {
		return dao.query(this.getQueryString());
	}
	
	//关闭数据库链接
	public void close() {
		dao.close();
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
