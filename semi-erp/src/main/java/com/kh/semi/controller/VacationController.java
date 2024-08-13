package com.kh.semi.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.dao.VacationDao;
import com.kh.semi.dto.VacaReqDto;
import com.kh.semi.service.AttachmentService;

@Controller
@RequestMapping("/vacation")
public class VacationController {
	
	@Autowired
	private VacationDao vacationDao;
	
	@Autowired
	private AttachmentService attachmentService;
	//list
	@RequestMapping("/list")
	public String list(Model model, 
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword) {
		boolean isSearch = column != null && keyword != null;
		
		List<VacaReqDto> list = isSearch ?
				vacationDao.selectList(column, keyword) : vacationDao.selectList();
		
		model.addAttribute("column", column);//검색분류
		model.addAttribute("keyword", keyword);//검색어
		model.addAttribute("list", list);//조회결과
		return "/WEB-INF/views/vacation/draftList.jsp";
	}
	
	@GetMapping("/insert")
	public String insert() {
		return "/WEB-INF/views/vacation/insert2.jsp";
	}
	
	@Transactional
	@PostMapping("/insert")
	public String insert(@ModelAttribute VacaReqDto vacaReqDto,
						@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int newVacano = vacationDao.sequence();
		vacaReqDto.setVacaNo(newVacano); 
		
	
		vacationDao.insertWithSequence(vacaReqDto);
		
//		if(attach.isEmpty() == false) {
//			int attachmentNo = attachmentService.save(attach);			
//			vacationDao.connect(newVacano, attachmentNo);
//		}
		return "redirect:insertComplete";
	}
	
	@RequestMapping("/insertComplete")
	public String insertComplete() {
		return "/WEB-INF/views/vacation/draftList.jsp";
	}
	
	
}
