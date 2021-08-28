<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="mailTest.GoogleAuthentication"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
	// 메일 폼에서 전달되어 진 한글 데이터가 깨지지 않도록 한글 처리
		request.setCharacterEncoding("UTF-8");
	
	// 클라 페이지에서 전달되어 온 파라미터 데이터 저장	
		String sender = request.getParameter("sender");
		String user_id = request.getParameter("user_id");
		String receiver = request.getParameter("receiver");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter ou = response.getWriter();
		
		try{
		
	// 서버 정보를 Properties 객체에 저장
		Properties properties = System.getProperties();
	// Starttls Command를 사용할 수 있도록 설정 , gmail은 무조건 true로 고정
		properties.put("mail.smtp.starttls.enable", "true");
	// SMTP 서버 주소
		properties.put("mail.smtp.host", "smtp.gmail.com");
	//AUTH command를 사용하여 사용자 인증을 할 수 있게 하는 설정 , gmail은 무조건 true로 고정
		properties.put("mail.smtp.auth", "true");
	// 서버 포트 지정 : gmail 포트번호
		properties.put("mail.smtp.port", "587");
	// 인증 정보 생성
		Authenticator auth = new GoogleAuthentication();
	// 메일을 전송하는 역할을 하는 단위인 Session 객체를 생성하는 부분	
		Session s = Session.getDefaultInstance(properties, auth);
	// Session 객체를 이용하여 전송할 Message 객체 생성
		Message message = new MimeMessage(s);
	// 메일을 송신할 송신 주소 생성
		Address sender_address = new InternetAddress(sender);
		Address receiver_address = new InternetAddress(receiver);
	// 메일 전송에 필요한 값들 성정
		message.setHeader("content-type", "text/html;charset=UTF-8");
		message.setFrom(sender_address);
		message.addRecipient(Message.RecipientType.TO, receiver_address);
		message.setSubject(subject); // message.setSubject("제목","UTF-8");
		message.setContent(content, "text/html;charset=UTF-8");
		message.setSentDate(new java.util.Date());
	// 메일 전송
		Transport.send(message);
	%>
	<script type="text/javascript">
		alert('메일이 정상적으로 전송되었습니다.');
		location.href='memInfo.jsp';
	</script>
	<%
		} catch(Exception e){
	%>
	<script type="text/javascript">
		alert('서버에 문제가 발생하였습니다. 서버 관리자에게 문의해주세요.');
		history.back();
	</script>
	<%		

		}
		
	%>

</body>
</html>