<%@page import="com.camping.board.BoardBean"%>
<%@page import="com.camping.board.ReviewBoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<!-- "헤더"들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/> 
<!-- 상위 폴더니까 ../  -->
<!-- 헤더 영역에 그 부분에 들어갈 페이지 , 액션태그(include)를 통해 추가시키기  -->

<!-- "헤더"들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
	<div id="sub_img_center"></div>
<!-- 메인이미지 -->
<!-- 왼쪽메뉴 -->
	<jsp:include page="../inc/left.jsp"/>
<!-- 왼쪽메뉴 -->
	<%
		request.setCharacterEncoding("UTF-8");
	
	// 파라미터로 넘어온 검색어 저장
		String search = request.getParameter("search");
		String type = request.getParameter("type");
		
	// 칸에 아무 단어를 입력하지 않은 채 검색하거나 공백문자일때 -> 모든 글이 나오도록 제어
		if(search == null || search == ""){
			search = "all";
		}
		System.out.println("검색어>>>>>>"+search);
		
	// DB에 저장되어 있는 리뷰 게시글 가져오기
		// 이 기능을 대신해 주는 객체 생성하고
		ReviewBoardDAO rbdao = new ReviewBoardDAO();
		// DB에 저장되어 있는 리뷰글이 몇 개인지 알려주는 메서드
		int cnt = rbdao.getReviewBoardCount();
		// 검색어와 관련된 게시글 갯수 출력하는 메서드
		int searchCnt = rbdao.getReviewBoardCount(search);
		System.out.println("리뷰 게시판 전체 글 개수 >>"+cnt);
		System.out.println("리뷰 게시판 : 검색어에 해당되는 글 개수 >>" + searchCnt);
			
		
////////////////////////////////////////////
			/////// 페이징 처리  - 게시판 보여질 글의 개수를 페이징 처리
			// 1. 한 페이지에서 보여줄 글의 수 수정
					int pageSize = 10;
			// 2. 현 페이지의 정보 저장
					String pageNum = request.getParameter("pageNum");
					if(pageNum == null){ //왜 String ? 페이지마다 String으로 가지고 다닐 꺼기에 , 주소줄에?pageNum=2 검색하면 2페이지 나옴
						pageNum = "1"; // 페이지를 1페이지로 고정해 놓음
					}
			// 페이지 출력 첫 행 계산
					int currentPage = Integer.parseInt(pageNum);
					int startRow = (currentPage-1)*pageSize+1; // 첫줄이란 이렇게 계산하는 구나..하고 받아드리세요,,;;
					
////////////////////////////////////////////


			ArrayList reviewBoardList = null;
			if(cnt != 0 || searchCnt != 0){
		// DB에 저장되어 있는 게시글 가져와주는 메서드 생성 : getBoardList()
			//boardList = bdao.getBoardList(startRow, pageSize); // 첫 행과 페이지 사이즈 가져감
			//reviewBoardList = rbdao.getReviewBoardList(startRow, pageSize); // 새로 메서드를 만드는 것이 아니라 인자만 추가해서
			if(search != null){ // 게시판 글 출력하기 - 검색어 있는 경우 (제어 해 놓은 게 맞나...?)
				reviewBoardList = rbdao.getBoardList(startRow, pageSize, search, type);
				System.out.println("리뷰 게시판 : 글 목록 저장 완료!");
			}else{ // 게시판 글 출력하기 - 검색어 없는 경우
				reviewBoardList = rbdao.getReviewBoardList(startRow, pageSize);
				}
			}
	%>
