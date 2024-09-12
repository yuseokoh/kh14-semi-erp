package com.kh.erp.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.erp.interceptor.AdminInterceptor;
import com.kh.erp.interceptor.EmpInterceptor;
import com.kh.erp.interceptor.LoginInterceptor;


@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer  {
	@Autowired
	private AdminInterceptor adminInterceptor;
	@Autowired
	private EmpInterceptor empInterceptor;
	@Autowired
	private LoginInterceptor loginInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(empInterceptor)
				.addPathPatterns(
						 "/home",
                         "/groupware/**",
                         "/stock/**",
                         "/res/**",
                         "/vacation/**",
                         "/report/**",
                         "/rest/**",
                         "/api/**"
									)
				.excludePathPatterns(
							"/tb/login",//로그인페이지
							"/",//메인페이지
							"/tb/findPw",//비밀번호찾기
							"/tb/join",//가입
							"/tb/resetPw",//비밀번호찾기 링크
							"/rest/emp/checkId"
						);
		registry.addInterceptor(adminInterceptor)
				.addPathPatterns(
							"/admin/**",//모든 admin 페이지
							"/rest/vacation/deducted",
							"/rest/report/reject",
							"/rest/document/sign"
						);
		registry.addInterceptor(loginInterceptor)
				.addPathPatterns(
							"/",//로그인페이지
							"/tb/login"
						);
	}
}