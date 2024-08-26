package com.kh.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.erp.VO.PageVO;
import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dto.TbEmpApprovalDto;

@Controller
@RequestMapping("/approval")
public class TbEmpApprovalController {

	@Autowired
	private TbEmpApprovalDao tbEmpApprovalDao;

	@RequestMapping("/list")
	public String list(@ModelAttribute PageVO pageVO, Model model) {
		List<TbEmpApprovalDto> list = tbEmpApprovalDao.approListByPaging(pageVO);
		System.out.println(list);
		model.addAttribute("list",list);
		pageVO.setCount(tbEmpApprovalDao.countPage(pageVO));
		return "/WEB-INF/views/groupware/totalList2.jsp";
	}

}
