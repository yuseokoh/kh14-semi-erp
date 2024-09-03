package com.kh.semi.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReservationDto {
	private int resId;
	private int roomId;
	private int pw;
	private String roomName;
	private String guestName;
	private String resYN;
	private Date calDate;
	private String stime;
	private String etime;
}
