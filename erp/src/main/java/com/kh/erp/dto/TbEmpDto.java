package com.kh.erp.dto;
import java.util.Date;
import lombok.Data;

@Data
public class TbEmpDto {
		private String loginId;
		private String userType;
		private String empNo;
		private String name;
		private String password;
		private String empLevel;
		private String empDept;
		private String empGender;
		private String empHp;
		private String empEmail;
		private String empBirth;
		private String empEdu;
		private String empSdate;
		private Date empEdate;
		private int empFinalMoney;
		private String empReason;
		private String empMemo;
		private String empAccountNumber;
    	private String empBank;
    	private String empPost;
    	private String empAddress1;
    	private String empAddress2;
    	private int salSan;
    	private int salKo;
    	private int salKun;
    	private int salKuk;
    	private String salDate;
    	private int salPre;
    	private int salAfter;
}