<%@page import="com.camping.comment.CommentBean"%>
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
		// 이전 페이지에서 넘어온 데이터 저장
		int num = Integer.parseInt(request.getParameter("num"));
		int comment_no = Integer.parseInt(request.getParameter("comment_no"));
		String comment_content = request.getParameter("comment_content");
		
		CommentBean cb = new CommentBean();
		cb.setComment_no(comment_no);
		cb.setNum(num);
		cb.setComment_content(comment_content);
		System.out.println(cb);
		
		
		CommentDAO2 cdao2 = new CommentDAO2();
		cdao2.updateComment(cb);
		response.sendRedirect("dealContent.jsp?num="+num);
		
	%>

</body>
</html>