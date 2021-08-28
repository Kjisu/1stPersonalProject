<%@page import="com.camping.member.MemberBean"%>
<%@page import="com.camping.member.MemberDAO"%>
<%@page import="com.camping.comment.CommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camping.comment.CommentDAO"%>
<%@page import="com.camping.board.ReviewBoardDAO"%>
<%@page import="com.camping.board.BoardBean"%>
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
<%	// 회원만 리뷰 게시글을 볼수 있도록 제어 (굳이 필요 있을까?)
	String member_id = (String)session.getAttribute("member_id"); // 수정하기, 삭제하기 버튼 보이기 위해 필요.
	
	// 회원 이메일
	String email = request.getParameter("member_email");
	
	// 사용자 메일 주소가 바로 뜨도록 데이터 가져오기
	MemberDAO bd = new MemberDAO();
	MemberBean mb = bd.getInfo(member_id);
%>
<!-- 게시판 -->
	<article>
	<form action="MailSend.jsp" method="post">
	<h2>메일 쓰기</h2>
	<table id="notice">
		<tr>
			<th class="tno" colspan="5" align="center"></th> 
	    </tr>
	    <tr>
	    	<td>보내는 사람 : </td>
	    	<td><input type="text" name="sender" value="gabrieljisu9@gmail.com" readonly="readonly"></td>
	    </tr>
	    <tr>
	    	<td>받는 사람 메일 : </td>
	    	<td><input type="text" name="receiver" value="<%=email %>"></td>
	    </tr>
	    <tr>
	    	<td>제목 : </td>
	    	<td><input tyep="text" name="subject"></td>
	    </tr>
	    <tr>
	    	<td>내용 : </td>
	    	<td><textarea name="content" cols="40" rows="20"></textarea></td>
	    </tr>
	    <tr>
	    	<td colspan="2" align="center"><input type="submit" value="보내기"></td>
	    </tr>
	<!-- 이메일 입력 폼 만들기 // 프로 페이지에서 이메일 보내기 기능 구현 -->
	</table>
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