package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.dto.DocumentDto;

@Service
public class DocumentMapper implements RowMapper<DocumentDto>{
	@Override
	public DocumentDto mapRow(ResultSet rs, int rowNum) throws SQLException{
		DocumentDto documentDto = new DocumentDto();
		documentDto.setDocumentNo(rs.getInt("document_no"));
		documentDto.setDocumentName(rs.getString("document_name"));
		documentDto.setDocumentType(rs.getString("document_type"));
		documentDto.setDocumentSize(rs.getLong("document_size"));
		return documentDto;
	}
}
