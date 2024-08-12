package com.kh.semi.dao;

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
	
//	@Autowired
//	private StatusMapper statusMapper;
//	
	@Autowired
	private VacaReqMapper vacaReqMapper;
	
	@Autowired
	private DTVacationMapper dTVacationMapper;

	//등록하기
	public void insert(VacaReqDto vacaReqDto) {
		String sql = "insert into tb_vaca_req("
				+ "	vaca_no, vaca_tel, vaca_sdate, vaca_edate, vaca_reason,vaca_req_date"
				+ ")values("
				+ " vaca_seq, ?, ?, ?, ?, sysdate "
				+ ")";
		Object[] data = {vacaReqDto.getVacaSdate(), vacaReqDto.getVacaTel(),
				vacaReqDto.getVacaEdate(), vacaReqDto.getVacaReason()};
		jdbcTemplate.update(sql, data);
 	}

	public void connect(int newVacano, int attachmentNo) {
		// TODO Auto-generated method stub
		
	}

	public int sequence() {
		// TODO Auto-generated method stub
		return 0;
	}

	public void insertWithSequence(VacaReqDto vacaReqDto) {
		// TODO Auto-generated method stub
		
	}

}
