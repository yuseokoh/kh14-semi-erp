package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semi.vo.VacationApplyVO;

@Service
public class VacationApplyMapper implements RowMapper<VacationApplyVO> {
    @Override
    public VacationApplyVO mapRow(ResultSet rs, int rowNum) throws SQLException {
        VacationApplyVO vacationApplyVO = new VacationApplyVO();
        vacationApplyVO.setVacaNo(rs.getInt("vaca_no")); //휴가번호
        vacationApplyVO.setVacaTel(rs.getString("vaca_tel")); //비상연락처
        vacationApplyVO.setVacaSdate(rs.getDate("vaca_sdate")); //휴가시작일
        vacationApplyVO.setVacaEdate(rs.getDate("vaca_edate")); //휴가종료일
        vacationApplyVO.setVacaReason(rs.getString("vaca_reason"));//휴가사유
        vacationApplyVO.setVacaRej(rs.getString("vaca_rej"));//반려사유
        vacationApplyVO.setVacaReqDate(rs.getDate("vaca_req_date"));//휴가신청일
        vacationApplyVO.setVacaType(rs.getString("vaca_type"));//휴가 종류
        vacationApplyVO.setApproDate(rs.getDate("appro_date"));;//결재일자
        vacationApplyVO.setApproYN(rs.getString("appro_yn")); //결재여부
        vacationApplyVO.setApproNo(rs.getInt("appro_no"));//결재번호
        vacationApplyVO.setApproBos(rs.getString("appro_bos"));//결재자
        vacationApplyVO.setApproBos1(rs.getString("appro_bos1"));//결재자
        vacationApplyVO.setApproBos2(rs.getString("appro_bos2"));//결재자
        vacationApplyVO.setApproBos3(rs.getString("appro_bos3"));//결재자
        vacationApplyVO.setApproNo2(rs.getInt("appro_no2"));//사번
        vacationApplyVO.setLoginId(rs.getInt("loginID"));//사번 - userInfo
        vacationApplyVO.setName(rs.getString("name")); //이름 - userInfo
        vacationApplyVO.setDeptCd(rs.getString("dept_cd"));//- userInfo
        vacationApplyVO.setLevelCd(rs.getString("level_cd"));//- userInfo
        vacationApplyVO.setEmpEmail(rs.getString("emp_email"));//이메일 - userInfo
        return vacationApplyVO;
    }
}



