package com.naver.erp;

import java.util.Map;

public interface LoginService {

	//+++++++++++++++++++++++++++++++++++++++++
	// 로그인 정보의 개수를 리턴하는 메소드 선언
	//+++++++++++++++++++++++++++++++++++++++++
	public int getAdminIdCnt( 
			
			Map<String,String> admin_id_pwd
			
			
			); 
	
}
