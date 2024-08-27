package com.kh.erp.service;

import java.io.File;
import java.io.IOException;
import java.util.Random;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.erp.dao.CertDao;
import com.kh.erp.dto.CertDto;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private JavaMailSender sender;
	
	public void sendResetPw(String loginId, String EmpEmail) throws IOException, MessagingException {
		ClassPathResource resource = new ClassPathResource("templates/resetPw.html");
		File target = resource.getFile();
		Document document = Jsoup.parse(target);
		Element loginIdWrapper = document.getElementById("loginId");
		loginIdWrapper.text(loginId);
		
		
		Random r = new Random();
		StringBuffer buffer = new StringBuffer();
			for(int i=0;i<6;i++) {
				int number = r.nextInt(10);
				buffer.append(number);			
			}
		//돌아올 링크 주소를 생성하는 코드
		String certNumber =  buffer.toString();
		certDao.delete(EmpEmail);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(EmpEmail);
		certDto.setCertNumber(certNumber);
		certDao.insert(certDto);
		
		//접속 주소 생성 : 도구를 이용해서 현재 실행중인 주소를 자동으로 읽어오도록 처리
		String url = ServletUriComponentsBuilder.fromCurrentContextPath()// = http://localhost:8080/
					 .path("/tb/resetPw")//나머지경로
					 .queryParam("certNumber",certNumber)//파라미터
					 .queryParam("certEmail",EmpEmail)//파라미터
					 .queryParam("loginId", loginId)//파라미터
					 .build().toUriString();//문자열 변환
		Element resetUrlWrapper = document.getElementById("reset-url");
		resetUrlWrapper.attr("href",url);
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message,false,"UTF-8");
		helper.setTo(EmpEmail);
		helper.setSubject("OO회사 비밀번호 재설정 안내");
		helper.setText(document.toString(), true);
		
		sender.send(message);
	}
}
