package com.kh.erp.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.erp.VO.AttendanceSummaryVO;
import com.kh.erp.VO.PageVO;
import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dao.TbEmpAttendanceDao;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dao.TbEmpReportDao;
import com.kh.erp.dao.TbEmpVacaReqDao;
import com.kh.erp.dto.TbEmpApprovalDto;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.dto.TbEmpReportDto;
import com.kh.erp.dto.TbEmpVacaReqDto;
import com.kh.erp.service.NameChangeService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/emp")
public class AdminEmpController {
	@Autowired
	private TbEmpDao tbEmpDao;
	@Autowired
	private TbEmpReportDao tbEmpReportDao;
	@Autowired
	private TbEmpVacaReqDao tbEmpVacaReqDao;
	@Autowired
	private TbEmpApprovalDao tbEmpApprovalDao;
	@Autowired
	private TbEmpAttendanceDao tbEmpAttendanceDao;
	@Autowired
	private NameChangeService nameChangeService;

	@RequestMapping("/list")
	public String list(@ModelAttribute PageVO pageVO, Model model) {
		List<TbEmpDto> list = tbEmpDao.empListbyPaging(pageVO);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setEmpDept(nameChangeService.deptChange(list.get(i).getEmpDept()));
		}
		model.addAttribute("list", list);
		pageVO.setCount(tbEmpDao.countPage(pageVO));
		return "/WEB-INF/views/admin/list.jsp";
	}

	@RequestMapping("/detail")
	public String detail(@RequestParam String loginId, Model model) {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		model.addAttribute("tbEmpDto", tbEmpDto);
		return "/WEB-INF/views/admin/detail2.jsp";
	}

	@GetMapping("/edit")
	public String edit(@RequestParam String loginId, Model model) {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		model.addAttribute("tbEmpDto", tbEmpDto);
		return "/WEB-INF/views/admin/edit.jsp";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute TbEmpDto tbEmpDto) {
		tbEmpDao.updateEmpByAdmin(tbEmpDto);
		return "redirect:/admin/emp/list";
	}

	// 퇴사에 대한 구현(삭제 아님)
	@GetMapping("/delete")
	public String delete(@RequestParam String loginId, Model model) {
		model.addAttribute("loginId", loginId);
		return "/WEB-INF/views/admin/delete.jsp";
	}

	@PostMapping("/delete")
	public String delete(@RequestParam String loginId) {
		tbEmpDao.updateEdate(loginId);
		return "redirect:/admin/emp/list";
	}

	// 문서결재 하는 란 admin으로 넘겨질수도
	@GetMapping("/approval")
	public String detail(@RequestParam String applicantId, @RequestParam int approNo, Model model) {
		// 결재해야할 문서 정보 접근
		TbEmpApprovalDto tbEmpApprovalDto = tbEmpApprovalDao.selectOneByApproNo(approNo);

		// 승인번호에 해당하는 문서를 가져오는데 그걸 타입으로 먼저 비교하고
		// 그에따라 매핑하듯 가져온다
		// 그걸 모델에 넘겨서 restController 쓸거임
		// 메소드는 만들때 key-value 메소드를 만드는게 나을듯 + 둘다
		// 이거한번만 적용되면 휴가도 적용하고~ 다하면 된다 이마리야~
		if (tbEmpApprovalDto.getApproType().equals("보고서")) {
			// 보고서면 작성자 Id와 결재번호로 보고서 접근
			TbEmpReportDto tbEmpReportDto = tbEmpReportDao.selectOneWithApproNoAndId(approNo, applicantId);

			// 작성자 Id로 사원정보 접근 + document(결재 사인)이 있는 경우 그거도 보냄
			// 보내는 게아니라 받는다면? 받아서 보여주면된다면?

			TbEmpDto tbEmpDto = tbEmpDao.selectOne(tbEmpReportDto.getWriterId());
			model.addAttribute("tbEmpReportDto", tbEmpReportDto);
			// 중간에 부서코드 -> 이름으로 바꿔서 보여주기
			tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
			model.addAttribute("tbEmpDto", tbEmpDto);
			model.addAttribute("tbEmpApprovalDto", tbEmpApprovalDto);
			return "/WEB-INF/views/groupware/admin/approval/reportWait.jsp";
		} else {// 보고서 제외 전부 지금은 휴가 관련된 것만 나오게
			TbEmpVacaReqDto tbEmpVacaReqDto = tbEmpVacaReqDao.selectOneWithApproNoAndId(approNo, applicantId);
			TbEmpDto tbEmpDto = tbEmpDao.selectOne(tbEmpVacaReqDto.getApplicantId());
			tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
			model.addAttribute("tbEmpVacaReqDto", tbEmpVacaReqDto);
			model.addAttribute("tbEmpDto", tbEmpDto);
			model.addAttribute("tbEmpApprovalDto", tbEmpApprovalDto);
			return "/WEB-INF/views/groupware/admin/approval/leaveWait.jsp";
		}

	}

	// dao에서 sql 수정 -- > 이거 수정하고 페이지 만들기
	@RequestMapping("/approvalList")
	public String approlist(@ModelAttribute PageVO pageVO, Model model, HttpSession session) {
		if (session.getAttribute("userType").equals("A")) {
			List<TbEmpApprovalDto> list = tbEmpApprovalDao.approListByPaging(pageVO);
			model.addAttribute("list", list);
			pageVO.setCount(tbEmpApprovalDao.countPage(pageVO));
			return "/WEB-INF/views/groupware/admin/approval/approvalList.jsp";
		} else {
			return "redirect:/home";
		}
	}

	@RequestMapping("/status")
	public String status(Model model) {
		model.addAttribute("empLevelStatusList", tbEmpDao.statusByEmpLevel());
		model.addAttribute("empLevelStatusByeList", tbEmpDao.statusByEmpLevelBye());
		model.addAttribute("empSdateList", tbEmpDao.statusByEmpSdate());
		model.addAttribute("empEdateList", tbEmpDao.statusByEmpEdate());
		model.addAttribute("workingDayList", tbEmpDao.workingDay());
		return "/WEB-INF/views/admin/status2.jsp";
	}

	@GetMapping("/hoursMgmt")
	public String hoursMgmt(Model model, HttpSession session, PageVO pageVO,
			@RequestParam(required = false) Integer tbyear, @RequestParam(required = false) Integer tbmonth) {

		// 현재 날짜와 시간 가져오기
		LocalDateTime now = LocalDateTime.now();

		if (tbyear == null && tbmonth == null) {
			// 현재 년도와 월 추출
			int year = now.getYear();
			int month = now.getMonthValue();
			List<AttendanceSummaryVO> list = tbEmpAttendanceDao.getAttendanceSummary(pageVO, year, month);
			model.addAttribute("list", list);
			pageVO.setCount(tbEmpAttendanceDao.countSummaryPageWithVO(pageVO, year, month));
		} else {
			List<AttendanceSummaryVO> list = tbEmpAttendanceDao.getAttendanceSummary(pageVO, tbyear, tbmonth);
			model.addAttribute("list", list);
			pageVO.setCount(tbEmpAttendanceDao.countSummaryPageWithVO(pageVO, tbyear, tbmonth));
		}
		return "/WEB-INF/views/groupware/admin/workHours.jsp";
	}
}
