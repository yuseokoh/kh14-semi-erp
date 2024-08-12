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
		vacaReqDto.setVacaNo(rs.getInt("vaca_no"));
		vacaReqDto.setVacaTel(rs.getString("vaca_tel"));
		vacaReqDto.setVacaSdate(rs.getDate("vaca_sdate"));
		vacaReqDto.setVacaEdate(rs.getDate("vaca_edate"));
		vacaReqDto.setVacaReason(rs.getString("vaca_reason"));
		vacaReqDto.setVacaRej(rs.getString("vaca_rej"));
		vacaReqDto.setVacaReqDate(rs.getDate("vaca_req_date"));
		vacaReqDto.setApproDate(rs.getDate("appro_date"));
		vacaReqDto.setApproYN(rs.getString("appro_yn"));
		vacaReqDto.setApproNo(rs.getInt("appro_no"));
		vacaReqDto.setApproBos(rs.getString("appro_bos"));
		vacaReqDto.setLoginID(rs.getString("loginID"));
		
		return vacaReqDto;
	}

}
