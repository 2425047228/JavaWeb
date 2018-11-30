package com.love.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



public final class DAO {
	private static DAO instance;
	private Connection conn;
	private final static String driver = "org.mariadb.jdbc.Driver";
	private final static String url = "jdbc:mysql://127.0.0.1:3306/love";
	private final static String user = "root";
	private final static String pwd = "";
	static {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
	
	private DAO() {}
	public static DAO getInstance() {
		if (null == instance) {
            synchronized (DAO.class) {
                if (null == instance) {
                    instance = new DAO();
                }
            }
        }
		return instance;
	}
	//建立数据库连接
	public Connection connection() {
		try {
			if (null == conn || conn.isClosed()) {
				conn = DriverManager.getConnection(url, user, pwd);    //获取链接
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	//关闭数据库连接
	public void close() {
		try {
    		if (null != conn && !conn.isClosed()) {
				conn.close();
			}
    	} catch (SQLException conn_e) {
    		conn_e.printStackTrace();
    	}
	}
	//关闭结果集和清单
	public void close(ResultSet rs, PreparedStatement stmt) {
		try {
			if(null != rs) {
				rs.close();
			}			
		} catch (SQLException rs_e) {
			rs_e.printStackTrace();
		} finally {
			try{
                if(null != stmt) {
                	stmt.close();
                }
            }catch(SQLException stmt_e){
            	stmt_e.printStackTrace();
            }
		}
	}
	//关闭全部连接
	public void closeAll(ResultSet rs, PreparedStatement stmt) {
		close(rs, stmt);
		close();
	}
}
