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

import com.kh.erp.VO.ResPageVO;
import com.kh.erp.dao.ReservationDao;
import com.kh.erp.dto.ReservationDto;

@Controller
@RequestMapping("/res")
public class ReservatoinController {

	@Autowired
	private ReservationDao reservationDao;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute("pageVO") ResPageVO pageVO, Model model) {
	    // 1. 검색된 리스트 데이터를 가져와서 모델에 추가
	    model.addAttribute("list", reservationDao.selectListByPaging(pageVO));
	    
	    // 2. 전체 캘린더 데이터를 가져와서 모델에 추가
	    List<ReservationDto> allReservations = reservationDao.selectAllReservations(); 
	    model.addAttribute("allReservations", allReservations);
	    
	    // 3. 페이지 네비게이션을 위한 카운트 설정
	    pageVO.setCount(reservationDao.countByPaging(pageVO));
	    
	    // 4. JSP로 이동
	    return "/WEB-INF/views/meetingRoom/meetingroomList.jsp";
	}

	// 예약하기
	@GetMapping("/insert")
	public String insert() {
		return "/WEB-INF/views/meetingRoom/insert.jsp";
	}

	//  중복 예약 확인하는 insert
	@PostMapping("/insert")
	public String insertReservation(@ModelAttribute ReservationDto reservationDto, Model model) {
	    // 중복 예약 확인
	    boolean isConflict = reservationDao.isReservationConflict(
	        reservationDto.getRoomId(),
	        reservationDto.getCalDate(),
	        reservationDto.getStime(),
	        reservationDto.getEtime()
	    );

	    if (isConflict) {
	        model.addAttribute("errorMessage", "이미 해당 시간대에 예약이 존재합니다.");
	        return "/WEB-INF/views/meetingRoom/insert.jsp"; // 다시 입력 페이지로 이동
	    }

	    // 중복이 없으면 예약을 진행
	    reservationDao.insert(reservationDto);
	    return "redirect:list"; 
	}


	// 예약 취소
	
	@RequestMapping("/delete")
	public String delete(@RequestParam(value = "resIds", required = false) List<Integer> resIds, Model model) {
	    if (resIds != null && !resIds.isEmpty()) {
	        for (Integer resId : resIds) {
	            reservationDao.delete(resId);
	        }
	    } else {
	    }
	    return "redirect:list";
	}




	// ---------------
	// 예약 수정
	@GetMapping("/edit")
	public String edit() {
		return "/WEB-INF/views/meetingRoom/editChk.jsp";
	}

	// 예약 수정 처리
	@PostMapping("/edit")
	public String edit(@RequestParam int inputPw,
			@ModelAttribute ReservationDto reservationDto, Model model) {
		
	    int dbPw = reservationDao.myPw(reservationDto.getResId());
	    if (dbPw != inputPw) {
	        model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
	        return "redirect:list"; 
	    }
	    reservationDto = reservationDao.selectOne(reservationDto.getResId());
	    model.addAttribute("roomName", reservationDto.getRoomName());
		model.addAttribute("res", reservationDto);
		
		return "/WEB-INF/views/meetingRoom/edit.jsp";
	}
	
	@RequestMapping("/editComplete")
	public String editComplete(@ModelAttribute ReservationDto reservationDto) {
		reservationDao.update(reservationDto);
		return "redirect:list";
	}	
}
