package com.kh.erp.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.erp.dao.NoticeDao;
import com.kh.erp.dto.NoticeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class NoticeOwnerInterceptor implements HandlerInterceptor {

	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
											HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String createdLevel = (String) session.getAttribute("createdLevel");
		boolean isAdmin = createdLevel != null && createdLevel.equals("관리자");
		boolean isDelete = request.getRequestURI().equals("/notice/delete");
		if(isAdmin && isDelete) {
			return true;
		}
		String createdUser = (String) session.getAttribute("createdUser");
		if(createdUser == null) {
			response.sendError(401);
			return false;
		}
		int noticeNo =  Integer.parseInt(request.getParameter("noticeNo"));
		
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		boolean isOwner = createdUser.equals(noticeDto.getNoticeWriter());
		
		if(isOwner) {
			return true;
		}
		else {
			response.sendError(403);
			return false;
		}
	}
}
