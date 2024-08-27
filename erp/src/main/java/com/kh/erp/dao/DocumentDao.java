package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.dto.DocumentDto;
import com.kh.erp.mapper.DocumentMapper;

@Repository
public class DocumentDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private DocumentMapper documentMapper;
	
	public int sequence() {
		String sql = "select document_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public void insert(DocumentDto documentDto) {
		String sql = "insert into document("
						+ "document_no, document_name, "
						+ "document_type, document_size"
					+ ") values(?, ?, ?, ?)";
		Object[] data = {
				documentDto.getDocumentNo(), documentDto.getDocumentName(),
				documentDto.getDocumentType(), documentDto.getDocumentSize()
		};
		jdbcTemplate.update(sql, data);
	}
	public DocumentDto selectOne(int documentNo) {
		String sql = "select * from document where document_no =?";
		Object[] data = {documentNo};
		List<DocumentDto> list =
						jdbcTemplate.query(sql, documentMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	public boolean delete(int documentNo) {
		String sql = "delete document where document_no = ?";
		Object[] data = {documentNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
}