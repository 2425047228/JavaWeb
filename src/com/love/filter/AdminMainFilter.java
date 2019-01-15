package com.love.filter;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.love.util.JWT;

/**
 * Servlet Filter implementation class AdminMainFilter
 */
@WebFilter("/admin/main/*")
public class AdminMainFilter implements Filter {

    /**
     * Default constructor. 
     */
    public AdminMainFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest hsr = (HttpServletRequest) request;
		Cookie[] cookies = hsr.getCookies();
		int len = cookies.length;
		String token = null;
		for (int i = 0;i < len;++i) {
			if (cookies[i].getName().equals("admin_token")) {
				token = cookies[i].getValue();
				break;
			}
		}
		HttpServletResponse hsp = (HttpServletResponse) response;
		if (null != token) {
			Map sign = JWT.parse(token);
			if (!sign.isEmpty()) {
				Date expiration = (Date) sign.get("expiration");
				if (expiration.getTime() < System.currentTimeMillis()) {
					hsp.sendRedirect("../login.jsp");
					return;
				} else {
					request.setAttribute("id", sign.get("subject"));
				}
			} else {
				hsp.sendRedirect("../login.jsp");
				return;
			}
		} else {
			hsp.sendRedirect("../login.jsp");
			return;
		}
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