<!-- 게시판 -->
<article>
	<h1>리뷰 게시글</h1>
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
		<th class="tno">No.</th>
	    <th class="ttitle">Title</th>
	    <th class="twrite">Writer</th>
	    <th class="tdate">Date</th>
	    <th class="tread">Read</th>
	</tr>
	<%if(cnt != 0 || searchCnt != 0){ 
		for(int i=0;i<reviewBoardList.size();i++){ // size = 배열 인덱스 수
		
		// 가변배열 인덱스 개수만큼 반복될 때 마다 
		// 새로운 자바빈 객체에 배열 인덱스에 있는 자바빈 객체를 저장 -> <%= % >에 출력.
			BoardBean bb = (BoardBean)reviewBoardList.get(i);
	%>
		<tr>
			<td><%=bb.getNum() %></td>
			
			<td class="left">
			<!-- 답글의 순서는 게시판에 보여지는 거랑 DB에 보여지는 순서가 다를 수 밖에 없다.
			          왜? 게시판에 보여지는 순서는 쿼리 구문을 통해 순서를 조작한 상태로 출력해 냈기 때문에 -->
			<!-- re_lev의 값 = 1 : 일반글(원글)의 답글임을 의미 -->
			<!-- re_lev의 값 = 2 : 답글의 답글임을 의미 -->
			<!-- 일반글(원글)의 re_lev,seq 값은 무조건 '0'
				  일반글, 답글 구분은 lev,seq값 가지고 구분 가능한데 lev가지고 구분해야. -->
			
			<!-- re_lev 값에 따른 들여쓰기 표현(이미지 가지고 들여쓰기 정도 표현 ) -->
			<!-- 답글 일때만 해당 이미지를 사용하게끔 하기(re_lev이용) -->
				<%	
					int wid = 0;
					if(bb.getRe_lev()>0){
						wid = 10 * bb.getRe_lev();
				%>
					<img src="level.gif" height="10" width="<%=wid %>">
					<img src="re.gif" height="10">
				<%
				   }
					
				 %>
				 <%
				 	if(bb.getRe_seq() == 0){ // 원글 
				 %>
				<a href="reviewContent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject() %></a>
				<% }else{ // 답글
					
				%>
					<a href="reviewReContent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject() %></a>
				
				<%} %>
			</td>
		    <td><%=bb.getWriter() %></td>
		    <td width="80px"><%=bb.getDate() %></td>
		    <td><%=bb.getReadcount() %></td>
		</tr>
	<% 
		}
		}%>
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
		<form action="" method="get"> <!--액션 페이지가 없으면 다시 내 페이지를 부름, 이때 search 데이터를 가지고 감, 주소의 값을 가지고 간다.  -->
			<select name="type">
				<option value="writer">아이디</option>
				<option value="subject">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="search" class="input_box">
			<input type="submit" value="검색" class="btn">
		</form>
	</div>
	<div class="clear"></div>
	
	<div id="page_control">
	<%
	//글이 있을 때만, <이전>1234...<이후> 글이 몇 페이지 있는지 보여주는 제어
		if(cnt != 0 || searchCnt != 0){
	
	// 몇 페이지 필요한지 계산
		int pageCount = cnt/pageSize+(cnt%pageSize == 0? 0:1); // 나누어 떨어지지 않는다 == 페이지 수가 하나 더 필요하다
		
	// 한 페이지에서 보여줄 페이지 수 (페이지 블럭 : ex,한 번에 5개씩 보여주겠다) 
	
		int pageBlock = 5; // 변경가능
	
	// 한 페이지에서 시작하는 페이지 번호 계산(공식..만들어낼 필요없음 이해하기 까지만,,)
		int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
	// 한 페이지에서 끝나는 페이지 번호	
		int endPage = startPage+pageBlock-1;
	
		if(endPage > pageCount){ // endPage가 전체 페이지수 보다 큰 경우
			endPage = pageCount;
		}
	
	%>
		
		<% // 이전 페이지 활성화
			if(startPage > pageBlock){
				
		%>
				<a href="reviewBoardList.jsp?pabeNum=<%=startPage-pageBlock %>">이전</a>
		<% 
			}
		%>
		
		
		<%
			for(int i=startPage;i<=endPage;i++){ 
			// 페이지 이동시 데이터 까지 같이 가져가고 싶다면 --> 주소줄에 ".jsp?name=속성값" 
		%>
		<a href="reviewBoardList.jsp?pageNum=<%=i %>&search=<%=search %>&type=<%=type %>"><%=i %></a>
		<%
			} 
		%>
		<% 
			if(endPage<pageCount){	
		%>
					<a href="reviewBoardSearchList.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
		<%
			}
		%>
	<%}%>	
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