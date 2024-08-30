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

import com.kh.erp.VO.PageVO;
import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dao.TbEmpReportDao;
import com.kh.erp.dao.TbEmpVacaReqDao;
import com.kh.erp.dto.TbEmpApprovalDto;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.dto.TbEmpReportDto;
import com.kh.erp.dto.TbEmpVacaReqDto;
import com.kh.erp.service.NameChangeService;

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
		return "/WEB-INF/views/admin/detail.jsp";
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

	@GetMapping("/delete")
	public String delete(@RequestParam String loginId, Model model) {
		model.addAttribute("loginId", loginId);
		return "/WEB-INF/views/admin/delete.jsp";
	}

	@PostMapping("/delete")
	public String delete(@RequestParam String loginId) {
		tbEmpDao.deleteEmp(loginId);
		return "redirect:/admin/emp/list";
	}

	// 문서결재 하는 란 admin으로 넘겨질수도
	@GetMapping("/approval")
	public String detail(@RequestParam String writerId, @RequestParam int approNo, Model model) {
		// 결재해야할 문서 정보 접근
		TbEmpApprovalDto tbEmpApprovalDto = tbEmpApprovalDao.selectOneByApproNo(approNo);

		// 승인번호에 해당하는 문서를 가져오는데 그걸 타입으로 먼저 비교하고
		// 그에따라 매핑하듯 가져온다
		// 그걸 모델에 넘겨서 restController 쓸거임
		// 메소드는 만들때 key-value 메소드를 만드는게 나을듯 + 둘다
		// 이거한번만 적용되면 휴가도 적용하고~ 다하면 된다 이마리야~
		if (tbEmpApprovalDto.getApproType().equals("보고서")) {
			// 보고서면 작성자 Id와 결재번호로 보고서 접근
			TbEmpReportDto tbEmpReportDto = tbEmpReportDao.selectOneWithApproNoAndId(approNo, writerId);

			// 작성자 Id로 사원정보 접근 + document(결재 사인)이 있는 경우 그거도 보냄
			System.out.println("test in approval " + tbEmpReportDao.findImage(approNo));
			if (tbEmpReportDao.findImage(approNo) == -1)
			{
				System.out.println("에러요 이씨빌아");
			}
			TbEmpDto tbEmpDto = tbEmpDao.selectOne(tbEmpReportDto.getWriterId());
			model.addAttribute("tbEmpReportDto", tbEmpReportDto);
			model.addAttribute("tbEmpDto", tbEmpDto);
			model.addAttribute("tbEmpApprovalDto", tbEmpApprovalDto);
			return "/WEB-INF/views/groupware/admin/approval/reportWait.jsp";
		} else {// 보고서 제외 전부 지금은 휴가 관련된 것만 나오게
//				TbEmpVacaReqDto tbEmpVacaReqDto = tbEmpVacaReqDao.selectOneWithApproNoAndId();
//				TbEmpDto tbEmpDto = tbEmpDao.selectOne(tbEmpReportDto.getWriterId());
//				model.addAttribute("tbEmpVacaReqDto", tbEmpVacaReqDto);
//				model.addAttribute("tbEmpDto", tbEmpDto);
//				model.addAttribute("tbEmpApprovalDto", tbEmpApprovalDto);
			return "/WEB-INF/views/groupware/admin/approval/vacaWait.jsp";
		}

	}

	// dao에서 sql 수정
	@RequestMapping("/approlist")
	public String approlist(@ModelAttribute PageVO pageVO, Model model) {
		List<TbEmpApprovalDto> list = tbEmpApprovalDao.approListByPaging(pageVO);
		System.out.println(list);
		model.addAttribute("list", list);
		pageVO.setCount(tbEmpApprovalDao.countPage(pageVO));
		return "/WEB-INF/views/groupware/totalList2.jsp";
	}
}
