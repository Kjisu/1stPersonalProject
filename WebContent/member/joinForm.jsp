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
 
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 
 <script type="text/javascript">
 
 	function sample6_execDaumPostcode(){
 		new daum.Postcode({
 	        oncomplete: function(data) {
 	           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
               
 	        }
 	    }).open();
 	}
 
 // 새창 열어서 중복확인 하기
 	function idCheck(){ 
 		
 			window.open("joinIdCheck.jsp?member_id="+document.fr.member_id.value,"","width=500, height=300");
 	}
 
 
 // 사용자가 중복확인 후, 아이디를 변경하는 경우  중복확인 했는지 안했는지 판별하기 위한 코드.	
 	function inputIdChk(){ 
 		document.fr.idDuplication.value ="idUnCheck";
 	}

 
 	function formCheck(){
 		
 		// 유효성 검사에 필요한 정규식들
 			
 		 	 var RegExp = /^[a-zA-Z0-9]{4,12}$/; //id와 pwassword  
        	 var e_RegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//이메일
	         var checkNames = /^[가-힣]{2,5}$/; // 이름 
	         var objId = document.getElementById("member_id"); //아이디
	         var objPwd = document.getElementById("member_pwd"); //비밀번호
	         var objPwd2 = document.getElementById("member_pwd2"); //비밀번호확인
	         var objName = document.getElementById("member_name"); //이름
	         var objEmail = document.getElementById("member_email");//메일

     
		//  ==================== ID 유효성 검사 ================================
		
	    if(document.fr.idDuplication.value != "idCheck"){
			alert('아이디 중복체크를 해주세요');
			return false;
		} 
		
		if(objId == '' ){ 
			alert('아이디 입력해주세요!');   
			objId.focus();
			return false; 
		}
		
		if(!RegExp.test(objId.value)){
			alert('아이디는 4~12자리 영문 대소문자와 숫자로만 입력해 주세요!');
			objId.focus();
			return false;
		}
		
		// =========================PWD ======================================
		
		if(objPwd.value == ''){
			alert('비밀번호를 입력해 주세요.');
			objPwd.focus();
			return false;
		}
		
		 if(!RegExp.test(objPwd.value)){ 
	            alert("비밀번호는 6~12자의 영문 대소문자와 숫자로만 입력하여 주세요.");
	            objPwd.focus();
	            return false;
	        }
	        
        if(objPwd2.value != objPwd.value){ 
            alert("비밀번호가 틀립니다. 다시 확인하여 입력해주세요.");
            objPwd.focus();
            return false;
        }
        
        
     // ========================= 이름  ======================================
    	 
    	 
		if(objName.value.length <= 0 ){
			alert('이름을 입력해주세요!');
			objName.focus();
			return false;
		}
		
		 if(!checkNames.test(objName.value)){
	          alert("특수문자,영어,숫자는 사용할수 없습니다. 2~5자 한글만 입력하여주세요.");
	          objName.focus();
	          return false;
	     }
		 
		// ========================= 이메일 ======================================      

		if(objEmail.value == ""){
			alert('이메일을 입력해주세요!');
			objEmail.focus();
			return false;
		}
		
        if(!e_RegExp.test(objEmail.value)){ 
            alert("올바른 이메일 형식이 아닙니다.");
            objEmail.focus();
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

<!-- 본문내용 -->
<article id="joinForm">
<h1>&nbsp;</h1>
<form action="joinPro.jsp" id="join" method="post" name="fr" autocomplete="off" onsubmit="return formCheck();">
	<fieldset>
	<legend>회원가입</legend>
	<label>아이디(*)</label>
		<input type="text" name="member_id" id="member_id" maxlength="12"   class="id" autofocus="autofocus" onkeydown="inputIdChk();">
		<input type="button" value="중복확인" class="dup" onclick="idCheck();"><br>
		<input type="hidden" name="idDuplication" value="idUnCheck">
	<label>비밀번호(*)</label>
		<input type="password" name="member_pwd" id="member_pwd" placeholder="영문,숫자 조합(6~12자 이내)" maxlength="12"><br>
	<label>비밀번호 확인(*)</label>
		<input type="password" name="member_pwd2" id="member_pwd2" placeholder="영문,숫자 조합(6~12자 이내)" maxlength="12"><br>
	<label>이름(*)</label>
		<input type="text" name="member_name" id="member_name"><br>
	<label>이메일(*)</label>
		<input type="email" name="member_email" id="member_email"><br>
	<label>주소(*)</label>
		<input type="text" id="sample6_postcode" placeholder="우편번호" name="member_address">
		<input type="button" class="dup" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="sample6_address" placeholder="주소" name="member_address">
		<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="member_address">
		<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="member_address">
	</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit">
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