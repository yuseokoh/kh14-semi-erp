package com.kh.erp.dto;

import java.sql.Date;

import lombok.Data;

//휴가 DTO
@Data
public class TbEmpVacaReqDto {
	private int vacaNo; // 휴가번호 
	private String applicantId; // 신청자 ID
	private String vacaTel; // 비상 연락처
	private String vacaTitle; // 휴가신청서 제목 //임시 
	private Date vacaSdate; // 휴가시작일
	private Date vacaEdate; // 휴가종료일
	private String vacaType; // 휴가종류
	private String vacaReason; // 휴가사유
	private String vacaReject; // 반려사유
	private Date vacaReqDate; // 휴가신청일 --> sysdate
	private int approNo; // 승인번호
}
