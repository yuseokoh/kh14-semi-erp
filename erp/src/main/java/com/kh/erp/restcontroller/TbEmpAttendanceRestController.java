package com.kh.erp.restcontroller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.erp.dao.TbEmpAttendanceDao;
import com.kh.erp.dto.TbEmpAttendanceDto;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/rest/attendance")
public class TbEmpAttendanceRestController {

	@Autowired
	private TbEmpAttendanceDao tbEmpAttendanceDao;

	@PostMapping("/start")
	public String startCommuting(HttpSession session) {
		// 출근 시간 처리 로직
		String loginId = (String) session.getAttribute("createdUser");
		int seq = tbEmpAttendanceDao.sequence();

		tbEmpAttendanceDao.insert(loginId, seq);
		// 시간 받기
		LocalDateTime checkOutTime = tbEmpAttendanceDao.selectOneById(loginId).getCheckInTime();
		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("a h:mm:ss", Locale.KOREAN);
		// 포맷된 문자열로 변환
		String formattedCheckOutTime = checkOutTime.format(formatter);
		return formattedCheckOutTime;
	}

	@PostMapping("/end")
	public String endCommuting(HttpSession session) {
		// 퇴근 시간 처리 로직
		String loginId = (String) session.getAttribute("createdUser");

		TbEmpAttendanceDto tbEmpAttendanceDto = tbEmpAttendanceDao.selectOneById(loginId);
		tbEmpAttendanceDao.updateCheckOutTime(tbEmpAttendanceDto.getTaAttendanceNo());

		// 시간 받기
		LocalDateTime checkOutTime = tbEmpAttendanceDao.selectOneById(loginId).getCheckOutTime();
		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("a h:mm:ss", Locale.KOREAN);
		// 포맷된 문자열로 변환
		String formattedCheckOutTime = checkOutTime.format(formatter);

		return formattedCheckOutTime;
	}

	
//	//상태조회
//	@PostMapping("/check")
//	public String check() {
//		//TODO: process POST request
//		
//		return entity;
//	}
	
}
