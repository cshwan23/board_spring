package com.naver.erp;

import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// BoardDTO 객체에 저장된 데이터의 유효성 체크할 BoardValidator 클래스 선언하기
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

public class BoardValidator implements Validator {
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 유효성 체크할 객체의 클래스 타입 정보 얻어 리턴하기
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	@Override
	public boolean supports(Class<?> arg0) {
		return BoardDTO.class.isAssignableFrom(arg0); // 검증할 객체의 클래스 타입 정보
	}
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 유효성 체크할 메소드 선언하기(에러객체를 이용한 유효성 체크)
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	@Override
	public void validate(
			  Object obj	 // DTO 객체 저장 매개 변수
			, Errors errors  // 유효성 검사 시 발생하는 에러를 관리하는 Errors 객체 저장 매개변수			
	) {
		
		try {
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 유효성 체크할 DTO 객체 얻기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		BoardDTO dto = (BoardDTO)obj;
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드 호출하여
		// 		BoardDTO 객체의 속성변수명 writer가 비거나 공백으로 구성되어 있으면
		//		경고 메시지를 Errors 객체에 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		ValidationUtils.rejectIfEmptyOrWhitespace(
				errors				// Errors 객체
				, "writer"			// BoardDTO 객체의 속성변수명
				, "작성자명 입력요망"	// BoardDTO 객체의 속성변수명이 비거나 공백으로 구되어있을때 경고문구
		);
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// BoardDTO 객체의 속성변수명 "writer" 저장된 데이터의 길이가 10자 보다 크면 
		// Errors 객체에 속성변수명 "writer"와 경고 메시지 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		String writer = dto.getWriter();
		
		// getWriter 가 null일 수도 있다. 
		if( writer!=null && writer.length()>10) {
			errors.rejectValue(
					  "writer"							// DTO 객체의 속성변수명
					, "작성자명은 공백없이 10자이하 입니다."		// 경고 문구
			);
			
		}
		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드 호출하여
		// 		BoardDTO 객체의 속성변수명 subject가 비거나 공백으로 구성되어 있으면
		//		경고 메시지를 Errors 객체에 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		ValidationUtils.rejectIfEmptyOrWhitespace(
				errors				// Errors 객체
				, "subject"			// BoardDTO 객체의 속성변수명
				, "제목 입력요망"		// BoardDTO 객체의 속성변수명이 비거나 공백으로 구성되어있을때 경고문구
		);
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// BoardDTO 객체의 속성변수명 "subject" 저장된 데이터의 길이가 10자 보다 크면 
		// Errors 객체에 속성변수명 "subject"와 경고 메시지 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		String subject = dto.getSubject();
		
		// getSubject 가 null일 수도 있다. 
		if( subject!=null && subject.length()>20) {
			errors.rejectValue(
					  "subject"							// DTO 객체의 속성변수명
					, "제목은 공백없이 20자 이하 입니다."		// 경고 문구
			);
			
		}
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드 호출하여
		// 		BoardDTO 객체의 속성변수명 content가 비거나 공백으로 구성되어 있으면
		//		경고 메시지를 Errors 객체에 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		ValidationUtils.rejectIfEmptyOrWhitespace(
				errors				// Errors 객체
				, "content"			// BoardDTO 객체의 속성변수명
				, "내용 입력요망"		// BoardDTO 객체의 속성변수명이 비거나 공백으로 구성되어있을때 경고문구
		);
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// BoardDTO 객체의 속성변수명 "content" 저장된 데이터의 길이가 10자 보다 크면 
		// Errors 객체에 속성변수명 "content"와 경고 메시지 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		String content = dto.getContent();
		
		// getContent 가 null일 수도 있다. 
		if( content!=null && content.length()>300) {
			errors.rejectValue(
					  "content"							// DTO 객체의 속성변수명
					, "내용은 공백없이 300자 이하 입니다."		// 경고 문구
			);
			
		}

		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드 호출하여
		// 		BoardDTO 객체의 속성변수명 email가 비거나 공백으로 구성되어 있으면
		//		경고 메시지를 Errors 객체에 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		ValidationUtils.rejectIfEmptyOrWhitespace(
				errors				// Errors 객체
				, "email"			// BoardDTO 객체의 속성변수명
				, "이메일 입력요망"		// BoardDTO 객체의 속성변수명이 비거나 공백으로 구성되어있을때 경고문구
		);
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// BoardDTO 객체의 속성변수명 "email" 저장된 데이터의 길이가 10자 보다 크면 
		// Errors 객체에 속성변수명 "email"와 경고 메시지 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		String email = dto.getEmail();
		
		// getContent 가 null일 수도 있다. 
		if( email!=null && email.length()>30) {
			errors.rejectValue(
					  "email"							// DTO 객체의 속성변수명
					, "이메일은 공백없이 30자 이하 입니다."		// 경고 문구
			);
			
		}
//----------------------------------------------------------------
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드 호출하여
		// 		BoardDTO 객체의 속성변수명 pwd가 비거나 공백으로 구성되어 있으면
		//		경고 메시지를 Errors 객체에 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		ValidationUtils.rejectIfEmptyOrWhitespace(
				errors				// Errors 객체
				, "pwd"				// BoardDTO 객체의 속성변수명
				, "암호 입력요망"		// BoardDTO 객체의 속성변수명이 비거나 공백으로 구성되어있을때 경고문구
		);		
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// BoardDTO 객체의 속성변수명 "pwd" 저장된 데이터의 길이가 10자 보다 크면 
		// Errors 객체에 속성변수명 "pwd"와 경고 메시지 저장하기
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		String pwd = dto.getPwd();
		
		// 네글자여야되고 숫자여야한다(정규표현식 유효성 패턴) 
		if( Pattern.matches("^[0-9]{4}$",pwd)==false) {
			errors.rejectValue(
					  "pwd"									// DTO 객체의 속성변수명
					, "암호는 숫자 4자리 입니다. 재입력 요망"		// 경고 문구
			);
			
		}		
		
		}catch(Exception ex) {
			System.out.println("BoardValidator.validate 메소드 실행시 예외발생!");
		}
	}

}






