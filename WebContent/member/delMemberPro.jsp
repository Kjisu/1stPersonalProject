<%@page import="com.camping.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		String member_id =(String)session.getAttribute("member_id");
		String member_pwd = request.getParameter("member_pwd");
		
		MemberDAO md = new MemberDAO();
		
		int result = md.getIdentification(member_id, member_pwd);
		
		if(result == 1){
			md.deleteMember(member_id);
			session.invalidate();
			%>
			<script type="text/javascript">
				alert('정상적으로 탈퇴 되셨습니다.');
				location.href='main.jsp';
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
			System.out.println("pro : 회원이 아님");
		}
	%>

</body>
</html>