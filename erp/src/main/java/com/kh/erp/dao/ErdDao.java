package com.kh.erp.dao;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.dto.ErdDto;
import com.kh.erp.mapper.ErdMapper;

@Repository
public class ErdDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Autowired
    private ErdMapper erdMapper;

    // 등록 (유통기한 포함)
    public void insert(ErdDto dto, String imageUrl) {
        String sql = "insert into stock (stock_no, stock_category, stock_name, stock_quantity, stock_date, image_url, expiration_date) " +
                     "values (stock_seq.nextval, ?, ?, ?, SYSDATE, ?, ?)";
        Date expirationDate = dto.getExpirationDate() != null ? new Date(dto.getExpirationDate().getTime()) : null;
        Object[] data = {dto.getStockCategory(), dto.getStockName(), dto.getStockQuantity(), imageUrl, expirationDate};
        jdbcTemplate.update(sql, data);

        logChange(dto.getStockNo(), "등록", null, dto, imageUrl);
    }

    // 수정 (유통기한 포함)
    public boolean update(ErdDto dto, String imageUrl) {
        ErdDto existingDto = selectOne(dto.getStockNo());
        if (existingDto == null) {
            return false;
        }

        String oldValues = getFieldValues(existingDto);
        String newValues = getFieldValues(dto);

        String sql = "update stock set stock_category = ?, stock_name = ?, stock_quantity = ?, image_url = ?, expiration_date = ? where stock_no = ?";
        Date expirationDate = dto.getExpirationDate() != null ? new Date(dto.getExpirationDate().getTime()) : null;
        Object[] data = {dto.getStockCategory(), dto.getStockName(), dto.getStockQuantity(), imageUrl, expirationDate, dto.getStockNo()};
        boolean isUpdated = jdbcTemplate.update(sql, data) > 0;

        if (isUpdated) {
            logChange(dto.getStockNo(), "수정", oldValues, dto, imageUrl);
        }
        
        return isUpdated;
    }

    // 삭제
    public boolean delete(int stockNo) {
        ErdDto existingDto = selectOne(stockNo);
        if (existingDto == null) {
            return false;
        }

        String oldValues = getFieldValues(existingDto);

        String sql = "delete from stock where stock_no = ?";
        Object[] data = {stockNo};
        boolean isDeleted = jdbcTemplate.update(sql, data) > 0;

        if (isDeleted) {
            logChange(stockNo, "삭제", oldValues, null, null);
        }
        
        return isDeleted;
    }

    // 조회 - 전체 리스트
    public List<ErdDto> selectList() {
        String sql = "select * from stock order by stock_no asc";
        return jdbcTemplate.query(sql, erdMapper);
    }

    public List<ErdDto> selectList(String column, String keyword) {
        if ("category".equalsIgnoreCase(column)) {
            column = "STOCK_CATEGORY";
        } else if ("name".equalsIgnoreCase(column)) {
            column = "STOCK_NAME";
        }

        String sql = "select * from stock where instr(" + column + ", ?) > 0 order by stock_no asc";
        Object[] data = {keyword};
        return jdbcTemplate.query(sql, erdMapper, data);
    }

    // 조회 - 특정 항목 상세 조회
    public ErdDto selectOne(int stockNo) {
        String sql = "select * from stock where stock_no = ?";
        Object[] data = {stockNo};
        List<ErdDto> list = jdbcTemplate.query(sql, erdMapper, data);
        return list.isEmpty() ? null : list.get(0);
    }

    // 이미지 URL 업데이트
    public boolean updateImageUrl(int stockNo, String imageUrl) {
        String sql = "update stock set image_url = ? where stock_no = ?";
        Object[] data = {imageUrl, stockNo};
        return jdbcTemplate.update(sql, data) > 0;
    }

    // 수량 업데이트 메서드
    public boolean updateQuantity(ErdDto dto) {
        String sql = "update stock set stock_quantity = ? where stock_no = ?";
        Object[] data = {dto.getStockQuantity(), dto.getStockNo()};
        return jdbcTemplate.update(sql, data) > 0;
    }
    
    // 필드 값을 문자열로 변환하는 메서드
    private String getFieldValues(ErdDto dto) {
        return String.format("Category: %s, Name: %s, Quantity: %d, Image URL: %s, Expiration Date: %s",
                             dto.getStockCategory(),
                             dto.getStockName(),
                             dto.getStockQuantity(),
                             dto.getImageUrl(),
                             dto.getExpirationDate());
    }

    // ChangeLog 기록 메서드
    private void logChange(int stockNo, String changedFields, String oldValues, ErdDto newDto, String newImageUrl) {
        String newValues = newDto != null ? getFieldValues(newDto) : "";
        String oldImageUrl = oldValues != null ? oldValues : "";

        String sql = "INSERT INTO ChangeLog (id, stockNo, changedFields, oldValues, newValues, changedDate) VALUES (ChangeLog_seq.NEXTVAL, ?, ?, ?, ?, ?)";
        Object[] data = {stockNo, changedFields, oldImageUrl, newValues, new java.util.Date()};
        jdbcTemplate.update(sql, data);
    }
    
    // 페이징을 지원하는 조회 메소드
    public Page<ErdDto> selectList(String column, String keyword, Pageable pageable) {
        if ("category".equalsIgnoreCase(column)) {
            column = "STOCK_CATEGORY";
        } else if ("name".equalsIgnoreCase(column)) {
            column = "STOCK_NAME";
        }

        String sql = "SELECT * FROM ( " +
                     "    SELECT stock.*, ROW_NUMBER() OVER (ORDER BY stock_no ASC) AS row_num " +
                     "    FROM stock " +
                     "    WHERE instr(" + column + ", :keyword) > 0 " +
                     ") WHERE row_num BETWEEN :startRow AND :endRow";

        int pageSize = pageable.getPageSize();
        int pageNumber = pageable.getPageNumber();
        int startRow = pageNumber * pageSize + 1;
        int endRow = startRow + pageSize - 1;

        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("keyword", keyword);
        parameters.addValue("startRow", startRow);
        parameters.addValue("endRow", endRow);

        List<ErdDto> content = namedParameterJdbcTemplate.query(sql, parameters, erdMapper);

        String countSql = "SELECT COUNT(*) FROM stock WHERE instr(" + column + ", :keyword) > 0";
        int total = namedParameterJdbcTemplate.queryForObject(countSql, parameters, Integer.class);

        return new PageImpl<>(content, pageable, total);
    }
}
