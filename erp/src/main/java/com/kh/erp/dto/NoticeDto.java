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
	private Date noticeDate;
	private String noticeCont;
	private int fileNo;
	private String noticeDelYn;
	
	private int noticeGroup;
	private Integer noticeTarget;
	private int noticeDepth;
	
	public String getLoginIdString() {
		if(noticeWriter == null)
			return "탈퇴한 사용자";
		return noticeWriter;
	}
	
	public String getNoticeDate() {
		Timestamp stamp = new Timestamp(noticeDate.getTime());
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