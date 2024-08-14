package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.VacaReqDto;
import com.kh.semi.mapper.DTVacationMapper;
import com.kh.semi.mapper.VacaReqMapper;

@Repository
public class VacationDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private VacaReqMapper vacaReqMapper;

	@Autowired
	private DTVacationMapper dTVacationMapper;

	// 조회
	public List<VacaReqDto> selectList() {
		String sql = "select * from tb_vaca_req order by vaca_no asc";
		return jdbcTemplate.query(sql, vacaReqMapper);
	}

	// 검색
	public List<VacaReqDto> selectList(String column, String keyword) {
		String sql = "select * from tb_vaca_req " 
				+ "where instr(" + column + ", ?) > 0 " 
				+ "order by " + column
				+ " asc, vaca_no asc";
		Object[] data = { keyword };
		return jdbcTemplate.query(sql, vacaReqMapper, data);
	}


	public int sequence() {
		String sql = "select vaca_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	public void insertWithSequence(VacaReqDto vacaReqDto) {
		String sql = "insert into tb_vaca_req("
				+ "	vaca_no, vaca_tel, vaca_sdate, vaca_edate, vaca_reason,vaca_req_date" + ")"
				+ "values(" 
				+ "vaca_seq.nextVal , ?, ?, ?, ?, sysdate " + ")";
		Object[] data = { vacaReqDto.getVacaSdate(), vacaReqDto.getVacaTel(), vacaReqDto.getVacaEdate(),
				vacaReqDto.getVacaReason() };
		jdbcTemplate.update(sql, data);
	}

}
