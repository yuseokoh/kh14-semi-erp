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
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dto.TbEmpDto;
import com.kh.erp.service.NameChangeService;

@Controller
@RequestMapping("/admin/emp")
public class AdminEmpController {
	@Autowired
	private TbEmpDao tbEmpDao;
	@Autowired
	private NameChangeService nameChangeService;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute PageVO pageVO,Model model) {
		List<TbEmpDto> list = tbEmpDao.empListbyPaging(pageVO);
		for(int i=0;i<list.size();i++) {
		list.get(i).setEmpDept(nameChangeService.deptChange(list.get(i).getEmpDept()));
		}
		model.addAttribute("list",list);
		pageVO.setCount(tbEmpDao.countPage(pageVO));
		return "/WEB-INF/views/admin/list.jsp";
	}
	@RequestMapping("/detail")
	public String detail(@RequestParam String loginId,Model model) {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		tbEmpDto.setEmpDept(nameChangeService.deptChange(tbEmpDto.getEmpDept()));
		model.addAttribute("tbEmpDto",tbEmpDto);
		return "/WEB-INF/views/admin/detail.jsp";
	}
	
	
	@GetMapping("/edit")
	public String edit(@RequestParam String loginId,Model model) {
		TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
		model.addAttribute("tbEmpDto",tbEmpDto);
		return "/WEB-INF/views/admin/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute TbEmpDto tbEmpDto) {
		tbEmpDao.updateEmpByAdmin(tbEmpDto);
		return "redirect:/admin/emp/list";
	}
	//퇴사에 대한 구현(삭제 아님)
	@GetMapping("/delete")
	public String delete(@RequestParam String loginId,Model model) {
		model.addAttribute("loginId",loginId);
		return "/WEB-INF/views/admin/delete.jsp";
	}
	@PostMapping("/delete")
	public String delete(@RequestParam String loginId) {
		tbEmpDao.updateEdate(loginId);
		return "redirect:/admin/emp/list";
	}
	@RequestMapping("/status")
	public String status(Model model) {
		model.addAttribute("empLevelStatusList",tbEmpDao.statusByEmpLevel());
		model.addAttribute("empLevelStatusByeList",tbEmpDao.statusByEmpLevelBye());
		model.addAttribute("empSdateList",tbEmpDao.statusByEmpSdate());
		model.addAttribute("empEdateList",tbEmpDao.statusByEmpEdate());
		model.addAttribute("workingDayList",tbEmpDao.workingDay());
		return "/WEB-INF/views/admin/status2.jsp";
	}
}
