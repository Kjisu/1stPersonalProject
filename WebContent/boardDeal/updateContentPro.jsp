<%@page import="com.camping.board.dealBoardDAO"%>
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
		// 한글 처리
			request.setCharacterEncoding("UTF-8");
		// 주소에 붙어서 get방식으로 넘어온 데이터(pageNum) 저장하기
		String pageNum = request.getParameter("pageNum");
	
		// form태그에 의해 post방식으로 넘어온 데이터(num,writer,pass,subject,content)저장하기 (맴버빈 객체에 - 액션태그 이용)
	%>
		<jsp:useBean id="bb" class="com.camping.board.BoardBean"/>
		<jsp:setProperty property="*" name="bb"/>
		<%System.out.println("게시글of중고게시판 수정 pro : 자바빈 객체에 수정된 데이터 잘 담겼낭 ==>"+bb);%>
	<%
		// db에 업데이트 시키기
		dealBoardDAO rbdao = new dealBoardDAO();
		int result = rbdao.updateContent(bb);
		System.out.println("메서드 결과 =>"+result);
		
		int num = bb.getNum(); // 결과에 따른 이동에 필요
		
		// 결과에 따른 페이지 이동
		if(result == 1){
			/* if(bb.getRe_seq() != 0){
				response.sendRedirect("dealContent.jsp?num="+num);
			}else{
				response.sendRedirect("dealReContent.jsp?num="+num);
			} */
			response.sendRedirect("dealBoardList.jsp");

		}else if(result == 0){
			%>
			<script type="text/javascript">
				alert('비밀번호가 일치하지 않습니다.');
				history.back();
			</script>
			<%
		}else{
			System.out.println("해당 게시글 엄슴");
			response.sendRedirect("dealBoardList.jsp");
		}
	%>

</body>
</html>