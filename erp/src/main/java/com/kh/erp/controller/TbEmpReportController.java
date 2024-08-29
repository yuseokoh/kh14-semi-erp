package com.kh.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dao.TbEmpReportDao;
import com.kh.erp.dto.TbEmpApprovalDto;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.dto.TbEmpReportDto;
import com.kh.erp.service.NameChangeService;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/report")
public class TbEmpReportController {

	@Autowired
	private TbEmpApprovalDao tbApprovalDao;

	@Autowired
	private TbEmpReportDao tbEmpReportDao;

	@Autowired
	private TbEmpDao tbEmpDao;

	@Autowired
	private NameChangeService nameChangeService;

	// 보고서 작성
	@GetMapping("/insert")
	public String insert(HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("createdUser");
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		model.addAttribute("tbEmpDto", tbEmpDto);
		return "/WEB-INF/views/groupware/report/reportInsert.jsp";
	}

	@Transactional
	@PostMapping("/insert")
	public String insert(@ModelAttribute TbEmpReportDto tbEmpReportDto, HttpSession session) {
		// 이름이 들어가기때문에 그 이름 받는 부분을 id로 받고(이전까진 내용물은 이름)
		String loginId = (String) session.getAttribute("createdUser");

		// [1]세션Id로 사용자 정보를 찾아다가 Id에 해당하는 이름 찾고
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);

		if (tbEmpDto.getName().equals(tbEmpReportDto.getWriterName())) {

			//
			int apprNo = tbApprovalDao.sequence();

			// 삽입 성공 시 일단 미리 결재 곽을 만들어야함 --> 결재 곽에 Type이랑 신청자 아이디 추가
			TbEmpApprovalDto tbEmpApprovalDto = new TbEmpApprovalDto();

			tbEmpApprovalDto.setApproNo(apprNo);
			// 보고서에 타입이 있나? 흠.. 흠...
			tbEmpApprovalDto.setApproType("보고서");
			tbEmpApprovalDto.setApplicantId(loginId);
			tbApprovalDao.insert(tbEmpApprovalDto);

			tbEmpReportDto.setApproNo(apprNo);
			tbEmpReportDto.setWriterId(loginId);
			// 최종 삽입
			tbEmpReportDao.insert(tbEmpReportDto);
		}
		// 일단 리턴은 리다이렉트 리스트 // 아직 보낼 장소를 못정함
		return "redirect:mylist?loginId=" + loginId;
	}

	@RequestMapping("/detail")
	public String requestMethodName(@RequestParam int reportNo, Model model) {
		TbEmpReportDto tbEmpReportDto = tbEmpReportDao.selectOne(reportNo);
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(tbEmpReportDto.getWriterId());
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));

		System.out.println("tbEmpReportDto = " + tbEmpReportDto);

		// 사원 정보
		model.addAttribute("tbEmpDto", tbEmpDto);

		// 보고서 정보
		model.addAttribute("tbEmpReportDto", tbEmpReportDto);

		/// 아마 대충 음..
		return "/WEB-INF/views/groupware/report/reportDetail.jsp";
	}

}
