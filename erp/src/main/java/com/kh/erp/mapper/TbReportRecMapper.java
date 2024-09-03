package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.VO.TbReportRecVO;


@Service
public class TbReportRecMapper implements RowMapper<TbReportRecVO>{

	@Override
	public TbReportRecVO mapRow(ResultSet rs, int rowNum) throws SQLException {

		TbReportRecVO tbReportRecVO = new TbReportRecVO();
		tbReportRecVO.setApproBosName(rs.getString("appro_BosName"));
		tbReportRecVO.setApproBosId(rs.getString("appro_BosId"));
		tbReportRecVO.setApproNo(rs.getInt("appro_No"));
		tbReportRecVO.setApproYN(rs.getString("appro_YN"));
		tbReportRecVO.setReportTitle(rs.getString("report_Title"));
		tbReportRecVO.setWirterId(rs.getString("writer_Id"));
		tbReportRecVO.setWriteDate(rs.getDate("write_Date"));
		tbReportRecVO.setReportNo(rs.getInt("report_no"));
		tbReportRecVO.setWriterDept(rs.getString("writer_Dept"));
		tbReportRecVO.setWriterName(rs.getString("writer_Name"));
		return tbReportRecVO;
	}

	

}
