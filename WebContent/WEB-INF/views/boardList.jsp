<!-- ****************************************************** -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ****************************************************** -->
	<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
	<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
	<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ****************************************************** -->
<!-- 현재 JSP 페이지에서 사용할 클래스의 패키지 수입하기 -->
<!-- ****************************************************** -->
<%@ page import="java.util.*"%>

<!-- ****************************************************** -->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 -->
<!--								common.jsp 파일 내의 소스를 삽입하기 -->	
<!-- ****************************************************** -->
<%@include file="common.jsp" %>


<html>
<head><title>게시판 목록</title>
	<script>	

		//**********************************************************
		// body 태그 안의 모든 태그를 읽어들인 후 실행할 자스 코딩 설정
		//**********************************************************
		$(document).ready(function( ){
			
			$('[name=boardContentForm],[name=boardRegForm]').hide();
			//--------------------------------------
			// name="rowCntPerPage" 에 change 이벤트가 발생하면 실행할 코드 설정하기
			//--------------------------------------
			$('[name=rowCntPerPage]').change(function( ){
				search_when_pageNoClick( );
			});


			//--------------------------------------
			// HttpServletRequest 객체가 가진 "boardSearchDTO" 라는 키워드로 저장된 객체의
			// keyword1 란 속성변수 안의 데이터를 EL 로 표현하여 class="keyword1" 가진 입력양식에 삽입하기
			//--------------------------------------
			// $(".keyword1").val("${requestScope.boardSearchDTO.keyword1}");
			inputData( ".keyword1" , "${requestScope.boardSearchDTO.keyword1}" );

			//--------------------------------------
			// HttpServletRequest 객체가 가진 "boardSearchDTO" 라는 키워드로 저장된 객체의
			// date 란 속성변수 안의 데이터를 EL 로 표현하여 class="date" 가진 입력양식에 삽입하기
			//--------------------------------------
			/*
			$("[name=boardContentForm] [name=date]").prop(
				"checked"
				,$("[name=boardListForm] [name=date]").prop("checked")
			)
			*/
			<c:forEach items="${boardSearchDTO.date}" var="date">
				//$("[name=boardListForm] [name=date]").filter("[value=${date}]").prop("checked",true);
				inputData( "[name=boardListForm] [name=date]" , "${date}" );
			</c:forEach>

			//--------------------------------------
			// HttpServletRequest 객체가 가진 "boardSearchDTO" 라는 키워드로 저장된 객체의
			// selectPageNo 란 속성변수 안의 데이터를 EL 로 표현하여 class="selectPageNo" 가진 입력양식에 삽입하기
			//--------------------------------------
			//$(".selectPageNo").val("${requestScope.boardSearchDTO.selectPageNo}");
			inputData( ".selectPageNo" , "${requestScope.boardSearchDTO.selectPageNo}" );
			//--------------------------------------
			// HttpServletRequest 객체가 가진 "boardSearchDTO" 라는 키워드로 저장된 객체의
			// rowCntPerPage 란 속성변수 안의 데이터를 EL 로 표현하여 class="rowCntPerPage" 가진 입력양식에 삽입하기
			//--------------------------------------
			//$(".rowCntPerPage").val("${requestScope.boardSearchDTO.rowCntPerPage}");
			inputData( ".rowCntPerPage" , "${requestScope.boardSearchDTO.rowCntPerPage}" );

			//--------------------------------------
			// HttpServletRequest 객체가 가진 "boardSearchDTO" 라는 키워드로 저장된 객체의
			// orderby 란 속성변수 안의 데이터를 EL 로 표현하여 class="orderby" 가진 입력양식에 삽입하기
			//--------------------------------------
			inputData( ".orderby" , "${requestScope.boardSearchDTO.orderby}" );
			




			//--------------------------------------
			// 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면 
			// class=readCnt 를 가진 태그 내부에 "조회수" 덮어씌우기
			//--------------------------------------
			<c:if test="${empty requestScope.boardSearchDTO.orderby}">
				$(".readCnt").text( "조회수" );
			</c:if>
			//--------------------------------------
			// 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "readcount desc" 저장되어 있으면 
			// class=readCnt 를 가진 태그 내부에 "조회수▼" 덮어씌우기
			//--------------------------------------
			<c:if test="${requestScope.boardSearchDTO.orderby=='readcount desc'}">
				$(".readCnt").text( "조회수▼" );
			</c:if>
			//--------------------------------------
			// 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "readcount asc" 저장되어 있으면 
			// class=readCnt 를 가진 태그 내부에 "조회수▲" 덮어씌우기
			//--------------------------------------
			<c:if test="${requestScope.boardSearchDTO.orderby=='readcount asc'}">
				$(".readCnt").text( "조회수▲" );
			</c:if>










			//--------------------------------------
			// 페이징 처리 관련 HTML 소스를 class=pagingNumber 가진 태그 안에 삽입하기
			//--------------------------------------
			$(".pagingNumber").html(
					getPagingNumber(
						"${requestScope.boardListAllCnt}"      // 검색 결과 총 행 개수
						,"${requestScope.boardSearchDTO.selectPageNo}"        // 선택된 현재 페이지 번호
						,"${requestScope.boardSearchDTO.rowCntPerPage}"       // 페이지 당 출력행의 개수
						,"15"                       // 페이지 당 보여줄 페이지번호 개수
						,"search_when_pageNoClick( );"              // 페이지 번호 클릭 후 실행할 자스코드
					)
			);
			//--------------------------------------
			// 게시판 목록을 보여주는 table 의 헤더행, 짝수행, 홀수행,마우스온 일때  배경색 설정하기
			//--------------------------------------
			setTableTrBgColor(
					"boardTable"             // 테이블 class 값
					, "gray"                 // 헤더 tr 배경색
					, "white"                // 홀수행 배경색                   
					, "lightgray"		     // 짝수행 배경색          
					, "lightblue"            // 마우스 온 시 배경색
			);
			inputBlank_to_tdth( ".boardTable", 3  );

			//--------------------------------------
			// class="readCnt" 에 클릭 이벤트가 발생하면 실행할 코드 설정하기
			//--------------------------------------
			$(".readCnt").click(function(){
					alert("조회수를 클릭하면 조회수 내립차순 또는 오름차순으로 볼수 있습니다. 그러나 댓글 관계는 무력화됩니다.")
					//---------------
					// class="readCnt" 를 가진 태그 안의 문자열 가져오기.
					//---------------
					var txt = $(this).text();
					//---------------
					// 만약 현재 보이는 글씨가 "조회수" 라면
					//---------------
					if( txt=="조회수") {
						// class=orderby 를 가진 태그의 value 값에 "readcount desc" 삽입하기
						$(".orderby").val("readcount desc");
					}
					//---------------
					// 만약 현재 보이는 글씨가 "조회수▼" 라면
					//---------------
					else if( txt=="조회수▼") {
						// class=orderby 를 가진 태그의 value 값에 "readcount asc" 삽입하기
						$(".orderby").val("readcount asc");
					}
					//---------------
					// 만약 현재 보이는 글씨가 "조회수▲" 라면
					//---------------
					else if( txt=="조회수▲") { 
						// class=orderby 를 가진 태그의 value 값에 "" 삽입하기
						$(".orderby").val("");
					}
					//---------------
					// name=boardListForm 가진 ,form 태그의 action 값의 URL 주소로 서버로 접속하라. 
					// 즉 페이지 이동하라
					//---------------
					document.boardListForm.submit();
			});
		});










		//**********************************************
		// [게시판 입력 화면]으로 이동하는 함수 선언
		//**********************************************  
		function goBoardRegForm( ){
			//--------------------------------------------------------------
			// name=boardListForm 를 가진 form 태그 내부의 name=selectPageNo 가진 태그의 value 값을
			// name=boardRegForm 를 가진 form 태그 내부의 name=selectPageNo 가진 태그의 value 값으로 삽입하기
			//--------------------------------------------------------------
			$("[name=boardRegForm] [name=selectPageNo]").val( 
				$("[name=boardListForm] [name=selectPageNo]").val( )
			);
			//---------------------------------
			// 위 코딩은 아래 처럼도 가능하다
			//---------------------------------
			// document.boardRegForm.selectPageNo.value = document.boardListForm.selectPageNo.value;
			//--------------------------------------------------------------
			// name=boardListForm 를 가진 form 태그 내부의 name=rowCntPerPage 가진 태그의 value 값을
			// name=boardRegForm 를 가진 form 태그 내부의 name=rowCntPerPage 가진 태그의 value 값으로 삽입하기
			//--------------------------------------------------------------
			$("[name=boardRegForm] [name=rowCntPerPage]").val( 
				$("[name=boardListForm] [name=rowCntPerPage]").val( )
			);
			//---------------------------------
			// 위 코딩은 아래 처럼도 가능하다
			//---------------------------------
			// document.boardRegForm.rowCntPerPage.value = document.boardListForm.rowCntPerPage.value;

			//--------------------------------------------------------------
			// name=boardListForm 를 가진 form 태그 내부의 name=keyword1 가진 태그의 value 값을
			// name=boardRegForm 를 가진 form 태그 내부의 name=keyword1 가진 태그의 value 값으로 삽입하기
			//--------------------------------------------------------------
			$("[name=boardRegForm] [name=keyword1]").val( 
				$("[name=boardListForm] [name=keyword1]").val( )
			);

			//--------------------------------------------------------------
			// name=boardListForm 를 가진 form 태그 내부의 name=date 가진 태그의 value 값을
			// name=boardRegForm 를 가진 form 태그 내부의 name=date 가진 태그의 value 값으로 삽입하기
			//--------------------------------------------------------------
			/*
			$("[name=boardRegForm] [name=date]").prop(
				"checked"
				,$("[name=boardListForm] [name=date]").prop("checked")
			)
			*/
			$("[name=boardListForm] [name=date]").filter(":checked").each(function(){
				var value = $(this).val();
				$("[name=boardRegForm] [name=date]").filter("[value="+value+"]").prop("checked",true);
			});

			//---------------------------------
			// 위 코딩은 아래 처럼도 가능하다
			//---------------------------------
			// document.boardRegForm.keyword1.value = document.boardListForm.keyword1.value;


			//--------------------------------------------------------------
			// name=boardRegForm 를 가진 form 태그 내부의 action 값의 URL 주소로 서버에 접속하기
			// 이때 form 태그 내부의 입력양식들은 파라미터명, 파리미터값으로 같이 서버로 이동한다.
			//--------------------------------------------------------------
			document.boardRegForm.submit();
		}

		//**********************************************
		// [게시판 상세보기 화면]으로 이동하는 함수 선언
		//**********************************************  
		function goContentForm(b_no){
			//--------------------------------------------------------------
			// name=boardListForm 를 가진 form 태그 내부의 name=selectPageNo 가진 태그의 value 값을
			// name=boardContentForm 를 가진 form 태그 내부의 name=selectPageNo 가진 태그의 value 값으로 삽입하기
			//--------------------------------------------------------------
			$("[name=boardContentForm] [name=selectPageNo]").val( 
				$("[name=boardListForm] [name=selectPageNo]").val( )
			);
			//--------------------------------------------------------------
			// name=boardListForm 를 가진 form 태그 내부의 name=rowCntPerPage 가진 태그의 value 값을
			// name=boardContentForm 를 가진 form 태그 내부의 name=rowCntPerPage 가진 태그의 value 값으로 삽입하기
			//--------------------------------------------------------------
			$("[name=boardContentForm] [name=rowCntPerPage]").val( 
				$("[name=boardListForm] [name=rowCntPerPage]").val( )
			);
			//--------------------------------------------------------------
			// name=boardListForm 를 가진 form 태그 내부의 name=keyword1 가진 태그의 value 값을
			// name=boardContentForm 를 가진 form 태그 내부의 name=keyword1 가진 태그의 value 값으로 삽입하기
			//--------------------------------------------------------------
			$("[name=boardContentForm] [name=keyword1]").val( 
				$("[name=boardListForm] [name=keyword1]").val( )
			);

			//--------------------------------------------------------------
			// name=boardListForm 를 가진 form 태그 내부의 name=date 가진 태그의 value 값을
			// name=boardContentForm 를 가진 form 태그 내부의 name=date 가진 태그의 value 값으로 삽입하기
			//--------------------------------------------------------------
			/*
			$("[name=boardContentForm] [name=date]").prop(
				"checked"
				,$("[name=boardListForm] [name=date]").prop("checked")
			)
			*/
			$("[name=boardListForm] [name=date]").filter(":checked").each(function(){
				var value = $(this).val();
				$("[name=boardContentForm] [name=date]").filter("[value="+value+"]").prop("checked",true);
			});
			

			// ---------------------------------
			// name=boardContentForm 가진 form 태그 내부의 name=b_no 가진 입력 양식에 클릭한 행의 
			// 게시판 번호 저장하기
			// ---------------------------------
			$("[name=boardContentForm] [name=b_no]").val(b_no);
			//$("[name=boardContentForm]").find("[name=b_no]").val(b_no);

			// ---------------------------------
			// name=boardContentForm 가진 form 태그 내부의 action 값의 URL 주소로 서버에 접속하기
			// 즉 상세보기 화면으로 이동하기
			// ---------------------------------
			document.boardContentForm.submit();
		}





		//**********************************************
		// 페이지 번호 클릭하면 호출되는 함수 선언
		//**********************************************
		function search_when_pageNoClick( ){
			// 입력한 키워드 얻기
			var keyword1 = $("[name=keyword1]").val();
			// 입력한 키워드가 비어 있지 않으면
			if( keyword1!=null && keyword1.split(" ").join("")!="" ){
				// 입력한 키워드의 앞뒤 공백 저거하기
				keyword1 = $.trim(keyword1);
				// name=keyword1 가진 입력 양식에 앞뒤 공백 제거한 키워드 넣어주기
				$("[name=keyword1]").val(keyword1);
			}
			// name=boardListForm  를 가진 form 태그 안의 action 값의 URL 주소로 웹서버로 접속하기
			document.boardListForm.submit( );
		}



		//**********************************************
		// [게시판 목록 화면]으로 이동하는 함수 선언
		//**********************************************
		function search( ){
			/*
			//-----------------------------------
			// 만약 키워드가 비어있거나 공백으로 구성되어 있으면 경고하고 비우기
			//-----------------------------------
			var keyword1 = $("[name=keyword1]").val();
			if( keyword1.split(" ").join("")=="" ) {
				alert("키워드가 없어 검색할수 없습니다.");
				$("[name=keyword1]").val("");
				return;
			}
			*/
			if(    isEmpty(  $("[name=keyword1]") ) && isEmpty(  $("[name=date]") )     ){
				alert("검색 조건이 비어 있어  검색할수 없습니다.");
				$("[name=keyword1]").val("");
				return;
			}
			//-----------------------------------
			// 키워드의 앞뒤 공백을 제거하기
			//-----------------------------------
			var keyword1 = $("[name=keyword1]").val();
			keyword1 = $.trim(keyword1);
			$("[name=keyword1]").val(keyword1);

			//-----------------------------------
			// name=boardListForm  을 가진  form 태그의 action 값의 URL로 웹서버에 접속하기
			// 이동 시 form 태그안의 모든 입력 양식이 파라미터값으로 전송된다.
			//-----------------------------------
			document.boardListForm.submit( );
			
			return;

			$.ajax({
				url : "${croot}/boardList.do"
				, type : "post"
				, data : $("[name=boardListForm]").serialize()
				, success : function(html){
					
					alert(   $(html).find(".boardListAllCnt").text()   );

					//$("[name=xxx]").text( html );
				}
				, error : function(){
					alert("서버 접속 실패");
				}
			});

			
		}


		//**********************************************
		// 키워드 없이 [게시판 목록 화면]으로 이동하는 함수 선언
		//**********************************************
		function searchAll( ){
			$("[name=selectPageNo]").val("1");
			//--------------------------
			// 키워드 비우기
			//--------------------------
			$("[name=keyword1]").val("");
			$("[name=date]").prop("checked",false);
			//-----------------------------------
			// name=boardListForm  을 가진  form 태그의 action 값의 URL로 웹서버에 접속하기
			// 이동 시 form 태그안의 모든 입력 양식이 파라미터값으로 전송된다.
			//-----------------------------------
			document.boardListForm.submit( );
		}

	</script>
