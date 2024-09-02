package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.erp.VO.PageVO;
import com.kh.erp.VO.StatusDateVO;
import com.kh.erp.VO.StatusVO;
import com.kh.erp.VO.WorkingDayVO;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.mapper.StatusDateMapper;
import com.kh.erp.mapper.StatusMapper;
import com.kh.erp.mapper.TbEmpMapper;
import com.kh.erp.mapper.WorkingDayMapper;

@Repository
public class TbEmpDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TbEmpMapper tbEmpMapper;
	@Autowired
	private PasswordEncoder encoder;
	@Autowired
	private StatusMapper statusMapper;
	@Autowired
	private StatusDateMapper statusDateMapper;
	@Autowired
	private WorkingDayMapper workingDayMapper;

	// 사원 등록 기능(insert)(C)
	// 아이디,이름,비밀번호,직급,부서,전화번호,이메일,생일,입사일,주소
	public void insert(TbEmpDto tbEmpDto) {
		String sql = "insert into tb_emp(" + "loginId ,name ,password, "
				+ "emp_level, emp_dept,emp_hp,emp_email,emp_birth,emp_sdate," + "emp_post,emp_address1,emp_address2"
				+ ")" + "values(?,?,?,?,?,?,?,?,?,?,?,?)";
		String rawPw = tbEmpDto.getPassword();
		String encPw = encoder.encode(rawPw);
		tbEmpDto.setPassword(encPw); // 없어도 됨 똑같은거임
		Object[] data = { tbEmpDto.getLoginId(), tbEmpDto.getName(), tbEmpDto.getPassword(), tbEmpDto.getEmpLevel(),
				tbEmpDto.getEmpDept(), tbEmpDto.getEmpHp(), tbEmpDto.getEmpEmail(), tbEmpDto.getEmpBirth(),
				tbEmpDto.getEmpSdate(), tbEmpDto.getEmpPost(), tbEmpDto.getEmpAddress1(), tbEmpDto.getEmpAddress2() };
		jdbcTemplate.update(sql, data);
	}

	// 회원 상세(detail)(R)
	public TbEmpDto selectOne(String loginId) {
		String sql = "select * from tb_emp where loginId = ?";
		Object[] data = { loginId };
		List<TbEmpDto> list = jdbcTemplate.query(sql, tbEmpMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	// 회원 상세 비밀번호 추가(로그인)(detail)(R)
	public TbEmpDto selectOneWithPW(String loginId, String password) {
		String sql = "select * from tb_emp where loginId = ?";
		Object[] data = { loginId };
		List<TbEmpDto> list = jdbcTemplate.query(sql, tbEmpMapper, data);
		if (list.isEmpty())
			return null;
		TbEmpDto tbEmpDto = list.get(0);
		boolean isValid = encoder.matches(password, tbEmpDto.getPassword());
		return isValid ? tbEmpDto : null;
	}

	// 회원 개인의 정보 변경(update)(U)
	// 이름,비밀번호,전화번호,이메일,생일,최종학력,비고,계좌번호,은행,주소,세전급여
	public boolean updateEmp(TbEmpDto tbEmpDto) {
		String sql = "update tb_emp set name=?, emp_hp=?,emp_email=?,emp_birth=?,emp_edu=?,"
				+ "emp_memo=?,emp_post=?,emp_address1=?,emp_address2=? where loginId=?";
		Object[] data = { tbEmpDto.getName(), tbEmpDto.getEmpHp(), tbEmpDto.getEmpEmail(), tbEmpDto.getEmpBirth(),
				tbEmpDto.getEmpBirth(), tbEmpDto.getEmpMemo(), tbEmpDto.getEmpPost(), tbEmpDto.getEmpAddress1(),
				tbEmpDto.getEmpAddress2(), tbEmpDto.getLoginId() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 사원 퇴사(delete)
	public boolean deleteEmp(String loginId) {
		String sql = "delete tb_emp where loginId = ?";
		Object[] data = { loginId };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// (관리자)사원 정보 변경
	// 직급,부서,비고,각종보험들,보험등록일자,세후급여
	public boolean updateEmpByAdmin(TbEmpDto tbEmpDto) {
		String sql = "update tb_emp set " + "emp_level=?,emp_dept=?,emp_memo=?,sal_san=?,"
				+ "sal_ko=?,sal_kun=?,sal_kuk=?,sal_date=?,sal_after=?,"
				+ "emp_account_number=?,emp_bank=? where loginId=?";
		Object[] data = { tbEmpDto.getEmpLevel(), tbEmpDto.getEmpDept(), tbEmpDto.getEmpMemo(), tbEmpDto.getSalSan(),
				tbEmpDto.getSalSan(), tbEmpDto.getSalKun(), tbEmpDto.getSalKuk(), tbEmpDto.getSalDate(),
				tbEmpDto.getSalAfter(), tbEmpDto.getEmpAccountNumber(), tbEmpDto.getEmpBank(), tbEmpDto.getLoginId() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 사원 목록(list)(R) 부서>직급>이름 순
	public List<TbEmpDto> EmpList() {
		String sql = "select * from tb_emp order by emp_dept asc, emp_level asc, name asc";
		return jdbcTemplate.query(sql, tbEmpMapper);
	}

	// 사원 검색(R) 검색어>부서>직급>이름 순
	public List<TbEmpDto> EmpList(String column, String keyword) {
		String sql = "select * from tb_emp where " + "instr(" + column + ", ?)>0 " + "order by " + column
				+ " asc, emp_dept asc, emp_level asc, name asc";
		Object[] data = { keyword };
		return jdbcTemplate.query(sql, tbEmpMapper, data);
	}

	public List<TbEmpDto> empListbyPaging(PageVO pageVO) {
		if (pageVO.isSearch()) {// 검색
			String sql = "select * from (" + "select rownum rn, TMP.* from ("
					+ "select * from tb_emp where emp_edate is null and instr(#1, ?) > 0 "
					+ "order by #1 asc, emp_dept asc, emp_level asc, name asc" + ")TMP" + ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = { pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbEmpMapper, data);
		} else {// 목록
			String sql = "select * from (" + "select rownum rn, TMP.* from (" + "select * from tb_emp  "
					+ "where emp_edate is null " + "order by emp_dept asc, emp_level asc, name asc" + ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = { pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbEmpMapper, data);
		}
	}

	public int countPage(PageVO pageVO) {
		if (pageVO.isSearch()) {
			String sql = "select count(*) from tb_emp where instr(" + pageVO.getColumn() + ",?) > 0";
			Object[] data = { pageVO.getKeyword() };
			return jdbcTemplate.queryForObject(sql, int.class, data);
		} else {
			String sql = "select count(*) from tb_emp";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	// 비밀번호 변경(U)
	public boolean updatePassword(String loginId, String password) {
		String sql = "update tb_emp set password = ? where loginId=?";
		String encPw = encoder.encode(password);
		Object[] data = { encPw, loginId };
		return jdbcTemplate.update(sql, data) > 0;
	}// 이미지 찾기

	public Integer findImage(String loginId) {
		String sql = "select document from tb_emp_image where loginId=?";
		Object[] data = { loginId };
		return jdbcTemplate.queryForObject(sql, Integer.class, data);
	}

	// 승인된 휴가신청서 중

	public void connect(String loginId, int documentNo) {
		String sql = "insert into tb_emp_image(loginId,document) " + "values(?,?)";
		Object[] data = { loginId, documentNo };
		jdbcTemplate.update(sql, data);

	}

	// 입사자 조회
	public List<StatusVO> statusByEmpLevel() {
		String sql = "SELECT emp_level AS title, COUNT(*) AS "
				+ "cnt FROM tb_emp WHERE TO_CHAR(emp_sdate, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM') "
				+ "GROUP BY emp_level  ORDER BY cnt DESC, title ASC ";
		return jdbcTemplate.query(sql, statusMapper);
	}

	// 퇴사자 조회
	public List<StatusVO> statusByEmpLevelBye() {
		String sql = "SELECT emp_level AS title, COUNT(*) AS "
				+ "cnt FROM tb_emp WHERE TO_CHAR(emp_edate, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM') "
				+ "GROUP BY emp_level  ORDER BY cnt DESC, title ASC ";
		return jdbcTemplate.query(sql, statusMapper);
	}

	// 퇴사일 조정
	public boolean updateEdate(String loginId) {
		String sql = "update tb_emp set " + "emp_edate=sysdate where loginId=?";
		Object[] data = { loginId };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 입사일 조회
	public List<StatusDateVO> statusByEmpSdate() {
		String sql = "SELECT " + "TO_CHAR(emp_sdate, 'YYYY-MM-DD') AS entry_date,"
				+ "COUNT(*) AS cnt FROM tb_emp WHERE TO_CHAR(emp_sdate, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM') "
				+ "GROUP BY TO_CHAR(emp_sdate, 'YYYY-MM-DD') " + "ORDER BY TO_CHAR(emp_sdate, 'YYYY-MM-DD')";
		return jdbcTemplate.query(sql, statusDateMapper);
	}

	// 퇴사일 조회
	public List<StatusDateVO> statusByEmpEdate() {
		String sql = "SELECT " + "TO_CHAR(emp_edate, 'YYYY-MM-DD') AS entry_date,"
				+ "COUNT(*) AS cnt FROM tb_emp WHERE TO_CHAR(emp_edate, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM') "
				+ "GROUP BY TO_CHAR(emp_edate, 'YYYY-MM-DD') " + "ORDER BY TO_CHAR(emp_edate, 'YYYY-MM-DD')";
		return jdbcTemplate.query(sql, statusDateMapper);
	}

	// 퇴사자 정보 조회
	public List<WorkingDayVO> workingDay() {
		String sql = "SELECT " + "emp_no AS empNo, " + "name, " + "emp_sdate AS startDate, " + "emp_edate AS endDate, "
				+ "TRUNC(emp_edate) - TRUNC(emp_sdate) AS workingDays " + "FROM tb_emp "
				+ "WHERE emp_edate IS NOT NULL";
		return jdbcTemplate.query(sql, workingDayMapper);
	}

	// 스케쥴 걸어다 만들 쿼리(15일의 연차)
	public void updateAnnualLeave() {
		String sql = "UPDATE tb_emp SET annualLeaveQuota = 15, annualLeaveUsed = 0";
		jdbcTemplate.update(sql);
	}

	// 휴가일수에 따른 연차 차감
	public boolean updateAnnualLeaveUsed(int days, String loginId) {
		String sql = "UPDATE tb_emp SET annualLeaveQuota = annualLeaveQuota - ?, annualLeaveUsed = ? WHERE loginId = ?";
		Object[] data = { days, days, loginId };
		return jdbcTemplate.update(sql, data) > 0;
	}
}