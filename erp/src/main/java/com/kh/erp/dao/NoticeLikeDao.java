package com.kh.erp.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeLikeDao {

		@Autowired
		private JdbcTemplate jdbcTemplate;
		
		//[1]아이디랑 글번호로 기록유무 조회 기능
		public boolean check(String loginId, int noticeNo) {
			if(loginId == null) return false;
			
			String sql = "select count(*) from notice_like "
							+ "where login_id=? and notice_no=?";
			Object[] data = {loginId, noticeNo};
			int count = jdbcTemplate.queryForObject(sql, int.class, data);
			return count > 0;
		}
		//[2] 글번호 카운팅하는 기능
		public int count(int noticeNo) {
			String sql = "select count(*) from notice_like where notice_no = ?";
			Object[] data = {noticeNo};
			jdbcTemplate.update(sql, data);
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		
		//[3] 좋아요 등록 기능
		public void insert(String loginId, int noticeNo) {
			String sql = "insert into notice_like values(?, ?)";
			Object[] data = {loginId, noticeNo};
			jdbcTemplate.update(sql, data);
		}
		
		//[4] 좋아요 삭제 기능
		public boolean delete(String loginId, int noticeNo) {
			String sql = "delete notice_like where login_id=? and notice_no=?";
			Object[] data = {loginId, noticeNo};
			return jdbcTemplate.update(sql, data) > 0;
		}
}