</head>


<body bgcolor="${requestScope.bodyBgcolor}"><center>

	
    <div style='cursor:pointer;'  onclick="location.replace('${requestScope.croot}/logout.do');">[로그아웃]</div>

	<!--**********************************************************-->
	<!-- [로그인 정보 입력 양식] 내포한 form 태그 선언 -->
	<!--**********************************************************-->
	<form name="boardListForm" method="post" action="${requestScope.croot}/boardList.do">   
		<div>
				<!---------------------------->
				<!--키워드 검색 입력 양식 표현하기-->
				<!---------------------------->
				[키워드] : <input type="text" name="keyword1" class="keyword1">&nbsp;&nbsp;&nbsp;
				           <input type="checkbox" name="date" class="date" value="오늘">오늘
				           <input type="checkbox" name="date" class="date" value="어제">어제
				<!---------------------------->
				<!--선택한 페이지번호가 저장되는 입력양식 표현하기-->
				<!--선택한 페이지번호는 DB 연동시 아주 중요한 역할을 한다.-->
				<!----------------------------> 
				<input type="hidden" name="selectPageNo" class="selectPageNo">  




				<!---------------------------->
				<!-- 조회수 내립차순 또는 오름 차순 정보가 저장되는 입력양식 표현하기-->
				<!----------------------------> 
				<input type="hidden" name="orderby" class="orderby">  



				<!---------------------------->
				<!--한 화면에 보여줄 행의 개수가 저장되는 입력양식 표현하기-->
				<!---------------------------->
				<select name="rowCntPerPage" class="rowCntPerPage">
					<option value="10">10
					<option value="15">15
					<option value="20">20
					<option value="25">25
					<option value="30">30
				</select> 행보기
				<!---------------------------->
				<!--버튼 표현하기-->
				<!---------------------------->
				<input type="button" value="  검색  " class="contactSearch" onClick="search( );">&nbsp;
				<input type="button" value="     모두검색     " class="contactSearchAll" onClick="searchAll( );">&nbsp;
				<a href="javascript:goBoardRegForm( );" >[새글쓰기]</a>
		</div>
		<!------------------------------------->
	</form>


	<!------------------------------------->
	<!------------------------------------->
	<!------------------------------------->
	<table border=0 cellpadding=5>
	<tr><td align=right>
			<!---------------------------->
			<!--게시판 검색 총 개수 출력하기.-->
			<!---------------------------->
			[총 개수] : <span class="boardListAllCnt">${requestScope.boardListAllCnt}</span>
	<tr><td align=center>
		<!--************************************************************-->
		<!---페이징 번호를 삽입할 span 태그 선언하기------>
		<!--************************************************************-->
		<div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div>
		<!--************************************************************ -->
		<!--게시판 목록 출력하기-->
		<!--************************************************************-->
		<table border=1 class="boardTable tbcss2">
		<tr>
			<th>번호<th width=200>제목<th>글쓴이<th>등록일<th> <span class="readCnt" style="cursor:pointer">조회수</span>

			<!------------------------------------------------------------------------------------>
			<c:forEach items="${requestScope.boardList}" var="board" varStatus="loopTagStatus">
				<tr style="cursor:pointer" onClick="goContentForm(${board.b_no});">
					<td align=center>
						<!-- 역순번호 출력-->
						${requestScope.boardListAllCnt-(boardSearchDTO.selectPageNo*boardSearchDTO.rowCntPerPage-boardSearchDTO.rowCntPerPage+1+loopTagStatus.index)+1}
						<!-- 
							정순 번호 출력 시 아래 코드로 대체 할 것
							${boardSearchDTO.selectPageNo*boardSearchDTO.rowCntPerPage-boardSearchDTO.rowCntPerPage+1+loopTagStatus.index} 
						 -->
					<td>
							<!---------------------------->
							<!-- 만약 들여쓰기 레벨번호가 0보다 크면-->
							<!-- 레벨번호 개수 만큼의 &nbsp;&nbsp; 를 삽입하고 마지막에 ㄴ 을 삽입하라-->
							<!---------------------------->
							<c:if test="${board.print_level>0}">
								<c:forEach begin="0" end="${board.print_level}">
									&nbsp;&nbsp;
								</c:forEach>
								ㄴ
							</c:if>
							${board.subject}
					<td align=center>${board.writer}
					<td align=center>${board.reg_date}
					<td align=center>${board.readcount}
			</c:forEach>
		</table>
		
		<!--************************************************************-->
		<!--만약에 게시판 목록이 없을 경우 없다고 출력하기-->
		<!-- HttpServletRequest 객체가 가진 "boardList" 라는 키워드로 저장된 객체(=List<Map<String,String>> 객체)가 null 이거나 -->
		<!-- 길이가 0이면 "검색 조건에 맞는 데이터가 없습니다." 출력하기-->
		<!--************************************************************-->
		<c:if test="${empty requestScope.boardList}">
			<h3>검색 조건에 맞는 데이터가 없습니다.</h3>
		</c:if>
	</table>

	<!------------------------------------->
	<!------------------------------------->
	<!------------------------------------->


		
