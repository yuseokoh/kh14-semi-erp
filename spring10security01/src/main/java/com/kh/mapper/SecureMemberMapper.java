package com.kh.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.dto.SecureMemberDto;

@Service
public class SecureMemberMapper implements RowMapper<SecureMemberDto>{
	@Override
	public SecureMemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		SecureMemberDto secureMemberDto = new SecureMemberDto();
		secureMemberDto.setMemberId(rs.getString("member_id"));
		secureMemberDto.setMemberPw(rs.getString("member_pw"));
		secureMemberDto.setMemberNickname(rs.getString("member_nickname"));
		secureMemberDto.setMemberJoin(rs.getDate("member_join"));
		return secureMemberDto;
	}
}