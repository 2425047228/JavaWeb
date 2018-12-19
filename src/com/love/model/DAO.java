package com.love.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
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
				for (int i = 0;i < count;++i) {
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
		boolean exec = false;
		try {
			ps = this.conn.prepareStatement(sql);
			exec = ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(null, ps);
		}
		return exec;
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
