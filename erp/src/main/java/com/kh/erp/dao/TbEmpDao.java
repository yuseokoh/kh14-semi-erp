package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.mapper.TbEmpMapper;


@Repository
public class TbEmpDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TbEmpMapper tbEmpMapper;


	//사원 등록 기능(insert)(C)
	public void insert(TbEmpDto tbEmpDto) {
		String sql = "insert into tb_emp("
				+ "loginId ,name ,password, "
				+ "emp_level, emp_dept, emp_gender,emp_hp,emp_email,emp_birth,emp_edu,emp_sdate,"
				+ "emp_memo,emp_account_number,emp_bank,emp_post,emp_address1,emp_address2,"
				+ "sal_pre) "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" ;
		Object[] data = {tbEmpDto.getLoginId(),tbEmpDto.getName(),tbEmpDto.getPassword(),
					tbEmpDto.getEmpLevel(),tbEmpDto.getEmpDept(),tbEmpDto.getEmpGender(),tbEmpDto.getEmpHp(),
					tbEmpDto.getEmpEmail(),tbEmpDto.getEmpBirth(),tbEmpDto.getEmpEdu(),tbEmpDto.getEmpSdate(),
					tbEmpDto.getEmpMemo(),tbEmpDto.getEmpAccountNumber(),tbEmpDto.getEmpBank(),tbEmpDto.getEmpPost(),
					tbEmpDto.getEmpAddress1(),tbEmpDto.getEmpAddress2(),
					tbEmpDto.getSalPre()};
		jdbcTemplate.update(sql,data);	
	}
	//회원 상세(detail)(R)
	public TbEmpDto selectOne(String loginId) {
		String sql = "select * from tb_emp where loginId = ?";
		Object[] data = {loginId};
		List<TbEmpDto> list =jdbcTemplate.query(sql,tbEmpMapper,data);
		return list.isEmpty()? null : list.get(0);
	}
	//회원 개인의 정보 변경(update)(U)
//	public boolean updateEmp(TbEmpDto tbEmpDto) {
//		String sql = "update tb_emp set "
//				+ "loginId=?,name=?,password=?, "
//				+ "emp_level=?, emp_dept=?,emp_hp=?,emp_email=?,"
//				+ "emp_memo=?,emp_account_number=?,emp_bank=?,emp_post=?,emp_address1=?,emp_address2=?,"
//				+ "sal_pre=?) ";
//		Object[] data = {tbEmpDto.get};
//	}
	//회원 탈퇴(delete)
	//회원 목록(list)(R)
	// 회원 검색(R)
}
