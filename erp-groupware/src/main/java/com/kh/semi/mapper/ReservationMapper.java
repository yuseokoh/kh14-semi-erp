package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semi.dto.ReservationDto;

@Service
public class ReservationMapper implements RowMapper<ReservationDto>{

	@Override
	public ReservationDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReservationDto reservationDto = new ReservationDto();
		reservationDto.setResId(rs.getInt("res_id"));
		reservationDto.setRoomId(rs.getInt("room_id"));
		reservationDto.setPw(rs.getInt("pw"));
		reservationDto.setCalDate(rs.getDate("calDate"));
		reservationDto.setRoomName(rs.getString("room_name"));
		reservationDto.setGuestName(rs.getString("guest_name"));
		reservationDto.setResYN(rs.getString("resYN"));
		reservationDto.setStime(rs.getString("stime"));
		reservationDto.setEtime(rs.getString("etime"));
		return reservationDto;
	}

}
