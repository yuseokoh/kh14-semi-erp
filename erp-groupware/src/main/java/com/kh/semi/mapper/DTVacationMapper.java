package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semi.dto.DTVacationDto;

@Service
public class DTVacationMapper implements RowMapper<DTVacationDto>{

	@Override
	public DTVacationDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		DTVacationDto dtVacationDto = new DTVacationDto();
		dtVacationDto.setDtVacaNo(rs.getInt("dt_vaca_no"));
		dtVacationDto.setDtVaTot(rs.getInt("dt_va_tot"));
		dtVacationDto.setDtVacaRest(rs.getInt("dt_vaca_rest"));
		dtVacationDto.setLoginID(rs.getString("loginID"));
		return dtVacationDto;
	}

}
