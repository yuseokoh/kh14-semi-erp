package com.kh.erp.dto;

import java.sql.Date;

import lombok.Data;

// 보고서 Dto 제작중..
@Data
public class TbEmpReportDto {
	private int reportNo; // 보고서 번호(주키)
	private String writerId; // 작성자 Id
	private String writerDept; // 작성자 부서
	private String writerName; // 작성자 이름
	private Date writeDate ; // 작성일자
	private String reportTitle; // 보고서 제목
	private String reportContent; // 보고서 내용
	private String reportReject; // 보고서 반려내용
	private int approNo; // 승인 번호 
}
