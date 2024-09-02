package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semi.dto.MeetingroomDto;

@Service
public class MeetingroomMapper implements RowMapper<MeetingroomDto>{

	@Override
	public MeetingroomDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MeetingroomDto meetingroomDto = new MeetingroomDto();
		meetingroomDto.setRoomId(rs.getInt("room_id"));
		meetingroomDto.setRoomName(rs.getString("room_name"));
		meetingroomDto.setLocation(rs.getString("location"));
		meetingroomDto.setCapacity(rs.getInt("capacity"));
		meetingroomDto.setProjector(rs.getString("projector"));
		meetingroomDto.setWhiteboard(rs.getString("whiteboard"));
		meetingroomDto.setMonitor(rs.getString("monitor"));
		meetingroomDto.setFaultyEquipmentInfo(rs.getString("faulty_equipment_info"));
		return meetingroomDto;
	}

}
