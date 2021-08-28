package com.camping.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDAO {  // reviewBoard게시판 댓글 처리
						   // CommentDAO2 댓글(수정,삭제)메서드 옮겨적기
	
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
///////////////////////////////////////// 	게시글 저장해 주는 메서드
	
	public void insertComment(CommentBean cb){
			int cno = 0;
		try {
			con = getCon();
		// 댓글 데이터 디비에 저장하기 전에 댓글 번호부터 작업
			SQL = "select max(comment_no) from board_comment";
			pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cno = rs.getInt(1)+1;
			}
			System.out.println("commentDAO : 댓글 번호 : " +cno);
			
			SQL = "insert into board_comment values(?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, cno);
			pstmt.setString(2, cb.getMember_id());
			pstmt.setString(3, cb.getComment_content());
			pstmt.setInt(4, cno); // 댓글(원글) 번호랑 같아야 함
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, cb.getNum());
			pstmt.executeUpdate();
			
			System.out.println("====commentDAO:댓글 디비에 저장 완료!=====");
		} catch (Exception e) {
			System.out.println("====commentDAO:댓글 디비에 저장 실패 이유>>"+e.getMessage());
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}
//////////////////////////////////////////////// 디비에 저장된 댓글 꺼내주는 메서드
	
	public ArrayList getCommentList(){
		
		ArrayList commentList = new ArrayList();
		
		try {
			con = getCon();
			
			SQL = "select * from board_comment"
					+ " order by re_ref "
					+ " limit 0,5";
			pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				CommentBean cb = new CommentBean();
				
				cb.setComment_no(rs.getInt("comment_no"));
				cb.setMember_id(rs.getString("member_id"));
				cb.setComment_content(rs.getString("comment_content"));
				cb.setRe_ref(rs.getInt("re_ref"));
				cb.setRe_lev(rs.getInt("re_lev"));
				cb.setRe_seq(rs.getInt("re_seq"));
				cb.setDate(rs.getDate("date"));
				cb.setNum(rs.getInt("num"));
				
				commentList.add(cb);
				System.out.println("commentDAO:디비 -> 자바빈 댓글 데이터 담기 완료!!---");
			}
			
		} catch (Exception e) {
			System.out.println("commentDAO:디비 -> 자바빈 댓글 데이터 담기 실패.,ㅜㅜㅜㅜ>>"+e.getMessage());
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return commentList;
	}
	
/////////////////////////////////////////// 디비에 저장된 댓글 갯수 세어주는 메서드
	
	public int getCommentCount(int num){
		int cnt = 0;
		try {
			con = getCon();
			
			SQL = "select count(*) from board_comment"
					+ " where num = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt("count(*)");
			}
			System.out.println("commentDAO 글 개수 : "+cnt);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return cnt;
	}
}
