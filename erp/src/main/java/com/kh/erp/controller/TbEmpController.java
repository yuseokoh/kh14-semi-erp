package com.kh.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dto.TbEmpDto;



@Controller
@RequestMapping("/tb")
public class TbEmpController {
	@Autowired
	private TbEmpDao tbEmpDao;

	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/tb/join.jsp"; 
	}
	@PostMapping("/join")
	public String join(@ModelAttribute TbEmpDto tbEmpDto) {
		tbEmpDao.insert(tbEmpDto);
		return "/";	
	}
	@GetMapping("/edit")
	public String edit() {
		return "/WEB-INF/views/tb/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute TbEmpDto tbempDto) {
		tbEmpDao.updateEmp(tbempDto);
		return "/";
	}
	
}