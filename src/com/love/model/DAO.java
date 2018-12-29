package com.love.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



public final class DAO {
	private static DAO _instance;
	private static final String driver = "org.mariadb.jdbc.Driver";
	private final String url = "jdbc:mysql://127.0.0.1:3306/love";
	private final String user = "root";
	private final String pwd = "";
	private List keys = new ArrayList();
	private Connection conn;

	static {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
	
	private DAO() {}
	public static DAO getInstance() {
		if (null == _instance) {
            synchronized (DAO.class) {
                if (null == _instance) {
                    _instance = new DAO();
                }
            }
        }
		_instance.connection();
		return _instance;
	}
	//建立数据库连接
	private void connection() {
		try {
			if (null == this.conn || this.conn.isClosed()) {
				this.conn = DriverManager.getConnection(url, user, pwd);    //获取链接
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//数据查询方法
	public List query(String sql) {
		List list = new ArrayList();
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd;
		int count;
		try {
			ps = this.conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rsmd = rs.getMetaData();
			count = rsmd.getColumnCount();
			//getColumnLabel    getColumnName
			while(rs.next())
			{
				Map tmpMap = new HashMap();
				for (int i = 1;i <= count;++i) {
					tmpMap.put(rsmd.getColumnLabel(i), rs.getString(i));
				}
				list.add(tmpMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, ps);
		}
		return list;
	}
	
	public Map queryOne(String sql) {
		Map map = new HashMap();
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd;
		int count;
		try {
			ps = this.conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rsmd = rs.getMetaData();
			count = rsmd.getColumnCount();
			//getColumnLabel    getColumnName
			if (rs.first()) {
				for (int i = 1;i <= count;++i) {
					map.put(rsmd.getColumnLabel(i), rs.getString(i));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, ps);
		}
		return map;
	}
	
	public int update(String sql) {
		PreparedStatement ps = null;
		int count = 0;
		try {
			ps = this.conn.prepareStatement(sql);
			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(null, ps);
		}
		return count;
	}
	
	public boolean insert(String sql) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int num = 0;
		try {
			ps = this.conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			num = ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			this.keys.clear();
			while (rs.next()) {
				this.keys.add(rs.getLong(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, ps);
		}
		return num > 0;
	}
	//获取插入语句的所有主键
	public List getKeys() {
		return this.keys;
	}
	//获取插入语句的第一个主键
	public long getKey() {
		return (long) this.keys.get(0);
	}
	
	
	//关闭数据库连接
	public void close() {
		try {
    		if (null != this.conn && !this.conn.isClosed()) {
    			this.conn.close();
    			this.conn = null;
			}
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
	}
	
	//关闭结果集和清单
	private void close(ResultSet rs, PreparedStatement ps) {
		try {
			if(null != rs) {
				rs.close();
			}			
		} catch (SQLException rs_e) {
			rs_e.printStackTrace();
		} finally {
			try{
                if(null != ps) {
                	ps.close();
                }
            }catch(SQLException ps_e){
            	ps_e.printStackTrace();
            }
		}
	}
	//关闭全部连接
	public void closeAll(ResultSet rs, PreparedStatement ps) {
		close(rs, ps);
		close();
	}
}
