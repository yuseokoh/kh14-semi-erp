package com.kh.erp.dto;

import java.util.Date;

import lombok.Data;

@Data
public class CertDto {
	private String certEmail;
	private String certNumber;
	private Date certTime;
}
