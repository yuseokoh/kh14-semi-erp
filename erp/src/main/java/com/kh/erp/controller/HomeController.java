package com.kh.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.erp.dao.NoticeDao;
import com.kh.erp.dao.ReservationDao;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dto.NoticeDto;
import com.kh.erp.dto.ReservationDto;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.service.DateService;
import com.kh.erp.service.NameChangeService;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class HomeController {
	@Autowired
	private TbEmpDao tbEmpDao;

	@Autowired
	private NameChangeService nameChangeService;
	
	@Autowired
    private ReservationDao reservationDao;
	
	@Autowired
	private DateService dateService;
	
	@Autowired
	private NoticeDao noticeDao;

	
	@Value("${server.servlet.context-path}")
    private String contextPath;
	
	// 로그인 페이지로 리디렉션
	@RequestMapping("/")
	public String redirectToLogin() {
		return "redirect:/tb/login";
	}

	// 홈 페이지로 접근할 수 있는 새 주소
	@RequestMapping("/home")
	public String home(HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("createdUser");
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		String inTime = dateService.TimeChangeIn(loginId);
		String outTime = dateService.TimeChangeOut(loginId);
		List<NoticeDto> noticeList = noticeDao.selectList();
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("inTime",inTime);
		model.addAttribute("outTime",outTime);
		model.addAttribute("tbEmpDto",tbEmpDto);
		List<ReservationDto> allReservations = reservationDao.selectAllReservations();
	    model.addAttribute("allReservations", allReservations);
        return "/WEB-INF/views/erp/main1.jsp";
    }
}