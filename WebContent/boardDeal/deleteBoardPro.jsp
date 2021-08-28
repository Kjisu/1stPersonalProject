<%@page import="com.camping.board.dealBoardDAO"%>
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

	<h1>WebContent/boardDeal/deleteBoardPro.jsp</h1>
	<h3>게시판 삭제 처리해 주는 페이지</h3>
	
	<%
		// 한글처리
			request.setCharacterEncoding("UTF-8");
		// 넘어온 정보 저장하기(pageNum / num,pass)
			BoardBean bb = new BoardBean();
			bb.setNum(Integer.parseInt(request.getParameter("num")));
			bb.setPass(request.getParameter("pass"));
			
		// 입력받은 비밀번호와 게시글 비밀번호가 일치하는지 확인시켜줄 메서드가 있는 객체 생성
			dealBoardDAO dbdao = new dealBoardDAO();
		// 메서드 호출
			int result = dbdao.deleteBoard(bb);
			System.out.println("중고게시판 삭제pro : 삭제 요청 처리 결과>>"+result);
		// 삭제 결과에 따른 처리
			if(result == 1){
				%>
				<script type="text/javascript">
					alert('삭제되셨습니다');
					location.href='dealBoardList.jsp';
				</script>
				<%
			}else if(result == 0){
				%>
				<script type="text/javascript">
					alert('비밀번호가 일치하지 않습니다.');
					history.back();
				</script>
				<%
			}else{
				%>
				<script type="text/javascript">
					alert('존재하지 않는 게시글 입니다.');
					location.href='dealBoardList.jsp';
				</script>
				<%
			}
			
	%>

</body>
</html>