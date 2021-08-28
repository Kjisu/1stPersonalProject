<%@page import="com.camping.comment.CommentDAO2"%>
<%@page import="com.camping.comment.CommentDAO"%>
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
		// form태그로 넘어온 데이터 저장(게시글 번호에 fit되는 댓글 번호)
		// db까지 가려면 String으로 넘어온 데이터 int로 바꾸기
			int num = Integer.parseInt(request.getParameter("num"));// 글 번호(글번호에fk)
			int comment_no = Integer.parseInt(request.getParameter("commentNum")); // 댓글 번호
			
			new CommentDAO2().deleteComment(comment_no, num);
			response.sendRedirect("dealContent.jsp?num="+num);
		
	%>

</body>
</html>