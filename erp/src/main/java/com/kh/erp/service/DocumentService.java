package com.kh.erp.service;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.erp.configuration.CustomFileuploadProperties;
import com.kh.erp.dao.DocumentDao;
import com.kh.erp.dto.DocumentDto;
import com.kh.erp.error.TargetNotFoundException;

import jakarta.annotation.PostConstruct;

@Service
public class DocumentService {

	@Autowired
	private CustomFileuploadProperties properties;
	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(properties.getPath());
		dir.mkdirs();
	}
	
	@Autowired
	private DocumentDao documentDao;
	
	public int save(MultipartFile attach) throws IllegalStateException, IOException {
		//시퀀스 생성
		int documentNo = documentDao.sequence();
		//파일 저장
		File target = new File(dir, String.valueOf(documentNo));
		attach.transferTo(target);
		//데이터베이스에 저장
		DocumentDto documentDto = new DocumentDto();
		documentDto.setDocumentNo(documentNo);
		documentDto.setDocumentName(attach.getOriginalFilename());
		documentDto.setDocumentType(attach.getContentType());
		documentDto.setDocumentSize(attach.getSize());
		documentDao.insert(documentDto);
		
		return documentNo;
	}
	
	public void delete(int documentNo) {//파일삭제 + DB삭제
		//[1]파일 삭제
		DocumentDto documentDto = documentDao.selectOne(documentNo);
		if(documentDto == null) {
			throw new TargetNotFoundException("존재하지 않는 문서 번호");
		}
		//[2]실물 파일 삭제
		File target = new File(dir, String.valueOf(documentNo));
		target.delete();
		//[3]DB삭제
		documentDao.delete(documentNo);
	}
	public ResponseEntity<ByteArrayResource> find(int documentNo) throws IOException{
		//[1] documentNo에 대한 데이터가 존재하는지 확인
		DocumentDto documentDto = documentDao.selectOne(documentNo);
		if(documentDto == null) {
			throw new TargetNotFoundException("존재하지 않는 문서 번호");
		}
		//[2] 정보가 있으므로 실제 파일 호출
		File target = new File(dir, String.valueOf(documentNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//[3] 불러온 정보를 사용자에게 전송
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(documentDto.getDocumentSize())
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.header(HttpHeaders.CONTENT_DISPOSITION,
					ContentDisposition.attachment()
						.filename(
								documentDto.getDocumentName(),
								StandardCharsets.UTF_8
						).build().toString()
			)
		.body(resource);
	}
}