<%@page import="com.camping.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		// 이전 페이지에서 넘어온 데이터들(url주소를 통해 파라미터로 넘어온&form태그의 post방식으로 넘어온) 저장하기
		// 1. get방식로 넘어온(파라미터) 데이터 저장 ->글 수정 후 , 이동시킬 때 필요
		String pageNum = request.getParameter("pageNum");
		// 2. form태그를 통해 넘어온 정보 저장. => 자바빈 객체 이용
	%>
		<jsp:useBean id="bb" class="com.camping.board.BoardBean"/>
		<jsp:setProperty property="*" name="bb"/>
		<%System.out.println(""); %>
	<%
		// 3. 저장 후 파라미터를 통해 수정된 정보가 들어있는 자바빈 객체 넘기기
		BoardDAO bdao = new BoardDAO();
		bdao.updateContent(bb);
		
		System.out.println("board");
	
	
	%>

</body>
</html>