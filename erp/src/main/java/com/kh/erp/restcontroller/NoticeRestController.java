package com.kh.erp.restcontroller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.erp.VO.NoticeLikeVO;
import com.kh.erp.dao.NoticeDao;
import com.kh.erp.dao.NoticeLikeDao;
import com.kh.erp.service.DocumentService;
import com.kh.erp.error.TargetNotFoundException;

import jakarta.servlet.http.HttpSession;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/notice")
public class NoticeRestController {

	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private NoticeLikeDao noticeLikeDao;
	
	//어떤 사원이 게시글에 좋아요를 눌렀는지 체크하여 알려주는 매핑
	@RequestMapping("/check")
	public NoticeLikeVO check(HttpSession session, @RequestParam int noticeNo) {
		//사원 아이디 추출
		String loginId = (String)session.getAttribute("testUser");
		
		NoticeLikeVO noticeLikeVO = new NoticeLikeVO();
		noticeLikeVO.setChecked(noticeLikeDao.check(loginId, noticeNo));
		noticeLikeVO.setCount(noticeLikeDao.count(noticeNo));
		return noticeLikeVO;
	}
	
	//좋아요나 취소를 할 수 있는 기능
	@RequestMapping("/action")
	public NoticeLikeVO action(
			HttpSession session, @RequestParam int noticeNo) {
		String loginId = (String) session.getAttribute("testUser");
		boolean isChecked = noticeLikeDao.check(loginId, noticeNo);
		if(isChecked) {//좋아요 이력 있으면 삭제
			noticeLikeDao.delete(loginId, noticeNo);
		}
		else {//좋아요 이력 없으면 추가
			noticeLikeDao.insert(loginId, noticeNo);
		}
		//좋아요 수 최신화
		noticeDao.updateNoticeLikes(noticeNo);
		
		NoticeLikeVO noticeLikeVO = new NoticeLikeVO();
		noticeLikeVO.setChecked(!isChecked);
		noticeLikeVO.setCount(noticeLikeDao.count(noticeNo));
		return noticeLikeVO;
	}
	//글 내부에 포함될 이미지를 업로드하고 번호를 반환하는 기능
	@Autowired
	private DocumentService documentService;
	
	@PostMapping("/upload")
	public int upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		if(attach.isEmpty()) {
			throw new TargetNotFoundException("문서가 없습니다");
		}
		int documentNo = documentService.save(attach);
		return documentNo;
	}
	
	@PostMapping("/uploads")
	public List<Integer> uploads(
			@RequestParam(value = "attach") List<MultipartFile> attachList) throws IllegalStateException, IOException {
		List<Integer> results = new ArrayList<>();//번호 담을 저장소 생성
		for(MultipartFile attach : attachList) {//사용자가 보낸 파일 수만큼 반복
			if(!attach.isEmpty()) {
				int documentNo = documentService.save(attach);
				results.add(documentNo);
			}
		}
		return results;
	}
}