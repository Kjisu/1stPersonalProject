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

	<%	// 한글처리
			request.setCharacterEncoding("UTF-8");
		// submit 버튼 클릭시, form을 통해 넘어오는 데이터 받기 : 아이디, 댓글 내용
		String member_id = request.getParameter("member_id");
		String comment_content = request.getParameter("comment_content");
		int num = Integer.parseInt(request.getParameter("num"));
		
		// 데이터 담아서 넘기기
	%>
	<jsp:useBean id="cb" class="com.camping.comment.CommentBean"/>
	<jsp:setProperty property="*" name="cb"/>
	<%
		cb.setNum(num);
		System.out.println("댓글 저장 pro : 댓글 정보 잘 담겼는지??>>"+cb); %>
	
	<%
		//댓글을 디비에 저장해줄 객체생성, 메서드 호출
			CommentDAO cdao = new CommentDAO();
			cdao.insertComment(cb);
			System.out.println("댓글 저장 pro: 실행 완료=== ");
		//페이지 이동
			response.sendRedirect("reviewContent.jsp?num="+num);
	%>

</body>
</html>