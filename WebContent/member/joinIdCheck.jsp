<%@page import="com.camping.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script type="text/javascript">
</script>
<body>
	<%
		String member_id = request.getParameter("member_id");
		
		MemberDAO md = new MemberDAO();
		boolean result = md.isExistId(member_id);
		
		if(result){
			out.print("중복 아이디 입니다.");
			%>
	<fieldset>
		<form action="joinIdCheck.jsp" method="post" name="wfr">
			ID :<input type="text" name="member_id" value="<%=member_id %>">
				<input type="submit" value="중복확인">
		</form>
	</fieldset>
	
			<%
		}else{
			out.print("사용 가능 아이디 입니다.");
			%>
			<form action="joinIdCheck.jsp" method="post" name="wfr">
				<input type="hidden" name="member_id" value="<%=member_id %>">
			</form>
			<br><input type="button" value="아이디 사용하기" onclick="result();">
	
			<%
		}
	
	%>
	
<script type="text/javascript">
	function result(){
		opener.document.fr.idDuplication.value = "idCheck";
		opener.document.fr.member_id.value = document.wfr.member_id.value; 
		window.close();
	}

</script>

</body>
</html>