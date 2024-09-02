package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ReportDto;
import com.kh.semi.mapper.ReportMapper;
import com.kh.semi.vo.ResPageVO;

@Repository
public class ReportDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ReportMapper reportMapper;
	
	//조회
	public List<ReportDto> selectList() {
		String sql = "select * from report order by repNo desc";
		return jdbcTemplate.query(sql, reportMapper);
	}

//	public List<ReportDto> selectListByPaging(PageVO pageVO) {
//		if(pageVO.isSearch()) {//검색
//			String sql = "select * from ("
//								+ "select rownum rn, TMP.* from ("
//									+ "select * from report where instr(#1, ?) > 0 "
//									+ "order by #1 asc, repNo desc"
//								+ ")TMP"
//							+ ") where rn between ? and ?";
//			sql = sql.replace("#1", pageVO.getColumn());
//			Object[] data = {
//				pageVO.getKeyword(), 
//				pageVO.getBeginRow(), pageVO.getEndRow()
//			};
//			return jdbcTemplate.query(sql, reportMapper, data);
//		}
//		else {//목록
//			String sql = "select * from ("
//								+ "select rownum rn, TMP.* from ("
//									+ "select * from report order by repNo desc"
//								+ ")TMP"
//							+ ") where rn between ? and ?";
//			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
//			return jdbcTemplate.query(sql, reportMapper, data);
//		}
//	}

	//검색기능 있는 조회
	public List<ReportDto> selectList(String column, String keyword) {
		String sql = "select * from report "
				+ " where instr(" +column +", ?) >0 "
						+ "order by " + column +" asc, repno asc";
		
		Object[] data = {keyword};	
		return jdbcTemplate.query(sql, reportMapper ,data);
	}
	
	public int countByPaging(ResPageVO pageVO) {
		if(pageVO.isSearch()) {//검색
			String sql = "select count(*) from report where instr(#1, ?) > 0";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {//목록
			String sql = "select count(*) from report";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	public int sequence() {
		String sql = "select report_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	//하나 검색

	public ReportDto selectOne(int repNo) {
		String sql = "select * from report where repNo = ? ";
		Object[] data = {repNo};
		List<ReportDto> list = jdbcTemplate.query(sql, reportMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//등록
	
	public void insertWithSequence(ReportDto reportDto) {
		String sql = "INSERT INTO report (repno, title, appro_bos, today_goal, "
				+ "today_goal2, today_goal3, "
				+ "achievement, achievement2, achievement3,"
				+ "no_achievement_reason, no_achievement_reason2, wname, dept, approYN)"
				+ " VALUES (report_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,?)";
		Object[] data = {reportDto.getTitle(), reportDto.getApproBos(), 
				reportDto.getTodayGoal(),reportDto.getTodayGoal2(),reportDto.getTodayGoal3(),
				reportDto.getAchievement(),reportDto.getAchievement2(),reportDto.getAchievement3(),
				reportDto.getNoAchievementReason(), reportDto.getNoAchievementReason2(),
				reportDto.getWname(), reportDto.getDept(), reportDto.getApproYN()};
		jdbcTemplate.update(sql, data);
	}
	
	//수정
	
	public boolean update(ReportDto dto) {
	    String sql = "UPDATE report "
	               + "SET title = ?, today_goal = ?, today_goal2 = ?, today_goal3 = ? ,"
	               + "achievement = ?, achievement2 =?, achievement3 = ?,"
	               + "no_achievement_reason = ?, no_achievement_reason2 = ?, approYN = ? "
	               + "WHERE repno = ?";
	    
	    Object[] data = {
	        dto.getTitle(),
	        dto.getTodayGoal(),
	        dto.getTodayGoal2(),
	        dto.getTodayGoal3(),
	        dto.getAchievement(),
	        dto.getAchievement2(),
	        dto.getAchievement3(),
	        dto.getNoAchievementReason(),
	        dto.getNoAchievementReason2(),
	        dto.getApproYN(),
	        dto.getRepNo()
	    };
	    
	    return jdbcTemplate.update(sql, data) > 0;
	}

	// 삭제
	public boolean delete(int repNo) {
		String sql = "delete report where repNo = ?";
		Object[] data = {repNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

}
