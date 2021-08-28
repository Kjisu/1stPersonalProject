<%@page import="com.camping.board.ReviewBoardDAO"%>
<%@page import="com.camping.board.dealBoardDAO"%>
<%@page import="com.camping.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>WebContent/center/reWritePro.jsp</h1>
	
	<%	
			String member_id = (String)session.getAttribute("member_id");
	
		// 한글 처리
			request.setCharacterEncoding("UTF-8");
	
		// 주소줄 타고 넘어온(->get방식) 데이터 (pageNum) 저장
			String pageNum = request.getParameter("pageNum");
		
		// form태그를 통해 넘어온 데이터(원글의 num,re_ref,re_lev,re_seq + 답글의 작성자, 제목, 내용) 저장 => 자바빈 객체에 넣기 (액션테그 이용)
	%>
		<jsp:useBean id="bb" class="com.camping.board.BoardBean"/>
		<jsp:setProperty property="*" name="bb"/>
		<%
			bb.setIp(request.getRemoteAddr());
		System.out.println("답글Pro : 답글 데이터, 자바빈 가방에 잘 담겼냐>>>"+bb);%>
		
	<%
		// 답글 디비에 저장해 줄 메서드가 있는 boardDao 객체 생성
		// 메서드 호출
				ReviewBoardDAO rbdao = new ReviewBoardDAO();
				rbdao.insertReBoard(bb);
	
		// 처리 후 페이지 전환
			response.sendRedirect("reviewBoardList.jsp?pageNum="+pageNum);
	%>

</body>
</html>