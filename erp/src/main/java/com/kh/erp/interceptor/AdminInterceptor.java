package com.kh.erp.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class AdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String userType = (String)session.getAttribute("userType");
//		boolean isAdmin = createdLevel !=null&&createdLevel.equals("관리자");
		boolean isAdmin = "A".equals(userType);
		if(isAdmin) {
			return true;	
		}
		else {
			response.sendRedirect("/home");//홈페이지로 추방
//			response.sendRedirect("/");
			return false;
		}
	
		
	}

}
