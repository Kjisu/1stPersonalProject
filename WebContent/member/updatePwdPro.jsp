<%@page import="com.camping.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>

	<%
		String member_id = (String)session.getAttribute("member_id");
		String member_pwd_pre = request.getParameter("member_pwd_pre");
		String member_pwd = request.getParameter("member_pwd");
	
		MemberDAO md = new MemberDAO();
		int result = md.getIdentification(member_id,member_pwd_pre);
		
		System.out.println("프로 : 신원 확인 완료");
		
		if(result == 1){
			md.updatePwd(member_id, member_pwd);
			%>
			<script type="text/javascript">
			alert('수정 완료하였습니다');
			location.href='memInfo.jsp';
			</script>
			<%
		}else if(result == 0){
			%>
			<script type="text/javascript">
				alert('기존 비밀번호가 다릅니다. 다시 시도해 주세요.');
				history.back();
			</script>
			<%
		}else{
			System.out.println("회원이 아닙니다.");
			response.sendRedirect("loginForm.jsp");
		}
		
	%>

</body>
</html>