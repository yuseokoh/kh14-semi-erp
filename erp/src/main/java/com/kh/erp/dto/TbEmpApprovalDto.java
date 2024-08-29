package com.kh.erp.dto;

import java.sql.Date;

import lombok.Data;

//결재 DTO
@Data
public class TbEmpApprovalDto {
	private int approNo; // 결재번호
	private String approType; // 결재 타입 (예: '휴가', '출장' 등)
	private Date approDate; // 결재일자
	private String approYN; // 결재여부 (Y/N)
	private String approBos1; // 결재자1 (이름 가져올듯)
	private String approBos2; // 결재자2 (이름 가져올듯)
	private String approBos3; // 결재자3 (이름 가져올듯)
	private String approNo1; // -- 결재자1 직급 or 사번(지금당장은 loginID)
	private String approNo2; // -- 결재자1 직급 or 사번(지금당장은 loginID)
	private String approNo3; // -- 결재자1 직급 or 사번(지금당장은 loginID)
	private String applicantId; // 신청자 ID
}