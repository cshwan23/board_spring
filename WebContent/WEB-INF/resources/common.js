//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//검색화면에서 검색 결과물의 페이징 번호 출력 소스 리턴
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function getPagingNumber(
	totRowCnt               // 검색 결과 총 행 개수
	, selectPageNo_str         // 선택된 현재 페이지 번호
	, rowCntPerPage_str     // 페이지 당 출력행의 개수
	, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
	, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
) {
	//--------------------------------------------------------------
	// name=nowPage을 가진 hidden 태그없으면 경고하고 중지하는 자바스크립트 소스 생성해 저장
	//--------------------------------------------------------------
	if( $('[name=selectPageNo]').length==0 ){
		alert("name=selectPageNo 을 가진 hidden 태그가 있어야 getPagingNumber(~) 함수 호출이 가능함.');" );
		return;
	}
	var arr = [];
	try{
		if( totRowCnt==0 ){	return ""; }
		if( jsCodeAfterClick==null || jsCodeAfterClick.length==0){
			alert("getPagingNumber(~) 함수의 5번째 인자는 존재하는 함수명이 와야 합니다");
			return "";
		}
		//--------------------------------------------------------------
		// 페이징 처리 관련 데이터 얻기
		//--------------------------------------------------------------
		if( selectPageNo_str==null || selectPageNo_str.length==0 ) {
			selectPageNo_str="1";  // 선택한 현재 페이지 번호 저장
		}
		if( rowCntPerPage_str==null || rowCntPerPage_str.length==0 ) {
			rowCntPerPage_str="10";  // 선택한 현재 페이지 번호 저장
		}
		if( pageNoCntPerPage_str==null || pageNoCntPerPage_str.length==0 ) {
			pageNoCntPerPage_str="10";  // 선택한 현재 페이지 번호 저장
		}
		//---
		var selectPageNo = parseInt(selectPageNo_str, 10);
		var rowCntPerPage = parseInt(rowCntPerPage_str,10);
		var pageNoCntPerPage = parseInt(pageNoCntPerPage_str,10);
		if( rowCntPerPage<=0 || pageNoCntPerPage<=0 ) { return; }
		//--------------------------------------------------------------
		//최대 페이지 번호 얻기
		//--------------------------------------------------------------
		var maxPageNo=Math.ceil( totRowCnt/rowCntPerPage );
			if( maxPageNo<selectPageNo ) { selectPageNo = 1; }

		//--------------------------------------------------------------
		// 선택된 페이지번호에 따라 출력할 [시작 페이지 번호], [끝 페이지 번호] 얻기
		//--------------------------------------------------------------
		var startPageNo = Math.floor((selectPageNo-1)/pageNoCntPerPage)*pageNoCntPerPage+1;  // 시작 페이지 번호
		var endPageNo = startPageNo+pageNoCntPerPage-1;                                      // 끝 페이지 번호
			if( endPageNo>maxPageNo ) { endPageNo=maxPageNo; }
			/*//--------------------------------------------------------------
			// <참고>위 코딩은 아래 코딩으로 대체 가능
			//--------------------------------------------------------------
			var startPageNo = 1;
			var endPageNo = pageNoCntPerPage;
			while( true ){
				if( selectPageNo <= endPageNo ){ startPageNo = endPageNo - pageNoCntPerPage + 1; break; }
				endPageNo = endPageNo + pageNoCntPerPage;
			}*/

		//---
		var cursor = " style='cursor:pointer' ";
		//arr.push( "<table border=0 cellpadding=3 style='font-size:13'  align=center> <tr>" );
		//--------------------------------------------------------------
		// [처음] [이전] 출력하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		//arr.push( "<td align=right width=110> " );
		if( startPageNo>pageNoCntPerPage ) {
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('1');"
							+jsCodeAfterClick+";\">[처음]</span>" );
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
				+(startPageNo-1)+"');"+jsCodeAfterClick+";\">[이전]</span>   " );
		}
		//--------------------------------------------------------------
		// 페이지 번호 출력하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		//arr.push( "<td align=center>  " );
		for( var i=startPageNo ; i<=endPageNo; ++i ){
			if(i>maxPageNo) {break;}
			if(i==selectPageNo || maxPageNo==1 ) {
				arr.push( "<b>"+i +"</b> " );
			}else{
				arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
							+(i)+"');"+jsCodeAfterClick+";\">["+i+"]</span> " );
			}
		}
		//--------------------------------------------------------------
		// [다음] [마지막] 출력하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		//arr.push( "<td align=left width=110>  " );
		if( endPageNo<maxPageNo ) {
			arr.push( "   <span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
						+(endPageNo+1)+"');"+jsCodeAfterClick+";\">[다음]</span>" );
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
						+(maxPageNo)+"');"+jsCodeAfterClick+";\">[마지막]</span>" );
		}
		//arr.push( "</table>" );
		return arr.join( "" );
	}catch(ex){
		alert("getPagingNumber(~) 메소드 호출 시 예외발생!");
		return "";
	}
}

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function printPagingNumber(
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	totRowCnt               // 검색 결과 총 행 개수
	, selectPageNo_str      // 선택된 현재 페이지 번호
	, rowCntPerPage_str     // 페이지 당 출력행의 개수
	, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
	, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
) {
	document.write(
		getPagingNumber(
			totRowCnt               // 검색 결과 총 행 개수
			, selectPageNo_str      // 선택된 현재 페이지 번호
			, rowCntPerPage_str     // 페이지 당 출력행의 개수
			, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
			, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
		)
	);
}


