package com.kh.erp.restcontroller;

import java.util.Base64;
import java.io.FileOutputStream;
import java.io.OutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.erp.dao.DocumentDao;
import com.kh.erp.dao.TbEmpApprovalDao;
import com.kh.erp.dto.DocumentDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/document")
public class DocumentRestController {
	
	@Autowired
	private DocumentDao documentDao;
	
	@Autowired
	private TbEmpApprovalDao tbEmpApprovalDao;
	
	@PostMapping("/sign")
	public String sign(HttpSession session,@RequestParam int approNo,
					   @RequestParam String signatureDataURL) {
		int documentNo = documentDao.sequence();
		String loginId = (String)session.getAttribute("createdUser");
		System.out.println(signatureDataURL);
		String base64Image = signatureDataURL;
		DocumentDto documentDto = new DocumentDto();
		documentDto.setDocumentName(loginId+documentNo);
		documentDto.setDocumentNo(documentNo);
		documentDto.setDocumentSize(0);
		documentDto.setDocumentType("png");
		 // 파일을 저장할 경로 설정
		 String folderPath = "D:\\upload\\sign\\"; // D 드라이브의 upload 폴더로 저장
		 String filePath = folderPath + String.valueOf	(documentNo);

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
            return "이미지가 성공적으로 저장되었습니다: " + filePath;
        } catch (Exception e) {
            e.printStackTrace();
            return "이미지 저장 실패: " + e.getMessage();
        }
        
	}
}
