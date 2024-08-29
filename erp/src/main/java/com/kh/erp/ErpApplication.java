package com.kh.erp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.scheduling.annotation.EnableScheduling;
//모든 시스템에 Spring Security 가 자동 적용되는 것을 방지하도록 설정
@EnableScheduling//스케쥴링 서비스 활성화 설정
@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class ErpApplication {

	public static void main(String[] args) {
		SpringApplication.run(ErpApplication.class, args);
	}

}
