package com.love.home.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.love.util.Utils;

/**
 * Servlet implementation class logout
 */
@WebServlet(
		description = "退出登陆Servlet", 
		urlPatterns = { 
				"/home/main/logout"
		})
public class logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public logout() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Cookie cookie = new Cookie("token", null);
		cookie.setPath("/");
		cookie.setMaxAge(1);
		response.addCookie(cookie);
		Cookie[] cookies = request.getCookies();
		int len = cookies.length;
		String token = null;
		for (int i = 0;i < len;++i) {
			if (cookies[i].getName().equals("token")) {
				token = cookies[i].getValue();
				break;
			}
		}
		response.sendRedirect(Utils.dir + "home/login.html");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
