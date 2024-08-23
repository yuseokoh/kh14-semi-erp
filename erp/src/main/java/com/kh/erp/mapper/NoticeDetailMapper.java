package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.dto.NoticeDto;
@Service
public class NoticeDetailMapper implements RowMapper<NoticeDto> {
	@Override
	public NoticeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		NoticeDto noticeDto = new NoticeDto();
		noticeDto.setNoticeNo(rs.getInt("notice_no"));
		noticeDto.setNoticeWriter(rs.getString("notice_writer"));
		noticeDto.setNoticeTitle(rs.getString("notice_title"));
		noticeDto.setNoticeDate(rs.getDate("notice_date"));
		noticeDto.setNoticeCont(rs.getString("notice_cont"));
		noticeDto.setFileNo(rs.getInt("file_no"));
		noticeDto.setNoticeDelYn(rs.getString("notice_del_yn"));
		return noticeDto;
	}
}
