package com.love.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.love.model.User;

/**
 * Servlet Filter implementation class HomeFilter
 */
@WebFilter("/home/*")
public class HomeFilter implements Filter {

    /**
     * Default constructor. 
     */
    public HomeFilter() {
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
		// TODO Auto-generated method stub
		// place your code here
//		User u = new User();
//		Map map = u.fields("*").find();
//		System.out.println(map.isEmpty());
//		Map<String, String> data = new HashMap();
//		data.put("name", "杨云龙");
//		data.put("age", "22");
//		data.put("sex", "1");
//		List list = new ArrayList();
//		list.add(data);
//		list.add(data);
//		list.add(data);
//		u.where("id = 1").update(data);
//		u.close();
		//new User().test();
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		
		HttpSession session = httpRequest.getSession();
//		if (session.getAttribute("id").equals(null) && httpRequest.getRequestURI() == "") {
//			
//		} else {
//			
//		}
		httpRequest.getHttpServletMapping();
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		httpRequest.getSession();
		System.out.println(httpRequest.getRequestURI());    ///LoveAffair/home/login.html
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
