<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>WebContent/fileUpload/fileDown.jsp</h1>
	
	<%  // 페이지 이동시 가장 먼저 해야 하는건 이전 페이지의 데이터 저장하는 일!!
		//** 이전페이지에서 가져온 데이터 저장 (파라미터) , 파라미터 이름이 다르면 변경
		String filename = request.getParameter("filename");
	
		System.out.println("다운로드 할 파일명 : " + filename);
		
	//** 파일이 업로드 된 폴더 명 , 폴더 명이 다르다면 변경 
		String savePath = "upload";// upload공간 : 파일을 올리고 +다운로드도 하는 공간
		
	// 다운로드 경로 계산 ()
		// 서블릿으로 만들어진 내 프로젝트 정보를 가져오겠다 
		ServletContext context = getServletContext();//인터페이스는 객체 생성할 수 없으니 
		
	// 프로젝트에  업로드 폴더의 실제 경로
		String sDownloadPath = context.getRealPath(savePath); 
		System.out.println("sDownloadPath : "+sDownloadPath);
		
	// 다운로드 할 파일의 전체 경로를 저장
		String sFilePath = sDownloadPath+"\\"+filename;
		System.out.println("sFilePath : "+sFilePath);
		
	// 파일 다운로드 - 파일 출력 (stream을 사용한 출력)
		
	// 파일을 한 번에 저장하는 배열 (버퍼스트림 - 보조 스트림 , 덩어리째 움직이게 해줌)
		byte[] b = new byte[4096]; // 한 번 내보내거나 읽어들일때 4096byte씩 하겠다.
			// 1바이트 씩 읽어오면 너무 느리니까 배열(byte)을 사용해서 일정 뭉텅이 씩([한번에 얼마만큼 이동할 껀지]) 데이터를 가져오거나 내보낸다.
			// 버퍼 와 유사
			// but BufferedInputStream과의 차이점은 배열은 메모리에서 바로 처리하는거고
			// BufferedInputStream이거는 보조스트림으로 기존 스트림에 끼워서(필터처럼) 사용하는 것.
			
		
		
		
	// 파일 입력 스트림 
		// 생성자 : 파일 객체를 주거나 , 파일에 해당하는 path를 줘서 객체 생성 할 수있음 // 객체 생성하는 순간지정해준 경로로 가서 해당 파일을 염.
		FileInputStream fis = new FileInputStream(sFilePath); // sFilePath : 이 경로에 가서 파일을 열어줌
		
	// MIME 타입 확인  및 설정
		String sMimeType = getServletContext().getMimeType(sFilePath); // 내 프로젝트에 있는 마임타입을 꺼내 올껀데 그 대상이 sFilePath
		System.out.println("sMimeType >>"+sMimeType);
		
	// MIME 타입 : 클라이언트에게 전송된 문서의 다양성을 알려주기 위한 매커니즘(기술)
		// 웹 환경에서는 파일의 확장자는 의미가 없음. 각 문서와(html결과) 해당 MIME 타입을 정확하게 전송하는 것이 서버의 역할 중 한 가지.
		// = 음악 스트리밍 : mp3파일을 서버에 올리면 (mp3->데이터 덩어리들로 올려짐), 그 데이터 덩어리가 스트림이라는 형태로 사용자 핸드폰에 들어와서 mp3 형태로 만들어 지고 핸드폰이 음악을 들려주는 것.
		// 이 정보를 브라우저가 리소스를 받아서  가장 먼저 해야 할 일을 알려줌.
		
		//https://developer.mozilla.org/ko/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
		
	// MINE 타입 기본값 지정
		
		if(sMimeType == null){
			sMimeType = "application/octet-stream"; 
			//application/octet-stream => 이진 타입 파일의 기본값
			// => "잘 알려지지 않은 이진 파일", 브라우저에서 자동실행 x, 실행여부 묻기도 함.
		}
		
	// 내가 응답할 페이지의 MIME타입을 지정
		response.setContentType(sMimeType);
		
	// 사용자의 브라우저를 구분(IE 인지 판단 해야)
		String agent = request.getHeader("User-Agent"); // 사용자의 접속 정보를 알려주는 
		System.out.println("agent : " +agent);
		
		boolean ieBrowser = (agent.indexOf("MSIE")>-1) || (agent.indexOf("Trident") > -1); // 해당 값이 있다면 그 값이 있는 위치의 값을 반환함
		
		if(ieBrowser){ // true : 사용자가 인터넷익스플로러로 접속했음을 의미
			filename = URLEncoder.encode(filename,"UTF-8").replaceAll("\\+", "%20");
			// ie 일 경우, 한글 파일이 깨짐 발생. 그래서 인코딩 먼저 해주고, 
			// ie 일 경우 , 공백문자 : "+" 이렇게 표시해버림 따라서  => 공백문자 "%20" 으로 변경 
		}else{
			
			filename = new String(filename.getBytes("UTF-8"),"iso-8859-1"); // 문자열 객체 생성
			// ie 아닌 경우 , 한글 파일 깨짐 처리 는 이렇게 
		}
		
/////// 여기까지가 다운로드 세팅
		
	// 이제 다운로드 파일 출력
		
		response.setHeader("Content-Disposition", "attachment; filename="+filename);
		// => 해당 브라우저 에서 사용할 수 있는 파일 (=해석 가능한 파일들) 도 다운로드 형태로 변경하기 위해 이렇게 설정하는 것.
		// 브라우저 : 텍스트도 읽어서 보여줄 수 있고 이미지 파일도 읽어서 보여줄 수 있음 . 하지만 압축파일은 다운로드 형태로 다운이 되어버림.
		// 브라우저가 해설 할 수 없는 거는 다운로드 형태로 변경
		// 이 코드는 이미지, 텍스트도 다운로드 형태로 보여지게끔 한 것
		
		// (콘솔창에 뜨는 빨간색 오류!!의 뜻)java.lang.IllegalStateException: 이 응답을 위해 getOutputStream()이 이미 호출되었습니다.
		// jsp에 이미 out객체(내장객체)가 있는데,, 왜 다른 out 객체(getOutputStream(); )를 불러와서 사용하냐... 라고 해서 실행에는 문제 없지만 빨간줄이 뜨는 것.
		// 이런 오류 안 보려면 jsp의 out 내장 객체를 이용하면됨.
		// png 이미지 파일등 몇몇 파일은 이렇게 출력하면 안됨
		// out.close();
		// out = pageContext.pushBody();
		
		
	// 데이터 보낼 통로 객체 생성
		// 추상클래스도 객체를 못 만들기에 객체를 가져와야 한다	
		ServletOutputStream out2 = response.getOutputStream(); 
		
		int numRead;  // -1이 아닐 때까지 데이터를 받을 것
		while((numRead = fis.read(b,0,b.length)) != -1){ // -1 : 파일의 끝(EOF, ctrl+z : 이클립스가 파일의 끝이라고 받아들임)
			out2.write(b, 0, numRead);
		}
		out2.flush(); // 버퍼(배열)의 빈공간을 공백으로 채워서 전달
		
		out2.close(); // 통로 닫기
		fis.close(); // inputstream은 리소스 많이 쓰기 때문에 반드시 닫아 줘야 함 
	%>

</body>
</html>