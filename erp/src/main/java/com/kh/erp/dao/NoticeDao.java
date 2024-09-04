package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.VO.PageVO;
import com.kh.erp.dto.NoticeDto;
import com.kh.erp.mapper.NoticeDetailMapper;
import com.kh.erp.mapper.NoticeListMapper;

@Repository
public class NoticeDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private NoticeListMapper noticeListMapper;
	@Autowired
	private NoticeDetailMapper noticeDetailMapper;
	
	//목록
	public List<NoticeDto> selectList(){
		String sql = "select "
						+ "notice_no, notice_writer, notice_title,notice_cont, "
						+ "notice_wtime, notice_utime, notice_views, notice_likes, "
						+ "notice_replies "
					+ "from notice order by notice_no desc";
		return jdbcTemplate.query(sql, noticeListMapper);
	}
	//검색
	public List<NoticeDto> selectList(String column, String keyword) {
		String sql = "select "
				+ "notice_no, notice_writer, notice_title, notice_cont, "
				+ "notice_wtime, notice_utime, notice_views, notice_likes, "
				+ "notice_replies "
					+ "from notice "
					+ "where instr(#1, ?) > 0 "
					+ "order by notice_no desc";
		sql = sql.replace("#1", column);
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, noticeListMapper, data);
	}
	//상세
	public NoticeDto selectOne(int noticeNo) {
		String sql = "select * from notice where notice_no=?";
		Object[] data = {noticeNo};
		List<NoticeDto> list = jdbcTemplate.query(sql, noticeDetailMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	//등록
	public int sequence() {
		String sql = "select notice_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public void insert(NoticeDto noticeDto) {
		String sql = "insert into notice("
						+ "notice_no, notice_writer, notice_title, "
						+ "notice_cont, "
						+ "notice_group, notice_target, notice_depth"
							+ ") "
								+"values(?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				noticeDto.getNoticeNo(), noticeDto.getNoticeWriter(), noticeDto.getNoticeTitle(),
				noticeDto.getNoticeCont(), noticeDto.getNoticeGroup(),
				noticeDto.getNoticeTarget(), noticeDto.getNoticeDepth()
				
		};
		jdbcTemplate.update(sql, data);
	}
	
	//삭제
	public boolean delete(int noticeNo) {
		String sql = "delete notice where notice_no = ?";
		Object[] data = {noticeNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	//수정
	public boolean update(NoticeDto noticeDto) {
		String sql = "update notice set "
						+ "notice_title=?, notice_cont=?, notice_utime=sysdate "
						+ "where notice_no=?";
		Object[] data = {
				noticeDto.getNoticeTitle(), noticeDto.getNoticeCont(),
				noticeDto.getNoticeNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//조회수 증가
	public boolean updateNoticeViews(int noticeNo) {
		String sql = "update notice "
						+ "set notice_views=notice_views+1 "
						+ "where notice_no=?";
		Object[] data = {noticeNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//페이징이 적용된 목록
	public List<NoticeDto> selectListByPaging(int page, int size) {
		int endRow = page * size;
		int beginRow = endRow - (size-1);
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select "
								+ "notice_no, notice_writer, notice_title, notice_cont, "
								+"notice_group, notice_target, notice_depth "
								+ "from notice order by notice_no desc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {beginRow, endRow};
		return  jdbcTemplate.query(sql, noticeListMapper, data);						
	}
	//페이징이 적용된 검색
	public List<NoticeDto> selectListByPaging(
				String column, String keyword, int page, int size) {
		int endRow = page * size;
		int beginRow = endRow - (size-1);
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select "
								+ "notice_no, notice_writer, notice_title, notice_cont,  "
								+ "notice_group, notice_target, notice_depth "
								+ "from notice "
								+ "where instr(#1, ?) > 0 "
								+ "order by notice_no desc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		sql = sql.replace("#1", column);
		Object[] data = {keyword, beginRow, endRow};
		return  jdbcTemplate.query(sql, noticeListMapper, data);
	}
	
	//페이징의 마지막 블록 번호를 위해 게시글 수를 구하는 메소드
	public int countByPaging() {
		String sql = "select count(*) from notice";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int countBypaging(String column, String keyword) {
		String sql = "select count(*) from notice where instr(#1, ?) > 0";
		sql = sql.replace("#1", column);
		Object[] data = {keyword};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	public List<NoticeDto> selectListByPaging(PageVO pageVO) {
	    if(pageVO.isSearch()) {
	        String sql = "select * from ("
	                            + "select rownum rn, TMP.* from ("
	                                + "select "
	                                + "notice_no, notice_writer, notice_title, notice_cont, "
	                                + "notice_group, notice_target, notice_depth "
	                                + "from notice "
	                                + "where instr(#1, ?) > 0 "
	                                + "connect by prior notice_no=notice_target "
	                                + "start with notice_target is null "
	                                + "order siblings by notice_group desc, notice_no asc"
	                            + ")TMP"
	                        + ") where rn between ? and ?";
	        sql = sql.replace("#1", pageVO.getColumn());
	        Object[] data = {pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow()};
	        return jdbcTemplate.query(sql, noticeListMapper, data);
	    } else {
	        String sql = "select * from ("
	                        + "select rownum rn, TMP.* from ("
	                            + "select "
	                                + "notice_no, notice_writer, notice_title, notice_cont, "
	                                + "notice_group, notice_target, notice_depth "
	                            + "from notice "
	                            + "connect by prior notice_no=notice_target "
	                            + "start with notice_target is null "
	                            + "order siblings by notice_group desc, notice_no asc"
	                        + ")TMP"
	                    + ") where rn between ? and ?";
	        Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
	        return jdbcTemplate.query(sql, noticeListMapper, data);
	    }
	}

	
	public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) {//검색카운팅
			String sql = "select count(*) from notice where instr(#1, ?) > 0";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {//목록카운팅
			String sql = "select count(*) from notice";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	//좋아요 수 최신화
	public boolean updateNoticeLikes(int noticeNo) {
		String sql = "update notice set notice_likes = ("
						+ "select count(*) from notice_like where notice_no=?"
					+ ") where notice_no = ?";
		Object[] data = {noticeNo, noticeNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//댓글 숫자 최신화
	public boolean updateNoticeReplies(int noticeNo) {
		String sql = "update notice set notice_replies = ("
							+ "select count(*) from reply where reply_origin = ?"
						+ ") where notice_no = ?";
		Object[] data = {noticeNo, noticeNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	//특정 사용자의 글 목록 조회
	public List<NoticeDto> selectListByNoticeWriter(String noticeWriter){
		String sql = "select * from notice "
					+ "where notice_writer =? "
					+ "order by notice_no desc";
	Object[] data = {noticeWriter};
	return jdbcTemplate.query(sql, noticeListMapper, data);
	}
	
	//특정 사용자가 좋아요 한 글 목록조회
	public List<NoticeDto> selectListByNoticeLikes(String noticeWriter){
		String sql = "select * from notice "
						+ "where notice_no in ("
							+ "select notice_no from notice_like "
							+ "where login_id =?"
						+ ")"
						+ "order by notice_no desc";
		Object[] data = {noticeWriter};
		return jdbcTemplate.query(sql, noticeListMapper, data);
	}
}