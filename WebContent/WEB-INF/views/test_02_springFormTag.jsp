<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!--JSP 페이지 처리 방식 선언-->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@page contentType = "text/html;charset=UTF-8" pageEncoding = "UTF-8"%>
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@page import = "java.util.*"%>
<%@page import = "com.naver.erp.*"%>

<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!--JSP 페이지에서 사용할 [사용자 정의 태그]인 [JSTL의 C 코어 태그] 선언-->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!--JSP 페이지에서 사용할 [사용자 정의 태그]인 [spring 폼 태그] 선언-->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>



<hr>Spring form 태그 연습하기<hr>
<%
	//---------------------------------------------------------------------
	// BoardSearchDTO 객체 생성하기
	// BoardSearchDTO 객체의 setter 메소드 호출로 속성변수에 데이터 삽입하기
	//---------------------------------------------------------------------
	BoardSearchDTO boardSearchDTO = new BoardSearchDTO();
	boardSearchDTO.setKeyword1("성배");
	boardSearchDTO.setDate( new String[]{"어제"} );
	boardSearchDTO.setRowCntPerPage(3);
	//---------------------------------------------------------------------
	// HttpServletRequest 객체에 "boardSearchDTO" 라는 키값으로 BoardSearchDTO 객체 저장하기
	//---------------------------------------------------------------------
	request.setAttribute("boardSearchDTO", boardSearchDTO );
%>

<hr>

<c:if test="${!empty requestScope.boardSearchDTO}">
		<!-- --------------------------------------- -->
		<!-- spring form 태그 선언-->
		<!-- --------------------------------------- -->
		<form:form name="board"  method="post" action="/z_spring/boardListForm.do"   commandName="boardSearchDTO">
			<!-- --------------------------------------- -->
			<!-- 위 코딩은 아래의 html 코딩으로 변화한다.-->
			<!-- <form id="boardSearchDTO" name="board" action="/z_spring/boardListForm.do" method="post"> -->
			<!-- --------------------------------------- -->
			<table border=0>
				<tr>
					<th>키워드
					<td><form:input path="keyword1"/>
						<!-- --------------------------------------- -->
						<!-- 위 코딩은 아래의 html 코딩으로 변화한다.-->
						<!-- <input id="keyword1" name="keyword1" type="text" value="성배"/> -->
						<!-- --------------------------------------- -->
				<tr>
					<th>날짜
					<td><form:checkbox path="date" value="오늘" label="오늘"/>
						<form:checkbox path="date" value="어제" label="어제"/>
						<!-- --------------------------------------- -->
						<!-- 위 코딩은 아래의 html 코딩으로 변화한다.-->
						<!-- 
							<input id="date1" name="date" type="checkbox" value="오늘"/><label for="date1">오늘</label>
							<input id="date2" name="date" type="checkbox" value="어제" checked="checked"/><label for="date2">어제</label>
							<input type="hidden" name="_date" value="on"/>
						-->
				<tr>
					<th>행보기개수
					<td><form:select path="rowCntPerPage">
							<form:option value="" label=""/>
							<form:option value="0" label="0"/>
							<form:option value="1" label="1"/>
							<form:option value="2" label="2"/>
							<form:option value="3" label="3"/>
							<form:option value="4" label="4"/>
						</form:select> 
						<!-- --------------------------------------- -->
						<!-- 위 코딩은 아래의 html 코딩으로 변화한다.-->
						<!-- 
									<select id="rowCntPerPage" name="rowCntPerPage">
											<option value=""></option>
											<option value="0">0</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3" selected="selected">3</option>
											<option value="4">4</option>
									</select> 
						-->
			</table>
		</form:form>
</c:if>