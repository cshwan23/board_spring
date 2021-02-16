package com.naver.erp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
// [DAO 클래스]인 [BoardDAOImpl 클래스] 선언
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
	// @Repository 를 붙임으로써 [DAO 클래스]임을 지정하게되고, bean 태그로 자동 등록된다.
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+
@Repository
public class BoardDAOImpl implements BoardDAO{
	//****************************************************
	// 속변 sqlSession 선언하고, [SqlSessionTemplate 객체]를 생성해 저장
	//****************************************************
		// @Autowired 역할 -> 속성변수에 붙은 자료형이 [인터페이스]면 이를 구현한 [클래스]를 객체화하여 저장한다.
		// @Autowired 역할 -> 속성변수에 붙은 자료형이 [클래스]면 이를 객체화하여 저장한다.
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	//****************************************************
	// [1개 게시판 글 출력번호 1 증가하고 수정 행의 개수] 리턴하는 메소드 선언
	//****************************************************
	public int updatePrintNo(BoardDTO boardDTO) {
		System.out.println( "BoardDAOImpl.updatePrintNo 메소드 진입성공!" );
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 udpate(~,~) 를 호출하여
		// [게시판 글 출력번호 1 증가하고 수정 행의 개수] 얻기
		//-------------------------------------------------------
		int updatePrintNoCnt = sqlSession.update(
					"com.naver.erp.BoardDAO.updatePrintNo"		// 실행할 SQL 구문의 위치 지정
					,boardDTO									// 실행할 SQL 구문에서 사용할 데이터 지정
		);
		System.out.println( "BoardDAOImpl.updatePrintNo 메소드 실행 성공" );

		//-------------------------------------------------------
		// [수정 행의 개수] 리턴하기
		//-------------------------------------------------------
		return updatePrintNoCnt;
	}
	//****************************************************
	// [게시판 글 입력 후 입력 적용 행의 개수]를 리턴하는 메소드 선언
	//****************************************************
	public int insertBoard(BoardDTO boardDTO) {

		System.out.println( "BoardDAOImpl.insertBoard 안으로 들어옴" );

		System.out.println( "boardDTO.getB_no() => " + boardDTO.getB_no() );

		//--------------------------------
		// SqlSessionTemplate 객체의 insert 메소드 호출로 
		// 게시판 글 입력 SQL 구문을 실행하고 입력 성공 행의 개수얻기
		//--------------------------------
		//**************************************
		// insert( "com.naver.erp.BoardDAO.insertBoard" , boardDTO ); 의미
		//**************************************
			// mybatis SQL 구문 설정 XML 파일 에서
			// <mapper namespace="com.naver.erp.BoardDAO"> 태그 내부의
			// <insert id="insertBoard" ~> 태그 내부의
			// [insert 쿼리문]을 실행하고 입려 성공행의 개수를 얻기
		int boardRegCnt = sqlSession.insert(
					"com.naver.erp.BoardDAO.insertBoard"	// 실행할 SQL 구문의 위치 지정
					,boardDTO								// 실행할 SQL 구문에서 사용할 데이터 지정
		);
		System.out.println( "BoardDAOImpl.insertBoard 실행 성공" );


		return boardRegCnt;
	}















	//****************************************************
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	//****************************************************
	public List<Map<String,String>> getBoardList(BoardSearchDTO boardSearchDTO ){
		List<Map<String,String>> boardList = this.sqlSession.selectList(
				"com.naver.erp.BoardDAO.getBoardList"	// 실행할 SQL 구문의 위치 지정
				,boardSearchDTO
		);
		return boardList;
	}

