package com.kh.erp.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
@ConfigurationProperties(prefix="custom.cert")
public class CustomCertProperties {
	private int expire;
}
