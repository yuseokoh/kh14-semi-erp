package com.kh.semi.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.VacationDao;
import com.kh.semi.dto.VacaReqDto;
import com.kh.semi.service.AttachmentService;
import com.kh.semi.vo.VacationApplyVO;
import com.kh.semi.error.TargetNotFoundException;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/vacation")
public class VacationController {

	@Autowired
	private VacationDao vacationDao;

	@Autowired
	private AttachmentService attachmentService;

	// list
	@RequestMapping("/list")
	public String list(Model model, @RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword) {
		boolean isSearch = column != null && keyword != null;

		List<VacaReqDto> list = isSearch ? vacationDao.selectList(column, keyword) : vacationDao.selectList();
		model.addAttribute("column", column);// 검색분류
		model.addAttribute("keyword", keyword);// 검색어
		model.addAttribute("list", list);// 조회결과
		return "/WEB-INF/views/vacation/draftList.jsp";
	}

	// 등록

	@GetMapping("/insert")
	public String insert() {
		return "/WEB-INF/views/vacation/insert.jsp";
	}

	@PostMapping("/insert")
	public String insert(@ModelAttribute VacaReqDto vacaReqDto) throws IllegalStateException, IOException {
		int newVacano = vacationDao.sequence();
		vacaReqDto.setVacaNo(newVacano);

		vacationDao.insertWithSequence(vacaReqDto);

		return "redirect:insertComplete";
	}

	@RequestMapping("/insertComplete")
	public String insertComplete() {
		return "redirect:list";
	}

	// detail
	@RequestMapping("/detail") // dto 추가하기
	public String detail(@RequestParam int vacaNo, Model model) {
//		System.out.println("vacaNo = " + vacaNo);
		VacationApplyVO vacationApplyVO = vacationDao.selectOne(vacaNo);
//		System.out.println(vacationApplyVO);
		model.addAttribute("vacationApplyVO", vacationApplyVO);
		return "/WEB-INF/views/vacation/detail.jsp";
	}

	// update
	@RequestMapping("/edit")
	public String update(@RequestParam int vacaNo, Model model) {
		VacationApplyVO vacationApplyVO = vacationDao.selectOne(vacaNo);
		model.addAttribute("vacationApplyVO", vacationApplyVO);
		return "/WEB-INF/views/vacation/edit.jsp";
	}
	
	//delete
	@RequestMapping("/delete") //세션이없어서 쓸 수 없다
	public String delete(@RequestParam int vacaNo, HttpSession session) {
		
		boolean result = vacationDao.delete(vacaNo, session);
		if(result == false) 
			throw new TargetNotFoundException("존재하지 않는 회원ID");
		return "/WEB-INF/views/vacation/draftList.jsp";
	}
	
	//rest
	@RequestMapping("/rest")
	public String rest() {//15 - 연차일수
		int fullLeave = 15;
		//사용한 연차 계산하기 : 총연차, 휴가연차, 남은 연차 
		return "/WEB-INF/views/vacation/restAnualLeave.jsp";
	}
	
}
