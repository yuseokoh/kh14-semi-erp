package com.kh.semi.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
	
	@GetMapping("/insert")
	public String insert() {
		return "/WEB-INF/views/vacation/insert.jsp";
	}
	
	@Transactional
	@PostMapping("/insert")
	public String insert(@ModelAttribute VacaReqDto vacaReqDto,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int newVacano = vacationDao.sequence();
		vacaReqDto.setVacaNo(newVacano); 
		
	
		vacationDao.insertWithSequence(vacaReqDto);
		
		if(attach.isEmpty() == false) {
			int attachmentNo = attachmentService.save(attach);			
			vacationDao.connect(newVacano, attachmentNo);
		}
		return "redirect:insertComplete";
	}
	
	@RequestMapping("/insertComplete")
	public String insertComplete() {
		return "/WEB-INF/views/vacation/list.jsp";
	}
	
}
