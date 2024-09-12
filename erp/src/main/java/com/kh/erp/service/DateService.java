package com.kh.erp.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.erp.dao.TbEmpAttendanceDao;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dto.TbEmpAttendanceDto;
import com.kh.erp.dto.TbEmpDto;

@Service
public class DateService {

	@Autowired
	private TbEmpDao tbEmpDao;

	@Autowired
	private TbEmpAttendanceDao tbEmpAttendanceDao;

	public long dateChange(@RequestParam String loginId) {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		// 문자열을 LocalDateTime으로 변환하기 위한 포맷터 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

		try {
			// 문자열을 LocalDateTime으로 변환
			LocalDateTime localDateTime = LocalDateTime.parse(tbEmpDto.getEmpSdate(), formatter);

			// LocalDateTime을 LocalDate로 변환
			LocalDate sDate = localDateTime.toLocalDate();

			// 오늘 날짜(LocalDate) 구하기
			LocalDate today = LocalDate.now();

			// Sdate와 오늘 날짜 사이의 차이 계산
			long daysBetween = ChronoUnit.DAYS.between(sDate, today);

			return daysBetween;
		} catch (DateTimeParseException e) {
			return -1; // 에러 발생 시 -1 반환
		}
	}

	public String TimeChangeIn(@RequestParam String loginId) {
		TbEmpAttendanceDto tbEmpAttendanceDto = tbEmpAttendanceDao.selectTodayRecordById(loginId);
		if (tbEmpAttendanceDto != null) {
			LocalDateTime dateTime = tbEmpAttendanceDto.getCheckInTime();
			// 원하는 형식으로 LocalDateTime을 String으로 변환
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM월dd일 HH시mm분ss초");
			String formattedDateStr = dateTime.format(formatter);

			return formattedDateStr;
		} else
			return "출근 필요";
	}

	public String TimeChangeOut(@RequestParam String loginId) {
		TbEmpAttendanceDto tbEmpAttendanceDto = tbEmpAttendanceDao.selectTodayRecordById(loginId);
		if (tbEmpAttendanceDto != null) {
			LocalDateTime dateTime = tbEmpAttendanceDto.getCheckOutTime();
			if (dateTime == null)
				return "퇴근 필요";
			// 원하는 형식으로 LocalDateTime을 String으로 변환
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM월dd일 HH시mm분ss초");
			String formattedDateStr = dateTime.format(formatter);

			return formattedDateStr;
		} else
			return null;
	}
}
