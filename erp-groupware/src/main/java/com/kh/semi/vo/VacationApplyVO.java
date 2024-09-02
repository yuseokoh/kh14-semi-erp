package com.kh.semi.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class VacationApplyVO {
	private int vacaNo; //휴가번호
	private String vacaTel; //비상연락처
	private Date vacaSdate; //휴가시작일
	private Date vacaEdate; //휴가종료일
	private String vacaType; // (추가)휴가종류
	private String vacaReason; //휴가사유
	private String vacaRej; //반려사유
	private Date vacaReqDate; //휴가신청일
	private Date approDate; //결재일자
	private String approYN; //결재여부
	private int approNo; //결재번호
	private String approBos; //(통합) 결재자 의견
	private String approBos1; //결재자1
	private String approBos2; //결재자2
	private String approBos3; //결재자3	
	private int approNo2; //사번
	
	//--------------------------

	private int loginId; //사번
	private String name; //이름
	private String empLevel; // 직급
	private String empDept; //부서
    private String empEmail; //이메일
    private String deptCd;
    private String levelCd;
}
