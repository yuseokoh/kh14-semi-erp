package com.kh.security;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.dao.SecureMemberDao;
import com.kh.dto.SecureMemberDto;

@SpringBootTest
public class Test07회원가입테스트2 {
	
	@Autowired
	private SecureMemberDao secureMemberDao;
	
	@Test
	public void test() {
		//데이터 준비
		SecureMemberDto secureMemberDto = new SecureMemberDto();
		secureMemberDto.setMemberId("testuser2");
		secureMemberDto.setMemberPw("Testuser2!");
		secureMemberDto.setMemberNickname("테스트유저2");
		
		//JDBC
		secureMemberDao.insert(secureMemberDto);
	}
	
}