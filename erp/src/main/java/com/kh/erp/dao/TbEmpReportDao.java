package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.dto.TbEmpReportDto;
import com.kh.erp.mapper.TbEmpReportMapper;

@Repository
public class TbEmpReportDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private TbEmpReportMapper tbEmpReportMapper;

	// seq
	public int sequence() {
		String sql = "select tb_Report_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	// c
	public void insert(TbEmpReportDto tbEmpReportDto) {
		String sql = "insert into tb_Report(report_no, writer_Id, writer_Dept, writer_Name, report_Title, report_Content, appro_No) "
				+ "values(tb_Report_seq.nextval, ?, ?, ?, ?, ?, ?)";
		Object[] data = { tbEmpReportDto.getWriterId(), tbEmpReportDto.getWriterDept(), tbEmpReportDto.getWriterName(),
				tbEmpReportDto.getReportTitle(), tbEmpReportDto.getReportContent(), tbEmpReportDto.getApproNo() };
		jdbcTemplate.update(sql, data);
	}

	public TbEmpReportDto selectOne(int reportNo) {
		String sql = "select * from tb_Report where report_no = ?";
		Object[] data = { reportNo };
		List<TbEmpReportDto> list = jdbcTemplate.query(sql, tbEmpReportMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	public boolean updateContent(TbEmpReportDto tbEmpReportDto) {
		String sql = "update tb_Report set report_Content = ?, report_title=? where report_no = ?";
		Object[] data = {tbEmpReportDto.getReportContent(), tbEmpReportDto.getReportTitle(), tbEmpReportDto.getReportNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}

}
