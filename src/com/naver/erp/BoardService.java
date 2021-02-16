package com.naver.erp;

import java.util.*;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
//[BoardService 인터페이스] 선언
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
public interface BoardService {
	//****************************************************
	// [게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	//****************************************************
	int insertBoard(BoardDTO boardDTO);

	//****************************************************
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	//****************************************************
	List<Map<String,String>> getBoardList(BoardSearchDTO boardSearchDTO);

	//****************************************************
	// [1개 게시판 글] 리턴하는 메소드 선언
	//****************************************************
	BoardDTO getBoard(int b_no);

	//****************************************************
	// 조회수 증가 없이 [1개 게시판 글] 리턴하는 메소드 선언
	//****************************************************
	BoardDTO getBoard_without_updateReadCnt(int b_no);

	//****************************************************
	// [1개 게시판] 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	int updateBoard(BoardDTO boardDTO);

	//****************************************************
	// [1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	int deleteBoard(BoardDTO boardDTO);

	
	//*******************************************
	//  [게시판의 총 개수] 를 얻는 메소드 선언
	//*******************************************
	int  getBoardListAllCnt(BoardSearchDTO boardSearchDTO);
}

