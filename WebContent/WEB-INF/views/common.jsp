<!-- ************************************************************* -->
<!-- JSP 기술의 한종류인 [Page Directive]를 이용하요 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ************************************************************* -->
	<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
	<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩한다 -->
	<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화 할 수 있는 방법이다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!--
————————————————————————————————————————
JSP 페이지에서 사용할 [사용자 정의 태그]의 한 종류인 [JSTL의 C 코어 태그]를 사용하겠다고 선언
아래 코딩이 들어가야 JSTL의 C 코어 태그를 사용할 수 있다. 
   ————————————————————————————————————————
   JSTL 이란?
   ————————————————————————————————————————
	=> 자카르타라는 단체에서 만든 사용자 정의 태그를 말한다.
	=> 자바 문법을 HTML과 같은 태그 형태로 표현한다.
	=> 태그 형태로 표현하면 뒤에서 자바 문법으로 바뀌어 실행한다.

   ————————————————————————————————————————
   JSTL 장점
   ————————————————————————————————————————
	=> 태그형태이므로 디자이너 퍼블리셔 초급개발자가 접근이 쉽다.
	=> 큰 에러가 아닌 이상 화면이 멈추지 않는다. 
	=> null 처리에 대해 관대하다.
	=> JSTL은 EL과 같이 쓰인다
   ————————————————————————————————————————
   EL(=Expression Language)이란?
   ————————————————————————————————————————
	=> 자바 영역의 데이터를 JSP 페이지에 표현하는 언어이다.
	=> EL 문법 형식
		-----------------
		달러{EL문법}
		-----------------
	=> JSP 기술 중에 하나이다. 
	=> <예> HttpServletRequest 객체에 저장된 데이터를 아주 쉽게 표현해서 JSP 에 삽입해준다.
   		————————————————————————————————————————
		자바로 JSP 페이지에서 HttpServletRequest 객체에 "keyword"란 키값으로 저장된 놈을 꺼내서
		div 태그 안에 삽입하는 경우 아래처럼 하면 된다.
   		————————————————————————————————————————
		<%
		String keyword = (String)request.getAttribute("keyword");
		%>
		<div> <%=keyword%> </div>
   		————————————————————————————————————————
		EL 문법으로 JSP 페이지에서 HttpServletRequest 객체에 "keyword"란 키값으로
		저장된 놈을 꺼내서 div 태그 안에 삽입하는 경우 아래처럼 하면 된다.
   		————————————————————————————————————————
		<div>${requestScope.keyword}</div>
   		————————————————————————————————————————
		심지어 requestScope. 을 생략해도 된다.
   		————————————————————————————————————————
		<div>${keyword}</div>
————————————————————————————————————————-->
<%--  <%@taglib prefix=“c” uri=“http://java.sun.com/jsp/jstl/core” %>  --%>


<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!-- JSP 페이지에서 사용할 [자바스크립트 파일], [CSS 파일] 수입하기 -->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!------------------------------------------------------------------->
<!-- JSP 페이지에서 사용할 [JQuery API] 수입 -->
<!-- JSP 페이지에서 사용할 [공용 함수 내장된 common.jsp 파일] 수입 -->
<!------------------------------------------------------------------->

<link href="/z_spring/resources/common.css" rel="stylesheet" type="text/css">
<script src="/z_spring/resources/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="/z_spring/resources/common.js?ver=<%=Math.random()%>" type="text/javascript"></script>


<%
int boardList_width = 600;
%>










