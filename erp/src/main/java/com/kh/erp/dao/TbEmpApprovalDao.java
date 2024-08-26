package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.VO.PageVO;
import com.kh.erp.dto.TbEmpApprovalDto;
import com.kh.erp.mapper.TbEmpApprovalMapper;

@Repository
public class TbEmpApprovalDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private TbEmpApprovalMapper tbEmpApprovalMapper;

	// C --> 행동(보고서 / 휴가신청서 작성)에 따른 기본 결재 데이터 생성 결재자에 대한 정보 NULL
	// [1] 휴가신청서 먼저 작성
	// [2] 결재란 후에 작성
	// [3] 존재하는 휴가 신청서에 생성된 번호 추가 해서 이쪽으로 전달(DTO형식)
	public void insert(TbEmpApprovalDto tbEmpApprovalDto) {
		String sql = "INSERT INTO tb_Approval(appro_No, appro_Type, appro_YN) values(tb_Approval_seq.nextval, ?, 'N')";
		Object[] data = { tbEmpApprovalDto.getApproType() };
		jdbcTemplate.update(sql, data);
	}

	// R
	public List<TbEmpApprovalDto> selectList() {
		String sql = "SELECT * FROM tb_Approval";
		return jdbcTemplate.query(sql, tbEmpApprovalMapper);
	}

	
	// U --> sql 쿼리를 세개 작성 // 조건 getApproNo1먼저 업데이트 
	public boolean update(TbEmpApprovalDto tbEmpApprovalDto) {
		String sql;
		//
		if(tbEmpApprovalDto.getApproNo2().isEmpty() && tbEmpApprovalDto.getApproNo3().isEmpty()) {
			sql = "UPDATE SET ";
			Object[] data = {tbEmpApprovalDto.getApproBos1(), tbEmpApprovalDto.getApproNo1()};
			return jdbcTemplate.update(sql, data) > 0;
		}else if(tbEmpApprovalDto.getApproNo3().isEmpty()) {
			
		}
		
		return false;
		
		
	}
//
//	// D
//	public void insert() {
//
//	}

	// 페이징이 적용된 승인 상태 리스트
	public List<TbEmpApprovalDto> approListByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) {//검색
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
						+ "select * from tb_Approval where instr(#1, ?) > 0 "
						+ "order by #1 asc, appro_No asc, appro_Date asc"
					+ ")TMP"
				+ ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {
					pageVO.getKeyword(), 
					pageVO.getBeginRow(), pageVO.getEndRow()
				};
			return jdbcTemplate.query(sql, tbEmpApprovalMapper,data);
			}
			else {//목록
				String sql = "select * from ("
									+ "select rownum rn, TMP.* from ("
										+ "select * from tb_Approval order by appro_No asc, appro_Date asc"
									+ ")TMP"
								+ ") where rn between ? and ?";
				Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
				return jdbcTemplate.query(sql, tbEmpApprovalMapper, data);
			}
	}

	//페이징 관련
	public int countPage(PageVO pageVO) {
		if(pageVO.isSearch()) {
			String sql ="select count(*) from tb_Approval where instr("+pageVO.getColumn()+",?) > 0";
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql,int.class,data);
		}
		else {
			String sql = "select count(*) from tb_Approval";
			return jdbcTemplate.queryForObject(sql,int.class);			
		}
	}

}
