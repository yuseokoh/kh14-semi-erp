package com.kh.security;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.dao.SecureMemberDao;
import com.kh.dto.SecureMemberDto;

@SpringBootTest
public class Test08로그인테스트 {
	
	@Autowired
	private SecureMemberDao secureMemberDao;
	
	@Test
	public void test() {
		String memberId = "testuser1";
		String memberPw = "Testuser1!";
		
		SecureMemberDto secureMemberDto = 
				secureMemberDao.selectOneWithPassword(memberId, memberPw);
		
		System.out.println(secureMemberDto);
	}
	
}