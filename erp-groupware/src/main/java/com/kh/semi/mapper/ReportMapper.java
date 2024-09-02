package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.semi.dto.ReportDto;

@Service
public class ReportMapper implements RowMapper<ReportDto>{

	@Override
	public ReportDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReportDto reportDto = new ReportDto();
		reportDto.setRepNo(rs.getInt("repno")); //보고서번호
		reportDto.setTitle(rs.getString("title")); //제목
		reportDto.setApproBos(rs.getString("appro_bos")); //결재자
		reportDto.setTodayGoal(rs.getString("today_goal")); //금일목표
		reportDto.setTodayGoal2(rs.getString("today_goal2")); //금일목표
		reportDto.setTodayGoal3(rs.getString("today_goal3")); //금일목표
		reportDto.setAchievement(rs.getString("achievement")); // 달성내역
		reportDto.setAchievement2(rs.getString("achievement2")); // 달성내역
		reportDto.setAchievement3(rs.getString("achievement3")); // 달성내역
		reportDto.setNoAchievementReason(rs.getString("no_achievement_reason")); //미달성이유
		reportDto.setNoAchievementReason2(rs.getString("no_achievement_reason2")); //미달성이유
		reportDto.setWdate(rs.getDate("wdate")); //작성일자
		reportDto.setWname(rs.getString("wname")); //작성자이름
		reportDto.setDept(rs.getString("dept")); //부서이름
		reportDto.setApproYN(rs.getString("approYN")); //결재여부
		return reportDto;
	}

}
