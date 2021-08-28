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
 
 	<script type="text/javascript">
 		function fun1(){
 			var result = confirm('정말로 회원 탈퇴 하시겠습니까?');
 			
 			(result == true)? location.href='delMemberPro.jsp':false;  
 		}
 	</script>
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
%>

<!-- 게시판 -->
	<article>
	<h2>회원탈퇴하기</h2>
	<form action="delMemberPro.jsp" method="post" onsubmit="return fun1();" >
	<table id="notice">
		<tr>
			<th class="tno" colspan="5" align="center"></th> 
	    </tr>
		<tr>
			<th> 아이디 </th>
			<td><input type="text" name="member_id" value=<%=member_id %>></td>
		</tr>
		<tr>
			<th> 비밀번호 </th>
			<td><input type="password" name="member_pwd"></td>
		</tr>
	</table>
		<input type="submit" value="탈퇴하기" class="btn" onclick="fun1();">
	</form>
	<div id="table_search">
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