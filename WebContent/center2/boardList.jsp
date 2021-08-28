<%@page import="com.camping.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camping.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>낭만캠핑</title>
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

	// 파라미터로 넘어온 데이터(검색어) 저장
		BoardDAO bdao = new BoardDAO();
		int cnt = bdao.getBoardCount();
		
		/// 페이징 처리
		//1. 한 페이지에서 보여줄 글의 수 
			int pageSize  = 5;
		//2. 현 페이지의 정보 저장
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null){
				pageNum = "1";
			}
		//3. 페이지 출력 첫 행 계산
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage-1)*pageSize+1;
			
			ArrayList boardList = null;
		if(cnt != 0 ){
			//ArrayList boardList = bdao.getBoardList();
			
			boardList = bdao.getBoardList(startRow, pageSize);
			System.out.println("pro : 글 목록 저장 완료!");
		}
	%>

<!-- 게시판 -->
<article>
<h1>공지사항</h1>

	<table id="notice">
	<h4>총 개시글 : <%=cnt%>개</h4>
	<tr>
		<th class="tno" width="20px">No.</th>
	    <th class="ttitle">Title</th>
	    <th class="twrite">Writer</th>
	    <th class="tdate">Date</th>
	    <th class="tread">Read</th>
    </tr>
    
   <%  if(cnt != 0){
			
			for(int i=0;i<boardList.size();i++){
				BoardBean bb = (BoardBean)boardList.get(i);	
	%>
	
		<tr>
			<td><%=bb.getNum()%></td>
			<td class="left">
			<a href="boardContent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject()%></a>
			</td>
	   	    <td><%=bb.getWriter()%></td>
	   	    <td width="80px"><%=bb.getDate()%></td>
	   	    <td><%=bb.getReadcount()%></td>
	    </tr>
	    
   <%
			}
       }
   %>
</table>
<div id="table_search">
<%   // 관리자만 글쓰기 기능을 사용할 수 있도록 제어
	String member_id=(String)session.getAttribute("member_id");
	if(member_id != null && member_id.equals("admin")){
%>
	<input type="button" value="글쓰기" onclick="location.href='writeForm.jsp'">
<%
	}
%>
</div>
<div class="clear"></div>
<div id="page_control">

<%	//해당 페이지에 글이 있을 때만 나타남.
	if(cnt != 0){
		
	int pageCount = cnt/pageSize+(cnt%pageSize == 0? 0:1);
	
	int pageBlock = 2;
	
	int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
	
	int endPage = startPage+pageBlock-1;
	
	if(endPage > pageCount){
		endPage = pageCount;
	}
%>
<%	
	if(startPage > pageBlock){
%>
		<a href="boardList.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<% 
	}
%>
<%
	for(int i=startPage;i<=endPage;i++){	
%>
	<a href="boardList.jsp?pageNum=<%=i%>"><%=i %></a>
<%
	}
%>
<%
	if(endPage<pageCount){
%>
		<a href="boardList.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
<% }%>
<%} %>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>