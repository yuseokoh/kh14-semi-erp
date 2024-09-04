package com.kh.erp.dao;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.VO.ResPageVO;
import com.kh.erp.dto.ReservationDto;
import com.kh.erp.mapper.ReservationMapper;

@Repository
public class ReservationDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private ReservationMapper reservationMapper;

	// 예약하기
	public void insert(ReservationDto reservationDto) {
		String sql = "INSERT INTO reservation (res_id, room_id, room_name, guest_name, stime, etime, resYN, pw, calDate) "
				+ "VALUES (res_seq.nextVal, ?, ?, ?, ?, ?, ?, ?,?)";
		Object[] data = { reservationDto.getRoomId(), reservationDto.getRoomName(), // room_name 추가
				reservationDto.getGuestName(), reservationDto.getStime(), reservationDto.getEtime(), "대여중" // 기본 상태값 설정
				, reservationDto.getPw(), reservationDto.getCalDate() };
		jdbcTemplate.update(sql, data);
	}

	// 예약수정하기
	public boolean update(ReservationDto reservationDto) {
		String sql = "UPDATE reservation SET room_id = ?, room_name = ?, guest_name = ?,calDate =?, "
				+ " stime = ?, etime = ? " + "WHERE res_id = ?";

		Object[] data = { reservationDto.getRoomId(), reservationDto.getRoomName(), reservationDto.getGuestName(),
				reservationDto.getCalDate(), reservationDto.getStime(), reservationDto.getEtime(),
				reservationDto.getResId() };

		// 쿼리가 성공적으로 실행되었는지 확인
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 예약취소하기
	public boolean delete(int resId) {
		String sql = "delete reservation where res_id = ?";
		Object[] data = { resId };
		return jdbcTemplate.update(sql, data) > 0;
	}


	public int sequence() {
		String sql = "select res_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	//예약시 설정한 비밀번호
	public int myPw(int resId) {
		String sql = "SELECT pw FROM reservation WHERE res_id = ?";
		return jdbcTemplate.queryForObject(sql, new Object[] { resId }, Integer.class);
	}

	// 회의실 이용 끝나면 목록에서 사라지게 구현
	public void endMeeting() {
	    String sql = "DELETE FROM reservation "
	               + "WHERE calDate < TRUNC(SYSDATE) "
	               + "   OR (calDate = TRUNC(SYSDATE) AND TO_DATE(etime, 'HH24:MI') < TO_DATE(TO_CHAR(SYSDATE, 'HH24:MI'), 'HH24:MI'))";
	    jdbcTemplate.update(sql);
	}



	// 예약된 회의실 예약 못하게 막기
	public boolean isReservationConflict(int roomId, Date calDate, String stime, String etime) {
		String sql = "SELECT COUNT(*) FROM reservation WHERE room_id = ? AND calDate = ? "
				+ "AND ((TO_DATE(stime, 'HH24:MI') < TO_DATE(?, 'HH24:MI') "
				+ "AND TO_DATE(etime, 'HH24:MI') > TO_DATE(?, 'HH24:MI')) "
				+ "OR (TO_DATE(stime, 'HH24:MI') < TO_DATE(?, 'HH24:MI') "
				+ "AND TO_DATE(etime, 'HH24:MI') > TO_DATE(?, 'HH24:MI')))";

		int count = jdbcTemplate.queryForObject(sql, new Object[] { roomId, calDate, etime, stime, stime, etime },
				Integer.class);

		return count > 0;
	}

	public ReservationDto selectOne(int resId) {
		String sql = "select * from reservation where res_id=?";
		Object[] data = { resId };
		List<ReservationDto> list = jdbcTemplate.query(sql, reservationMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	public int countByPaging(ResPageVO pageVO) {
	    if (pageVO.isSearch()) { // 검색
	        String sql = "select count(*) from reservation where instr(" + pageVO.getColumn() + ", ?) > 0";
	        Object[] data = {pageVO.getKeyword()};
	        return jdbcTemplate.queryForObject(sql, int.class, data);
	    } else { // 목록 조회
	        String sql = "select count(*) from reservation";
	        return jdbcTemplate.queryForObject(sql, int.class);
	    }
	}


	public List<ReservationDto> selectListByPaging(ResPageVO pageVO) { 
	    if (pageVO.isSearch()) { // 검색
	        String column = pageVO.getColumn();

	        String sql = "select * from (select rownum rn, TMP.* "
	                    + " from (select * from reservation "
	                    + " where instr(" + column + ", ?) > 0 "
	                    + " order by calDate asc, stime asc, " + column + " asc, res_id asc) TMP) "
	                    + " where rn between ? and ?";

	        Object[] data = {
	            pageVO.getKeyword(), 
	            pageVO.getBeginRow(), pageVO.getEndRow()
	        };
	        return jdbcTemplate.query(sql, reservationMapper, data);
	    } else { // 목록 조회 (검색 조건이 없을 때)
	        String sql = "select * from (select rownum rn, TMP.* "
	                    + " from (select * from reservation order by calDate asc, stime asc) "
	                    + " TMP) where rn between ? and ?";
	        Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
	        return jdbcTemplate.query(sql, reservationMapper, data);
	    }
	}


	//캘린더에 표시할 전체 조회 내역
	public List<ReservationDto> selectAllReservations() {
	    String sql = "select * from reservation order by res_id asc";
	    return jdbcTemplate.query(sql, reservationMapper);
	}

}