//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 테이블 색깔 지정 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function setTableBgColor(
			tableClassV		// 테이블 class 속성값 
			,headerColor	// tr 태그 중 헤더부분 배경색 
			,oddBgColor		// tr 태그 중 홀수행 배경색
			,evenBgColor	// tr 태그 중 짝수행 배경색 
			,mouseOnBgColor	// tr 태그 중 마우스 온 시 배경색 
			
){
	try{
		
		var firstTrObj = $("." +tableClassV+" tr:eq(0)");
		
		var trObjs = firstTrObj.sibilings("tr");
		
		firstTrObj.css("background",headerColor);
		
		trObjs.filter(":odd").css("background",evenBgColor);
		
		trObjs.filter(":even").css("background",oddBgColor);
		
		trObjs.hover(
				function(){
					$(this).css("background",mouseOnBgColor);
				},
				function(){
					if( $(this).index()%2==0){
						$(this).css("background",evenBgColor);
					
					}else{
						$(this).css("background",oddBgColor);
					}
				}
		);
	}catch(e){
		alert("setTableTrBgColor(~) 함수 호출 시 에러 발생");
	}

}
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 입력양식이 비어있거나 미체크시 true 리턴 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function isEmpty( jqueryObj ){
	try{
		var flag = true;
		
		if(jqueryObj.is(":checkbox")||jqueryObj.is(":radio")){
			if(jqueryObj.filter(":checked").length>0){flag=false;}
		}else{
			var value=jqueryObj.val();
			if (value==null||value.split(" ").join("")==""){
			}
		}	
		return flag;
		
	}catch(e){
		alert("isEmpty(~) 함수 호출 시 에러 발생!");
		return false;
	}
}
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 비동기 방식으로 서버에 접속하는 함수 선언.
// 파일업로드 또는 비파일업로드 모두 적용 가능한 함수이다.
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function ajax( 
		url_addr			// 서버의 접속 url
		,formName			// 서버로 전송할 파라미터값을 내포한 form 태그 name 값
		,callback_func		// 
 ){
	try{
		var formObj = $("[name="+formName+"]");
		
		if(formObj.length==0){
			alert("ajax 함수 호출 시 2번째 인자에 입력되는 "+formName+"라는 form 태그가 없습니다.");
			return;
		}
			var isFile=formObj.find("[type='file']").length>0;
			//------------------------------------------------
			// JQuery 객체의 ajax 메소드 호출로 비동기 방식으로 서버에 접속하기
			//------------------------------------------------
			$.ajax({
			//------------------------
			// 호출할 서버 쪽 URL 주소 설정
			//------------------------
			url : url_addr
			//------------------------
			// 전송 방법 설정
			//------------------------
			,type : "post"
			//------------------------
			// 전송하는 파라미터명, 파라미터 값을 "파명=파값&~" 형태의 문자열로 변경할 지 여부 설정하기.
			// form 태그 안에 파일업로드 입력양식이 있으면 false 없으면 true 로 설정한다.
			// 서버로 보내는 데이터에 파일이 있으면 문자열로 변경하지 말고 FromData 객체 그대로 보내야한다.
			//------------------------
			,processData : isFile?false:true
			//------------------------
			// "content-type" 라는 헤더명의 헤더값 설정하기.
			// contentType:true 면 헤더값으로 "application/x-www-form-urlencoded" 가 설정된다.
			// contentType:true 면 헤더값으로 "multipart/form-data" 가 설정된다.
			// 파일이 있으므로 "multipart/form-data"로 해야한다. 
			//------------------------
			,contentType:isFile?false:true
			//------------------------
			// 서버로 보내는 데이터 설정하기
			// form 태그 안에 파일업로드 입력양식이 있으면 new FromData 객체 설정하고
			// 없으면 data: "파명=파값&~" 형태 또는 data: {"파명":파값,~}또는 data: $("[name=폼 이름]").serialize()로 설정한다.
			//------------------------
			,data : isFile?(new FormData(formObj.get(0))):(formObj.serialize())
			//------------------------
			// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정
			//------------------------
			,success : callbac_func
			//------------------------
			// 서버의 응답을 못받았을 경우 실행할 익명함수 설정
			//------------------------
			,error : function(){
				alert(url_addr + "접속시 서버 응답 실패! 관리자에게 문의 바람!")
			}
			
		});
	}catch(e){
		alert("ajax 함수 호출 시 에러 발생!"+e.message);
	}
}















