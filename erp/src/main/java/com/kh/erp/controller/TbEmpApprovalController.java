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

	

}
