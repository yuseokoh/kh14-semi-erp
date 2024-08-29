package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.dto.TbEmpAttendanceDto;
import com.kh.erp.mapper.TbEmpAttendanceMapper;

@Repository
public class TbEmpAttendanceDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private TbEmpAttendanceMapper tbEmpAttendanceMapper;

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

}
