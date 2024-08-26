package com.kh.semi.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.AttachmentDao;
import com.kh.semi.service.AttachmentService;

//사용자에게 파일을 전송하는 컨트롤러
//이 컨트롤러는 화면이 아니라 데이터를 사용자에게 보냅니다!
@RestController
@RequestMapping("/attach")
public class FileDownloadController {
	
	@Autowired
	private AttachmentDao attachmentDao;

	@Autowired
	private AttachmentService attachmentService;
	
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(
				@RequestParam int attachmentNo) throws IOException {
		return attachmentService.find(attachmentNo);
	}
}









