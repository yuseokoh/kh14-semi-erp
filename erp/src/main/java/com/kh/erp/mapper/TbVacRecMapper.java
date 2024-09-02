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
		tbVacRecVO.setApproBosId(rs.getString("appro_BosId"));
		tbVacRecVO.setApproBosName(rs.getString("appro_BosName"));
		tbVacRecVO.setApproYN(rs.getString("appro_YN"));
		tbVacRecVO.setVacaType(rs.getString("vaca_Type"));
		tbVacRecVO.setApproNo(rs.getInt("appro_No"));
		tbVacRecVO.setVacaNo(rs.getInt("vaca_No"));
		return tbVacRecVO;
	}

}
