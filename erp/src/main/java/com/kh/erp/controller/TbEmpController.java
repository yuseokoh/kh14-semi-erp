package com.kh.erp.controller;

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
 
import com.kh.erp.VO.PageVO;
import com.kh.erp.configuration.CustomCertProperties;
import com.kh.erp.dao.CertDao;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dto.CertDto;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.error.TargetNotFoundException;
import com.kh.erp.service.EmailService;
import com.kh.erp.service.NameChangeService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;





@Controller
@RequestMapping("/tb")
public class TbEmpController {
	@Autowired
	private TbEmpDao tbEmpDao;
	
	@Autowired
	private NameChangeService nameChangeService;
	
	@Autowired
	private CertDao certDao;
	@Autowired
	private CustomCertProperties customCertProperties;
	@Autowired
	private EmailService emailService;
	
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
	session.setAttribute("userType", tbEmpDto.getUserType());// 관리자 인지 아닌지 구분용
	// 부서 ->> 부서코드 테이블없이 아마 a00으로 들어갈듯 // 이거만 조절하면될듯
	session.setAttribute("userLevel", tbEmpDto.getEmpDept());
	//2024-08-27 17:09 조재혁 수정
//	return "redirect:/";// 홈으로 이동
	return "/WEB-INF/views/groupware/truehome.jsp";
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("createdUser");
		session.removeAttribute("userType");
		session.removeAttribute("userLevel");
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
	
	@GetMapping("/findPw")
	public String findPw2() {
		return "/WEB-INF/views/tb/findPw.jsp";
	}
	
	@PostMapping("/findPw")
	public String findPw(@RequestParam String loginId,@RequestParam String EmpEmail) throws MessagingException, IOException {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
	    if(tbEmpDto ==null) {
	    	return "redirect:findPw2?error";
	    }
	    if(!EmpEmail.equals(tbEmpDto.getEmpEmail())) {
	    	return "redirect:findPw2?error";
	    }
	    emailService.sendResetPw(loginId,EmpEmail);
		return "redirect:login";
	}
	
	
	
	
	
	//비밀번호 재설정 페이지
		@GetMapping("/resetPw")
		public String resetPw(@ModelAttribute CertDto certDto, @RequestParam String loginId,Model model) {
			boolean isValid = certDao.check(certDto,customCertProperties.getExpire());
			if(isValid) {
				model.addAttribute("certDto",certDto);
				model.addAttribute("loginId",loginId);
				return "/WEB-INF/views/tb/resetPw.jsp";			
			}
			else{
				throw new TargetNotFoundException("올바르지 않은 접근");
			}
		}
		@PostMapping("/resetPw")
		public String resetPw(@ModelAttribute CertDto certDto,@ModelAttribute TbEmpDto tbEmpDto) {
			boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
			if(!isValid) {
				throw new TargetNotFoundException("올바르지 않은 접근");
			}
			
			//인증 성공시 인증번호 삭제
			certDao.delete(certDto.getCertEmail());
			//비밀번호 변경 처리
			tbEmpDao.updatePassword(tbEmpDto.getLoginId(), tbEmpDto.getPassword());
			return "redirect:login";
		}
}