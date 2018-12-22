package com.love.home.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import io.jsonwebtoken.*;
import io.jsonwebtoken.impl.JwtMap;

import com.love.model.DAO;
import com.love.model.User;
import com.love.util.JWT;


/**
 * Servlet implementation class verify
 */
@WebServlet(
		description = "前台验证Servlet", 
		urlPatterns = { 
				"/home/verify_login", 
				"/home/verify_register"
		})
public class verify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public verify() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");    //设置响应字符集
		if (request.getRequestURI().indexOf("/home/verify_login") != -1) {    //登陆验证
			this.login(request, response);
		} else if (request.getRequestURI().indexOf("/home/verify_register") != -1) {    //注册验证
			this.register(request, response);
		}
	}
	
	//登陆处理
	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map param = request.getParameterMap();
		System.out.println(param.toString());
		String token = JWT.create("this is a token", 1000);
		System.out.println(token);
		JWT.parse(token);
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
		User user = new User();
		Map data = user.getByPhone(phone);
		if (data.isEmpty()) {
			writer.write("用户不存在");
		} else if (user.verify(pwd)) {
//			HttpSession session = request.getSession();
//			Cookie[] cookie = request.getCookies();
		} else {
			writer.write("手机号或密码错误");
		}
		System.out.println(data.isEmpty());
		
	}
	
	//注册处理
	private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map param = request.getParameterMap();
		System.out.println(param.toString());
	}

}
