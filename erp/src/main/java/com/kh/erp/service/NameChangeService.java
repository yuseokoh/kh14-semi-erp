package com.kh.erp.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class NameChangeService {
	 private Map<String, String> map;
	 
	 public String deptChange(String nameCode) {
		 map = new HashMap<>();
		 map.put("a00", "인사팀");
		 map.put("a01", "총무팀");
		 map.put("a02", "영업팀");
		 map.put("a03", "개발팀");
		 map.put("a04", "생산팀");
		 map.put(null, "인사 발령 필요");
		 return map.get(nameCode);
	 }
	 
}
