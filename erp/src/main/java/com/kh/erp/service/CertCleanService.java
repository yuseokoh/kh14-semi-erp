package com.kh.erp.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.erp.configuration.CustomCertProperties;
import com.kh.erp.dao.CertDao;


//인증번호 청소 서비스
//-정해진 시간마다 "쓸모없어진" 인증번호를 삭제하는 서비스
//-쓸모없다는 것은 인증시간이 만료된 데이터를 의미(현재는 10분)

@Service
public class CertCleanService {
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private CustomCertProperties customCertProperties;
	
	@Scheduled(cron = "0 0 * * * *")
	public void clean() {
		certDao.clean(customCertProperties.getExpire());
	}
	
}