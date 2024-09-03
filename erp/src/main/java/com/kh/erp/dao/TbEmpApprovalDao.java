package com.kh.erp.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.erp.VO.PageVO;
import com.kh.erp.dto.TbEmpApprovalDto;
import com.kh.erp.mapper.TbEmpApprovalMapper;

@Repository
public class TbEmpApprovalDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private TbEmpApprovalMapper tbEmpApprovalMapper;

	// C --> 행동(보고서 / 휴가신청서 작성)에 따른 기본 결재 데이터 생성 결재자에 대한 정보 NULL
	// [1] 휴가신청서 먼저 작성
	// [2] 결재란 후에 작성
	// [3] 존재하는 휴가 신청서에 생성된 번호 추가 해서 이쪽으로 전달(DTO형식)
	public void insert(TbEmpApprovalDto tbEmpApprovalDto) {
		String sql = "INSERT INTO tb_Approval(appro_No, appro_Type, appro_YN, applicantId) values(? , ?, 'N', ?)";
		Object[] data = { tbEmpApprovalDto.getApproNo(), tbEmpApprovalDto.getApproType(),
				tbEmpApprovalDto.getApplicantId() };
		jdbcTemplate.update(sql, data);
	}

	// R
	public List<TbEmpApprovalDto> selectList() {
		String sql = "SELECT * FROM tb_Approval";
		return jdbcTemplate.query(sql, tbEmpApprovalMapper);
	}

	// U --> sql 쿼리를 세개 작성 // 조건 getApproNo1먼저 업데이트
	// U --> 수정 결재자를 한명으로 줄였고 고정 결재자가 생겼음
//	public boolean update(TbEmpApprovalDto tbEmpApprovalDto) {
//		
//
//	}
	
	
//
//	// D 여기선 삭제는 필요없음
//	public void insert() {
//
//	}

	// 페이징이 적용된 승인 상태 리스트
	public List<TbEmpApprovalDto> approListByPaging(PageVO pageVO) {
		if (pageVO.isSearch()) {// 검색
			String sql = "select * from (" + "select rownum rn, TMP.* from ("
					+ "select * from tb_Approval where instr(#1, ?) > 0 "
					+ "order by #1 asc, appro_No asc, appro_Date asc" + ")TMP" + ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = { pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbEmpApprovalMapper, data);
		} else {// 목록
			String sql = "select * from (" + "select rownum rn, TMP.* from ("
					+ "select * from tb_Approval order by appro_No asc, appro_Date asc" + ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = { pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, tbEmpApprovalMapper, data);
		}
	}

	// 페이징 관련
	public int countPage(PageVO pageVO) {
		if (pageVO.isSearch()) {
			String sql = "select count(*) from tb_Approval where instr(" + pageVO.getColumn() + ",?) > 0";
			Object[] data = { pageVO.getKeyword() };
			return jdbcTemplate.queryForObject(sql, int.class, data);
		} else {
			String sql = "select count(*) from tb_Approval";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	// 전자결재 이미지 커넥팅
	public void connect(int approNo, int documentNo) {
		String sql = "insert into tb_approval_image(approno,document) " +
					"values(?,?)";
		Object[] data = { approNo, documentNo };
		jdbcTemplate.update(sql, data);

	}

	public int sequence() {
		String sql = "select tb_Approval_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	// 승인된 휴가 신청서 중 해당 인원의 연차 값을 가져오는 메소드
	// 이를 통해 int 값을 반환 하여 TbEmpDao와 연계하여 잔여 연차를 차감 및 사용 연차 업데이트 할 예정
	// -- > 아직 승인 절차 a.appro_yn 가 'Y'가 되게 만드는 작업 없음(2024-08-28)
	public Integer getVacationApproCount(String applicantId, int vacaNo) {
		String sql = 
			    "SELECT COALESCE(SUM(v.date_diff), 0) " +
			    "FROM (" +
			    "    SELECT DISTINCT " +
			    "        v.vaca_No, " +
			    "        v.vaca_Sdate, " +
			    "        v.vaca_Edate, " +
			    "        (v.vaca_Edate - v.vaca_Sdate) AS date_diff " + // 날짜 차이 계산 (+1일 포함) 
			    "    FROM tb_VacaReq v " +
			    "    INNER JOIN tb_Approval a " +
			    "        ON v.applicantId = a.applicantId " +
			    "        AND a.appro_yn = 'Y' " +
			    "    WHERE v.applicantId = ? " + // 신청자 ID
			    "      AND v.vaca_No = ? " + // 특정 휴가 번호
			    "      AND v.vaca_type = '연차' " + // 휴가 유형
			    ") v";
		Object[] data = { applicantId, vacaNo };
		return jdbcTemplate.queryForObject(sql, Integer.class, data); // Integer로 결과 반환
	}

	public TbEmpApprovalDto selectOneByApproNo(int approNo) {
		String sql = "SELECT * FROM tb_Approval WHERE appro_No = ?";
		Object[] data = {approNo};
		List<TbEmpApprovalDto> list = jdbcTemplate.query(sql, tbEmpApprovalMapper, data);
		
		return list.isEmpty() ? null : list.get(0);
	}

	// 수정해야할것 -->  이젠 지쳐서 그냥 이렇게 할래...
	public boolean updateSign(int approNo, String approBosId, String approBosName, String rejectReason) {
		String sql = "UPDATE tb_Approval SET appro_yn = ?, appro_BosName = ?, appro_BosId = ? WHERE appro_no = ?";
		// 조건에 따라 appro_yn 값을 결정합니다.
	    String approYn = (rejectReason != null) ? "N" : "Y";
	    Object[] data = {approYn, approBosName, approBosId, approNo};
		return jdbcTemplate.update(sql, data) > 0;
		
		
		
		
	}

	public boolean updateType(String vacaType, int approNo) {
		String sql = "UPDATE tb_Approval set appro_type = ? where appro_no = ? and appro_YN = 'N'";
		Object[] data = {vacaType, approNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
}
