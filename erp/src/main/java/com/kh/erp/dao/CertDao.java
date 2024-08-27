package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.dto.CertDto;
import com.kh.erp.mapper.CertMapper;

@Repository
public class CertDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private CertMapper certMapper;
	
	//C
	public void insert(CertDto certDto) {
		String sql = "insert into cert(cert_email,cert_number) values(?,?)";
		Object[] data = {certDto.getCertEmail(),certDto.getCertNumber()};
		jdbcTemplate.update(sql,data);
	}
	//D
	public boolean delete(String certEmail) {
		String sql = "delete cert where cert_email=?";
		Object[] data = {certEmail};
		return jdbcTemplate.update(sql,data)>0;	
	}
	//체크
	public boolean check(CertDto certDto,int duration) {
		String sql = "select * from cert "
				+ "where cert_email=? and cert_number=? "
				+ "and cert_time between sysdate-?/60/24 and sysdate";
//				+ "and cert_time between sysdate-interval '10' minute and sysdate";
		Object[] data = {certDto.getCertEmail(),certDto.getCertNumber(),duration};
		List<CertDto>list = jdbcTemplate.query(sql, certMapper,data);
		return list.size()>0;
	}
	//유효시간이 지난 인증번호를 삭제하도록 구현
	public boolean clean(int minute) {
		String sql = "delete cert where cert_time <sysdate-?/24/60";		
		Object[] data = {minute};
		return jdbcTemplate.update(sql,data)>0;
		}
}
