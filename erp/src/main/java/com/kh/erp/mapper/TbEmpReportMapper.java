package com.kh.erp.mapper;

import java.io.IOException;
import java.io.Reader;
import java.io.StringWriter;
import java.sql.Clob;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.erp.dto.TbEmpReportDto;

@Service
public class TbEmpReportMapper implements RowMapper<TbEmpReportDto> {

    @Override
    public TbEmpReportDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        TbEmpReportDto tbEmpReportDto = new TbEmpReportDto();
        tbEmpReportDto.setReportNo(rs.getInt("report_no"));
        tbEmpReportDto.setWriterId(rs.getString("writer_Id"));
        tbEmpReportDto.setWriterDept(rs.getString("writer_Dept"));
        tbEmpReportDto.setWriterName(rs.getString("writer_Name"));
        tbEmpReportDto.setReportTitle(rs.getString("report_Title"));
        tbEmpReportDto.setWriteDate(rs.getDate("write_Date"));

        // CLOB 데이터 처리
        Clob clob = rs.getClob("report_Content");
        if (clob != null) {
            try (Reader reader = clob.getCharacterStream();
                 StringWriter writer = new StringWriter()) {
                char[] buffer = new char[1024];
                int length;
                while ((length = reader.read(buffer)) != -1) {
                    writer.write(buffer, 0, length);
                }
                tbEmpReportDto.setReportContent(writer.toString());
            } catch (IOException e) {
                // IO 예외 발생 시 처리
                e.printStackTrace(); // 로그를 남기거나 다른 예외 처리 로직을 추가할 수 있습니다.
            }
        } else {
            tbEmpReportDto.setReportContent(""); // CLOB이 null인 경우 빈 문자열로 설정
        }

        tbEmpReportDto.setApproNo(rs.getInt("appro_No"));
        return tbEmpReportDto;
    }
}
