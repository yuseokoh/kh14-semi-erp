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
		tbEmpApprovalDto.setApproBos1(rs.getString("appro_Bos1"));
		tbEmpApprovalDto.setApproBos2(rs.getString("appro_Bos2"));
		tbEmpApprovalDto.setApproBos3(rs.getString("appro_Bos3"));
		tbEmpApprovalDto.setApproNo1(rs.getString("appro_No1"));
		tbEmpApprovalDto.setApproNo2(rs.getString("appro_No2"));
		tbEmpApprovalDto.setApproNo3(rs.getString("appro_No3"));
		tbEmpApprovalDto.setApplicantId(rs.getString("applicantId"));
		return tbEmpApprovalDto;
	}

}
