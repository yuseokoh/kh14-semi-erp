package com.kh.erp.VO;

import java.util.List;

import lombok.Data;

@Data
public class AttendanceSummaryVO {
	private String loginID; // tb_attendance.loginID
	private String name; // tb_emp.name
	private String empDept; // tb_emp.emp_dept
	private String empGender; // tb_emp.emp_gender
	private String empHp; // tb_emp.emp_hp
	private int tbYear;
	private int tbMonth;
	private int daysWorked;
	private List<String> checkInDates; // 변환 후 리스트 형태로 저장
	private String totalWorkTime; // HH:MM:SS 형식의 문자열
}
