package com.kh.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.erp.VO.PageVO;
import com.kh.erp.dao.TbEmpVacaReqDao;
import com.kh.erp.dto.TbEmpVacaReqDto;

@Controller
@RequestMapping("/vacation")
public class TbEmpVacaReqController {

	@Autowired
	private TbEmpVacaReqDao tbEmpVacaReqDao;

	@RequestMapping("/list")
	public String list(@ModelAttribute PageVO pageVO, Model model) {
		List<TbEmpVacaReqDto> list = tbEmpVacaReqDao.vacaReqListByPaging(pageVO);
		System.out.println(list);
		model.addAttribute("list",list);
		pageVO.setCount(tbEmpVacaReqDao.countPage(pageVO));
		return "/WEB-INF/views/groupware/totalList.jsp";
	}

}
