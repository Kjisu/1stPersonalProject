<%@page import="com.camping.board.ReviewBoardDAO"%>
<%@page import="com.camping.board.BoardBean"%>
<%@page import="com.camping.board.BoardDAO"%>
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
	<jsp:include page="../inc/left_center2.jsp"/>
<!-- 왼쪽메뉴 -->
<%
	String member_id =(String)session.getAttribute("member_id");
	int num =Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
		
	BoardDAO bdao = new BoardDAO();
	bdao.updateReadNumber(num);
	BoardBean bb = bdao.getBoard(num);
	
	// 본문 내용(name="content") 줄 바꿈 표시 
		String content = bb.getContent();
		if(content != null) content = content.replace("\r\n","<br>");
		

	
%>
<!-- 게시판 -->
	<article>
	<h2>공지사항 본문보기</h2>
	<table id="notice">
		<tr>
			<th class="tno" colspan="5" align="center"></th> 
	    </tr>
		<tr>
			<td>글번호</td>
			<td><%=bb.getNum() %></td>
			<td>조회수</td>
			<td><%=bb.getReadcount() %></td>
    	</tr>
		<tr>
			<td>글쓴이</td>
			<td><%=bb.getWriter() %></td>
			<td>작성일</td>
			<td><%=bb.getDate() %></td>
		</tr>
		<tr>
    		<td>제목</td>
    		<td colspan="4"><%=bb.getSubject() %></td>
    	</tr>
		<tr>
		    <td>내용</td>
		    <td colspan="4"><%=content %></td>
		</tr>
	</table><br>
	<!-- 주소줄을 통해 데이터 넘기기  -->
	<% if(member_id != null&&member_id.equals("admin")){ %>
		<input type="button" value="수정하기" onclick="location.href='updateContent.jsp?pageNum=<%=pageNum%>&num=<%=num%>'">
		<input type="button" value="삭제하기" onclick="location.href='deleteBoardForm.jsp?pageNum=<%=pageNum%>&num=<%=num%>';">
	<% 
			}	
	%>
		<input type="button" value="목록으로" onclick="location.href='boardList.jsp?pageNum=<%=pageNum%>';">
	
	<div id="table_search">
	</div>
	
	 <script type="text/javascript">
		function delQuestion(){
			var result = confirm('게시글을 정말로 삭제하시겠습니까?');
			if(result){
				location.href='deleteContent.jsp?num=<%=num %>';
			}else{
				location.href='boardContent.jsp';
			}
		}
	</script>
	
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