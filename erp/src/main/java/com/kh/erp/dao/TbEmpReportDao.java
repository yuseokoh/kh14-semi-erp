package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.VO.PageVO;
import com.kh.erp.VO.TbReportRecVO;
import com.kh.erp.dto.TbEmpReportDto;
import com.kh.erp.mapper.TbEmpReportMapper;
import com.kh.erp.mapper.TbReportRecMapper;

@Repository
public class TbEmpReportDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private TbEmpReportMapper tbEmpReportMapper;

	@Autowired
	private TbReportRecMapper tbReportRecMapper;

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
		String sql = "update tb_Report set report_Content = ?, report_title=?, write_Date = sysdate where report_no = ?";
		Object[] data = { tbEmpReportDto.getReportContent(), tbEmpReportDto.getReportTitle(),
				tbEmpReportDto.getReportNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// admin용 검색할때 쓰는 거였던가?
	public TbEmpReportDto selectOneWithApproNoAndId(int approNo, String writerId) {
		String sql = "select * from tb_Report where appro_No = ? and writer_Id = ?";
		Object[] data = { approNo, writerId };
		List<TbEmpReportDto> list = jdbcTemplate.query(sql, tbEmpReportMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	public int findImage(int approNo) {

		String sql = "select document from tb_approval_image where approNo=?";
		Object[] data = { approNo };
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	public boolean updateReject(int approNo, String rejectReason) {
		String sql = "update tb_Report set report_reject = ? where appro_no = ?";
		Object[] data = { rejectReason, approNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public int countPage(PageVO pageVO) {
		if (pageVO.isSearch()) {
			String sql = "select count(*) from tb_Report where instr(" + pageVO.getColumn() + ",?) > 0";
			Object[] data = { pageVO.getKeyword() };
			return jdbcTemplate.queryForObject(sql, int.class, data);
		} else {
			String sql = "select count(*) from tb_Report";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	public int countPageWithVO(PageVO pageVO, String sessionloginId) {
		if (pageVO.isSearch()) {
			String sql = "SELECT COUNT(*) FROM tb_Report r " + "JOIN tb_Approval a ON r.appro_No = a.appro_No "
					+ "WHERE instr(#1, ?) > 0 " + // 검색 조건
					"AND a.applicantId = ?"; // 로그인 ID 조건

			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = { pageVO.getKeyword(), sessionloginId };
			return jdbcTemplate.queryForObject(sql, Integer.class, data);
		} else {
			String sql = "SELECT COUNT(*) FROM tb_Report r " + "JOIN tb_Approval a ON r.appro_No = a.appro_No "
					+ "WHERE a.applicantId = ?"; // 로그인 ID 조건

			Object[] data = { sessionloginId };
			return jdbcTemplate.queryForObject(sql, Integer.class, data);
		}
	}

	// 수정(완)
	// 작성중
	public List<TbReportRecVO> selectReportListByPaging(PageVO pageVO, String loginId) {
		if (pageVO.isSearch()) { // 검색
			String sql = "SELECT * FROM ( "
				    + "    SELECT rownum rn, TMP.* FROM ( "
				    + "        SELECT "
				    + "            r.write_Date, "
				    + "            r.report_Title, "
				    + "            r.writer_Id, "
				    + "            a.appro_BosName, "
				    + "            a.appro_BosId, "
				    + "            a.appro_YN, "
				    + "            a.appro_No, "
				    + "            r.report_No, "
				    + "            r.writer_Dept, "
				    + "            r.writer_Name "
				    + "        FROM tb_Report r "
				    + "        JOIN tb_Approval a ON r.appro_No = a.appro_No "
				    + "        WHERE instr(" + pageVO.getColumn() + ", ?) > 0 "
				    + "        AND a.applicantId = ? "
				    + "        ORDER BY r.write_Date DESC, " + pageVO.getColumn() + " ASC "
				    + "    ) TMP "
				    + ") WHERE rn BETWEEN ? AND ?";
			Object[] data = { pageVO.getKeyword(), loginId, pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbReportRecMapper, data);
		} else { // 목록
			String sql = "SELECT * FROM ( " +
		             "    SELECT rownum rn, TMP.* FROM ( " +
		             "        SELECT " +
		             "            r.write_Date, " +
		             "            r.report_Title, " +
		             "            r.writer_Id, " +
		             "            a.appro_BosName, " +
		             "            a.appro_BosId, " +
		             "            a.appro_YN, " +
		             "            a.appro_No, " +
		             "            r.report_No, " +
		             "            r.writer_Dept, " +
		             "            r.writer_Name " +
		             "        FROM tb_Report r " +
		             "        JOIN tb_Approval a ON r.appro_No = a.appro_No " +
		             "        WHERE a.applicantId = ? " +
		             "        ORDER BY r.write_Date DESC " +
		             "    ) TMP " +
		             ") WHERE rn BETWEEN ? AND ?";
			Object[] data = { loginId, pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbReportRecMapper, data);
		}
	}

}
