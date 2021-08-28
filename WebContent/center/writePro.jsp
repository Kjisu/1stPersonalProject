<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.camping.board.ReviewBoardDAO"%>
<%@page import="com.camping.board.BoardDAO"%>
<%@page import="com.camping.board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%// 파일 업로드 후 -> 이전 페이지에서 넘어온 데이터 저장
			/* request.setCharacterEncoding("UTF-8"); */
		//1. 파일 업로드할 폴더 생성
		// 2. 업로드 폴더 경로 지정
			String uploadPath = request.getRealPath("/upload");
		// 3. 업로드 파일 크기 지정
			int fileSize = 10*1024*1024;
		// 4. 파일 업로드 하기 위한 객체 생성
			MultipartRequest mr = new MultipartRequest(request,uploadPath,fileSize,"UTF-8",new DefaultFileRenamePolicy());
			
			System.out.println("파일 업로드 완료!!");
			
	
	// 이전 페이지에서 전달해준 정보 -> 자바빈 객체에 저장
			BoardBean bb = new BoardBean();
			bb.setWriter(mr.getParameter("writer"));
			bb.setPass(mr.getParameter("pass"));
			bb.setSubject(mr.getParameter("subject"));
			bb.setContent(mr.getParameter("content"));
			bb.setIp(request.getRemoteAddr());
			bb.setFile(mr.getFilesystemName("filename"));

	// 잘 저장되었는지 확인!
		System.out.println(bb);
	
	  // 디비에 글 정보 저장하기  (리뷰게시판)
	  	ReviewBoardDAO rbdao = new ReviewBoardDAO();
		rbdao.insertReviewBoard(bb);
	 
	 	System.out.println("writePro:db에 '리뷰 글' 저장 완료");
		response.sendRedirect("reviewBoardList.jsp");
	%>

</body>
</html>