<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!--JSP 페이지 처리 방식 선언-->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@page contentType = "text/html;charset=UTF-8" pageEncoding = "UTF-8"%>
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!--JSP 페이지에서 사용할 [사용자 정의 태그]인 [JSTL의 C 코어 태그] 선언-->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<%@page import = "java.util.*"%>
<%@page import = "com.naver.erp.*"%>

<hr>JSTL 의 반복문을 연습해 보자<hr>
<%
	//---------------------------------------------------------------------
	// 다량의 HashMap<String,String> 객체를 저장할 ArrayList 객체 생성하기
	//---------------------------------------------------------------------
	List<Map<String,String>> boardList = new ArrayList<Map<String,String>>();

	Map<String,String> map1 = new HashMap<String,String>( );
	map1.put( "b_no", "1" );  map1.put( "writer", "박희병" ); map1.put( "subject", "강사 교체 문제" );
	boardList.add(map1);
	
	Map<String,String> map2 = new HashMap<String,String>( );
	map2.put( "b_no", "2" );  map2.put( "writer", "차승윤" ); map2.put( "subject", "아빠가 된다는 것은 무얼까요..." );
	boardList.add(map2);
	
	Map<String,String> map3= new HashMap<String,String>( );
	map3.put( "b_no", "3" );  map3.put( "writer", "황보민" ); map3.put( "subject", "나도 아빠가 되고 싶어요...." );
	boardList.add(map3);

	request.setAttribute("board", boardList );
	//---------------------------------------------------------------------
	/*
	List<Map<String,String>> boardList2 = (List<Map<String,String>>)request.getAttribute("board" );
	out.print( "<table border=1><tr><th>번호<th>작성자<th>제목" );
	for( int i=0 ; i<boardList2.size() ; i++ ){
		Map<String,String> map = boardList2.get(i);
		out.print( "<tr><td>" + (i+1) +  "<td>" + map.get("writer")+ "<td>" + map.get("subject")  );
	}
	out.print( "</table><hr>" );
	*/
	//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	List<BoardDTO> boardList3 = new ArrayList<BoardDTO>();

	BoardDTO boardDTO1 = new BoardDTO();
	boardDTO1.setB_no(1); boardDTO1.setWriter("박희병병"); boardDTO1.setSubject("강사 교체 문제");
	boardList3.add(boardDTO1);

	BoardDTO boardDTO2 = new BoardDTO();
	boardDTO2.setB_no(2); boardDTO2.setWriter("차승윤윤"); boardDTO2.setSubject("아빠가 된다는 것은 무얼까요...");
	boardList3.add(boardDTO2);

	BoardDTO boardDTO3 = new BoardDTO();
	boardDTO3.setB_no(3); boardDTO3.setWriter("황보민민"); boardDTO3.setSubject("나도 아빠가 되고 싶어요....");
	boardList3.add(boardDTO3);

	request.setAttribute("board2", boardList3 );
	//---------------------------------------------------------------------
	/*
	List<BoardDTO> boardList4 = (List<BoardDTO>)request.getAttribute("board2" );
	out.print( "<table border=1><tr><th>번호<th>작성자<th>제목" );
	for( int i=0 ; i<boardList4.size() ; i++ ){
		BoardDTO boardDTO = boardList4.get(i);
		out.print( "<tr><td>" + (i+1) +  "<td>" + boardDTO.getWriter()+ "<td>" + boardDTO.getSubject( )  );
	}
	out.print( "</table><hr>" );
	*/
%>

	<%--
		 HttpServletRequest 객체에 board 라는 키값으로 저장된
		 ArrayList<HashMap<String,String>> 객체 안의 HashMap<String,String> 들을
		 자바 지역변수 xxx 에 1개씩 저장하고 반복문 안으로 들어가서
		 ${xxx.HashMap객체키값명} 으로 표현하고 있다.
		 반복문 돌 때마다 자바 지역변수 xxx 에는 n번째 HashMap<String,String> 객체가 저장된다.
		 반복문 돌 때마다 LoopTagStatus 객체의 index 라는 속성변수 안의 데이터를 꺼내어 출력한다.
		 출력 시 EL 로 ${loopTagStatus.index} 로 한다.
		 반복문 돌 때마다 LoopTagStatus 객체의 index 라는 속성변수 안의 데이터는 0부터 시작해서
		 1씩 증가하면서 반복문 안에서 표현된다.
		 현재 LoopTagStatus 객체의 메위주는 loopTagStatus 라는 지역 변수에 저장되어 있다.
		 바로 varStatus="loopTagStatus" 에 선언된 지역변수이다.
	--%>
<table border=1>
	<tr><th>번호<th>작성자<th>제목
	<c:forEach items="${requestScope.board}" var="xxx" varStatus="loopTagStatus">
		<tr>
		<td>${loopTagStatus.index+1}
		<td>${xxx.writer}
		<td>${xxx.subject}
	</c:forEach>
</table>
<hr>

	<%--
		 HttpServletRequest 객체에 board 라는 키값으로 저장된
		 ArrayList<BoardDTO> 객체 안의 BoardDTO 들을
		 자바 지역변수 xxx 에 1개씩 저장하고 반복문 안으로 들어가서
		 ${xxx.BoardDTO객체석성변수명} 으로 표현하고 있다.
		 반복문 돌 때마다 자바 지역변수 xxx 에는 n번째 BoardDTO 객체가 저장된다.
		 반복문 돌 때마다 LoopTagStatus 객체의 index 라는 속성변수 안의 데이터를 꺼내어 출력한다.
		 출력 시 EL 로 ${loopTagStatus.index} 로 한다.
		 반복문 돌 때마다 LoopTagStatus 객체의 index 라는 속성변수 안의 데이터는 0부터 시작해서
		 1씩 증가하면서 반복문 안에서 표현된다.
		 현재 LoopTagStatus 객체의 메위주는 loopTagStatus 라는 지역 변수에 저장되어 있다.
		 바로 varStatus="loopTagStatus" 에 선언된 지역변수이다.
	--%>
<table border=1>
	<tr><th>번호<th>작성자<th>제목
	<c:forEach items="${requestScope.board2}" var="xxx" varStatus="loopTagStatus">
		<tr>
		<td>${loopTagStatus.index+1}
		<td>${xxx.writer}
		<td>${xxx.subject}
	</c:forEach>
</table>


<%
	
	List<Map<String,String>> empList = new ArrayList<Map<String,String>>();

	Map<String,String> empMap1 = new HashMap<String,String>( );
	empMap1.put( "emp_no", "1" );  empMap1.put( "emp_name", "박희병" ); empMap1.put( "jikup", "사장" );
	empList.add(empMap1);
	
	Map<String,String> empMap2 = new HashMap<String,String>( );
	empMap2.put( "emp_no", "2" );  empMap2.put( "emp_name", "차승윤" ); empMap2.put( "jikup", "과장" );
	empList.add(empMap2);
	
	Map<String,String> empMap3= new HashMap<String,String>( );
	empMap3.put( "emp_no", "3" );  empMap3.put( "emp_name", "황보민" ); empMap3.put( "jikup", "대리" );
	empList.add(empMap3);
	request.setAttribute("empList", empList );
	request.setAttribute("empListCnt", empList.size() );


%>
<table border=1>
	<tr><th>번호<th>직원번호<th>직원명<th>직급
	<c:forEach items="${requestScope.empList}" var="emp" varStatus="loopTagStatus">
		<tr>
		<td>${requestScope.empListCnt-loopTagStatus.index}
		<td>${emp.emp_no}
		<td>${emp.emp_name}
		<td>${emp.jikup}
	</c:forEach>
</table>