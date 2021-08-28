<%@page import="com.camping.board.ReviewBoardDAO"%>
<%@page import="com.camping.board.BoardDAO"%>
<%@page import="com.camping.member.MemberDAO"%>
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
		// 0. 한글 데이터 처리
		request.setCharacterEncoding("UTF-8");
		// 1. get방식로 넘어온(파라미터) 데이터 저장 ->글 수정 후 , 이동시킬 때 필요
		String pageNum = request.getParameter("pageNum");
		// 2. form태그를 통해 넘어온 정보 저장. => 자바빈 객체 이용
	%>  
		<jsp:useBean id="bb" class="com.camping.board.BoardBean"/>
		<jsp:setProperty property="*" name="bb"/>
		
		<%System.out.println("updatePro : 공지사항 게시글 수정할 정보, 자바빈에 잘 들어 갔능가??=>"+bb); %>
	<%
		// 3. 저장 후 파라미터를 통해 수정된 정보가 들어있는 자바빈 객체 넘기기
		BoardDAO bdao = new BoardDAO();
		int result = bdao.updateContent(bb);
		
		int num = bb.getNum(); // 글 수정 완료 후, 수정된 글을 보여주는 페이지로 이동시키는데 사용될 게시글 번호.
		
		System.out.println("updatePrp : 수정된 정보, 업데이트 완료^^^^^");
		
		// 4. 결과에 따라 처리
		if(result == 1){ // 업데이트 완료됐음
			%>
			<script type="text/javascript">
				alert('수정 완료되었습니다.');
				location.href='boardContent.jsp?num=<%=num%>';
				location.href='boardList.jsp?pageNum=<%=pageNum%>';
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
			System.out.println("존재하지 않는 게시글 입니다");
		}
	%>
		
</body>
</html>