<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.camping.member.MemberBean"%>
<%@page import="com.camping.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>낭만 캠핑</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
	<jsp:include page="../inc/left_memberInfo.jsp"/>
<!-- 왼쪽메뉴 -->
<%
	String member_id =(String)session.getAttribute("member_id");
	if(member_id == null){
		// 어짜피 로그인 상태가 아니면 회원정보 확인 메뉴가 안보일꺼긴 한데..일단 제어 코드 적어놓자.
		response.sendRedirect("loginForm.jsp");
	}
	
	// 회원정보 가져오기
	
	MemberDAO md = new MemberDAO();
	MemberBean mb = md.getInfo(member_id);
	
	// Timestamp 타입 -> String으로 바꿔서 날짜 뒤에 시간 정보 잘라가지고 출력하기.
	// 쿼리구문에서 변환시켜 꺼내오려했더니 dto 데이터타입까지 다 건드려야 해서 ... 꺼내와서 조작하는걸로ㅠ
	String reg_date = String.valueOf(mb.getReg_date()).substring(0, 10);
	
	// 주소 맨 앞 뒤에 있는 이거 --> [ ,] 제거하기
	String member_address = mb.getMember_address().substring(1, mb.getMember_address().length()-1);
	
	
	
%>
<!-- 게시판 -->
	<article>
	<h2>정보확인</h2>
	<table id="notice">
		<tr>
			<th class="tno" colspan="5" align="center"></th> 
	    </tr>
		<tr>
			<td>아이디</td>
			<td colspan="4"><%=mb.getMember_id() %></td>
    	</tr>
    	<tr>
			<td>이름</td>
			<td colspan="4"><%=mb.getMember_name() %></td>
    	</tr>
		<tr>
    		<td>이메일</td>
    		<td colspan="4"><%=mb.getMember_email() %></td>
    	</tr>
		<tr>
		    <td>가입일</td>
		    <td colspan="4"><%=reg_date %></td>
		</tr>
		<tr>
		    <td>주소</td>
		    <td colspan="4"><%=member_address %></td>
		</tr>
	</table>
	<div id="table_search">
<input type="button" value="비밀번호 변경" onclick="location.href='updatePwdForm.jsp'"class="btn">
	</div>
	<div class="clear"></div>
	<div id="page_control">
	</div>
	</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
	<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>