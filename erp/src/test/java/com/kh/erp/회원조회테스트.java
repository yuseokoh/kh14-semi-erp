package com.kh.erp;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.vo.PageVO;

@SpringBootTest
public class 회원조회테스트 {
	@Autowired
	private TbEmpDao tbEmpDao;
	
	@Test
	public void test() {
		PageVO pageVO = new PageVO();
		System.out.println(tbEmpDao.empListbyPaging(pageVO));
	}
}
