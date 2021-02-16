package com.naver.erp;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// [서비스 클래스]인 [LoginServiceImpl 클래스] 선언
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// [서비스 클래스]에는 @Service 와 @Transactional 를 붙인다.
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// @Service			=> [서비스 클래스] 임을 지정하고 bean 태그로 자동 등록된다.
	// @Transactional	=> [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
@Service
@Transactional
public class BoardServiceImpl implements BoardService{
	
	//****************************************************
	// 속성변수 boardDAO 선언하고, [BoardDAO 인터페이스]를 구현한 클래스를 객체화해서 저장한다.
	//****************************************************
		// @Autowired 역할 -> 속성변수에 붙은 자료형인 [인터페이스]를 구현한 [클래스]를 객체화하여 저장한다.
	//****************************************************
	@Autowired
	private BoardDAO boardDAO;



	//****************************************************
	// [1개 게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	//****************************************************
	public int insertBoard( BoardDTO boardDTO ) {
		System.out.println( "BoardServiceImpl.insertBoard 진입 성공" );
		//------------------------------------------
		//  엄마글의 글 번호 얻기
		//------------------------------------------
		int b_no = boardDTO.getB_no();
		//------------------------------------------
		//  만약 엄마글의 글 번호가 1 이상이면 댓글쓰기 이므로
		//  엄마 글 이후의 게시판 글에 대해 출력순서번호를 1 증가 시키기.
		//------------------------------------------
		if( b_no>0 ){
			//------------------------------------------
			// [BoardDAO 인터페이스]를 구현한 객체(=BoardDAOImpl)의 
			// updatePrintNo 메소드를 호출하여 출력 순서 번호를 1증가시키고 
			// 수행정에 적용 개수를 리턴받는다
			// 게시판 글이 입력되는 부분 이후 글들은 출력 순서번호를 1씩 증가하여야한다.
			// 게시판 테이블 분석 요망. 오늘 집에 가서 게시판 테이블 분석할 꼬야....
			//------------------------------------------
			int updatePrintNoCnt = this.boardDAO.updatePrintNo(boardDTO);
			System.out.println( "BoardServiceImpl.insertBoard 실행 성공1" );
		}
		//------------------------------------------
		// BoardDAOImpl 객체의  insertBoard 메소드 호출하여 게시판 글 입력 후 입력 적용 행의 개수 얻기
		//------------------------------------------
		int boardRegCnt = this.boardDAO.insertBoard(boardDTO);
		System.out.println( "BoardServiceImpl.insertBoard 실행 성공2" );
		//------------------------------------------
		// 1개 게시판 글 입력 적용 행의 개수 리턴하기
		//------------------------------------------
		return boardRegCnt;
	}










