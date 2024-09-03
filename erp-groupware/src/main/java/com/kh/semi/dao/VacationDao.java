package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.VacaReqDto;
import com.kh.semi.mapper.DTVacationMapper;
import com.kh.semi.mapper.VacaReqMapper;
import com.kh.semi.mapper.VacationApplyMapper;
import com.kh.semi.vo.VacationApplyVO;

import jakarta.servlet.http.HttpSession;

@Repository
public class VacationDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private VacaReqMapper vacaReqMapper;

	@Autowired
	private DTVacationMapper dTVacationMapper;
	
	@Autowired
	private VacationApplyMapper vacationApplyMapper;
	

	// 조회
	public List<VacaReqDto> selectList() {
		String sql = "select * from tb_vaca_req order by vaca_no asc";
		return jdbcTemplate.query(sql, vacaReqMapper);
	}

	// 검색
	public List<VacaReqDto> selectList(String column, String keyword) {
		String sql = "select * from tb_vaca_req " + "where instr(" + column + ", ?) > 0 " + "order by " + column
				+ " asc, vaca_no asc";
		Object[] data = { keyword };
		return jdbcTemplate.query(sql, vacaReqMapper, data);
	}

	public int sequence() {
		String sql = "select vaca_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	public void insertWithSequence(VacaReqDto vacaReqDto) {
		String sql = "INSERT INTO tb_vaca_req " 
				+ " (vaca_no, emp_name, appro_no2, emp_position, emp_department, "
				+ " emp_email, vaca_tel, vaca_sdate, vaca_edate, vaca_type, vaca_reason) "
				+ " SELECT vaca_seq.nextVal, u.name, u.LOGINID, u.level_cd, u.dept_cd, u.emp_email, "
				+ " ?, ?, ?, ?, ? " 
				+ " FROM tb_userInfo u WHERE u.loginID = ?";
		Object[] data = { vacaReqDto.getVacaTel(), // vaca_tel
				vacaReqDto.getVacaSdate(), // vaca_sdate
				vacaReqDto.getVacaEdate(), // vaca_edate
				vacaReqDto.getVacaType(), // vaca_type
				vacaReqDto.getVacaReason(), // vaca_reason
				vacaReqDto.getApproNo2() // 사번
		};

		jdbcTemplate.update(sql, data);
	}

	// 1개 선택 : 상세보기
	public VacationApplyVO selectOne(int vacaNo) {
	    String sql = "SELECT vr.vaca_no, vr.vaca_tel, vr.vaca_sdate, "
	    		+ "vr.vaca_edate, vr.vaca_reason, vr.vaca_rej, vr.vaca_req_date, "
	    		+ "vr.vaca_type, vr.appro_date, vr.appro_yn, vr.appro_no, vr.appro_bos ,vr.appro_bos1, "
	    		+ "vr.appro_bos2, vr.appro_bos3, vr.appro_no2, ui.loginID, ui.name, ui.dept_cd, "
	    		+ "ui.level_cd, ui.emp_email "
	    		+ "FROM tb_vaca_req vr "
	    		+ "LEFT JOIN tb_userInfo ui "
	    		+ "ON vr.appro_no2 = ui.loginID WHERE vr.vaca_no = ?";

	    Object[] data = {vacaNo};
	    List<VacationApplyVO> list = jdbcTemplate.query(sql, vacationApplyMapper, data);
	    return list.isEmpty() ? null : list.get(0);
	}

	// 수정
	public boolean updateApprove(VacaReqDto vacaReqDto) {
		String sql = "update tb_vaca_req set "
				+ "appro_date = sysdate, appro_yn =?,"
				+ "appro_no =?, appro_bos1 = ?, appro_bos2 = ?, appro_bos3 = ? "
				+ "vaca_rej =? where vaca_no =? ";
		Object[] data = {vacaReqDto.getApproYN(), 
				vacaReqDto.getApproNo(), vacaReqDto.getApproBos1(),  vacaReqDto.getApproBos2(),  vacaReqDto.getApproBos3(), 
				vacaReqDto.getVacaRej(), vacaReqDto.getVacaNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//삭제
	public boolean delete(int vacaNo, HttpSession session) { //session에서 가져와야한다
		String sql = "delete tb_vaca_req where vaca_no = ? and loginID = ?"; //본인만 삭제할 수 있다.
		Object[] data = {vacaNo , session.getAttribute("createdUser")};
		return jdbcTemplate.update(sql, data) > 0;
	}

}
