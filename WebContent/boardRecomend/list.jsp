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

	<article>
	<h2>[이달의 추천 캠핑장] 리스트</h2>
	<table>
		
	
<%	// 관리자에게만 글쓰기 버튼이 보일 수 있도록 제어하기 위해 아이디 값 필요
		String member_id = (String)session.getAttribute("member_id");

	// 내용이 존재하는 경우에만 데이터 불러와야 하니까


	// 리스트에 썸네일기능 이용하여 출력, 관리자가 업로드한 이미지 파일 불러오기
	
		// 객체 생성해서 이미지 갯수. filename 출력하기
		recomListDAO rldao = new recomListDAO();

	// 총 게시글 수
		int cnt = rldao.getBoardCount();
	

	// 디비에 있는 추천 목록 데이터 자바빈에 담기
		if(cnt != 0){
	 	ArrayList recomList = rldao.getBoardList();
	 
	// 객체 생성을 반복할 필요 없으니까..?
		ServletContext context = getServletContext();
		String imagePath = context.getRealPath("/upload");
		System.out.println("실제 경로 imagePath:"+imagePath);
	 	
	 	BoardBean bb = null;
	 	for(int i=0;i<recomList.size();i++){
	 		bb = (BoardBean)recomList.get(i);
	 		System.out.println("bb:"+bb);
	 	
	// JAI API를 이용하여 이미지 변환
	
		ParameterBlock pb = new ParameterBlock();
		pb.add(imagePath+"/"+bb.getFile());
		RenderedOp rop = JAI.create("fileload", pb);
		
		BufferedImage bi = rop.getAsBufferedImage();
		BufferedImage thumb = new BufferedImage(100,100,BufferedImage.TYPE_INT_BGR);
		Graphics2D g = thumb.createGraphics();
		g.drawImage(bi, 0, 0, 100, 100, null);
		File file = new File(imagePath+"/sm_"+bb.getFile());
		ImageIO.write(thumb, "jpg", file);
		
	
	 	
%>

<!-- 게시판 -->
	
		<tr>
			<td><img src="../upload/sm_<%=bb.getFile() %>"></td>
			<td>
				<p><h3><%=bb.getSubject() %></h3></p>
				<p><%=bb.getContent() %></p>
				<a href="mapSelect.jsp?num=<%=bb.getNum()%>&cnt=<%=cnt %>" target="_blank"><input type="button" value="주변 캠핑장 보기"></a>
			</td>
		</tr>
		<% 
			}
		}
		%>
		
	</table>
		<%
		
		// member_id.equals("")만 적으니까, 로그인 하지 않은 상태에서는 nullPointException발생함.
		// member_id != null 이 아니라고 적어주니까 nullPointException 사라짐.
			if(member_id != null && member_id.equals("admin")){
		%>
		<input type="button" value="게시글 작성하기" onclick="location.href='writeForm.jsp';">
		<%
			}
		%>
	<div id="table_search">
<!-- <input type="submit" value="글쓰기" class="btn"> -->
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