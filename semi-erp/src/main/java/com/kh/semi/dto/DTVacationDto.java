package com.kh.semi.dto;

import lombok.Data;

@Data
public class DTVacationDto { //휴가잔여
	private int dtVacaNo; //휴가잔여번호
	private int dtVaTot; //총연차
	private int dtVacaRest; //잔여연차
	private String loginID; //사번
}
