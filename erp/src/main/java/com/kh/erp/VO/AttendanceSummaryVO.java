package com.kh.erp.VO;

import java.util.List;

import lombok.Data;

@Data
public class AttendanceSummaryVO {
    private String loginId;
    private int tbYear;
    private int tbMonth;
    private int daysWorked;
    private List<String> checkInDates; // 변환 후 리스트 형태로 저장
    private String totalWorkTime; // HH:MM:SS 형식의 문자열
}

