package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.dto.TbEmpDto;


@Service
public class TbEmpMapper implements RowMapper<TbEmpDto> {

	@Override
	public TbEmpDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		TbEmpDto tbEmpDto = new TbEmpDto();
		tbEmpDto.setLoginId(rs.getString("loginId"));
		tbEmpDto.setUserType(rs.getString("user_type"));
		tbEmpDto.setName(rs.getString("name"));
		tbEmpDto.setPassword(rs.getString("password"));
		tbEmpDto.setEmpLevel(rs.getString("emp_level"));
		tbEmpDto.setEmpDept(rs.getString("emp_dept"));
		tbEmpDto.setEmpGender(rs.getString("emp_gender"));
		tbEmpDto.setEmpHp(rs.getInt("emp_hp"));
		tbEmpDto.setEmpEmail(rs.getString("emp_email"));
		tbEmpDto.setEmpBirth(rs.getString("emp_birth"));
		tbEmpDto.setEmpEdu(rs.getString("emp_edu"));
		tbEmpDto.setEmpSdate(rs.getString("emp_sdate"));
		tbEmpDto.setEmpEdate(rs.getDate("emp_edate"));
		tbEmpDto.setEmpFinalMoney(rs.getInt("emp_final_money"));
		tbEmpDto.setEmpReason(rs.getString("emp_reason"));
		tbEmpDto.setEmpMemo(rs.getString("emp_memo"));
		tbEmpDto.setEmpAccountNumber(rs.getInt("emp_account_number"));
		tbEmpDto.setEmpBank(rs.getString("emp_bank"));
		tbEmpDto.setEmpPost(rs.getString("emp_post"));
		tbEmpDto.setEmpAddress1(rs.getString("emp_address1"));
		tbEmpDto.setEmpAddress2(rs.getString("emp_address2"));
		tbEmpDto.setSalSan(rs.getInt("sal_san"));
		tbEmpDto.setSalKo(rs.getInt("sal_ko"));
		tbEmpDto.setSalKun(rs.getInt("sal_kun"));
		tbEmpDto.setSalKuk(rs.getInt("sal_kuk"));
		tbEmpDto.setSalDate(rs.getDate("sal_date"));
		tbEmpDto.setSalPre(rs.getInt("sal_pre"));
		tbEmpDto.setSalAfter(rs.getInt("sal_after"));
		return tbEmpDto;
	}

}