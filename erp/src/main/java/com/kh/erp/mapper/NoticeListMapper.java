package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.dto.NoticeDto;

@Service
public class NoticeListMapper implements RowMapper<NoticeDto>{
    @Override
    public NoticeDto mapRow(ResultSet rs, int rowNum) throws SQLException{
        NoticeDto noticeDto = new NoticeDto();
        noticeDto.setNoticeNo(rs.getInt("notice_no"));
        noticeDto.setNoticeWriter(rs.getString("notice_writer"));
        noticeDto.setNoticeTitle(rs.getString("notice_title"));
        noticeDto.setNoticeCont(rs.getString("notice_cont"));
        noticeDto.setNoticeWtime(rs.getDate("notice_Wtime"));


        //항목 3개 추가
        noticeDto.setNoticeGroup(rs.getInt("notice_group"));
        noticeDto.setNoticeTarget(rs.getObject("notice_target", Integer.class));
        noticeDto.setNoticeDepth(rs.getInt("notice_depth"));

        return noticeDto;
    }
}