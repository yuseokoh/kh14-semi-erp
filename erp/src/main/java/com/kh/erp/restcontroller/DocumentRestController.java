package com.kh.erp.restcontroller;

import java.util.Base64;
import java.io.FileOutputStream;
import java.io.OutputStream;

import org.eclipse.angus.mail.handlers.text_html;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.erp.dao.DocumentDao;
import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dao.TbEmpDao;
import com.kh.erp.dao.TbEmpReportDao;
import com.kh.erp.dao.TbEmpVacaReqDao;
import com.kh.erp.dto.DocumentDto;
import com.kh.erp.dto.TbEmpDto;

import jakarta.servlet.http.HttpSession;

@RestController
@Transactional
@RequestMapping("/rest/document")
public class DocumentRestController {

	@Autowired
	private DocumentDao documentDao;

	@Autowired
	private TbEmpApprovalDao tbEmpApprovalDao;

	@Autowired
	private TbEmpDao tbEmpDao;
	
	
	@PostMapping("/sign")
	public boolean sign(HttpSession session, // 세션
			@RequestParam int approNo, // 승인번호
			@RequestParam(required = false) String rejectReason, // 반려 사유
			@RequestParam String signatureDataURL) {
		int documentNo = documentDao.sequence();
		String loginId = (String) session.getAttribute("createdUser");
		// 최종때에 지울 출력문 두개
		System.out.println(loginId);
		System.out.println(signatureDataURL);
		System.out.println("앙기모띠 : "+rejectReason);
		String base64Image = signatureDataURL;
		DocumentDto documentDto = new DocumentDto();
		documentDto.setDocumentName(loginId + documentNo);
		documentDto.setDocumentNo(documentNo);
		documentDto.setDocumentSize(0);
		documentDto.setDocumentType("png");
		// 파일을 저장할 경로 설정
		String folderPath = "D:\\upload\\"; // D 드라이브의 upload 폴더로 저장
		String filePath = folderPath + String.valueOf(documentNo);

		try {
			// Base64 문자열에서 "data:image/png;base64," 부분 제거
			String base64Data = base64Image.split(",")[1];

			// Base64 문자열을 디코딩하여 바이트 배열로 변환
			byte[] imageBytes = Base64.getDecoder().decode(base64Data);

			// 파일로 바이트 배열을 저장
			try (OutputStream out = new FileOutputStream(filePath)) {
				out.write(imageBytes);
			}
			documentDao.insert(documentDto);
			tbEmpApprovalDao.connect(approNo, documentNo);
			// 사인 --> 사원명이랑 사원직급? 부서? 필요
			TbEmpDto tbEmpDto = tbEmpDao.selectOne(loginId);
			
			if(rejectReason != null) {
				tbEmpApprovalDao.updateSign(approNo, loginId, tbEmpDto.getName(), rejectReason);
			}else {
				tbEmpApprovalDao.updateSign(approNo, loginId, tbEmpDto.getName(), null);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}
}
