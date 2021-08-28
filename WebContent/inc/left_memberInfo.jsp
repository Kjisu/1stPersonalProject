<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<nav id="sub_menu">
	<ul>
		<li><a href="../member/memInfo.jsp">회원 정보</a></li>
	<%
		String member_id = (String)session.getAttribute("member_id");
		if(member_id.equals("admin")){
	%>
	
		<li><a href="../member/memberList.jsp">회원 리스트 </a></li>
	<%
		}
	%>
	<%
		if(!member_id.equals("admin")){
	%>
		<li><a href="../member/delMemberForm.jsp">회원 탈퇴</a></li>
	<%
		}
	%>
		<!-- <li><a href="#">Driver Download</a></li>
		<li><a href="#">Service Policy</a></li> -->
	</ul>
</nav>

</body>
</html>