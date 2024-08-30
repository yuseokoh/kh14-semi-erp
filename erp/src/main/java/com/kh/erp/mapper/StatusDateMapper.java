package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.VO.StatusDateVO;

@Service
public class StatusDateMapper implements RowMapper<StatusDateVO> {
	@Override
	public StatusDateVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		StatusDateVO statusDateVO = new StatusDateVO();
		statusDateVO.setEntryDate(rs.getString("entry_date"));
		statusDateVO.setCnt(rs.getInt("cnt"));
		return statusDateVO;
	}
}