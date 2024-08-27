package com.kh.erp.dto;


import java.time.LocalDateTime;

import lombok.Data;

//단순 일간 출퇴근 기록용
@Data
public class TbEmpAttendanceDto {
	private int taAttendanceNo; // 번호
	private String loginId; // 로그인 아이디 == UserDto의 loginId
	private LocalDateTime  checkInTime; // 출근 시각
	private LocalDateTime  checkOutTime; // 퇴근 시각
}
