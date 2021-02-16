<!-- ************************************************************* -->
<!-- JSP 기술의 한종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ************************************************************* -->
	<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
	<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩한다 -->
	<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화 할 수 있는 방법이다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>

<!--*****************************************************-->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 -->
<!--                               common.jsp 파일 내의 소스를 삽입하기 -->
<!--*****************************************************-->
<%@include file="common.jsp" %>




<head>
<title>로그인</title>
	<script>
		//**********************************************
		// body 태그 안의 소스를 모두 실행한 후에 실행할 자스 코드 설정
		//**********************************************
		$(document).ready(function(){
			//-------------------------------
			// name=loginForm 가진 태그 안의 class=login 가진 태그에
			// click 이벤트 발생 시 실행할 코드 설정하기
			//-------------------------------
			$("[name=loginForm] .login").click(function(){
				checkLoginForm();
			});
			
			/* 
			$(".admin_id").val("abc");
			$(".pwd").val("a123";) */
		});
		//*****************************************
		// 로그인 정보 유효성 체크하고 비동기 방식으로 서버와 통신하여
		// 로그인 정보와 암호의 존재 여부에 따른 자스 코드 실행하기
		//*****************************************
		function checkLoginForm(){
			//alert("우왕.... 로그인 버튼 눌렀냉....")
			// 입력된 [아이디]를 가져와 변수에 저장
			var admin_id = $('.admin_id').val();
			// 아이디를 입력 안했거나 공백이 있으면
			// 아이디 입력란을 비우고 경고하고 함수 중단
			if(admin_id.split(" ").join("")==""){
				alert("관리자 아이디 입력 요망");
				$('.admin_id').val("");
				return;
			}
			// 입력된 [암호]를 가져와 변수에 저장
			var pwd = $('.pwd').val();
			// 암호를 입력 안했거나 공백이 있으면
			// 암호 입력란을 비우고 경고하고 함수 중단
			if(pwd.split(" ").join("")==""){
				alert("관리자 암호 입력 요망");
				$('.pwd').val("");
				return;
			}
			
			//------------------------------------------
			// 현재 화면에서 페이지 이동 없이 (= 비동기 방식으로)
			// 서버쪽 loginForm.do 로 접속하여 아이디, 암호의 	 존재 개수를 얻기
			//------------------------------------------
			$.ajax({
				// 서버 쪽 호출 URL 주소 지정
				url : "/z_spring/loginProc.do"
				// form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
				, type : "post"  
				// 서버로 보낼 파라미터명과 파라미터값을 설정. 즉 입력한 아이디와 암호를 지정
				, data : {"admin_id":admin_id, "pwd":pwd}   
				//------------------------------------------
				// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
				// 익명함수의 매개변수 date 에는 서버가 응답한 데이터가 들어온다
				//------------------------------------------
				, success : function(admin_idCnt){
					if(admin_idCnt==1){
						alert("로그인 성공");
						location.replace("/z_spring/boardList.do")
					}
					else{
						alert("입력하신 아이디 또는 암호가 틀립니다.");
					}
				}
				// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
				, error : function(){
					alert("서버 접속 실패");
				}
			});
		
		}
	</script>
</head>
<body><center>

	<!-- ************************************************ -->
	<!-- [로그인 정보 입력 양식] 내포한 form 태그 선언 -->
	<!-- ************************************************ -->
	<form name="loginForm" method="post" action="/z_spring/loginProc.do">
		<b>로그인</b>
		<table class="tbcss1" border=1 cellpadding=5 cellspacing=0 bordercolor="gray" >
		<tr>
			<th bgcolor="lightgray" align=center>아이디
				<td><input type="text" name="admin_id" class="admin_id" size="20">
		<tr>
			<th bgcolor="lightgray" align=center>암호
			<td><input type="password" name="npwd" class="pwd" size="20">
		</table>
		<!------------------------->
		<div style="height:6"></div>
		<!------------------------->
		<table><tr>
			<td><input type="button" value="로그인" class="login">
			<td><input type="checkbox" name="is_login" value="y">아이디, 암호 기억
		</table>
	</form>
	
</body>
</html>




