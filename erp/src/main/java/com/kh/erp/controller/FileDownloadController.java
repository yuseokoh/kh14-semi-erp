package com.kh.erp.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.erp.dao.AttachmentDao;
import com.kh.erp.dto.AttachmentDto;
import com.kh.erp.error.TargetNotFoundException;
import com.kh.erp.service.AttachmentService;

import jakarta.servlet.http.HttpServletResponse;

//사용자에게 파일을 전송하는 컨트롤러
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