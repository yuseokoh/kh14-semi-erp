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
	private String vacaType; // 휴가 종료
	private String applicantId; // 신청자 ID
	private String approBosName; // 결재자 이름
	private String approBosId;// 결재자 Id
	private String approYN; // 결재여부 (Y/N)
	private int approNo; //appro_No
	private int vacaNo; //vaca_No
}
