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
 	function pwdCheck(){
 		
 		if(document.fr.member_pwd.value.length <= 0){
			alert('비밀번호를 입력해주세요!');
			document.fr.member_pwd.focus();
			return false;
		}
 		
 		if(document.fr.member_pwd.value != document.fr.member_pwd2.value){
 			alert('비밀번호가 일치하지 않습니다.');
 			document.fr.member_pwd.focus();
 			return false;
 		}
		
 		 var RegExp = /^[a-zA-Z0-9]{4,12}$/;
 		 var objPwd = document.getElementById("member_pwd"); 
 		  if(!RegExp.test(objPwd.value)){ 
            alert("비밀번호는 6~12자의 영문 대소문자와 숫자로만 입력하여 주세요.");
            objPwd.focus();
            return false;
          
 		  }
		var pwdLength = document.fr.member_pwd.value.length;
		if(6<=pwdLength&&pwdLength<=12){
			alert('비밀번호는 영문,숫자 조합 6~12자 이내로 입력해 주세요');
			document.fr.member_pwd.focus();
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
	<jsp:include page="../inc/left_memberInfo.jsp"/>
<!-- 왼쪽메뉴 -->
<%
	String member_id =(String)session.getAttribute("member_id");
	if(member_id == null){
		// 어짜피 로그인 상태가 아니면 회원정보 확인 메뉴가 안보일꺼긴 한데..일단 제어 코드 적어놓자.
		response.sendRedirect("loginForm.jsp");
	}
%>
<!-- 게시판 -->
	<article>
	
	<h2>비밀번호 변경</h2>
	<form action="updatePwdPro.jsp" method="post" name="fr" onsubmit="return pwdCheck();">
	<table id="notice">
		<!-- <tr>
			<th class="tno" colspan="5" align="center"></th> 
	    </tr> -->
		<tr>
			<th>기존 비밀번호</th>
			<td colspan="4"><input type="password" name="member_pwd_pre"></td>
    	</tr>
    	<tr>
			<th>변경 비밀번호</th>
			<td colspan="4"><input type="password" name="member_pwd" maxlength="12" placeholder="영문,숫자 조합 6~12자 "></td>
    	</tr>
		<tr>
    		<th>변경 비밀번호 확인</th>
    		<td colspan="4"><input type="password" name="member_pwd2" placeholder="영문,숫자 조합 6~12자 "></td>
    	</tr>
	</table>
		<input type="submit" value="비밀번호 변경"class="btn">
	</form>
	<div id="table_search">
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