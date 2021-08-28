package com.camping.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	
	// 메서드 작업에 필요한 변수들 선언
	Connection con = null;
	String SQL = "";
	PreparedStatement pstmt =null;
	ResultSet rs = null;
	
///////////////////////////////////////////이클립스 - mySQL디비 연결 해주는 메서드
	
	private Connection getCon() throws Exception{
		
		// 커녁션 풀 사용하여 디비에 연결
		
		Context initCTX = new InitialContext();
		DataSource sc = (DataSource)initCTX.lookup("java:comp/env/jdbc/romanceCamping");
		con = sc.getConnection();
		return con;
		
	}
/////////////////////////////////////////// 디비 연결 자원 쓰고 해체하는 메서드
	
	private void closeDB(){
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
/////////////////////////////////////////////// 사용자가 작성한 게시글 디비에 저장해주는 메서드
	
	public void insertBoard(BoardBean bb){
		int bno = 0;
		
		try {
		// 이 메서드가 호출되는 순간 디비에 연결되어야 하니까
			con = getCon();
		// 디비에 데이터 넘겨주기 전에 게시글 번호부터 손보자.
			SQL = "select max(num) from camping_board";
			pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bno = rs.getInt(1)+1;
			}
			System.out.println("(게시판DAO) 게시글 번호 :"+bno);
			
			SQL = "insert into camping_board (num,writer,pass,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,date,ip,file) "
					+ "values(?,?,?,?,?,?,?,?,?,now(),?,?)";
			
		 // 쿼리 구문 적을 때마다, 이 쿼리 구문을 전송할 객체 생성해 줘야 함@!!!!
			pstmt = con.prepareStatement(SQL); 
		 // ?  순서대로 데이터 넣어주기
			pstmt.setInt(1, bno);
			pstmt.setString(2, bb.getWriter());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0);
			pstmt.setInt(7, bno);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			pstmt.setString(10, bb.getIp());
			pstmt.setString(11, bb.getFile());
			
			pstmt.executeUpdate();
			
			System.out.println("( 게시판 DAO ) 디비에 글 저장 완료!");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}
//////////////////////////////////////////////////디비에 게시글이 몇개 있는지 세어주는 메서드 (int 값 반환)
	
	public int getBoardCount(){
		int cnt = 0;
		try {
			con = getCon();
			
			SQL = "select count(*) from camping_board";
			pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt("count(*)");
			}
			System.out.println("DAO 글 개수 : "+cnt);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return cnt;
	}
