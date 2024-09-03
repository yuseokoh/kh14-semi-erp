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
	
	//이거는 js용 추가 하나 일단 만들어둠(쓰는거임!!)
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

	//총 근무시간 관련 내용
	public List<AttendanceSummaryVO> getAttendanceSummary(PageVO pageVO) {
		if(pageVO.isSearch()) {
			
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = { pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, attendanceSummaryMapper, data);
		}else
		{
			
			Object[] data = { pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, attendanceSummaryMapper, data);
		}
		String sql = "SELECT loginID AS loginId, EXTRACT(YEAR FROM check_in_time) AS tb_year, EXTRACT(MONTH FROM check_in_time) AS tb_month, COUNT(DISTINCT TO_CHAR(check_in_time, 'YYYY-MM-DD')) AS days_worked, LISTAGG(TO_CHAR(check_in_time, 'YYYY-MM-DD'), ', ') WITHIN GROUP (ORDER BY check_in_time) AS check_in_dates, LPAD(TRUNC(SUM(EXTRACT(DAY FROM (check_out_time - check_in_time)) * 24 * 60 * 60 + EXTRACT(HOUR FROM (check_out_time - check_in_time)) * 60 * 60 + EXTRACT(MINUTE FROM (check_out_time - check_in_time)) * 60 + ROUND(EXTRACT(SECOND FROM (check_out_time - check_in_time))) / 3600), 2, '0') || ':' || LPAD(TRUNC(MOD(SUM(EXTRACT(DAY FROM (check_out_time - check_in_time)) * 24 * 60 * 60 + EXTRACT(HOUR FROM (check_out_time - check_in_time)) * 60 * 60 + EXTRACT(MINUTE FROM (check_out_time - check_in_time)) * 60 + ROUND(EXTRACT(SECOND FROM (check_out_time - check_in_time))) / 60, 60)), 2, '0') || ':' || LPAD(MOD(ROUND(SUM(EXTRACT(DAY FROM (check_out_time - check_in_time)) * 24 * 60 * 60 + EXTRACT(HOUR FROM (check_out_time - check_in_time)) * 60 * 60 + EXTRACT(MINUTE FROM (check_out_time - check_in_time)) * 60 + EXTRACT(SECOND FROM (check_out_time - check_in_time))), 60), 2, '0') AS total_work_time FROM tb_attendance GROUP BY loginID, EXTRACT(YEAR FROM check_in_time), EXTRACT(MONTH FROM check_in_time) ORDER BY loginId, tb_year, tb_month;";
	}
	
	
	
	
	
	
}
