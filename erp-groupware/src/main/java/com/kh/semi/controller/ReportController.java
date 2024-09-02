package com.kh.semi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.ReportDao;
import com.kh.semi.dto.ReportDto;
import com.kh.semi.error.TargetNotFoundException;


@Controller
@RequestMapping("/report")
public class ReportController {

	@Autowired
	private ReportDao reportDao;
	
//	@RequestMapping("/list")
//	public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
//		model.addAttribute("list", reportDao.selectListByPaging(pageVO));
//		pageVO.setCount(reportDao.countByPaging(pageVO));
//		return "/WEB-INF/views/report/list.jsp";
//	}
	
	@RequestMapping("/list")
	public String list(Model model, 
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword) {
		boolean isSearch = column != null && keyword != null;
		
		List<ReportDto> list = isSearch ?
			reportDao.selectList(column, keyword) : reportDao.selectList();
		model.addAttribute("column", column);//검색분류
		model.addAttribute("keyword", keyword);//검색어
		model.addAttribute("list", list);//조회결과
		return "/WEB-INF/views/report/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int repNo) {
		ReportDto reportDto = reportDao.selectOne(repNo);
		model.addAttribute("reportDto", reportDto);
		return "/WEB-INF/views/report/detail.jsp";
	}
	
	@GetMapping("/insert")
	public String insert() {
		return "/WEB-INF/views/report/insert.jsp";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute ReportDto reportDto) {
		int renewRepNo = reportDao.sequence();
		reportDto.setRepNo(renewRepNo);
		
		reportDao.insertWithSequence(reportDto);
		
		return "redirect:insertComplete";
	}
	
	@RequestMapping("/insertComplete")
	public String insertComplete() {
		return "redirect:list";
	}
	
	//수정
	@GetMapping("/edit")
	public String edit(@RequestParam int repNo, Model model) {
		ReportDto reportDto = reportDao.selectOne(repNo);
		model.addAttribute("reportDto", reportDto);
		return "/WEB-INF/views/report/edit.jsp";
	}
	//처리
	@PostMapping("/edit")
	public String edit(@ModelAttribute ReportDto reportDto) {
		boolean result = reportDao.update(reportDto);
		if(result == false) throw new TargetNotFoundException();
		return "redirect:detail?repNo="+reportDto.getRepNo();
	}
	
	
	@RequestMapping("/delete")
	public String delete(int repNo) {
		boolean result = reportDao.delete(repNo);
		return "redirect:list";
	}
}
