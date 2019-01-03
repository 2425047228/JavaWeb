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
import com.love.util.DateUtil;
import com.love.util.JWT;
import com.love.util.Utils;


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
		} else if (!user.verify(pwd)) {
			writer.write("手机号或密码错误");
		} else {
			long hours = DateUtil.hours(24);
			String token = JWT.create((String) data.get("id"), hours);
			Cookie cookie = new Cookie("token", token);
			cookie.setPath("/");
			cookie.setMaxAge((int) hours);
			response.addCookie(cookie);
		}
		user.close();	
	}
	
	//注册处理
	private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer = response.getWriter();
		String name = request.getParameter("name")
		,      sex = request.getParameter("sex")
		,      addr = request.getParameter("addr")
		,      marital = request.getParameter("marital")
		,      edu = request.getParameter("edu")
		,      phone = request.getParameter("phone")
		,      pwd = request.getParameter("pwd");
		long birthday = DateUtil.date2TimeStamp(request.getParameter("birthday"), "yyyy-MM-dd");
		int height =Integer.parseInt(request.getParameter("height"));
		int income = Integer.parseInt(request.getParameter("income"));
		User user = new User();
		Map data = user.getByPhone(phone);
		
		if (data.isEmpty()) {
			if (name.equals("") || name.length() > 8) {
				writer.write("姓名格式错误");
			} else if (!sex.equals("1") && !sex.equals("2")) {
				writer.write("性别错误");
			} else if (0 == birthday) {
				writer.write("生日错误");
			} else if (!marital.equals("1") && !marital.equals("2") && !marital.equals("3")) {
				writer.write("婚姻状况错误");
			} else if (height < 50) {
				writer.write("身高错误");
			} else if (height > 255) {
				height = 255;
			} else if (!edu.equals("1") && !edu.equals("2") && !edu.equals("3") && !edu.equals("4") && !edu.equals("5") && !edu.equals("6")) {
				writer.write("学历错误");
			} else if (income > 999999999) {
				income = 1000000000;
			} else if (income < 0) {
				writer.write("月收入错误");
			} else if (phone.length() != 11 || !Utils.isNumeric(phone)) {
				writer.write("手机号格式错误");
			} else if (pwd.equals("")) {
				writer.write("密码不能为空");
			} else {
				Map<String, String> map = new HashMap();
				map.put("name", name);
				map.put("sex", sex);
				map.put("addr", addr);
				map.put("marital", marital);
				map.put("edu", edu);
				map.put("phone", phone);
				map.put("pwd", pwd);
				map.put("birthday", String.valueOf(birthday));
				map.put("height", String.valueOf(height));
				map.put("income", String.valueOf(income));
				if (!user.register(map)) {
					writer.write("注册失败");
				}
			}
		} else {
			writer.write("该手机号已被注册");
		}
		user.close();
	}

}
