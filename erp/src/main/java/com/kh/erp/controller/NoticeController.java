package com.kh.erp.controller;

import java.util.HashSet;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.erp.VO.PageVO;
import com.kh.erp.dao.NoticeDao;
import com.kh.erp.dto.NoticeDto;
import com.kh.erp.error.TargetNotFoundException;
import com.kh.erp.service.AttachmentService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	private NoticeDao noticeDao;
	
	@RequestMapping("/list")
	public String list(
			@ModelAttribute("pageVO") PageVO pageVO, Model model) {
		model.addAttribute("noticeList", noticeDao.selectListByPaging(pageVO));
		int count = noticeDao.countByPaging(pageVO);
		pageVO.setCount(count);
		return "/WEB-INF/views/notice.jsp";
	}
	
	private boolean checkSearch(String column, String keyword) {
		if(column == null) return false;
		if(keyword == null) return false;
		switch(column) {
		case "notice_title":
		case "notice_writer":
			return true;
		}
		return false;
	}
	//상세 페이지
	@RequestMapping("/detail")
	public String detail(@RequestParam int noticeNo, Model model) {
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		if(noticeDto == null)
			throw new TargetNotFoundException("존재하지 않는 공지사항 번호");
		model.addAttribute("noticeDto", noticeDto);
		return "/WEB-INF/views/notice/detail.jsp";
	}
	
	//등록 페이지
	@GetMapping("/write")
	public String write() {
		return "/WEB-INF/views/notice/write.jsp";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute NoticeDto noticeDto, HttpSession session) {
		String testUser = (String)session.getAttribute("testUser");
		noticeDto.setNoticeWriter(testUser);
		
		int seq = noticeDao.sequence();
		
		noticeDto.setNoticeNo(seq);
		
		if(noticeDto.isNew()) {
			noticeDto.setNoticeGroup(seq);
			noticeDto.setNoticeTarget(null);
			noticeDto.setNoticeDepth(0);
		}
		else {
			NoticeDto targetDto = noticeDao.selectOne(noticeDto.getNoticeTarget());
			noticeDto.setNoticeGroup(targetDto.getNoticeGroup());
			noticeDto.setNoticeDepth(targetDto.getNoticeDepth()+1);
		}
		noticeDao.insert(noticeDto);
		return "redirect:detail?noticeNo="+seq;
	}
	
	@Autowired
	private AttachmentService attachmentService;
	
	//삭제 페이지(글 안에 있는 이미지 파일까지 찾아서 삭제)
	@RequestMapping("/delete")
	public String delete(@RequestParam int noticeNo) {
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		if(noticeDto == null)
			throw new TargetNotFoundException("존재하지 않는 공지사항 번호");
		
		String noticeCont = noticeDto.getNoticeCont();
		
		Document document = Jsoup.parse(noticeCont);
		Elements elements = document.select(".notice-attach");
		for(Element element : elements) {
			String key = elements.attr("data-key");
			int attachmentNo = Integer.parseInt(key);
			attachmentService.delete(attachmentNo);
		}
		boolean result = noticeDao.delete(noticeNo);
		return "redirect:list";
	}
	//수정 페이지
	@GetMapping("/edit")
	public String edit(@RequestParam int noticeNo, Model model) {
		NoticeDto noticeDto = noticeDao.selectOne(noticeNo);
		if(noticeDto == null)
			throw new TargetNotFoundException("존재하지 않는 공지사항 번호");
		model.addAttribute("noticeDto", noticeDto);
		return "/WEB-INF/views/notice/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute NoticeDto noticeDto) {
		NoticeDto originDto = noticeDao.selectOne(noticeDto.getNoticeNo());//이전글 조회
		if(originDto == null)
			throw new TargetNotFoundException("존재하지 않는 공지사항 번호");
		
		//수정 전
		Set<Integer> before = new HashSet<>();
		Document beforeDocument = Jsoup.parse(originDto.getNoticeCont());//이전글 내용 해석
		for(Element el : beforeDocument.select(".board-attach")) {//.board-attach 찾아 반복
			String keyStr = el.attr("data-key");//data-key 속성 추출
			int key = Integer.parseInt(keyStr);//int로 변환
			before.add(key);//저장소에 추가
	}
		//수정 후
		Set<Integer> after = new HashSet<>();
		Document afterDocument = Jsoup.parse(noticeDto.getNoticeCont());//수정글 내용 해석
		for(Element el : afterDocument.select(".board-attach")) {//.board-attach 찾아 반복
			String keyStr = el.attr("data-key");//data-key 속성 추출
			int key = Integer.parseInt(keyStr);//int로 변환
			after.add(key);//저장소에 추가
		}
		
		//수정 전 - 수정 후 계산
		before.removeAll(after);
		
		//before에 남아있는 번호에 해당하는 파일을 모두 삭제
		for(int attachmentNo : before) {
			attachmentService.delete(attachmentNo);
		}
		//수정 처리
		noticeDao.update(noticeDto);
		return "redirect:detail?noticeNo=" + noticeDto.getNoticeNo();
	}
}