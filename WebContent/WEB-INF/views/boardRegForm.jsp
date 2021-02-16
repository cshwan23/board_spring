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
<!-- common.jsp 파일 내의 소스를 삽입하기 -->
<!--*****************************************************-->
<%@include file="common.jsp" %>

<head>
<title>게시판 글쓰기</title>
	<script>
	//****************************************
	//[게시판 등록 화면]에 입력된 데이터의 유효성 체크 함수 선언
	//****************************************
	function checkBoardRegForm(){
		
		
		if (isEmpty( "$("[name=writer]") ) ){
			alert("이름을 입력해 주세요");
			$("[name=writer]").focus();
			return;
		}
		
		
		
		var writer = $("[name=writer]").val();
		if(writer.split(" ").join("")==""){
			alert("이름을 입력해주세요.");
			$("[name=writer]").focus();
			return;
		}
		
		var subject = $("[name=subject]").val();
		if(subject.split(" ").join("")==""){
			alert("제목을 입력해주세요.");
			$("[name=subject]").focus();
			return;
		}
		
		var email = $("[name=email]").val();
		if(email.split(" ").join("")==""){
			alert("이메일을 입력해주세요.");
			$("[name=email]").focus();
			return;
		}

		var content = $("[name=content]").val();
		if(content.split(" ").join("")==""){
			alert("내용을 입력해주세요.");
			$("[name=content]").focus();
			return;
		}
		
		var pwd = $("[name=pwd]").val();
		if(pwd.split(" ").join("")==""){
			alert("암호를 입력해주세요.");
			$("[name=pwd]").focus();
			return;
		}
		
		if(new RegExp(/^[0-9]{4}$/).test(pwd)==false){
			alert("암호는 숫자 4개를 입력해주세요");
			return;
		}
		
		if (confirm("정말 등록하시겠습니까?")==false){
			return;
		}
		
		//----------------------------
		// 현재 화면에서 페이지 이동없이 서버쪽 "/z_spring/bpardRegProc.do"를 호출하여
		// 게시판 글을 입력하고 [게시판 입력 행 적용 개수]를 받기
		//----------------------------
		$.ajax({
			//------------------
			// 호출할 서버쪽 URL 주소 설정
			//------------------
			url : "/z_spring/boardRegProc.do"
			//------------------
			// 전송 방법 설정
			//------------------
			,type : "post"
			//------------------
			// 서버로 보낼 파라미터명과 파라미터값을 설정
			//------------------
			,data : $('[name=boardRegForm]').serialize()
			
			//----------------------------
			// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
			// 매개변수 boardRegCnt 에는 입력 행의 개수가 들어온다. 
			//----------------------------
			/*
			,success : function(boardRegCnt){
			
				// [게시판 새글 입력 행 적용 개수]가 1개면
				if(boardRegCnt==1){
					//------------------------------------
					// HttpServletRequest 객체가 가진 "b_no" 라는 키워드로 저장된 객체가
					// 비어있지 않으면 "게시판 댓글 등록 성공!"
					// null 또는 "" 또는 0 이면 "게시판 새글 등록 성공!"을 alert 상자로 경고하기 
					//------------------------------------
					alert("게시판 ${empty requestScope.b_no==0?'새글':'댓글'} 등록 성공!");
					//------------------------------------
					// name="boardListForm"를 가진 form 태그 action 값의 URL 주소 서버로 접속하기
					// 결국 게시판 목록보기 화면으로 이동하기
					//------------------------------------
					document.boardListForm.submit();
				}
				
				// [게시판 새글 입력 행 적용 개수]가 -2개면
				else if(boardRegCnt==-2) {
					alert("유효성 체크시 뭔가 잘못됐습니다.");
				}
				
				// [게시판 새글 입력 행 적용 개수]가 -1개면
				else if(boardRegCnt==-1){
					alert("게시판 등록 실패! 관리자에게 문의 바람.");
				}
			}
			*/
			,success : function (json){
				//----------------------------
				// 웹서버가 보낸 [유효성 체크 메시지]가 ""가 아니면
				// 경고문구 보여주고 익명함수 중단 하기
				//----------------------------
				if( json.checkMsg!=""){
					alert(json.checkMsg);
					return;
				}
				//----------------------------
				// 웹서버가 보낸 입력 성공 행의 개수가 1이 아니면
				// 경고문구 보여주고 익명함수 중단하기 
				//----------------------------
				if( json.boardRegCnt!=1){
					alert("입력 실패! 관리자에 문의 바람!");
					return;
				}
			 	location.replace("$(requestScope.croot}/boardList.do");
			}
			
			//----------------------------
			// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			//----------------------------
			,error : function(){
				alert("서버 접속 실패")
			}
			
			
		});
	}
	
	</script>
</head>
<body bgcolor="${requestScope.bodyBgcolor}"><center>

	<div style='cursor:pointer;'  onclick="location.replace('${requestScope.croot}/logout.do');">[로그아웃]</div>
	<!--**********************************************************-->
	<!-- [게시판 글쓰기] 화면을 출력하는 form 태그 선언 -->
	<!--**********************************************************-->
	<form name="boardRegForm" method="post" action="${requestScope.croot}/boardRegProc.do">

		<c:if test="${requestScope.b_no==0}">
			<b>[새 글쓰기]</b><br>
		</c:if>
		<c:if test="${requestScope.b_no!=0}">
			<b>[댓글 쓰기]</b><br>
		</c:if>

		<table class="tbcss1"  border=1  bordercolor="${requestScope.thBgcolor}" cellpadding=5 align=center>
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">이 름
				<td>
				<!-------------------------------------------------------->
				<input type="text" size="10" name="writer" maxlength=10>
				<!-------------------------------------------------------->
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">제 목 
				<td>
				<!-------------------------------------------------------->
				<input type="text" size="40" name="subject" maxlength=30>
				<!-------------------------------------------------------->
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">이메일
				<td>
				<!-------------------------------------------------------->
				<input type="text" size="40" maxlength='30' name="email">
				<!-------------------------------------------------------->
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">내 용
				<td>
				<!-------------------------------------------------------->
				<textarea name="content" rows="13" cols="40"  maxlength=300></textarea>
				<!-------------------------------------------------------->
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">파 일
				<td>
				<!-------------------------------------------------------->
				<input type="file" name="pic2">
				<!-------------------------------------------------------->
			<tr>
				<th bgcolor="${requestScope.thBgcolor}">비밀번호
				<td>
				<!-------------------------------------------------------->
				<input type="password" size="8" name="pwd" maxlength=4>
				<!-------------------------------------------------------->
		</table>
		<div style="height:6"></div>

		<!-------------------------------------------------------->
		<input type="hidden" name="b_no" value="${requestScope.b_no}">
		<!-------------------------------------------------------->



		<input type="button" value="저장" onClick="checkBoardRegForm()">
		<input type="reset" value="다시작성">
		<input type="button" value="목록보기" onClick="document.boardListForm.submit();">

	</form>

	<!-- ********************************************************** -->
	<!-- [게시판 목록] 화면으로 이동하는 form 태그 선언 -->
	<!-- ********************************************************** -->
	<form name="boardListForm" method="post" action="${requestScope.croot}/boardList.do">	
			<!-------------------------------------------------------------------->
			<!--- /boardContentForm.do 로 접속하면서 가져왔던 파리미터명 "selectPageNo" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
			<!--- HttpServletRequest 객체가 가진 파리미터값을 꺼내는 방법은 아래와 같다.-->
			<!--- <방법1>request.getParameter("파라미터명")    -->
			<!---        request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP 에서 제공하는 변수이다.    -->
			<!--- <방법2> 달러기호{param.파라미터명}    -->
			<!---        EL 문법을 써서 쉽게 꺼낼수 있다. 값이 null 이면 출력되지 않는다.    -->
			<!-------------------------------------------------------------------->
			<input type="hidden" name="selectPageNo" value="${param.selectPageNo}">
			<!-------------------------------------------------------------------->
			<!--- /boardContentForm.do 로 접속하면서 가져왔던 파리미터명 "rowCntPerPage" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
			<!--- HttpServletRequest 객체가 가진 파리미터값을 꺼내는 방법은 아래와 같다.-->
			<!--- <방법1>request.getParameter("파라미터명")    -->
			<!---        request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP 에서 제공하는 변수이다.    -->
			<!--- <방법2> 달러기호{param.파라미터명}    -->
			<!---        EL 문법을 써서 쉽게 꺼낼수 있다. 값이 null 이면 출력되지 않는다.    -->
			<!-------------------------------------------------------------------->
			<input type="hidden" name="rowCntPerPage" value="${param.rowCntPerPage}">
			<!-------------------------------------------------------------------->
			<!--- /boardContentForm.do 로 접속하면서 가져왔던 파리미터명 "keyword1" 의 파라미터값을  hidden 태그의 value 값으로 삽입하기->
			<!--- HttpServletRequest 객체가 가진 파리미터값을 꺼내는 방법은 아래와 같다.-->
			<!--- <방법1>request.getParameter("파라미터명")    -->
			<!---        request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP 에서 제공하는 변수이다.    -->
			<!--- <방법2> 달러기호{param.파라미터명}    -->
			<!---        EL 문법을 써서 쉽게 꺼낼수 있다. 값이 null 이면 출력되지 않는다.    -->
			<!-------------------------------------------------------------------->
			<input type="hidden" name="keyword1" value="${param.keyword1}">

			<input type="checkbox" name="date" value="오늘">
			<input type="checkbox" name="date" value="어제">
	</form>

</body>
</html>




