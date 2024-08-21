package com.kh.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class SecureMemberDto {
	private String memberId;
	private String memberPw;
	private String memberNickname;
	private Date memberJoin;
}