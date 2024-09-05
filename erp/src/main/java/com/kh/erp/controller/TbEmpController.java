package com.kh.erp.controller;

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

import com.kh.erp.VO.PageVO;
import com.kh.erp.configuration.CustomCertProperties;
import com.kh.erp.dao.CertDao;
import com.kh.erp.dao.NoticeDao;
import com.kh.erp.dao.ReservationDao;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dto.CertDto;
import com.kh.erp.dto.NoticeDto;
import com.kh.erp.dto.ReservationDto;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.error.TargetNotFoundException;
import com.kh.erp.service.DateService;
import com.kh.erp.service.DocumentService;
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
	@Autowired
	private DocumentService documentService;
	@Autowired
	private DateService dateService;
	@Autowired
	private ReservationDao reservationDao;

	// 회원 가입 페이지
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/tb/join.jsp";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute TbEmpDto tbEmpDto) {
		tbEmpDao.insert(tbEmpDto);

		return "redirect:/";
	}

	// 일반 회원 수정 페이지
	@GetMapping("/edit")
	public String edit(HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("createdUser");
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		model.addAttribute("tbEmpDto", tbEmpDto);
		return "/WEB-INF/views/tb/edit.jsp";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute TbEmpDto tbEmpDto, @RequestParam(required = false) MultipartFile attach)
			throws IllegalStateException, IOException {
		tbEmpDao.updateEmp(tbEmpDto);

		if (attach != null && !attach.isEmpty())
			try {
				int beforeNo = tbEmpDao.findImage(tbEmpDto.getLoginId());
				if (beforeNo > 0) {
					documentService.delete(beforeNo);
				}
				int documentNo = documentService.save(attach);
				tbEmpDao.connect(tbEmpDto.getLoginId(), documentNo);
			} catch (Exception e) {
				int documentNo = documentService.save(attach);
				tbEmpDao.connect(tbEmpDto.getLoginId(), documentNo);
			}
		return "redirect:/tb/mypage?loginId=" + tbEmpDto.getLoginId();

	}

	// 마이페이지
	@RequestMapping("/mypage")
	public String mypage(@RequestParam String loginId, Model model) {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		long workingDays = dateService.dateChange(loginId);
		String inTime = dateService.TimeChangeIn(loginId);
		String outTime = dateService.TimeChangeOut(loginId);

		model.addAttribute("inTime", inTime);
		model.addAttribute("outTime", outTime);
		model.addAttribute("workingDays", workingDays);
		model.addAttribute("tbEmpDto", tbEmpDto);
		return "/WEB-INF/views/tb/mypage.jsp";
	}

	// 회원 목록+조회
	@RequestMapping("/list")
	public String list(@ModelAttribute PageVO pageVO, Model model) {
	
		List<TbEmpDto> list = tbEmpDao.empListbyPaging(pageVO);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setEmpDept(nameChangeService.deptChange(list.get(i).getEmpDept()));
		}
		
		model.addAttribute("list", list);
		pageVO.setCount(tbEmpDao.countPage(pageVO));
		return "/WEB-INF/views/tb/list.jsp";
	}

	// 로그인 페이지
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/erp/findPw0828.jsp";
	}

	@PostMapping("/login")
	public String login(@RequestParam(required = false) String loginId, @RequestParam(required = false) String password, HttpSession session) {
		if(loginId == null || password == null) {
			return "redirect:login?error";
		}
		// 아이디에 해당하는 정보를 불러와서 없으면 에러
		TbEmpDto tbEmpDto = tbEmpDao.selectOneWithPW(loginId, password);
		if (tbEmpDto == null)
			return "redirect:login?error";

		session.setAttribute("createdUser", loginId);
		session.setAttribute("userType", tbEmpDto.getUserType());// 관리자 인지 아닌지 구분용
		// 부서 ->> 부서코드 테이블없이 아마 a00으로 들어갈듯 // 이거만 조절하면될듯
		session.setAttribute("userLevel", tbEmpDto.getEmpDept());
		// 2024-08-27 17:09 조재혁 수정
		return "redirect:/home";// 홈으로 이동
//	return "/WEB-INF/views/groupware/truehome.jsp";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("createdUser");
		session.removeAttribute("userType");
		session.removeAttribute("userLevel");
		// 2024-09-02 22:36 로그아웃 시 /tb/login getmapping쪽으로 보내기(성공)
		return "redirect:/tb/login";
	}

	// 상세 페이지

	// 상세 페이지
	@RequestMapping("/detail")
	public String detail(@RequestParam String loginId, Model model) {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		model.addAttribute("tbEmpDto", tbEmpDto);
		return "/WEB-INF/views/tb/detail.jsp";
	}

	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/erp/loginsendEmail0903.jsp";
	}

	@PostMapping("/findPw")
	public String findPw(@RequestParam String loginId, @RequestParam String EmpEmail)
			throws MessagingException, IOException {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		if (tbEmpDto == null) {
			return "redirect:findPw?error";
		}
		if (!EmpEmail.equals(tbEmpDto.getEmpEmail())) {
			return "redirect:findPw?error";
		}
		emailService.sendResetPw(loginId, EmpEmail);
		return "redirect:login";
	}

	// 비밀번호 재설정 페이지
	@GetMapping("/resetPw")
	public String resetPw(@ModelAttribute CertDto certDto, @RequestParam String loginId, Model model) {
		boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
		if (isValid) {
			model.addAttribute("certDto", certDto);
			model.addAttribute("loginId", loginId);
			return "/WEB-INF/views/erp/loginFindPw0903.jsp";
		} else {
			throw new TargetNotFoundException("올바르지 않은 접근");
		}
	}

	@PostMapping("/resetPw")
	public String resetPw(@ModelAttribute CertDto certDto, @ModelAttribute TbEmpDto tbEmpDto) {
		boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
		if (!isValid) {
			throw new TargetNotFoundException("올바르지 않은 접근");
		}

		// 인증 성공시 인증번호 삭제
		certDao.delete(certDto.getCertEmail());
		// 비밀번호 변경 처리
		tbEmpDao.updatePassword(tbEmpDto.getLoginId(), tbEmpDto.getPassword());
		return "redirect:/";
	}

	@RequestMapping("/myImage")
	public String myImage(@RequestParam String loginId) {
		try {// 이미지가 있으면
			Integer documentNo = tbEmpDao.findImage(loginId);
			return "redirect:/attach/download?documentNo=" + documentNo;
		} catch (Exception e) {// 이미지가 없으면
//				return "redirect:/images/dummy.png";
			return "redirect:/images/user.png";
		}
	}

	@GetMapping("/addImage")
	public String addImage() {
		return "/WEB-INF/views/tb/addImage.jsp";
	}

	@PostMapping("/addImage")
	@Transactional
	public String addImage(@RequestParam MultipartFile attach, @RequestParam String loginId)
			throws IllegalStateException, IOException {
		if (attach.isEmpty())
			return "";

		try {
			int beforeNo = tbEmpDao.findImage(loginId);
			documentService.delete(beforeNo);
		} catch (Exception e) {
		}

		int documentNo = documentService.save(attach);
		tbEmpDao.connect(loginId, documentNo);
		return "redirect:mypage";

	}

	// 직급,이미지,이름
	@RequestMapping("/home")
	public String home(HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("createdUser");
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		String inTime = dateService.TimeChangeIn(loginId);
		String outTime = dateService.TimeChangeOut(loginId);
		model.addAttribute("inTime", inTime);
		model.addAttribute("outTime", outTime);
		model.addAttribute("tbEmpDto", tbEmpDto);
		List<ReservationDto> allReservations = reservationDao.selectAllReservations();
		model.addAttribute("allReservations", allReservations);
		return "/WEB-INF/views/erp/main1.jsp";
	}
}