<%@page import="com.camping.member.MemberBean"%>
<%@page import="com.camping.member.MemberDAO"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.lang.ref.PhantomReference"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="com.camping.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camping.board.recomListDAO"%>
<%@page import="java.util.Enumeration"%>
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
	<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<!-- 메인이미지 -->

<article id="memberlist">
 <h2>회원 목록</h2>
<table id="notice" >
	<tr>
	
		<th class="tno">번호</th>
		<th class="tno">아이디</th>
	    <th class="tread">비밀번호</th>
	    <th class="twrite">이름</th>
	    <th class="ttitle">이메일</th>
	    <th class="ttitle">가입일</th>
	    <th class="ttitle">주소</th>
	</tr>
		
	
<%	// 관리자만이 볼 수 있도록 
		String member_id = (String)session.getAttribute("member_id");
		if(member_id != null && !(member_id.equals("admin"))){
			response.sendRedirect("loginForm.jsp");
		}

	// 회원 정보 꺼내기 
		MemberDAO md = new MemberDAO();
		ArrayList memberList = md.getMemberInfo();
		MemberBean mb = new MemberBean();
		
		for(int i=0;i<memberList.size();i++){
			mb = (MemberBean)memberList.get(i);
			
			String reg_date = String.valueOf(mb.getReg_date()).substring(0, 10);
			
			String member_address = mb.getMember_address().substring(1, mb.getMember_address().length()-1);
		
%>	

	
	<tr>
		<td><%=i+1 %></td>
		<td><%=mb.getMember_id() %></td>
		<td><%=mb.getMember_pwd() %></td>
		<td><%=mb.getMember_name() %></td>
		<td><a href="mailForm.jsp?member_email=<%=mb.getMember_email() %>"><%=mb.getMember_email() %></a></td>
		<td><%=reg_date %></td>
		<td><%=member_address %></td>
				
		<td class="left">
	<%}
	%>	
	</table>
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