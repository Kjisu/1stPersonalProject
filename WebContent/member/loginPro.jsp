<%@page import="com.camping.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>낭만 캠핑</title>
</head>
<body>

	<%	// 아이디, 비밀번호 정보 파라미터로 꺼내서 메개변수를 통해 넘기기
		String member_id = request.getParameter("member_id");
		String member_pwd = request.getParameter("member_pwd");
		System.out.println("아이디:"+member_id+", 비번 : "+member_pwd);
		
		MemberDAO md = new MemberDAO();
		int result = md.getIdentification(member_id, member_pwd);
		
		if(result == 1){
			session.setAttribute("member_id", member_id);
			response.sendRedirect("main.jsp");
		}else if(result == 0){
			%>
			<script type="text/javascript">
				alert('아이디나 비밀번호가 다릅니다.');
				history.back();
			</script>
			<%
		}else{
			%>
			<script type="text/javascript">
				var result = confirm('회원이 아닙니다. 회원 가입 하시겠습니까?');
				if(result){
					location.href='joinForm.jsp';
				}else{
					history.back();
				}
			</script>
			<%
		}
		
		
	%>

</body>
</html>