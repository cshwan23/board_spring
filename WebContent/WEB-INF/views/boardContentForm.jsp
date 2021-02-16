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
<title>게시판 상세보기</title>
	<script>
	
	//-------------------------------
	// 게시판 수정 화면으로 이동하는 함수 선언
	//-------------------------------
	function goBoardUpDelForm(){
		//name = boardUpDelForm 을 가진 태그의 action 값을 URL 로 서버에 접속하라
		document.boardUpDelForm.submit();
	}
	//-------------------------------
	// 게시판 댓글 화면으로 이동하는 함수 선언
	//-------------------------------
	function goBoardRegForm(){
		//name = boardUpRegForm 을 가진 태그의 action 값을 URL 로 서버에 접속하라
		document.boardUpDelForm.submit();
	}
	
	
	</script>
</head>
<body><center>

<div style='cursor:pointer;' onclick="location.replace('/z_spring/logout.do')">
	[로그아웃]
	</div>
	
<B>[글 상세 보기]</B>
<!---------------------------------->
<table class="tbcss1" width="500" border=1 bodercolor="#DDDDDD" cellpadding="5" align="center"> 
<tr align=center>
	<th width=60>글번호
	<td width=150>${requestScope.board.b_no}
	<th width=60>조회수
	<td width=150>${requestScope.board.readcount}
<tr align=center>
	<th width=60>작성자
	<td width=150>${requestScope.board.writer}
	<th width=60>작성일
	<td width=150>${requestScope.board.reg_date}
<tr>
	<th>글제목
	<td width=150 colspan=3>>${requestScope.board.subject}
<tr>
	<th>글내용
	<td width=150 colspan=3>
		<textarea name="content" rows="13" cols="45" style="border:0" readonly>${requestScope.board.content}</textarea>
</table><br>

<input type="button" value="댓글쓰기" onClick="goBoardRegForm();">&nbsp;
<input type="button" value="수정/삭제" onClick="goBoardUpDelForm();">&nbsp;
<input type="button" value="글 목록 보기" onClick="document.boardlListForm.submit();">


<!------------------------------------------->
<!--[게시판 목록] 화면으로 이동하는 form 태그 선언  -->
<!------------------------------------------->

<form name="boardListForm" method="post" action="/z_spring/boardList.do">
	<!-------------------------------------------------->
	<!-- /boardContentForm.do로 접석하면서 가져왔던 파라미터명 "selectPageNo"의 파라미터값을 hidden 태그의 value 값으로 삽입하기 -->
	<!-- HttpServletRequest 객체가 가진 파라미터값을 꺼내는 방법은 아래와 같다. -->
	<!-- <방법1> request.getParameter("파리미터명") -->
	<!-- request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP에서 제공하는 변수이다 -->
	<!-- <방법2> 달러기호{param.파라미터명} -->
	<!-- EL문법을 써서 쉽게 꺼낼 수 있다. 값이 null이면 출력되지 않는다. 
	<!-------------------------------------------------->	
	<input type="hidden" name="selectPageNo" value="${param.selectPageNo}">
	<!-------------------------------------------------->
	<!-- /boardContentForm.do로 접석하면서 가져왔던 파라미터명 "selectPageNo"의 파라미터값을 hidden 태그의 value 값으로 삽입하기 -->
	<!-- HttpServletRequest 객체가 가진 파라미터값을 꺼내는 방법은 아래와 같다. -->
	<!-- <방법1> request.getParameter("파리미터명") -->
	<!-- request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP에서 제공하는 변수이다 -->
	<!-- <방법2> 달러기호{param.파라미터명} -->
	<!-- EL문법을 써서 쉽게 꺼낼 수 있다. 값이 null이면 출력되지 않는다. 
	<!-------------------------------------------------->	
	<input type="hidden" name="rowCntPerPage" value="${param.rowCntPerPage}">
	<!-------------------------------------------------->
	<!-- /boardContentForm.do로 접석하면서 가져왔던 파라미터명 "selectPageNo"의 파라미터값을 hidden 태그의 value 값으로 삽입하기 -->
	<!-- HttpServletRequest 객체가 가진 파라미터값을 꺼내는 방법은 아래와 같다. -->
	<!-- <방법1> request.getParameter("파리미터명") -->
	<!-- request에 HttpServletRequest 객체의 메위주가 저장되어 있다. JSP에서 제공하는 변수이다 -->
	<!-- <방법2> 달러기호{param.파라미터명} -->
	<!-- EL문법을 써서 쉽게 꺼낼 수 있다. 값이 null이면 출력되지 않는다. 
	<!-------------------------------------------------->	
	<input type="hidden" name="keyword1" value="${param.keyword1}">

</form>


<!------------------------------------------->
<!--[댓글 쓰기] 화면으로 이동하는 form 태그 선언  -->
<!------------------------------------------->
<form name="boardRegForm" method="post" action="/z_spring/boardRegForm.do">
	<input type="hidden" name="b_no" value="${requestScope.board.b_no}>">
	<input type="hidden" name="selectPageNo" value="<%=request.getParameter("selectPageNo")%>">
	<input type="hidden" name="rowCntPerPage" value="<%=request.getParameter("rowCntPerPage")%>">
	<input type="hidden" name="keyword1" value="<%=request.getParameter("keyword1")%>">
</form>


<!------------------------------------------->
<!-- 수정/삭제 화면으로 이동하기 위한 form 태그 선언 -->
<!------------------------------------------->
<form name="boardUpDelForm" method="post" action="/z_spring/boardUpDelForm.do">
<input type="hidden" name="b_no" value="${requestScope.board.b_no}">
	<input type="hidden" name="selectPageNo" value="<%=request.getParameter("selectPageNo")%>">
	<input type="hidden" name="rowCntPerPage" value="<%=request.getParameter("rowCntPerPage")%>">
	<input type="hidden" name="keyword1" value="<%=request.getParameter("keyword1")%>">
</form>

</body>
</html>
















