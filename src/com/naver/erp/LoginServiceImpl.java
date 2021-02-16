package com.naver.erp;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//+++++++++++++++++++++++++++++++++++++++++
// [서비스 클래스]인 [LoginServiceImpl 클래스]선언 
//+++++++++++++++++++++++++++++++++++++++++
	// [서비스 클래스]에는 @Service 와 @Transactional 를 붙인다.
	//--------------------------------------------------
	// @Service 		=> [서비스 클래스]임을 지정하고 bean 태그로 자동등록된다.
	// @Transactional	=> [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다. 



@Service
@Transactional

public class LoginServiceImpl implements LoginService {
	
		@Autowired
		private LoginDAO loginDAO;
		
		//+++++++++++++++++++++++++++++++++++++++++
		// 로그인 정보의 개수를 리턴하는 메소드 선언
		//+++++++++++++++++++++++++++++++++++++++++
		public int getAdminIdCnt( 
				
			//------------------
			//매개변수로 클이 입력한 아이디와 암호가 저장된 HashMap 객체가 들어온다.
			//<참고>

			Map<String,String> admin_id_pwd
				
		) {
				
			int adminCnt = this.loginDAO.getAdminIdCnt(admin_id_pwd);
			return adminCnt;
			
		}
}
