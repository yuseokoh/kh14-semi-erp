package com.kh.erp.interceptor;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.erp.dao.NoticeDao;
import com.kh.erp.dto.NoticeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class NoticeViewsInterceptor implements HandlerInterceptor {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String testUser = (String) session.getAttribute("testUser");
		if(testUser == null) {//비회원이 글을 읽으면 조회수 증가X
			return true;
		}
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		if(testUser.equals(noticeDto.getNoticeWriter())) {//본인 글을 읽을때는 조회수 증가X
			return true;
		}
		
		Set<Integer> history = (Set<Integer>) session.getAttribute("history");
		if(history == null) {
			history = new HashSet<>();
		}
		if(history.add(noticeNo)) {
			noticeDao.updateNoticeViews(noticeNo);//조회수 증가
		}
		session.setAttribute("history", history);
		return true;
	}

}
