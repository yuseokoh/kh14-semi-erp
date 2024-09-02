package com.kh.erp.restcontroller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
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
	
	@PostMapping("/reject")
	public void reject(@RequestParam String rejectReason
			, @RequestParam int approNo) {
		tbEmpVacaReqDao.updateReject(approNo, rejectReason);
	}
	
	//날짜 검증
	@PostMapping("/checkDate")
	public boolean checkDate(@RequestParam String loginId,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date vacaSdate,
	        @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date vacaEdate) {
		
		//리스트 찾기
		List<TbEmpVacaReqDto> list =  tbEmpVacaReqDao.selectListByvacaTypeAndapplicantId("Y",loginId);
		//검증
		for (TbEmpVacaReqDto tbEmpVacaReqDto : list) {
		    // 각 dto 객체에 대한 작업 수행
			Date dtoSdate = tbEmpVacaReqDto.getVacaSdate();
	        Date dtoEdate = tbEmpVacaReqDto.getVacaEdate();
	        
	     // 날짜가 겹치는지 확인
	        if (vacaSdate.before(dtoEdate) && vacaEdate.after(dtoSdate)) {
	            return false; // 겹치면 false 반환
	        }
		}
		//겹치는게 하나도없으면 반환
		return true;
	}
	

}
