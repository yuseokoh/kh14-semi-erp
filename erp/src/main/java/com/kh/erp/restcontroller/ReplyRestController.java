package com.kh.erp.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.erp.dao.NoticeDao;
import com.kh.erp.dao.ReplyDao;
import com.kh.erp.dto.ReplyDto;
import com.kh.erp.error.TargetNotFoundException;
import com.kh.erp.vo.ReplyListVO;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private NoticeDao noticeDao;
	
	@PostMapping("/wirte")
	public void write(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		//시퀀스 번호 생성
		int seq = replyDao.sequence();
		//작성자 정보 불러오기
		String loginId = (String)session.getAttribute("testUser");
		//정보 설정
		replyDto.setReplyNo(seq);
		replyDto.setReplyWriter(loginId);
		//등록
		replyDao.insert(replyDto);
		//댓글 수 최신화
		noticeDao.updateNoticeReplies(replyDto.getReplyOrigin());
	}
		@RequestMapping("/list")
		public List<ReplyDto> list(@RequestParam int replyOrigin){
			return replyDao.selectList(replyOrigin);
		}
		
		@RequestMapping("/list/paging")
		public ReplyListVO listByPaging(@RequestParam int replyOrigin,
					@RequestParam(required = false, defaultValue = "1") int page,
					@RequestParam(required = false, defaultValue = "10")int size) {
			int count = replyDao.count(replyOrigin);
			int totalPage = (count + size-1) / size;
			
			ReplyListVO replyListVO = new ReplyListVO();
			replyListVO.setList(replyDao.selectList(replyOrigin, page, size));
			replyListVO.setTotalPage(totalPage);
			replyListVO.setCurrentPage(page);
			return replyListVO;
		}
		//본인 글만 삭제 가능
		@PostMapping("/delete")
		public void delete(HttpSession session, @RequestParam int replyNo) {
			String loginId = (String)session.getAttribute("testUser");
			ReplyDto replyDto = replyDao.selectOne(replyNo);
			if(replyDto == null) {
				throw new TargetNotFoundException();
			}
			boolean isOwner = loginId.equals(replyDto.getReplyWriter());
			if(isOwner) {
				replyDao.delete(replyNo);
				noticeDao.updateNoticeReplies(replyDto.getReplyOrigin());//댓글 수 최신화
			}
		}
		
		@PostMapping("/edit")
		public void edit(HttpSession session, @ModelAttribute ReplyDto replyDto) {
			String loginId = (String) session.getAttribute("testUser");
			ReplyDto originDto = replyDao.selectOne(replyDto.getReplyNo());
			if(originDto == null) {
				throw new TargetNotFoundException();
			}
			boolean isOwner = loginId.equals(originDto.getReplyWriter());
			if(isOwner) {
				replyDao.update(replyDto);
			}
		}
}
