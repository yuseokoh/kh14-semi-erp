package com.kh.erp.VO;

import java.util.Date;

import lombok.Data;

@Data
public class WorkingDayVO {
	 private int empNo;         // 사원 번호
	 private String name;          // 이름
	 private Date startDate;       // 입사일
	 private Date endDate;         // 퇴사일
	 private int workingDays;      // 근무일 수

}
