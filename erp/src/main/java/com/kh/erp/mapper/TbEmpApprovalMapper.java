package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.dto.TbEmpApprovalDto;

@Service
public class TbEmpApprovalMapper implements RowMapper<TbEmpApprovalDto>{

	@Override
	public TbEmpApprovalDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		TbEmpApprovalDto tbEmpApprovalDto = new TbEmpApprovalDto();
		tbEmpApprovalDto.setApproNo(rs.getInt("appro_No"));
		tbEmpApprovalDto.setApproType(rs.getString("appro_Type"));
		tbEmpApprovalDto.setApproDate(rs.getDate("appro_Date"));
		tbEmpApprovalDto.setApproYN(rs.getString("appro_YN"));// DB상에선 CHAR(1)
		tbEmpApprovalDto.setApproBosId(rs.getString("appro_BosId"));
		tbEmpApprovalDto.setApproBosName(rs.getString("appro_BosName"));
		tbEmpApprovalDto.setApplicantId(rs.getString("applicantId"));
		return tbEmpApprovalDto;
	}

}