	//****************************************************
	// [1개 게시판 글 정보] 리턴하는 메소드 선언
	//****************************************************
	public BoardDTO getBoard(int b_no) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [1개 게시판 글 정보] 얻기
		//-------------------------------------------------------
		BoardDTO board = this.sqlSession.selectOne(
				"com.naver.erp.BoardDAO.getBoard"	// 실행할 SQL 구문의 위치 지정
				,b_no								// 실행할 SQL 구문에서 사용할 데이터 지정
		);
		//-------------------------------------------------------
		// [1개 게시판 글 정보] 리턴하기
		//-------------------------------------------------------
		return board;
	}

	//****************************************************
	// [게시판 글 조회수 증가하고 수정행의 개수] 리턴하는 메소드 선언
	//****************************************************
	public int updateReadcount(int b_no) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 [조회수 증가]하기
		//-------------------------------------------------------
		int updateCnt = this.sqlSession.update(
				"com.naver.erp.BoardDAO.updateReadcount"// 실행할 SQL 구문의 위치 지정
				,b_no									// 실행할 SQL 구문에서 사용할 데이터 지정
		);
		return updateCnt;
	}


	//****************************************************
	// 삭제/수정할 게시판의 존재 개수를 리턴하는 메소드 선언
	//****************************************************
	public int getBoardCnt(BoardDTO board) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [게시판의 존재 개수] 얻기
		//-------------------------------------------------------
		int boardCnt = this.sqlSession.selectOne(
				"com.naver.erp.BoardDAO.getBoardCnt" // 실행할 SQL 구문의 위치 지정
				,board							     // 실행할 SQL 구문에서 사용할 데이터 지정
		);
		return boardCnt;
	}
	//****************************************************
	// 삭제할 게시판의 비밀번호 존재 개수를 리턴하는 메소드 선언
	//****************************************************
	public int getPwdCnt(BoardDTO board) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [비밀번호 존재 개수] 얻기
		//-------------------------------------------------------
		int pwdCnt = this.sqlSession.selectOne(
				"com.naver.erp.BoardDAO.getPwdCnt" // 실행할 SQL 구문의 위치 지정
				,board							  // 실행할 SQL 구문에서 사용할 데이터 지정
		);
		return pwdCnt;
	}
	//****************************************************
	// 게시판 수정 후 수정행의 적용 개수를 리턴하는 메소드선언
	//****************************************************
	public int updateBoard(BoardDTO board) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 [게시판 수정]하기
		//-------------------------------------------------------
		int updateCnt = this.sqlSession.update(
				"com.naver.erp.BoardDAO.updateBoard" // 실행할 SQL 구문의 위치 지정
				,board							     // 실행할 SQL 구문에서 사용할 데이터 지정
		);
		return updateCnt;
	}





	//****************************************************
	// 삭제할 게시판의 자식글 존재 개수를 리턴하는 메소드 선언
	//****************************************************
	public int getChildrenCnt(BoardDTO board) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 selectOne(~,~) 를 호출하여 [자식글 존재 개수] 얻기
		//-------------------------------------------------------
		int  childrenCnt = this.sqlSession.selectOne(
				"com.naver.erp.BoardDAO.getChildrenCnt" // 실행할 SQL 구문의 위치 지정
				,board							        // 실행할 SQL 구문에서 사용할 데이터 지정
		);
		return childrenCnt;
	}
	//****************************************************
	// 삭제될 게시판 이후 글의 출력 순서번호를 1씩 감소 시킨 후 수정 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	public int downPrintNo(BoardDTO board) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 
		// [삭제될 게시판 이후 글의 출력 순서번호를 1씩 감소]하고 감소된 행의 개수 얻기
		//-------------------------------------------------------
		int downPrintNoCnt = this.sqlSession.update(
				"com.naver.erp.BoardDAO.downPrintNo" 	// 실행할 SQL 구문의 위치 지정
				,board							 // 실행할 SQL 구문에서 사용할 데이터 지정
		);
		return downPrintNoCnt;
	}
	//****************************************************
	// 게시판 삭제 명령한 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	//****************************************************
	public int deleteBoard(BoardDTO board) {
		//-------------------------------------------------------
		// [SqlSessionTemplate 객체]의 delete(~,~) 를 호출하여 
		// [게시판 삭제 명령]한 후 삭제 적용행의 개수얻기
		//-------------------------------------------------------
		int deleteBoardCnt = this.sqlSession.delete(
				"com.naver.erp.BoardDAO.deleteBoard" // 실행할 SQL 구문의 위치 지정
				,board							 // 실행할 SQL 구문에서 사용할 데이터 지정
		);
		return deleteBoardCnt;
	}

	//****************************************************
	// [검색한 게시판 목록 개수 ] 리턴하는 메소드 선언
	//****************************************************
	public int getBoardListAllCnt(BoardSearchDTO boardSearchDTO ) {
		int boardListAllCnt = this.sqlSession.selectOne(
				"com.naver.erp.BoardDAO.getBoardListAllCnt" // 실행할 SQL 구문의 위치 지정
				, boardSearchDTO
		);
		return boardListAllCnt;
	}
}