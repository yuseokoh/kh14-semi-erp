package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.dto.TbEmpAttendanceDto;

@Service
public class TbEmpAttendanceMapper implements RowMapper<TbEmpAttendanceDto> {
	@Override
	public TbEmpAttendanceDto mapRow(ResultSet rs, int rowNum) throws SQLException {

		TbEmpAttendanceDto tbEmpAttendanceDto = new TbEmpAttendanceDto();
		tbEmpAttendanceDto.setTaAttendanceNo(rs.getInt("ta_attendance_no"));
		tbEmpAttendanceDto.setLoginId(rs.getString("loginID"));
		// DB의 TIMESTAMP값을 직접적으로가져올순있어도 SET은 할수없기에 TIMESTAMP -> LOCALDATETIME으로 변환하는 메소드
		// toLocalDateTime()로 gap 해결
		// null 체크 후 LocalDateTime으로 변환
		Timestamp checkInTimestamp = rs.getTimestamp("check_in_time");
		if (checkInTimestamp != null) {
			tbEmpAttendanceDto.setCheckInTime(checkInTimestamp.toLocalDateTime());
		} else {
			tbEmpAttendanceDto.setCheckInTime(null);
		}

		Timestamp checkOutTimestamp = rs.getTimestamp("check_out_time");
		if (checkOutTimestamp != null) {
			tbEmpAttendanceDto.setCheckOutTime(checkOutTimestamp.toLocalDateTime());
		} else {
			tbEmpAttendanceDto.setCheckOutTime(null);
		}
		
		return tbEmpAttendanceDto;
	}

}