	//****************************************************
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	//****************************************************
	public List<Map<String,String>> getBoardList( BoardSearchDTO boardSearchDTO ){

		List<Map<String,String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);
		return boardList;
	}
	//****************************************************
	// [검색한 게시판 목록 개수 ] 리턴하는 메소드 선언
	//****************************************************
	public int getBoardListAllCnt(BoardSearchDTO boardSearchDTO) {
		//------------------------------------------
		// [BoardDAOImpl] 객체의 getBoardListAllCnt 메소드를 호출하여
		// [검색한 게시판 목록 개수]을 얻는다.
		//------------------------------------------
		int boardListAllCnt = this.boardDAO.getBoardListAllCnt(boardSearchDTO);
		//------------------------------------------
		// [검색한 게시판 목록 개수]을 리턴한다
		//------------------------------------------
		return boardListAllCnt;
	}













	//****************************************************
	// [1개 게시판 글] 리턴하는 메소드 선언
	//****************************************************
	public BoardDTO getBoard(int b_no) {
		/*
		//------------------------------------------
		// [BoardDAO 인터페이스]를 구현한 객체(=BoardDAOImpl)의 getBoard 메소드를 호출하여
		// [1개 게시판 글]을 얻는다
		//------------------------------------------
		BoardDTO board = this.boardDAO.getBoard(b_no);

		//------------------------------------------
		// [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여
		// [조회수 증가]하고 수정한 행의 개수를 얻는다
		//------------------------------------------
		if( board!=null ){
			int readcount = this.boardDAO.updateReadcount(b_no);
			board.setReadcount(board.getReadcount()+1);
		}
		*/

		//------------------------------------------
		// [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여
		// [조회수 증가]하고 수정한 행의 개수를 얻는다
		//------------------------------------------
		int updateCnt = this.boardDAO.updateReadcount(b_no);
		//------------------------------------------
		// 만약 수정 적용 행의 개수가 1이면
		// [BoardDAO 인터페이스]를 구현한 객체(=BoardDAOImpl)의 getBoard 메소드를 호출하여
		// [1개 게시판 글]을 얻는다
		//------------------------------------------
		BoardDTO board = null;
		if( updateCnt==1 ){
			board = this.boardDAO.getBoard(b_no);
		}
		//------------------------------------------
		// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
		//------------------------------------------
		return board;
	}

	
	//****************************************************
	// 조회수 증가 없이 [1개 게시판 글] 리턴하는 메소드 선언
	//****************************************************
	public BoardDTO getBoard_without_updateReadCnt(int b_no) {
		//------------------------------------------
		// [BoardDAO 인터페이스]를 구현한 객체의 getBoard메소드를 호출하여
		// 조회수 증거 없이 [1개 게시판 글]을 얻는다
		//------------------------------------------
		BoardDTO boardDTO = this.boardDAO.getBoard(b_no);
		//------------------------------------------
		// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
		//------------------------------------------
		return boardDTO;
	}

	//****************************************************
	// [1개 게시판] 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	public int updateBoard(BoardDTO boardDTO) {
		//------------------------------------------
		// [BoardDAOImpl 객체]의 getBoardCnt메소드를 호출하여
		// 수정할 게시판의 존재 개수를 얻는다
		//------------------------------------------ 
		int boardCnt = this.boardDAO.getBoardCnt(boardDTO);
		if(boardCnt==0) {return -1;}
		//------------------------------------------
		// [BoardDAOImpl 객체]의 getPwdCnt메소드를 호출하여
		// 수정할 게시판의 비밀번호 존재 개수를 얻는다
		//------------------------------------------
		int pwdCnt = this.boardDAO.getPwdCnt(boardDTO);
		if(pwdCnt==0) {return -2;}
		//------------------------------------------
		// [BoardDAOImpl 객체]의 updateBoard메소드를 호출하여
		// 게시판 수정 명령한 후 수정 적용행의 개수를 얻는다
		//------------------------------------------
		int updateCnt = this.boardDAO.updateBoard(boardDTO);
		//------------------------------------------
		// 게시판 수정 명령한 후 수정 적용행의 개수를 리턴하기
		//------------------------------------------	
		return updateCnt;
	}

	
	//****************************************************
	// [1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	public int deleteBoard(BoardDTO boardDTO) {
		//------------------------------------------
		// [BoardDAOImpl 객체]의 getBoardCnt메소드를 호출하여
		// 수정할 게시판의 존재 개수를 얻는다
		//------------------------------------------ 
		int boardCnt = this.boardDAO.getBoardCnt(boardDTO);
		if(boardCnt==0) {return -1;}
		//------------------------------------------
		// [BoardDAOImpl 객체]의 getPwdCnt메소드를 호출하여
		// 수정할 게시판의 비밀번호 존재 개수를 얻는다
		//------------------------------------------
		int pwdCnt = this.boardDAO.getPwdCnt(boardDTO);
		if(pwdCnt==0) {return -2;}
		//------------------------------------------
		// [BoardDAOImpl 객체]의 getChildrenCnt메소드를 호출하여
		// [삭제할 게시판의 자식글 존재 개수]를 얻는다
		//------------------------------------------
		int childrenCnt = this.boardDAO.getChildrenCnt(boardDTO);
		if(childrenCnt>0) {return -3;}
		//------------------------------------------
		// [BoardDAOImpl 객체]의  downPrintNo메소드를 호출하여
		// [삭제될 게시판 이후 글의 출력 순서번호를 1씩 감소 시킨 후 수정 적용행의 개수]를 얻는다
		//------------------------------------------
		int downPrintNoCnt = this.boardDAO.downPrintNo(boardDTO);
		//------------------------------------------
		// [BoardDAOImpl 객체]의  deleteBoard메소드를 호출하여
		// [게시판 삭제 명령한 후 삭제 적용행의 개수]를 얻는다.
		//------------------------------------------
		int deleteCnt = this.boardDAO.deleteBoard(boardDTO);

		return deleteCnt;
	}
}
