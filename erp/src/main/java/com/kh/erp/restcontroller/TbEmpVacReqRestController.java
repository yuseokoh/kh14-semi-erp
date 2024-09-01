package com.kh.erp.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dao.TbEmpDao;
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

	@Autowired
	private TbEmpDao tbEmpDao;

	@Transactional
	@PostMapping("/update")
	public boolean update(@ModelAttribute TbEmpVacaReqDto tbEmpVacaReqDto, // dto로 받은거
			@RequestParam String approYN, // 이거받은거
			HttpSession session// 검증할때 세션쓸거
	) {
		String loginId = (String) session.getAttribute("createdUser");
		tbEmpVacaReqDto.setApplicantId(loginId);

		// 선검증
		TbEmpApprovalDto tbEmpApprovalDto = tbEmpApprovalDao.selectOneByApproNo(tbEmpVacaReqDto.getApproNo());
		if (tbEmpApprovalDto.getApplicantId().equals(loginId) && tbEmpApprovalDto.getApproYN().equals(approYN)
				&& approYN.equals("N") && tbEmpVacaReqDto.getVacaType() != null) {
			// 검증 완료되면 업데이트
			tbEmpVacaReqDao.updateContent(tbEmpVacaReqDto);
			// 타입때문에 하나 더뱉어야댐..
			tbEmpApprovalDao.updateType(tbEmpVacaReqDto.getVacaType(), tbEmpVacaReqDto.getApproNo());
			return true;
		} else
			return false;
	}

	//admin 레스트 컨트롤러에서 실행해야 될거같은데..?
	//연차일수 감소
	@PostMapping("/deducted")
	public boolean deducted(@RequestParam String approNo) {
		int approNoInt = Integer.parseInt(approNo);
		TbEmpApprovalDto tbEmpApprovalDto = tbEmpApprovalDao.selectOneByApproNo(approNoInt);
		TbEmpVacaReqDto tbEmpVacaReqDto = tbEmpVacaReqDao.selectOneWithApproNoAndId(approNoInt, tbEmpApprovalDto.getApplicantId());
		int days =  tbEmpApprovalDao.getVacationApproCount(tbEmpVacaReqDto.getApplicantId(), tbEmpVacaReqDto.getVacaNo());
	
		System.out.println(days);
		// 만약 승인 됐는데
		if (tbEmpApprovalDto.getApproYN().equals("Y")) {
			// 잔여 연차보다 사용일수가 적으면 갱신
			if (tbEmpDao.selectOne(tbEmpApprovalDto.getApplicantId()).getAnnualLeaveQuota() >= days) {
				tbEmpDao.updateAnnualLeaveUsed(days, tbEmpApprovalDto.getApplicantId());
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}

	}

}
