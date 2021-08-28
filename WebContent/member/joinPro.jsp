<%@page import="java.util.Arrays"%>
<%@page import="java.util.StringJoiner"%>
<%@page import="java.sql.Timestamp"%>
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
	//  한글 안 꺠지도록 바꾸기
		request.setCharacterEncoding("UTF-8");
	
	//  주소값 String 배열을 => String 문자열로 변환하여 db에 저장하기 
		String[] address = request.getParameterValues("member_address");
		String member_address = Arrays.toString(address);
		
	//  dto 객체를 이용하여 데이터 잠시 저장 (액션코드 이용하여 객체 생성)
	%>
		<jsp:useBean id="mb" class="com.camping.member.MemberBean"/>
		<jsp:setProperty property="*" name="mb"/>
	<%
	
	// 가입 날짜, 변환한 주소 자바빈에 넣기
		mb.setReg_date(new Timestamp(System.currentTimeMillis()));
		mb.setMember_address(member_address);
		
	//  모든 데이터, 자바빈에 잘 들어갔는지 확인
		System.out.println(mb);
	
	//  객체 memberDAO 생성, 메서드 호출(매게변수로 데이터 담겨진 자바빈 넘기기)
		MemberDAO md = new MemberDAO();
		md.insertMember(mb);
	%>
	
	<script type="text/javascript">
		var result = confirm('회원가입이 완료되었습니다.로그인 하시려면 확인 버튼을 클릭해주세요.');
		if(result){
			location.href="loginForm.jsp";
		}else{
			location.href="main.jsp";
		}
	</script>

</body>
</html>