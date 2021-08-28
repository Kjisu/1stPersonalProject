<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>낭만캠핑</title>
</head>
<body>

<header>
	<div id="login">
	
		<% 
		String member_id = (String)session.getAttribute("member_id");
		if(member_id == null){
		%>
		<a href="../member/loginForm.jsp">로그인</a> | 
		<a href="../member/joinForm.jsp">회원가입</a>
		<%
		}else{
		%>
		<%=member_id%>님, 반갑습니다.&nbsp;
		<a href="../member/logout.jsp">로그아웃</a> | 
		<a href="../member/memInfo.jsp">마이페이지</a>
		<%} %>
	</div>
	<div class="clear"></div>
<!-- 로고들어가는 곳 -->
	<div id="logo"><img src="../images/camp_log.JPG" width="250" height="55" alt="Fun Web"></div>
<!-- 로고들어가는 곳 -->
	<nav id="top_menu">
	<ul>
		<li><a href="../member/main.jsp">메인</a></li>
		<li><a href="../boardRecomend/list.jsp">이달의 추천 캠핑장</a></li>
		<li><a href="../center/reviewBoardList.jsp">캠핑 나눔</a></li>
		<li><a href="../center2/boardList.jsp">캠핑 소식</a></li>
	</ul>
	</nav>
</header>

</body>
</html>