<%-- 
		<!--************************************************************-->
		<!--만약에 게시판 목록이 없을 경우 없다고 출력하기-->
		<!-- HttpServletRequest 객체가 가진 "boardListAllCnt" 라는 키워드로 저장된 객체가 0 이면-->
		<!-- "검색 조건에 맞는 데이터가 없습니다." 출력하기--> 
		<!--************************************************************-->
		<c:if test="${requestScope.boardListAllCnt==0}">
			<h3>검색 조건에 맞는 데이터가 없습니다.</h3>
		</c:if>

		<!--************************************************************-->
		<!--만약에 게시판 목록이 없을 경우 없다고 출력하기-->
		<!-- HttpServletRequest 객체가 가진 "boardListAllCnt" 라는 키워드로 저장된 객체가 0 이면-->
		<!-- "검색 조건에 맞는 데이터가 없습니다." 출력하기--> 
		<!--************************************************************-->
		${requestScope.boardListAllCnt==0?'<h3>검색 조건에 맞는 데이터가 없습니다.</h3>':''}
 --%>	



	<!--************************************************************-->
	<!--게시판 상세 보기 화면 이동하는 form 태그 선언하기-->
	<!--************************************************************-->
	<form name="boardContentForm" method="post" action="${requestScope.croot}/boardContentForm.do">
		<!-------------------------------------------------------------->
		<!-- [클릭한 게시판 글의 고유번호]가 저장되는 [hidden 입력 양식] 선언.
		<!-------------------------------------------------------------->
		<input type="hidden" name="b_no">
		<input type="hidden" name="selectPageNo">  
		<input type="hidden" name="rowCntPerPage">  
		<input type="hidden" name="keyword1">  
		<input type="checkbox" name="date" value="오늘">  
		<input type="checkbox" name="date" value="어제"> 
	</form>


	<!--************************************************************-->
	<!--게시판 새글쓰기 화면으로 이동하는 form 태그 선언하기-->
	<!--************************************************************-->
	<form name="boardRegForm" method="post" action="${requestScope.croot}/boardRegForm.do">
		<input type="hidden" name="selectPageNo">  
		<input type="hidden" name="rowCntPerPage">  
		<input type="hidden" name="keyword1">  
		<input type="checkbox" name="date" value="오늘">  
		<input type="checkbox" name="date" value="어제">  
	</form>


	<textarea cols=150 rows=500 name=xxx></textarea>


	
