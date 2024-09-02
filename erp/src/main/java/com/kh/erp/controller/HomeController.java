package com.kh.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dto.TbEmpDto;

import jakarta.servlet.http.HttpSession;




@Controller
public class HomeController {
	@Autowired
	private TbEmpDao tbEmpDao;
	
    // 로그인 페이지로 리디렉션
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String redirectToLogin() {
        return "redirect:/tb/login";
    }

    // 홈 페이지로 접근할 수 있는 새 주소
    @RequestMapping("/home")
    public String home(HttpSession session,Model model) {
    	String loginId = (String) session.getAttribute("createdUser");
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		model.addAttribute("tbEmpDto",tbEmpDto);
		System.out.println(tbEmpDto);
        return "/WEB-INF/views/erp/mian0828.jsp";
    }
}