package com.kh.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.service.NameChangeService;
import com.kh.erp.vo.PageVO;

import jakarta.servlet.http.HttpSession;





@Controller
@RequestMapping("/tb")
public class TbEmpController {
	@Autowired
	private TbEmpDao tbEmpDao;
	
	@Autowired
	private NameChangeService nameChangeService;
	
	//회원 가입 페이지
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/tb/join.jsp"; 
	}
	@PostMapping("/join")
	public String join(@ModelAttribute TbEmpDto tbEmpDto) {
		tbEmpDao.insert(tbEmpDto);
		
		return "redirect:/";	
	}
	//일반 회원 수정 페이지
	@GetMapping("/edit")
	public String edit(HttpSession session, Model model) {
		String loginId = (String)session.getAttribute("createdUser");
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		model.addAttribute("tbEmpDto",tbEmpDto);
		return "/WEB-INF/views/tb/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute TbEmpDto tbempDto) {
		tbEmpDao.updateEmp(tbempDto);
		return "redirect:/";
	}
	//마이페이지
	@RequestMapping("/mypage")
	public String mypage(HttpSession session,Model model) {
		String loginId = (String)session.getAttribute("createdUser");
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		model.addAttribute("tbEmpDto",tbEmpDto);
		return "/WEB-INF/views/tb/mypage.jsp";
	}
	//회원 목록+조회
	@RequestMapping("/list")
	public String list(@ModelAttribute PageVO pageVO,Model model) {
		List<TbEmpDto> list = tbEmpDao.empListbyPaging(pageVO);
		for(int i=0;i<list.size();i++) {
		list.get(i).setEmpDept(nameChangeService.deptChange(list.get(i).getEmpDept()));
		}
		model.addAttribute("list",list);
		pageVO.setCount(tbEmpDao.countPage(pageVO));
		return "/WEB-INF/views/tb/list.jsp";
	}
	//로그인 페이지
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/erp/login2.jsp";
	}
	@PostMapping("/login")
	public String login(@RequestParam String loginId, @RequestParam String password, HttpSession session) {
	//아이디에 해당하는 정보를 불러와서 없으면 에러
	TbEmpDto tbEmpDto = tbEmpDao.selectOneWithPW(loginId,password);
	if (tbEmpDto == null)return "redirect:login?error";

	session.setAttribute("createdUser", loginId);
	session.setAttribute("userType", tbEmpDto.getUserType());
	//session.setAttribute("createdLevel", memberDto.getMemberLevel());
	return "redirect:/";// 홈으로 이동
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("createdUser");
		session.removeAttribute("userType");
		return "redirect:/";
	}
	//상세 페이지
	@RequestMapping("/detail")
	public String detail(@RequestParam String loginId,Model model) {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		model.addAttribute("tbEmpDto",tbEmpDto);
		return "/WEB-INF/views/tb/detail.jsp";
	}
}