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
 	// 아이디 , 비밀번호 공백 체크
 	function checkAttri(){
 		
 		if(document.fr.member_id.value == ""){
 			alert('아이디는 필수 입니다.');
 			document.fr.id.focus();
 			return false;
 		}
 		
 		if(document.fr.member_pwd.value == ""){
 			alert('비밀번호는 필수 입니다.');
 			document.fr.member_pwd.focus();
 			return false;
 		}
 	}
 	
 </script>
 
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
	<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<!-- <nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav> -->
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
	<article>
		<form action="loginPro.jsp" method="post" id="join" name="fr" autocomplete="off" onsubmit="return checkAttri();">
	<fieldset>
	<h2>로그인</h2>
	<span>낭만 캠핑의 다양한 서비스와 혜택을 누리세요.</span><br>
		<input type="text" name="member_id" autofocus="autofocus" placeholder="ID"><br>
		<input type="password" name="member_pwd" placeholder="PASSWORD" maxlength="12"><br>
	</fieldset>
	<div class="clear"></div>
	<div id="buttons">
		<input type="submit" value="로그인" class="submit">
<!-- <input type="button" value="네이버로 로그인" class="cancel"> -->
<!-- 아이디 찾기, 비밀번호 찾기 , 회원가입 링크 -->
<p><a href="joinForm.jsp">회원가입</a></p>
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
	<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>