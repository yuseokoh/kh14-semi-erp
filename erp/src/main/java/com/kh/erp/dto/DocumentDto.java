package com.kh.erp.dto;

import lombok.Data;

@Data
public class DocumentDto {
	private int documentNo;
	private String documentName;
	private String documentType;
	private long documentSize;
}