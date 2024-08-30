package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.VO.WorkingDayVO;



@Service
public class WorkingDayMapper implements RowMapper<WorkingDayVO> {

	@Override
	public WorkingDayVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		WorkingDayVO workingDayVO = new WorkingDayVO();
		workingDayVO.setEmpNo(rs.getInt("empNo"));
        workingDayVO.setName(rs.getString("name"));
        workingDayVO.setStartDate(rs.getDate("startDate"));
        workingDayVO.setEndDate(rs.getDate("endDate"));
        workingDayVO.setWorkingDays(rs.getInt("workingDays"));
		return workingDayVO;
	}

}
