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
 		var pass = document.fr.pass.value.length; 
 		if(pass <=0 ){
 			alert('비밀번호는 필수 입력 입니다.');
 			document.fr.pass.focus();
 			return false;
 		}else if(!(4<=pass&&pass<=6)){
 			alert('비밀번호는 숫자 4~6자리 입력해 주세요. ');
 			document.fr.pass.focus();
 			return false;
 		}
 		
 		var result = confirm('삭제된 글은 복구가 불가능합니다. 정말로 글을 삭제 하시겠습니까?');
 		if(result){
 			
 		}else{
 			return false;
 			history.back();
 		}
 	}
 
 </script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
	<jsp:include page="../inc/left_center2.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
	<jsp:include page="../inc/left.jsp"/>
<!-- 왼쪽메뉴 -->

<%	// 로그인 상태인지 제어
	String member_id = (String)session.getAttribute("member_id");
	if(member_id == null) response.sendRedirect("loginForm.jsp");
	// 이전 페이로 부터 넘어온 데이터 저장
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>
<!-- 게시판 -->
	<article>
	<form action="deleteBoardPro.jsp?pageNum=<%=pageNum %>" method="post" name ="fr" onsubmit="return formChk();">
	<h2>게시글 삭제하기</h2>
	<input type="hidden" name="num" value="<%=num%>">
	<table id="notice">
		<tr>
			<th class="tno" colspan="5" align="center">삭제</th> 
	    </tr>
		<tr>
			<td>비밀번호</td>
		    <td><input type="password" name="pass" placeholder="숫자 4~6자리 입력" maxlength="6"></td>
		</tr>
	</table>
	<div id="table_search">
		<input type="submit" value="삭제하기" class="btn">
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