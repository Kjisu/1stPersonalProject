<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		// 이전 페이지에서 넘어온 데이터 받기
			String num = request.getParameter("num");
		// 총 개시글 갯수 
			int cnt = Integer.parseInt(request.getParameter("cnt"));
		// 만약 num == 1이라면 1번 지도 보여주기.
		// 반복문 이용해서 어떻게 출력할까 ,, 사용자가 개시글 n개 넣은 만큼 
			
			switch(num){
			case "1" :
				response.sendRedirect("map1.jsp");
				break;
			case "2" : 
				response.sendRedirect("map2.jsp");
				break;
			case "3" : 
				response.sendRedirect("map3.jsp");
				break;
			}
			
	
	%>

</body>
</html>