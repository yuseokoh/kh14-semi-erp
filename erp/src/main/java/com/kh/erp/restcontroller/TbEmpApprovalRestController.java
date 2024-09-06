package com.kh.erp.restcontroller;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



@RestController
@RequestMapping("/rest/approval")
public class TbEmpApprovalRestController {
	
	@RequestMapping("/sign")
	public String sign(@RequestBody Map<String, String> requestData) {
		 String result = requestData.get("result"); // 클라이언트에서 보낸 result 값
		return result;
	}

}
