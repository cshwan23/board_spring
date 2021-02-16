package com.naver.erp;

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// 게시판 검색 조건을 저장하는 [BoardSearchDTO 클래스] 선언
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
public class BoardSearchDTO {
	//*******************************************
	// 속성변수 선언
	//*******************************************
	//--------------------
	// 검색 키워드 저장하는 속성변수 선언
	//--------------------
	private String keyword1;
	//--------------------
	// 현재 선택된 페이지 번호를 저장하는 속성변수 선언
	// 속성변수 selectPageN 는 select 구문으로 DB 연동시 가져올 행의 범위에 사용되는
	// 중요한 데이터이므로 반드시 기본값으로 1을 기본적으로 세팅한다.
	//--------------------
	private int selectPageNo=1;
	//--------------------
	// 한 화면에 보여줄 행의 개수를 저장하는 속성변수 선언
	// 속성변수 rowCntPerPage는 select 구문으로 DB 연동시 가져올 행의 범위에 사용되는
	// 중요한 데이터이므로 반드시 본값으로 15을 기본적으로 세팅한다.
	//--------------------
	private int rowCntPerPage=10;

	//--------------------
	// 오늘을 저장하는 속성변수 선언
	//--------------------
	private String[] date;
			
	//--------------------
	// 조회수 정렬 기준을 저장하는 속성변수 선언
	//--------------------
	private String orderby;

	//-------------------------
	public String getKeyword1() {
		return keyword1;
	}

	public void setKeyword1(String keyword1) {
		this.keyword1 = keyword1;
	}

	public int getSelectPageNo() {
		return selectPageNo;
	}

	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}

	public int getRowCntPerPage() {
		return rowCntPerPage;
	}

	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}

	public String[] getDate() {
		return date;
	}

	public void setDate(String[] date) {
		this.date = date;
	}

	public String getOrderby() {
		return orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}
	

	
	
	
}
