<%@page import="com.camping.board.dealBoardDAO"%>
<%@page import="com.camping.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
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

<!-- 왼쪽메뉴 -->
	<jsp:include page="../inc/left.jsp"/>
<!-- 왼쪽메뉴 -->
<!-- 메인이미지 -->

	<%
	// DB와 관련된 처리를 해주는 인스턴스 생성
		dealBoardDAO dbdao = new dealBoardDAO();
		
	// 검색어 입력했을 때 파라미터로 넘어오는 데이터 저장
		String type = request.getParameter("type");
		String search = request.getParameter("search");	
		
	// 검색어가 없거나(사용자가 검색어 기능을 사용하지 않음) 공백문자일 때 -> 모든 글을 볼 수 있도록 제어
		if(search == null || search == ""){
			search = "all";
		}
			System.out.println("중고게시판 검색어>>"+search);
	
	// 사용자가 입력한 검색어에 부합되는 게시글의 갯수
		int searchCnt = dbdao.getBoardCount(search, type);
	// 전체 글 개수
		int cnt = dbdao.getBoardCount();
			System.out.println("중고 게시판 전체 글 갯수>>"+cnt);
			System.out.println("중고 게시판 검색어에 부합되는 글 갯수>>"+searchCnt);
	
///////////////////////////////////////// 페이징 처리

		//1. 한 페이지에서 보여줄 글의 수 
			int pageSize  = 7;
		//2. 현 페이지의 정보 저장
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null){
				pageNum = "1";
			}
		//3. 페이지 출력 첫 행 계산
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage-1)*pageSize+1;
			
		ArrayList dealBoardList = null;
		if(cnt != 0 || searchCnt != 0){
			
			if(search != null){
				dealBoardList = dbdao.getBoardList(startRow, pageSize, search, type);
			}else{ // 검색어 없는 경우
				dealBoardList = dbdao.getBoardList(startRow, pageSize);
				
			}
		}
	%>

<!-- 게시판 -->
<article>
<h1>중고 장터</h1>

	<table id="notice">
	<%
		if(search == null){
	%>
			<h4>총 개시글 : <%=cnt%>개</h4>
	<%
		}else{
	%>
			<h4>총 개시글 : <%=searchCnt%>개</h4>
	<%
			
		}
	%>
	<tr>
		<th class="tno" width="20px">No.</th>
	    <th class="ttitle">Title</th>
	    <th class="twrite">Writer</th>
	    <th class="tdate">Date</th>
	    <th class="tread">Read</th>
    </tr>
    
   <%  	BoardBean bb = null;
   			if(cnt != 0 || searchCnt != 0){
   				
				for(int i=0;i<dealBoardList.size();i++){
					
					bb = (BoardBean)dealBoardList.get(i);	
	%>
	
		<tr>
			<td><%=bb.getNum()%></td>
			<td class="left">
			<%	int wid = 0;
				if(bb.getRe_lev()>0){
					wid = bb.getRe_lev()*10;
			%>
			<img src="level.gif" width="<%=wid%>">
			<img src="re.gif">
			
			<%
				}
				
			%>
			<% 
				if(bb.getRe_seq() == 0){ // 원글인 경우
			%>
				<a href="dealContent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject()%></a>
				
			<% }else{ // 답글인 경우 -> 답글을 보여주는 content로 이동
			%>
				<a href="dealReContent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject()%></a>
			<%
			}
			%>
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
<% 
	String member_id = (String)session.getAttribute("member_id");
	if(member_id != null){
%>
		<input type="button" value="글쓰기" onclick="location.href='writeForm.jsp'">
<%
	}
%>
	<form action="" method="get">
		<select name="type">
			<option value="writer">아이디</option>
			<option value="subject">제목</option>
			<option value="content">내용</option>
		</select>
		<input type="text" name="search" class="input_box" value="검색어를 입력하세요.">
		<input type="submit" value="검색하기" class="bnt"> <!-- 검색 버튼을 돋보기 이미지로 변경하기 -->
	</form>
</div>

<div class="clear"></div>
<div id="page_control">

<%	//해당 페이지에 글이 있을 때만 나타남.
	if(cnt != 0 || searchCnt != 0){
		
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
		<a href="dealBoardList.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
<% 
	}
%>
<%
	for(int i=startPage;i<=endPage;i++){	
%>
	<a href="dealBoardList.jsp?pageNum=<%=i %>&search=<%=search %>&type=<%=type %>"><%=i %></a>
<%
	}
%>
<%
	if(endPage<pageCount){
%>
		<a href="dealBoardList.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
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