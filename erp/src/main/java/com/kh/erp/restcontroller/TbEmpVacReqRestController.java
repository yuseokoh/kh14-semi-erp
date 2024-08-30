package com.kh.erp.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dao.TbEmpVacaReqDao;
import com.kh.erp.dto.TbEmpApprovalDto;
import com.kh.erp.dto.TbEmpVacaReqDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/vacation")
public class TbEmpVacReqRestController {

	@Autowired
	private TbEmpApprovalDao tbEmpApprovalDao;

	@Autowired
	private TbEmpVacaReqDao tbEmpVacaReqDao;

	@PostMapping("/update")
	public boolean update(@ModelAttribute TbEmpVacaReqDto tbEmpVacaReqDto, // dto로 받은거
			@RequestParam String approYN, // 이거받은거
			HttpSession session// 검증할때 세션쓸거
	) {
		String loginId = (String) session.getAttribute("createdUser");
		
		
		
		// 선검증
		TbEmpApprovalDto tbEmpApprovalDto = tbEmpApprovalDao.selectOneByApproNo(tbEmpVacaReqDto.getApproNo());
		System.out.println("approYN in rest/report/update = " + approYN);
		if (tbEmpApprovalDto.getApplicantId().equals(loginId) && tbEmpApprovalDto.getApproYN().equals(approYN)
				&& approYN.equals("N")) {
			// 검증 완료되면 업데이트
//			tbEmpVacaReqDao.updateContent(tbEmpVacaReqDto);이거도 수정해야댐
			return true;
		} else
			return false;
	}

}
