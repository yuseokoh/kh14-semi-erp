package com.kh.erp.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dao.TbEmpReportDao;
import com.kh.erp.dto.TbEmpApprovalDto;
import com.kh.erp.dto.TbEmpReportDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/report")
public class TbEmpReportRestController {

	@Autowired
	private TbEmpApprovalDao tbEmpApprovalDao;

	@Autowired
	private TbEmpReportDao tbEmpReportDao;

	@PostMapping("/update")
	public boolean update(@ModelAttribute TbEmpReportDto tbEmpReportDto, // dto로 받은거
			@RequestParam String approYN, // 이거받은거
			HttpSession session// 검증할때 세션쓸거
	) {
		String loginId = (String) session.getAttribute("createdUser");
		tbEmpReportDto.setWriterId(loginId);
		// 선검증
		TbEmpApprovalDto tbEmpApprovalDto = tbEmpApprovalDao.selectOneByApproNo(tbEmpReportDto.getApproNo());
		if (tbEmpApprovalDto.getApplicantId().equals(loginId) && tbEmpApprovalDto.getApproYN().equals(approYN)
				&& approYN.equals("N")) {
			// 검증 완료되면 업데이트
			tbEmpReportDao.updateContent(tbEmpReportDto);
			return true;
		} else
			return false;
	}
	
	@PostMapping("/reject")
	public void reject(@RequestParam String rejectReason
			, @RequestParam int approNo) {
		tbEmpReportDao.updateReject(approNo, rejectReason);
	}
	

}
