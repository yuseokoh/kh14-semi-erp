package com.kh.erp.restcontroller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.erp.VO.StatusDateVO;
import com.kh.erp.VO.StatusVO;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dto.TbEmpDto;




@RestController
@RequestMapping("/rest/emp")
public class TbEmpRestController {
	@Autowired
	private TbEmpDao tbEmpDao;
	
	@PostMapping("/checkId")
	public boolean checkId(@RequestParam String loginId){
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		return tbEmpDto == null;
	}
	@PostMapping("/status/hi")
	public List<StatusVO> statusHi(){
		return tbEmpDao.statusByEmpLevel();
	}
	@PostMapping("/status/bye")
	public List<StatusVO> statusBye(){
		return tbEmpDao.statusByEmpLevelBye();
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute TbEmpDto tbEmpDto) {
		tbEmpDao.updateEmp(tbEmpDto);
		return "redirect:/tb/mypage?loginId="+tbEmpDto.getLoginId();
	}
	
}
