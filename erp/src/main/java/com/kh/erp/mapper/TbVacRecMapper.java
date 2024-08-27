package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.VO.TbVacRecVO;

@Service
public class TbVacRecMapper implements RowMapper<TbVacRecVO>{

	@Override
	public TbVacRecVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		TbVacRecVO tbVacRecVO = new TbVacRecVO();
		tbVacRecVO.setVacaReqDate(rs.getDate("vaca_ReqDate"));
		tbVacRecVO.setVacaTitle(rs.getString("vaca_Title"));
		tbVacRecVO.setApplicantId(rs.getString("applicantId"));
		tbVacRecVO.setApproBos1(rs.getString("appro_Bos1"));
		tbVacRecVO.setApproBos2(rs.getString("appro_Bos2"));
		tbVacRecVO.setApproBos3(rs.getString("appro_Bos3"));
		tbVacRecVO.setApproNo1(rs.getString("appro_No1"));
		tbVacRecVO.setApproNo2(rs.getString("appro_No2"));
		tbVacRecVO.setApproNo3(rs.getString("appro_No3"));
		tbVacRecVO.setApproYN(rs.getString("appro_YN"));
		
		return tbVacRecVO;
	}

}
