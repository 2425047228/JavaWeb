package com.love.home.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.love.model.DAO;
import com.love.model.User;

/**
 * Servlet implementation class login
 */
@WebServlet(
		description = "登陆处理", 
		urlPatterns = { 
				"/home/login_verify"
		})
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// TODO Auto-generated method stub
		//request.getRequestDispatcher(getServletInfo())
		//response.getWriter().append("Served at: ").append(request.getContextPath()).append(request.getRequestURI());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");    //设置响应字符集
		//获取post参数
		String phone = request.getParameter("phone");
		String pwd = request.getParameter("pwd");
		PrintWriter writer = response.getWriter();
		if (phone.equals("")) {
			writer.write("手机号不能为空");
		} else if (phone.length() != 11) {
			writer.write("手机号格式不正确");
		} else if (pwd.equals("")) {
			writer.write("密码不能为空");
		}
		DAO dao = DAO.getInstance();
		List list = dao.query("select * from user where phone = '" + phone + "'");
		System.out.println(list.size());
	}

}
