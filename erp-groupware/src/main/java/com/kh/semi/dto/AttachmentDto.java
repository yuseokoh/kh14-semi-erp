package com.kh.semi.dto;

import lombok.Data;

@Data
public class AttachmentDto { //첨부파일
	private int attachmentNo; 
	private String attachmentName;
	private String attachmentType;
	private long attachmentSize;
}
