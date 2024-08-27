package com.kh.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.erp.VO.PageVO;
import com.kh.erp.VO.TbVacRecVO;
import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dao.TbEmpVacaReqDao;
import com.kh.erp.dto.TbEmpApprovalDto;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.dto.TbEmpVacaReqDto;
import com.kh.erp.service.NameChangeService;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/vacation")
public class TbEmpVacaReqController {

	@Autowired
	private TbEmpVacaReqDao tbEmpVacaReqDao;

	@Autowired
	private TbEmpApprovalDao tbApprovalDao;

	@Autowired
	private TbEmpDao tbEmpDao;

	@Autowired
	private NameChangeService nameChangeService;

	@RequestMapping("/list")
	public String list(@ModelAttribute PageVO pageVO, Model model) {
		List<TbVacRecVO> list = tbEmpVacaReqDao.selectVacaLogListByPaging();
		model.addAttribute("list", list);
		pageVO.setCount(tbEmpVacaReqDao.countPage(pageVO));
		return "/WEB-INF/views/groupware/totalVacaList.jsp";
	}

	// 휴가 신청서 작성 근데 사용자의 관련 정보를 미리 가져와야함
	@GetMapping("/insert")
	public String insert(HttpSession session, Model model) {

		String loginId = (String) session.getAttribute("createdUser");
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		model.addAttribute("tbEmpDto", tbEmpDto);

		return "/WEB-INF/views/groupware/leave/leaveInsert.jsp";
	}

	@Transactional
	@PostMapping("/insert")
	public String insert(@ModelAttribute TbEmpVacaReqDto tbEmpVacaReqDto, HttpSession session, String empEmail) {
		// 이름이 들어가기때문에 그 이름 받는 부분을 id로 받고(이전까진 내용물은 이름)
		String loginId = (String) session.getAttribute("createdUser");

		// [1]세션Id로 사용자 정보를 찾아다가 Id에 해당하는 이름 찾고
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);

		// tbEmpVacaReqDto.getApplicantId()-> 여기에 아직 이름들어있음
		// [2]그값이 tbEmpDto에 이름값과 동일하고 empEmail과 같으면
		// tbEmpVacaReqDto의 ApplicantId 값을 세션아이디로 치환후 삽입
		if (tbEmpDto.getEmpEmail().equals(empEmail) && tbEmpDto.getName().equals(tbEmpVacaReqDto.getApplicantId())) {
			tbEmpVacaReqDto.setApplicantId(loginId);
			

			// 삽입 성공 시 일단 미리 결재 곽을 만들어야함 --> 결재 곽에 Type이랑 신청자 아이디 추가
			TbEmpApprovalDto tbEmpApprovalDto = new TbEmpApprovalDto();
			tbEmpApprovalDto.setApproType(tbEmpVacaReqDto.getVacaType());
			tbEmpApprovalDto.setApplicantId(loginId);
			tbApprovalDao.insert(tbEmpApprovalDto);

			System.out.println("tbEmpVacaReqDto in insert is = " + tbEmpVacaReqDto);
			// 최종 삽입
			tbEmpVacaReqDao.insert(tbEmpVacaReqDto);
		}

		// 일단 리턴은 리다이렉트 리스트 // 아직 보낼 장소를 못정함
		return "redirect:list";
	}

}
