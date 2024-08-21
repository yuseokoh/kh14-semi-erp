package com.kh.service;

import org.springframework.stereotype.Service;

@Service
public class PaddingEncryptService {
	//암호화
	public String encode(String rawStr, String padding) {
		StringBuffer buffer = new StringBuffer();
		for(int i=0; i < rawStr.length(); i++) {//origin의 글자수만큼 반복하며
			char ch = rawStr.charAt(i);//현재 글자를 추출하여
			buffer.append(ch);//추가하고
			buffer.append(padding);//패딩을 넣어준다
		}
		return buffer.toString();//암호화된 결과를 반환
	}
	//복호화
	public String decode(String encStr) {
		StringBuffer buffer = new StringBuffer();//버퍼를 만들고
		for(int i=0; i < encStr.length(); i+=2) {//encrypt를 2칸씩 이동하며
			char ch = encStr.charAt(i);//현재 위치의 글자를 추출하여
			buffer.append(ch);//버퍼에 추가
		}
		return buffer.toString();//복호화 결과를 반환
	}
}