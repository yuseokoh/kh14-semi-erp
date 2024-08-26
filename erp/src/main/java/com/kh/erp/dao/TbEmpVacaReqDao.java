package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.VO.PageVO;
import com.kh.erp.dto.TbEmpVacaReqDto;
import com.kh.erp.mapper.TbEmpVacaReqMapper;

@Repository
public class TbEmpVacaReqDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private TbEmpVacaReqMapper tbEmpVacaReqMapper;

	// seq
	public int sequence() {
		String sql = "select tb_VAcaReq_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	// C
	public void insert(TbEmpVacaReqDto tbEmpVacaReqDto) {
		String sql = "INSET INTO tb_VacaReq(vaca_No, applicantId, vaca_Tel, vaca_Sdate, vaca_Edate, vaca_Type, vaca_Reason, vaca_Reject) "
				+ "(?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = { tbEmpVacaReqDto.getVacaNo(), tbEmpVacaReqDto.getApplicantId(), tbEmpVacaReqDto.getVacaSdate(),
				tbEmpVacaReqDto.getVacaEdate(), tbEmpVacaReqDto.getVacaType(), tbEmpVacaReqDto.getVacaReason(),
				tbEmpVacaReqDto.getVacaReject() };
		jdbcTemplate.update(sql, data);
	}

	// 휴가 신청서 검색(R) - 페이징 적용 // 정렬순서 pageVO 컬럼, vaca_No, vaca_Sdate(휴가 시작일) 기준
	public List<TbEmpVacaReqDto> vacaReqListByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) {//검색
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
						+ "select * from tb_VacaReq where instr(#1, ?) > 0 "
						+ "order by #1 asc, vaca_No asc, vaca_Sdate asc"
					+ ")TMP"
				+ ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {
					pageVO.getKeyword(), 
					pageVO.getBeginRow(), pageVO.getEndRow()
				};
			return jdbcTemplate.query(sql, tbEmpVacaReqMapper,data);
			}
			else {//목록
				String sql = "select * from ("
									+ "select rownum rn, TMP.* from ("
										+ "select * from tb_VacaReq order by vaca_No asc, vaca_Sdate asc"
									+ ")TMP"
								+ ") where rn between ? and ?";
				Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
				return jdbcTemplate.query(sql, tbEmpVacaReqMapper, data);
			}
	}

	// R
	public void selectOneByColumn() {

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
//	// D
//	public void insert() {
//
//	}

	public int countPage(PageVO pageVO) {
		if(pageVO.isSearch()) {
			String sql ="select count(*) from tb_VacaReq where instr("+pageVO.getColumn()+",?) > 0";
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql,int.class,data);
		}
		else {
			String sql = "select count(*) from tb_VacaReq";
			return jdbcTemplate.queryForObject(sql,int.class);			
		}
	}

}
