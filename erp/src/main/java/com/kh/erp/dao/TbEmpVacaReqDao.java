package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.VO.PageVO;
import com.kh.erp.VO.TbVacRecVO;
import com.kh.erp.dto.TbEmpVacaReqDto;
import com.kh.erp.mapper.TbEmpVacaReqMapper;
import com.kh.erp.mapper.TbVacRecMapper;

@Repository
public class TbEmpVacaReqDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private TbEmpVacaReqMapper tbEmpVacaReqMapper;

	@Autowired
	private TbVacRecMapper tbVacRecMapper;

	// seq
	public int sequence() {
		String sql = "select tb_VAcaReq_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	// C
	public void insert(TbEmpVacaReqDto tbEmpVacaReqDto) {
		String sql = "INSERT INTO tb_VacaReq (vaca_No, applicantId, vaca_Tel, vaca_Title, vaca_Sdate, vaca_Edate, vaca_Type, vaca_Reason, appro_No) "
				+ "VALUES (tb_VAcaReq_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = { tbEmpVacaReqDto.getApplicantId(), tbEmpVacaReqDto.getVacaTel(),
				tbEmpVacaReqDto.getVacaTitle(), tbEmpVacaReqDto.getVacaSdate(), tbEmpVacaReqDto.getVacaEdate(),
				tbEmpVacaReqDto.getVacaType(), tbEmpVacaReqDto.getVacaReason(), tbEmpVacaReqDto.getApproNo() };
		jdbcTemplate.update(sql, data);
	}

	// 휴가 신청서 검색(R) - 페이징 적용 // 정렬순서 pageVO 컬럼, vaca_No, vaca_Sdate(휴가 시작일) 기준
	public List<TbEmpVacaReqDto> vacaReqListByPaging(PageVO pageVO) {
		if (pageVO.isSearch()) {// 검색
			String sql = "select * from (" + "select rownum rn, TMP.* from ("
					+ "select * from tb_VacaReq where instr(#1, ?) > 0 "
					+ "order by #1 asc, vaca_No asc, vaca_Sdate asc" + ")TMP" + ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = { pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbEmpVacaReqMapper, data);
		} else {// 목록
			String sql = "select * from (" + "select rownum rn, TMP.* from ("
					+ "select * from tb_VacaReq order by vaca_No asc, vaca_Sdate asc" + ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = { pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbEmpVacaReqMapper, data);
		}
	}

	// 수정(완)
	public List<TbVacRecVO> selectVacaLogListByPaging(PageVO pageVO) {
		if (pageVO.isSearch()) {// 검색
			String sql = "SELECT * FROM ( " + "    SELECT rownum rn, TMP.* FROM ( "
					+ "        SELECT v.vaca_ReqDate, v.vaca_Title, v.vaca_Type, v.vaca_No, "
					+ "               a.appro_no, v.applicantId, a.appro_BosId, a.appro_BosName, a.appro_YN "
					+ "        FROM tb_VacaReq v " + "        JOIN tb_Approval a ON v.appro_No = a.appro_No "
					+ "        WHERE instr(#1, ?) > 0 " + " ORDER BY v.vaca_ReqDate desc, #1 ASC "
					+ "    ) TMP " + ") WHERE rn BETWEEN ? AND ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = { pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbVacRecMapper, data);
		} else {// 목록
			String sql = "SELECT * FROM ( " + "    SELECT rownum rn, TMP.* FROM ( "
					+ "        SELECT v.vaca_ReqDate, v.vaca_Title, v.vaca_Type, v.vaca_No, "
					+ "               a.appro_no, v.applicantId, a.appro_BosId, a.appro_BosName, a.appro_YN "
					+ "        FROM tb_VacaReq v " + "        JOIN tb_Approval a ON v.appro_No = a.appro_No "
					+ "        ORDER BY v.vaca_ReqDate desc " + "   ) TMP "
					+ ") WHERE rn BETWEEN ? AND ?";
			Object[] data = { pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbVacRecMapper, data);
		}
	}

	// U
	// 휴가신청서 작성시 -> 결재테이블 구성 후-> 결재테이블에서 appro_No가져와서 현재 존재하는 db appro_No 갱신
	// 아마 보고서에서도 동일하게 작성해야 할 듯
	public boolean updateApproNo(TbEmpVacaReqDto tbEmpVacaReqDto) {
		String sql = "UPDATE tb_VacaReq SET appro_No=? WHERE applicantId=? AND vaca_No=?";
		Object[] data = { tbEmpVacaReqDto.getApproNo(), tbEmpVacaReqDto.getApplicantId(), tbEmpVacaReqDto.getVacaNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}
//
//	// D 여기선 삭제는 필요없음
//	public void insert() {
//
//	}

	public int countPage(PageVO pageVO) {
		if (pageVO.isSearch()) {
			String sql = "select count(*) from tb_VacaReq where instr(" + pageVO.getColumn() + ",?) > 0";
			Object[] data = { pageVO.getKeyword() };
			return jdbcTemplate.queryForObject(sql, int.class, data);
		} else {
			String sql = "select count(*) from tb_VacaReq";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	public TbEmpVacaReqDto selectOne(int vacaNo) {
		String sql = "select * from tb_VacaReq where vaca_no = ?";
		Object[] data = { vacaNo };
		List<TbEmpVacaReqDto> list = jdbcTemplate.query(sql, tbEmpVacaReqMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	public boolean updateContent(TbEmpVacaReqDto tbEmpVacaReqDto) {

		String sql = "update tb_VacaReq set vaca_Reason = ?, vaca_Title = ?, vaca_type = ?, vaca_tel = ?, vaca_sdate = ?, vaca_edate = ?, vaca_ReqDate = sysdate where vaca_no = ? ";
		Object[] data = { tbEmpVacaReqDto.getVacaReason(), tbEmpVacaReqDto.getVacaTitle(),
				tbEmpVacaReqDto.getVacaType(), tbEmpVacaReqDto.getVacaTel(), tbEmpVacaReqDto.getVacaSdate(),
				tbEmpVacaReqDto.getVacaEdate(), tbEmpVacaReqDto.getVacaNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public int findImage(int approNo) {

		String sql = "select document from tb_approval_image where approNo=?";
		Object[] data = { approNo };
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}

	public TbEmpVacaReqDto selectOneWithApproNoAndId(int approNo, String writerId) {

		String sql = "select * from tb_VacaReq where appro_No = ? and applicantId = ?";
		Object[] data = { approNo, writerId };
		List<TbEmpVacaReqDto> list = jdbcTemplate.query(sql, tbEmpVacaReqMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	public boolean updateReject(int approNo, String rejectReason) {
		String sql = "update tb_VacaReq set vaca_Reject = ? where appro_no = ?";
		Object[] data = { rejectReason, approNo };
		return jdbcTemplate.update(sql, data) > 0;

	}

	public List<TbEmpVacaReqDto> selectListByvacaTypeAndapplicantId(String approYN, String loginId) {
		String sql = "SELECT v.* FROM tb_VacaReq v JOIN tb_Approval a ON v.appro_No = a.appro_No WHERE a.appro_YN = ? AND v.applicantId = ? ORDER BY v.vaca_No ASC, v.vaca_Sdate ASC";
		Object[] data = { approYN, loginId };
		return jdbcTemplate.query(sql, tbEmpVacaReqMapper, data);
	}

}
