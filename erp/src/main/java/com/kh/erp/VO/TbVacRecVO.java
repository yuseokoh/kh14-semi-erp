package com.kh.erp.VO;

import java.sql.Date;

import lombok.Data;

//휴가일 기록조회
//휴가와 보고서를 가져올때 쓰게만들것(보고서 아직 안됨)
//보고서 추가시 쿼리도 다시만들어야됨
@Data
public class TbVacRecVO {
	private Date vacaReqDate; // 휴가신청일 --> sysdate
	private String vacaTitle; // 휴가신청서 제목 //임시
	private String applicantId; // 신청자 ID
	private String approBos1; // 결재자1 (이름 가져올듯)
	private String approBos2; // 결재자2 (이름 가져올듯)
	private String approBos3; // 결재자3 (이름 가져올듯)
	private String approNo1; // -- 결재자1 직급 or 사번(지금당장은 loginID)
	private String approNo2; // -- 결재자1 직급 or 사번(지금당장은 loginID)
	private String approNo3; // -- 결재자1 직급 or 사번(지금당장은 loginID)
	private String approYN; // 결재여부 (Y/N)
}
