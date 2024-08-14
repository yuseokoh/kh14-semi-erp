package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semi.dto.VacaReqDto;



@Service
public class VacaReqMapper implements RowMapper<VacaReqDto>{

	@Override
	public VacaReqDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		VacaReqDto vacaReqDto = new VacaReqDto(); 
		vacaReqDto.setVacaNo(rs.getInt("vaca_no")); //휴가번호
		vacaReqDto.setVacaTel(rs.getString("vaca_tel")); //비상연락처
		vacaReqDto.setVacaSdate(rs.getDate("vaca_sdate")); //휴가시작일
		vacaReqDto.setVacaEdate(rs.getDate("vaca_edate")); //휴가종료일
		vacaReqDto.setVacaReason(rs.getString("vaca_reason"));//휴가사유
		vacaReqDto.setVacaRej(rs.getString("vaca_rej"));//반려사유
		vacaReqDto.setVacaReqDate(rs.getDate("vaca_req_date"));//휴가신청일
		vacaReqDto.setApproDate(rs.getDate("appro_date"));//결재일자
		vacaReqDto.setApproYN(rs.getString("appro_yn")); //결재여부
		vacaReqDto.setApproNo(rs.getInt("appro_no"));//결재번호
		vacaReqDto.setApproBos(rs.getString("appro_bos"));//결재자
		vacaReqDto.setApproNo2(rs.getInt("appro_no2"));//사번
		
		return vacaReqDto;
	}

}
