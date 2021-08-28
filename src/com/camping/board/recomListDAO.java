package com.camping.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class recomListDAO {

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
			SQL = "select max(num) from camping_recommend";
			pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bno = rs.getInt(1)+1;
			}
			System.out.println("(게시판DAO) 게시글 번호 :"+bno);
			
			SQL = "insert into camping_recommend (num,writer,pass,subject,content,"
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
			
			SQL = "select count(*) from camping_recommend";
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
	
////////////////////////////////////////////////////camping_board 테이블에 저장되어 있는 게시글 데이터 꺼내주는 메서드
	
		public ArrayList getBoardList(){
		
			ArrayList boardList = new ArrayList();
		
			try {
					con = getCon();
		
				SQL = "select * from camping_recommend"
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
///////////////////////////////////////////// 이미지 파일 이름 list배열 이용하여 디비에서 꺼내 전달
		
		/*public ArrayList getImgList(){
			
			try {
				con = getCon();
				
				SQL = "select file from camping_recommend";
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}*/
}
