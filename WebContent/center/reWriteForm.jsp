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
 	function formChk(){
 	/* 	
 		if(document.fr.writer.value = ""){
 			alert('글쓴이 이름은 필수 입력입니다.');
 			document.fr.writer.focus();
 			return false;
 		} */
 		var pass = document.fr.pass.value.length; 
 		if(pass <=0 ){
 			alert('비밀번호는 필수 입력 입니다.비밀번호를 입력하셔야 본인 글에 대한 수정,삭제가 가능합니다.');
 			document.fr.pass.focus();
 			return false;
 		}else if(!(4<=pass&&pass<=6)){
 			alert('비밀번호는 숫자 4~6자리 입력해 주세요. ');
 			document.fr.pass.focus();
 			return false;
 		}
 		
 		if(document.fr.subject.value == ""){
 			alert('제목은 필수 입력입니다.');
 			document.fr.subject.focus();
 			return false;
 		}
 		if(document.fr.content.value == ""){
 			alert('내용은 필수 입력 입니다.');
 			document.fr.content.focus();
 			return false;
 		}
 		
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
	<jsp:include page="../inc/left.jsp"/>
<!-- 왼쪽메뉴 -->

<%	
	String member_id = (String)session.getAttribute("member_id");
	if(member_id == null) response.sendRedirect("../member/loginForm.jsp");

	// 이전 페이지에서 넘어온 데이터 저장(pageNum /  num, re_ref, re_lev, re_seq)
	String pageNum = request.getParameter("pageNum");
	
	// 디비 까지 가져갈 데이터들
	int num = Integer.parseInt(request.getParameter("num"));
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));
	int re_lev = Integer.parseInt(request.getParameter("re_lev"));
	int re_seq = Integer.parseInt(request.getParameter("re_seq"));
	
%>
<!-- 게시판 -->
	<article>
	<form action="reWritePro.jsp?pageNum=<%=pageNum %>" method="post" name ="fr" onsubmit="return formChk();">
	<h2>답글 작성</h2>
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="re_ref" value="<%=re_ref%>">
		<input type="hidden" name="re_lev" value="<%=re_lev%>">
		<input type="hidden" name="re_seq" value="<%=re_seq%>">
		
	<table id="notice">
		<tr>
			<th class="tno" colspan="5" align="center">글쓰기</th> 
	    </tr>
		<tr>
		<td>글쓴이</td>
    	<td>
    		<input type="text" name="writer" value="<%=member_id %>" readonly="readonly">
    	</td>
    	</tr>
		<tr>
			<td>비밀번호</td>
		    <td><input type="password" name="pass" placeholder="숫자 4~6자리 입력" maxlength="6"></td>
		</tr>
		<tr>
    		<td>제목</td>
    		<td><input type="text" name="subject" value="[Re] : "></td>
    	</tr>
		<tr>
		    <td>내용</td>
		    <td><textarea name="content" rows="10" cols="20"></textarea></td>
		</tr>
	</table>
	<div id="table_search">
		<input type="submit" value="작성완료" class="btn">
	<!-- 	<input type="reset" value="다시작성" class="btn"> -->
	</form>
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