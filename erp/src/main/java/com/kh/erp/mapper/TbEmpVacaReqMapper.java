package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.dto.TbEmpVacaReqDto;

@Service
public class TbEmpVacaReqMapper implements RowMapper<TbEmpVacaReqDto> {

	@Override
	public TbEmpVacaReqDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		TbEmpVacaReqDto tbEmpVacaReqDto = new TbEmpVacaReqDto();
		tbEmpVacaReqDto.setVacaNo(rs.getInt("vaca_No"));
		tbEmpVacaReqDto.setApplicantId(rs.getString("applicantId"));
		tbEmpVacaReqDto.setVacaTel(rs.getString("vaca_Tel"));
		tbEmpVacaReqDto.setVacaTitle(rs.getString("vaca_Title"));
		tbEmpVacaReqDto.setVacaReqDate(rs.getDate("vaca_Sdate"));
		tbEmpVacaReqDto.setVacaEdate(rs.getDate("vaca_Edate"));
		tbEmpVacaReqDto.setVacaType(rs.getString("vaca_Type"));
		tbEmpVacaReqDto.setVacaReason(rs.getString("vaca_Reason"));
		tbEmpVacaReqDto.setVacaReject(rs.getString("vaca_Reject"));
		tbEmpVacaReqDto.setVacaReqDate(rs.getDate("vaca_ReqDate"));
		tbEmpVacaReqDto.setApproNo(rs.getInt("appro_No"));
		return tbEmpVacaReqDto;
	}

}
