package com.kh.erp.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class PasswordConfiguration {
	@Bean
	public PasswordEncoder encoder() {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			return encoder;
		}
}
 