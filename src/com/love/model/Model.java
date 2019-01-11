package com.love.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Model{
	protected DAO dao = DAO.getInstance();
	protected String prefix = "";    //数据表名前缀
	protected String tableName = "";
	protected String as = "";
	protected String sql = "";
	protected String _fields = "";
	protected String _join = "";
	protected String _where = "";
	protected String _group = "";
	protected String _order = "";
	protected String _limit = "";
	
	public Model() {
		this.tableName = this.prefix + this.getClass().getSimpleName().toLowerCase();
	}
	public Model(String tableName) {
		this.tableName = this.prefix + tableName;
	}
	
	public Model fields(String fields) {
		this._fields = fields;
		return this;
	}
	
	public Model as(String as) {
		if (null != as) {
			this.as = as;
		}
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
		this.as = "";
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
		this.sql = "SELECT " + this._fields + " FROM " + this.tableName;
		
		if (!this.as.equals("")) {
			this.sql += " " + this.as;
		}
		if (!this._join.equals("")) {
			this.sql += " " + this._join;
		}
		if (!this._where.equals("")) {
			this.sql += " " + this._where;
		}
		if (!this._group.equals("")) {
			this.sql += " " + this._group;
		}
		if (!this._order.equals("")) {
			this.sql += " " + this._order;
		}
		if (!this._limit.equals("")) {
			this.sql += " " + this._limit;
		}
		this.clean();
		return this.sql + ";";
	}
	
	//获取单条记录方法
	public Map get() {
		return dao.queryOne(this.limit(1).getQueryString());
	}
	
	//多条记录的方法
	public List getAll() {
		return dao.query(this.getQueryString());
	}
	
	public int count(String field) {
		this.sql = "SELECT count(`" + field + "`) field_count FROM " + this.tableName;
		
		if (!this.as.equals("")) {
			this.sql += " " + this.as;
		}
		if (!this._join.equals("")) {
			this.sql += " " + this._join;
		}
		if (!this._where.equals("")) {
			this.sql += " " + this._where;
		}
		if (!this._group.equals("")) {
			this.sql += " " + this._group;
		}
		this.limit(1);
		this.sql += " " + this._limit + ";";
		this.clean();
		Map result = dao.queryOne(this.sql);
		return Integer.valueOf((String) result.get("field_count"));
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
	//获取插入记录的所有主键值
	public List getKeys() {
		return dao.getKeys();
	}
	//获取插入记录的第一个主键值
	public long getKey() {
		return dao.getKey();
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
