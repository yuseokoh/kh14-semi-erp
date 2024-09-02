package com.kh.erp.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.dto.ErdDto;

@Service
public class ErdMapper implements RowMapper<ErdDto> {
	@Override
	public ErdDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	    ErdDto dto = new ErdDto();
	    dto.setStockNo(rs.getInt("stock_no"));
	    dto.setStockName(rs.getString("stock_name"));
	    dto.setStockQuantity(rs.getInt("stock_quantity"));
	    dto.setStockCategory(rs.getString("stock_category"));
	    dto.setStockDate(rs.getTimestamp("stock_date"));
	    dto.setImageUrl(rs.getString("image_url"));
	 // Convert SQL Date to Java Date
	    java.sql.Date sqlDate = rs.getDate("expiration_date");
	    if (sqlDate != null) {
	        dto.setExpirationDate(new java.util.Date(sqlDate.getTime()));
	    }
	    return dto;
	}

}
