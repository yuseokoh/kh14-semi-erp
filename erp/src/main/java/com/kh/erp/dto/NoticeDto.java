package com.kh.erp.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class NoticeDto {
	private int noticeNo;
	private String noticeWriter;
	private String noticeTitle;
	private String noticeCont;
	private int fileNo;
	private String noticeDelYn;
	private Date noticeWtime;
	private Date noticeUtime;
	private int noticeViews;
	private int noticeLikes;
	private int noticeReplies;
	
	private int noticeGroup;
	private Integer noticeTarget;
	private int noticeDepth;
	
	public String getLoginIdString() {
		if(noticeWriter == null)
			return "탈퇴한 사용자";
		return noticeWriter;
	}
	
	public String getNoticeWtimeString() {//공지사항 작성일 출력 메소드
		Timestamp stamp = new Timestamp(noticeWtime.getTime());
		LocalDateTime time = stamp.toLocalDateTime();
		LocalDate today = LocalDate.now();
		
		if(time.toLocalDate().equals(today)) {
			return time.format(DateTimeFormatter.ofPattern("HH:mm"));
		}
		else {
			return time.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
	}
	public boolean isNew() {
		return this.noticeTarget == null;
	}
	public boolean isReply() {
		return this.noticeTarget != null;
	}
}