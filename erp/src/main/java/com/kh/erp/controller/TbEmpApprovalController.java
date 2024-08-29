package com.kh.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.erp.VO.PageVO;
import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dao.TbEmpReportDao;
import com.kh.erp.dao.TbEmpVacaReqDao;
import com.kh.erp.dto.TbEmpApprovalDto;
import com.kh.erp.dto.TbEmpReportDto;
import com.kh.erp.dto.TbEmpVacaReqDto;

@Controller
@RequestMapping("/approval")
public class TbEmpApprovalController {

	@Autowired
	private TbEmpApprovalDao tbEmpApprovalDao;

	@Autowired
	private TbEmpReportDao tbEmpReportDao;

	@Autowired
	private TbEmpVacaReqDao tbEmpVacaReqDao;

	@RequestMapping("/list")
	public String list(@ModelAttribute PageVO pageVO, Model model) {
		List<TbEmpApprovalDto> list = tbEmpApprovalDao.approListByPaging(pageVO);
		System.out.println(list);
		model.addAttribute("list", list);
		pageVO.setCount(tbEmpApprovalDao.countPage(pageVO));
		return "/WEB-INF/views/groupware/totalList2.jsp";
	}

	// 문서결재 하는 란 admin으로 넘겨질수도
	@GetMapping("/detail")
	public String detail(@RequestParam int approNo, Model model) {
		TbEmpApprovalDto tbEmpApprovalDto = tbEmpApprovalDao.selectOneByApproNo(approNo);
		
		//승인번호에 해당하는 문서를 가져오는데 그걸 타입으로 먼저 비교하고
		//그에따라 매핑하듯 가져온다
		//그걸 모델에 넘겨서 restController 쓸거임
		//메소드는 만들때 key-value 메소드를 만드는게 나을듯 + 둘다
		//이거한번만 적용되면 휴가도 적용하고~ 다하면 된다 이마리야~
		
		if (tbEmpApprovalDto.getApproType().equals("보고서")) {
			
//			TbEmpReportDto tbEmpReportDto = tbEmpReportDao.selectOne();
			model.addAttribute("tbEmpApprovalDto", tbEmpApprovalDto);
			return "/WEB-INF/views/groupware/admin/approval/reportWait.jsp";
		} else {// 보고서 제외 전부 지금은 휴가 관련된 것만 나오게
//			TbEmpVacaReqDto tbEmpVacaReqDto = tbEmpVacaReqDao.selectOneByColumn();
			return "/WEB-INF/views/groupware/admin/approval/vacaWait.jsp";
		}
		
	}

}
