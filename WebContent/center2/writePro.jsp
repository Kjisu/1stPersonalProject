<%@page import="com.camping.board.ReviewBoardDAO"%>
<%@page import="com.camping.board.BoardDAO"%>
<%@page import="com.camping.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%// 0. 한글처리
			request.setCharacterEncoding("UTF-8");
	  // 1. 폼 페이지에서 받아온 정보 저장하기 (자바빈 객체에 한 번에 저장)
			
	%>
		<jsp:useBean id="bb" class="com.camping.board.BoardBean"/>
		<jsp:setProperty property="*" name="bb"/>
		
	<%
	  // ip정보 저장
	  	 bb.setIp(request.getRemoteAddr());
	  // 잘 저장되었는지 확인.
		System.out.println(bb);
	
	  // 디비에 글 정보 저장하기  (리뷰게시판)
	  	BoardDAO rbdao = new BoardDAO();
		rbdao.insertBoard(bb);
	 
	 	System.out.println("writePro:db에 '공지사항' 저장 완료");
		response.sendRedirect("boardList.jsp");
	%>

</body>
</html>