//////////////////////////////////////////////////// camping_board 테이블에 저장되어 있는 게시글 데이터 꺼내주는 메서드
	
	public ArrayList getBoardList(){
		
		ArrayList boardList = new ArrayList();
		
		try {
			con = getCon();
			
			SQL = "select * from camping_board"
					+ " order by re_ref desc, re_seq asc"
					+ " limit 0,5";
			pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				BoardBean bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
				
				boardList.add(bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return boardList;
	}
////////////////////////////////////////////////////// (오버로딩) getBoardList(String startRow , String pageSize)

	
	public ArrayList getBoardList(int startRow, int pageSize){
		
ArrayList boardList = new ArrayList();
		
		try {
			con = getCon();
			
			SQL = "select * from camping_board"
					+ " order by re_ref desc, re_seq asc"
					+ " limit ?,?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				BoardBean bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
				
				boardList.add(bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return boardList;
	}
//////////////////////////////////////////// 글 불러오기 전 조회수 증가 시키는 메서드
	
	public void updateReadNumber(int num){
		try {
			con = getCon();
			
			SQL = "update camping_board set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			System.out.println("dao : 조회수 1 증가함!");
			
		} catch (Exception e) {
			System.out.println("dao : 조회수 1 증가 실패! 이유 =>"+e.getMessage());
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}
//////////////////////////////////////// 디비에서 특정 게시글 꺼내오기
	
	public BoardBean getBoard(int num){
		
		BoardBean bb = null;
		
		try {
			con = getCon();
			
			SQL = "select * from camping_board where num=?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			System.out.println("dao : 디비->자바빈에 데이터 넣기 실패@@");
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return bb;
	}
////////////////////////////////////////// 특정 글의 내용 수정한 내용 디비에 넣어주는 메서드
	
	public int updateContent(BoardBean bb){
		int result = -1; // -1은 보통 에러를 의미함.
		try {
			con=getCon();
			
		// 글쓴이가 입력한 비밀번호와 디비에 존재하는 글의 비밀번호가 일치하는지 체크
			SQL = "select pass from camping_board where num=?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, bb.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(bb.getPass().equals(rs.getString("pass"))){
					
				// 일치하다면 업데이트 시키자.
					SQL = "update camping_board set subject=?,content=? where num=?";
					pstmt = con.prepareStatement(SQL);
					pstmt.setString(1, bb.getSubject());
					pstmt.setString(2, bb.getContent());
					pstmt.setInt(3, bb.getNum());
					result=pstmt.executeUpdate();
					// result = 1;
					
					System.out.println("공지사항dao : 쿼리 구문 실행 완료로******");
				}else{ // 비번은 있는데 일치하지 않은 거니까..
					result = 0;
				}
			}else{ // 존재하지 않는 게시글임.
				result = -1;
			}
		} catch (Exception e) {
			System.out.println("공지사항dao 쿼리 구문 실행 실패____"+e.getMessage());
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return result;
	}
//////////////////////////////////////// 특정 글 삭제하는 메서드
	
	public int deleteBoard(BoardBean bb){
		int result = -1;
		
		
		try {
			con = getCon();
		// 본인이 작성하 글이 맞는지 확인 
			SQL = "select pass from camping_board where num=?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, bb.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(bb.getPass().equals(rs.getString("pass"))){
				// 본인 글이 맞으니까 삭제 작업시작
					SQL = "delete from camping_board where num=?";
					pstmt = con.prepareStatement(SQL);
					pstmt.setInt(1, bb.getNum());
					result = pstmt.executeUpdate(); // 쿼리가 적용된 줄 수를 리턴
				}else{
					result = 0;
				}
			}else{ // 게시글 엄슴
				result = -1;
			}
		} catch (Exception e) {
			System.out.println("공지사항dao: deleteBoard()메서드에서 쿼리 구문 실행 실패---이유>>"+e.getMessage());
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return result;
	}

////////////////////////////////////////// db에 답글 넣기
	
	public void insertReBoard(BoardBean bb){
		int newNum = 0;
		try {
			con = getCon();
	// 1. 게시글 번호(num) 계싼
			SQL = "select max(num) from camping_board";
			pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ // 게시글 1 증가 시키기
				newNum = rs.getInt("max(num)")+1;
				System.out.println("공지사항dao : 답글의 글 번호 =>"+newNum);
			}
			
	// 2. 답글 순서(re_sef) 재배치 하기(원하는 순서로 보이기 위함)
	// re_ref 값이 같은 그룹 중, re_seq 기존의 값보다 큰 값이 있을 때 1증가 시키기 (조건문)
			SQL = "update camping_board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			pstmt.executeUpdate();
			
			System.out.println("답글 순서 재배치 완료!!");
	
	// 3. 답글 데이터 db에 넣기
			SQL = "insert into camping_board values(?,?,?,?,?,?,?,?,?,now(),?,?);";
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, newNum);
			pstmt.setString(2, bb.getWriter());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0); // 첫 글이니까 조회수는 0으로 초기화!
			pstmt.setInt(7, bb.getRe_ref()); // 원글과 같은 re_ref 사용
			pstmt.setInt(8, bb.getRe_lev()+1); 
			pstmt.setInt(9, bb.getRe_seq()+1);
			pstmt.setString(10, bb.getIp());
			pstmt.setString(11, bb.getFile());
			pstmt.executeUpdate();
			
			System.out.println("공지사항dao:db에 답글 저장 완료---");
		} catch (Exception e) {
			System.out.println("공지사항dao: insertReBoard()메서드 중 쿼리 구문 실행 실패 이유>>>"+e.getMessage());
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
	}

////////////////////////////////////////// 내가 쓴 글만 가져오기
	
	public ArrayList getmyBoardList(int startRow, int pageSize,String member_id){
		
		ArrayList boardList = new ArrayList();
		
		try {
			con = getCon();
			
			SQL = "select * from camping_board b"
					+ " INNER JOIN camping_review r"
					+ " ON b.writer = r.writer"
					+ " INNER JOIN camping_deal d"
					+ " ON r.writer = d.writer"
					+ " where writer=?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				BoardBean bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setDate(rs.getDate("date"));
				bb.setIp(rs.getString("ip"));
				bb.setFile(rs.getString("file"));
				
				boardList.add(bb);
			}
		} catch (Exception e) {
			System.out.println("쿼리 구문 내가 쓴글 씰패");
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return boardList;
	}
}	
	
	