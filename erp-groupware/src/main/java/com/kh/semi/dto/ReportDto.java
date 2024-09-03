package com.kh.semi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReportDto {
	private int repNo;			//보고서번호
	private String title;		//제목
	private String approBos;	//결재자
	private String todayGoal;	//금일목표
	private String todayGoal2;	//금일목표2
	private String todayGoal3;	//금일목표3
	private String achievement;	//달성내역
	private String achievement2;	//달성내역2
	private String achievement3;	//달성내역3
	private String noAchievementReason; //미달성이유
	private String noAchievementReason2; //미달성이유2
	private Date wdate;			//작성일자
	private String wname;		//작성자이름
	private String dept;		//부서이름
	private String approYN;     //결재여부(결재대기,결재중,결재완료)
}