</body>
</html>		




<!-- 
--------------------------------------
검색된게시판총개수(=총개수)        => 110
--------------------------------------
선택한페이지번호(=페번)            => 2
--------------------------------------
한화면의보이는행의개수(행개)       => 10
--------------------------------------
현재화면의 첫번째 역순 번호(=역번) => ?
--------------------------------------

-------------------------------------------------------------------------
            정번  페번    역번
-------------------------------------------------------------------------
~ ~ ~ ~ ~ ~ 1행   1페     114       <= 총개수-(페번x행개-행개+1)+1
~ ~ ~ ~ ~ ~ 2행   1페     113       <= 총개수-(페번x행개-행개+2)+1    
~ ~ ~ ~ ~ ~ 3행   1페     112       <= 총개수-(페번x행개-행개+3)+1    
~ ~ ~ ~ ~ ~ 4행   1페     111       <= 총개수-(페번x행개-행개+4)+1    
~ ~ ~ ~ ~ ~ 5행   1페     110       <= 총개수-(페번x행개-행개+5)+1    
~ ~ ~ ~ ~ ~ 6행   1페     109       <= 총개수-(페번x행개-행개+6)+1    
~ ~ ~ ~ ~ ~ 7행   1페     108       <= 총개수-(페번x행개-행개+7)+1    
~ ~ ~ ~ ~ ~ 8행   1페     107       <= 총개수-(페번x행개-행개+8)+1    
~ ~ ~ ~ ~ ~ 9행   1페     106       <= 총개수-(페번x행개-행개+9)+1    
~ ~ ~ ~ ~ ~ 10행  1페     105       <= 총개수-(페번x행개-행개+10)+1    
~ ~ ~ ~ ~ ~ 11행  2페     104       <= 총개수-(페번x행개-행개+11)+1    
~ ~ ~ ~ ~ ~ 12행  2페     103       <= 총개수-(페번x행개-행개+12)+1    
~ ~ ~ ~ ~ ~ 13행  2페     102       <= 총개수-(페번x행개-행개+13)+1    
~ ~ ~ ~ ~ ~ 14행  2페     101       <= 총개수-(페번x행개-행개+14)+1    
~ ~ ~ ~ ~ ~ 15행  2페     100       <= 총개수-(페번x행개-행개+15)+1    
~ ~ ~ ~ ~ ~ 16행  2페     99        <= 총개수-(페번x행개-행개+16)+1    
~ ~ ~ ~ ~ ~ 17행  2페     98        <= 총개수-(페번x행개-행개+17)+1    
~ ~ ~ ~ ~ ~ 18행  2페     97        <= 총개수-(페번x행개-행개+18)+1    
~ ~ ~ ~ ~ ~ 19행  2페     96        <= 총개수-(페번x행개-행개+19)+1    
~ ~ ~ ~ ~ ~ 20행  2페     95        <= 총개수-(페번x행개-행개+20)+1    
.....

~ ~ ~ ~ ~ ~ 114행
-------------------------------------------------------------------------

   select b_no, subject, writer, reg_date, rnum "no_asc", b.cnt-rnum+1 "no_desc" from ( select zxcvb.* , rownum "RNUM" from (


      select * from board order by group_no desc , print_no asc

    ) zxcvb where rownum<=10 ) , (select count(*) "CNT" from board) b  where  rnum>=1  




 -->










