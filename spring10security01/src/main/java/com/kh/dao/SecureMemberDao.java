package com.kh.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.dto.SecureMemberDto;
import com.kh.mapper.SecureMemberMapper;

@Repository
public class SecureMemberDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private SecureMemberMapper secureMemberMapper;
	@Autowired
	private PasswordEncoder encoder;
	
	public void insert(SecureMemberDto secureMemberDto) {
		//암호화
		String rawPw = secureMemberDto.getMemberPw();
		String encPw = encoder.encode(rawPw);
		secureMemberDto.setMemberPw(encPw);
		
		//JDBC
		String sql = "insert into secure_member("
							+ "member_id, member_pw, member_nickname"
						+ ") values(?, ?, ?)";
		Object[] data = {
				secureMemberDto.getMemberId(),
				secureMemberDto.getMemberPw(),//암호화된 비밀번호
				secureMemberDto.getMemberNickname()
		};
		jdbcTemplate.update(sql, data);
	}

	//기존의 상세조회
	public SecureMemberDto selectOne(String memberId) {
		String sql = "select * from secure_member where member_id = ?";
		Object[] data = {memberId};
		List<SecureMemberDto> list = jdbcTemplate.query(sql, secureMemberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	//로그인 전용 상세조회
	public SecureMemberDto selectOneWithPassword(String memberId, String memberPw) {
		String sql = "select * from secure_member where member_id = ?";
		Object[] data = {memberId};
		List<SecureMemberDto> list = jdbcTemplate.query(sql, secureMemberMapper, data);
		if(list.isEmpty()) return null;
		
		SecureMemberDto secureMemberDto = list.get(0);
		boolean isValid = encoder.matches(memberPw, secureMemberDto.getMemberPw());
		return isValid ? secureMemberDto : null;
	}
}