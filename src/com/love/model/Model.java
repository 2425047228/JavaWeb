package com.love.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Model{
	protected DAO dao = DAO.getInstance();
	protected String tableName = "";
	protected String sql = "";
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
		this._where = "WHERE " + where;
		return this;
	}
	
	public <K, V> Model where (Map<K, V> map) {
		for (Map.Entry entry : map.entrySet()) {
			if (this._where.equals("")) {
				this._where += "WHERE `" + entry.getKey() + "`='" + entry.getValue() + "'";
			} else {
				this._where += " AND `" + entry.getKey() + "`='" + entry.getValue() + "'";
			}
		}
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
	
	public String getSql() {
		return this.sql;
	}
	
	//清空暂存操作
	protected void clean() {
		this._fields = "";
		this._join = "";
		this._where = "";
		this._group = "";
		this._order = "";
		this._limit = "";
	}
	
	//获取查询拼接的字符串
	protected String getQueryString() {
		if (this._fields.equals("")) {
			this.fields("*");
		}
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
		this.clean();
		return str;
	}
	
	//获取单条记录方法
	public Map get() {
		this.sql = this.limit(1).getQueryString();
		List list = dao.query(this.sql);
		Map map = new HashMap();
		if (list.size() > 0) {
			map.putAll((Map) list.get(0));
		}
		return map;
	}
	
	//多条记录的方法
	public List getAll() {
		this.sql = this.getQueryString();
		return dao.query(this.sql);
	}
	
	//获取传递的map中的列名
	protected <K, V> String getColumnNames(Map<K, V> map) {
		String names = "";
		for (K key : map.keySet()) {
			if (names.equals("")) {
				names = "`" + key + "`";
			} else {
				names += ",`" + key + "`";
			}
		} 
		return names;
	}
	//获取传递map中的值
	protected <K, V> String getColumnValues(Map<K, V> map) {
		String values = "";
		for (V value : map.values()) {
			if (values.equals("")) {
				values = "'" + value + "'";
			} else {
				values += ",'" + value + "'";
			}
		}
		return values;
	}
	
	//插入数据操作
	public <K, V> boolean insert(Map<K, V> map) {
		if (!map.isEmpty()) {
			String prefix = "INSERT INTO `" + this.tableName + "`";
			String fields = "";
			String values = "";
			for (Map.Entry entry : map.entrySet()) { 
				if (fields.equals("")) {
					fields = " (`" + entry.getKey() + "`";
					values = " VALUES ('" + entry.getValue() + "'";
				} else {
					fields += (",`" + entry.getKey() + "`");
					values += (",'" + entry.getValue() + "'");
				}
			}
			return dao.insert(prefix + fields + ")" + values + ")");
		} else {
			return false;
		}
	}
	//同时插入多条数据处理
	public boolean insert(List list) {
		String prefix = "INSERT INTO `" + this.tableName + "`";
		String fields = "";
		String values = "";
		int size = list.size();
		if (size > 0) {
			Map<String, String> map;
			for (int i = 0;i < size;++i) {
				map = (Map) list.get(i);
				if (0 == i) {
					fields = " (" + this.getColumnNames(map) + ") ";
					values = "VALUES (" + this.getColumnValues(map) + ")";
				} else {
					values += ",(" + this.getColumnValues(map) + ")";
				}
			}
			return dao.insert(prefix + fields + values);
		} else {
			return false;
		}
	}
	
	//更新数据操作
	public <K, V> int update(Map<K, V> map) {
		if (!map.isEmpty()) {
			String prefix = "UPDATE `" + this.tableName + "` SET ";
			String sets = "";
			for (Map.Entry entry : map.entrySet()) { 
				if (sets.equals("")) {
					sets = "`" + entry.getKey() + "`='" + entry.getValue() + "'";
				} else {
					sets += ",`" + entry.getKey() + "`='" + entry.getValue() + "'";
				}
			}
			String where = "";
			if (!this._where.equals("")) {
				where = " " + this._where;
			}
			this.clean();
			return dao.update(prefix + sets + where);
		} else {
			this.clean();
			return 0;
		}
	}
	
	public void close() {
		dao.close();
	}
	
}
