<%@page import="com.camping.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camping.board.recomListDAO" %>
<%@page import="com.camping.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>낭만캠핑</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]--> 


</head>
<body>
<div id="wrap">

<!-- 헤더파일들어가는 곳 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->

<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/camping_main.jpg"
 width="971" height="282"></div>

<!-- <div id="sec_news"> -->

<!-- 메인 첫 번째 게시판 -->
<div id="news_notice">
<h3 class="brown">추천캠핑장</h3>


<%
	recomListDAO rldao = new recomListDAO();
	int cnt = rldao.getBoardCount();
	
	ArrayList recomList = null;
	if(cnt != 0 ){
		//ArrayList boardList = bdao.getBoardList();
		
		recomList = rldao.getBoardList();
		System.out.println("pro : 글 목록 저장 완료!");
	}
	
%>
<table>
<%
	if(cnt != 0){
	
	for(int i=0;i<recomList.size();i++){
		BoardBean bb = (BoardBean)recomList.get(i);	

%>
<tr>
	<td class="contxt">
		<a href="../center2/../boardRecomend/list.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a>
	</td>
	<td>
		<%=bb.getDate() %>
	</td>
</tr>

<%		}
	}
%>
</table>
</div>


<!-- 메인 두 번째 게시판 -->
<div id="news_notice">
<h3 class="brown">공지사항</h3>

<%
	BoardDAO bdao = new BoardDAO();
	int cnt2 = bdao.getBoardCount();
	
	ArrayList boardList = null;
	if(cnt2 != 0 ){
		//ArrayList boardList = bdao.getBoardList();
		
		boardList = bdao.getBoardList();
		System.out.println("pro : 글 목록 저장 완료!");
	}
%>
<table>
<%
	if(cnt2 != 0){
	
	for(int i=0;i<boardList.size();i++){
		BoardBean bb = (BoardBean)boardList.get(i);	

%>
<tr>
	<td class="contxt">
		<a href="../center2/boardContent.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a>
	</td>
    <td>
    	<%=bb.getDate()%>
    </td>
</tr>

<%		}
	}
%>
</table>
</div>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>