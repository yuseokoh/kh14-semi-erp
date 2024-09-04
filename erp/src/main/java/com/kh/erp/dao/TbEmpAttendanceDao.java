package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.VO.AttendanceSummaryVO;
import com.kh.erp.VO.PageVO;
import com.kh.erp.dto.TbEmpAttendanceDto;
import com.kh.erp.mapper.AttendanceSummaryMapper;
import com.kh.erp.mapper.TbEmpAttendanceMapper;

@Repository
public class TbEmpAttendanceDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private TbEmpAttendanceMapper tbEmpAttendanceMapper;

	@Autowired
	private AttendanceSummaryMapper attendanceSummaryMapper;

	public int sequence() {
		String sql = "select tb_attendance_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	// C
	public void insert(String loginId, int seq) {
		String sql = "INSERT INTO tb_attendance (ta_attendance_no, loginID) VALUES (?, ?)";
		Object[] data = { seq, loginId };
		jdbcTemplate.update(sql, data);
	}

	// R
	public List<TbEmpAttendanceDto> selectList() {
		String sql = "SELECT * FROM tb_attendance";
		return jdbcTemplate.query(sql, tbEmpAttendanceMapper);
	}

	// D
	public void delete() {

	}

	// R - key = loginId
	public TbEmpAttendanceDto selectOneById(String loginId) {
		String sql = "SELECT * FROM tb_attendance WHERE loginId = ? order by ta_attendance_no desc";
		Object[] data = { loginId };
		List<TbEmpAttendanceDto> list = jdbcTemplate.query(sql, tbEmpAttendanceMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	// 이거는 js용 추가 하나 일단 만들어둠(쓰는거임!!)
	public TbEmpAttendanceDto selectTodayRecordById(String loginId) {
		String sql = "SELECT * FROM tb_attendance WHERE loginId = ? AND TRUNC(check_in_time) = TRUNC(SYSDATE) ORDER BY ta_attendance_no DESC";
		Object[] data = { loginId };
		List<TbEmpAttendanceDto> list = jdbcTemplate.query(sql, tbEmpAttendanceMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	// U
	public void updateCheckOutTime(int taAttendanceNo) {
		String sql = "UPDATE tb_attendance SET check_out_time = systimestamp WHERE ta_attendance_no = ?";
		Object[] data = { taAttendanceNo };
		jdbcTemplate.update(sql, data);
	}

	public List<TbEmpAttendanceDto> selectListById(String loginId) {

		String sql = "SELECT * FROM tb_attendance WHERE loginId = ? order by ta_attendance_no";
		Object[] data = { loginId };
		return jdbcTemplate.query(sql, tbEmpAttendanceMapper, data);
	}

	// 총 근무시간 관련 내용
	public List<AttendanceSummaryVO> getAttendanceSummary(PageVO pageVO, int year, int month) {
		if (pageVO.isSearch()) {
			String sql = "SELECT * FROM ( " + "    SELECT rownum rn, TMP.* FROM ( " + "        SELECT "
					+ "            tb_attendance.loginID, " + "            tb_emp.name, "
					+ "            tb_emp.emp_dept, " + "            tb_emp.emp_gender, "
					+ "            tb_emp.emp_hp, " + "            EXTRACT(YEAR FROM check_in_time) AS tb_year, "
					+ "            EXTRACT(MONTH FROM check_in_time) AS tb_month, "
					+ "            COUNT(DISTINCT TO_CHAR(check_in_time, 'YYYY-MM-DD')) AS days_worked, "
					+ "            LISTAGG(TO_CHAR(check_in_time, 'YYYY-MM-DD'), ', ') WITHIN GROUP (ORDER BY check_in_time) AS check_in_dates, "
					+ "            LPAD(TRUNC(SUM( "
					+ "                EXTRACT(DAY FROM (check_out_time - check_in_time)) * 24 * 60 * 60 + "
					+ "                EXTRACT(HOUR FROM (check_out_time - check_in_time)) * 60 * 60 + "
					+ "                EXTRACT(MINUTE FROM (check_out_time - check_in_time)) * 60 + "
					+ "                ROUND(EXTRACT(SECOND FROM (check_out_time - check_in_time))) "
					+ "            ) / 3600), 2, '0') || ':' || " + "            LPAD(TRUNC(MOD(SUM( "
					+ "                EXTRACT(DAY FROM (check_out_time - check_in_time)) * 24 * 60 * 60 + "
					+ "                EXTRACT(HOUR FROM (check_out_time - check_in_time)) * 60 * 60 + "
					+ "                EXTRACT(MINUTE FROM (check_out_time - check_in_time)) * 60 + "
					+ "                ROUND(EXTRACT(SECOND FROM (check_out_time - check_in_time))) "
					+ "            ) / 60, 60)), 2, '0') || ':' || " + "            LPAD(MOD(ROUND(SUM( "
					+ "                EXTRACT(DAY FROM (check_out_time - check_in_time)) * 24 * 60 * 60 + "
					+ "                EXTRACT(HOUR FROM (check_out_time - check_in_time)) * 60 * 60 + "
					+ "                EXTRACT(MINUTE FROM (check_out_time - check_in_time)) * 60 + "
					+ "                EXTRACT(SECOND FROM (check_out_time - check_in_time)) "
					+ "            )), 60), 2, '0') AS total_work_time " + "        FROM tb_attendance "
					+ "        JOIN tb_emp ON tb_attendance.loginID = tb_emp.loginId "
					+ "        WHERE EXTRACT(YEAR FROM check_in_time) = ? "
					+ "          AND EXTRACT(MONTH FROM check_in_time) = ? " + "          AND INSTR(#1, ?) > 0 "
					+ "        GROUP BY " + "            tb_attendance.loginID, " + "            tb_emp.name, "
					+ "            tb_emp.emp_dept, " + "            tb_emp.emp_gender, "
					+ "            tb_emp.emp_hp, " + "            EXTRACT(YEAR FROM check_in_time), "
					+ "            EXTRACT(MONTH FROM check_in_time) " + "        ORDER BY " + "            loginID, "
					+ "            tb_year, " + "            tb_month " + "    ) TMP " + ") WHERE rn BETWEEN ? AND ?";

			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = { year, month, pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, attendanceSummaryMapper, data);
		} else {
			String sql = "SELECT * FROM ( " + "    SELECT rownum rn, TMP.* FROM ( " + "        SELECT "
					+ "            tb_attendance.loginID, " + "            tb_emp.name, "
					+ "            tb_emp.emp_dept, " + "            tb_emp.emp_gender, "
					+ "            tb_emp.emp_hp, " + "            EXTRACT(YEAR FROM check_in_time) AS tb_year, "
					+ "            EXTRACT(MONTH FROM check_in_time) AS tb_month, "
					+ "            COUNT(DISTINCT TO_CHAR(check_in_time, 'YYYY-MM-DD')) AS days_worked, "
					+ "            LISTAGG(TO_CHAR(check_in_time, 'YYYY-MM-DD'), ', ') WITHIN GROUP (ORDER BY check_in_time) AS check_in_dates, "
					+ "            LPAD(TRUNC(SUM( "
					+ "                EXTRACT(DAY FROM (check_out_time - check_in_time)) * 24 * 60 * 60 + "
					+ "                EXTRACT(HOUR FROM (check_out_time - check_in_time)) * 60 * 60 + "
					+ "                EXTRACT(MINUTE FROM (check_out_time - check_in_time)) * 60 + "
					+ "                ROUND(EXTRACT(SECOND FROM (check_out_time - check_in_time))) "
					+ "            ) / 3600), 2, '0') || ':' || " + "            LPAD(TRUNC(MOD(SUM( "
					+ "                EXTRACT(DAY FROM (check_out_time - check_in_time)) * 24 * 60 * 60 + "
					+ "                EXTRACT(HOUR FROM (check_out_time - check_in_time)) * 60 * 60 + "
					+ "                EXTRACT(MINUTE FROM (check_out_time - check_in_time)) * 60 + "
					+ "                ROUND(EXTRACT(SECOND FROM (check_out_time - check_in_time))) "
					+ "            ) / 60, 60)), 2, '0') || ':' || " + "            LPAD(MOD(ROUND(SUM( "
					+ "                EXTRACT(DAY FROM (check_out_time - check_in_time)) * 24 * 60 * 60 + "
					+ "                EXTRACT(HOUR FROM (check_out_time - check_in_time)) * 60 * 60 + "
					+ "                EXTRACT(MINUTE FROM (check_out_time - check_in_time)) * 60 + "
					+ "                EXTRACT(SECOND FROM (check_out_time - check_in_time)) "
					+ "            )), 60), 2, '0') AS total_work_time " + "        FROM tb_attendance "
					+ "        JOIN tb_emp ON tb_attendance.loginID = tb_emp.loginId "
					+ "        WHERE EXTRACT(YEAR FROM check_in_time) = ? "
					+ "          AND EXTRACT(MONTH FROM check_in_time) = ? " + "        GROUP BY "
					+ "            tb_attendance.loginID, " + "            tb_emp.name, "
					+ "            tb_emp.emp_dept, " + "            tb_emp.emp_gender, "
					+ "            tb_emp.emp_hp, " + "            EXTRACT(YEAR FROM check_in_time), "
					+ "            EXTRACT(MONTH FROM check_in_time) " + "        ORDER BY " + "            loginID, "
					+ "            tb_year, " + "            tb_month " + "    ) TMP " + ") WHERE rn BETWEEN ? AND ?";
			Object[] data = { year, month, pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, attendanceSummaryMapper, data);
		}

	}

	public int countSummaryPageWithVO(PageVO pageVO, int year, int month) {
		if (pageVO.isSearch()) {
			String sql = "SELECT COUNT(*) " +
		             "FROM tb_attendance " +
		             "JOIN tb_emp ON tb_attendance.loginID = tb_emp.loginId " +
		             "WHERE EXTRACT(YEAR FROM check_in_time) = ? " +
		             "AND EXTRACT(MONTH FROM check_in_time) = ? " +
		             "AND INSTR(" + pageVO.getColumn()
		             +
		             "    ), ?" +
		             ") > 0";
			Object[] data = { pageVO.getKeyword() , year, month };
			return jdbcTemplate.queryForObject(sql, int.class, data);
		} else {
			String sql = "SELECT COUNT(*) " +
		             "FROM tb_attendance " +
		             "JOIN tb_emp ON tb_attendance.loginID = tb_emp.loginId " +
		             "WHERE EXTRACT(YEAR FROM check_in_time) = ? " +
		             "AND EXTRACT(MONTH FROM check_in_time) = ?";
			Object[] data = {year, month};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
	}

}
