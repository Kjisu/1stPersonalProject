package mailTest;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	
// PasswordAuthentication 객체 생성. (생성자 매개변수 : "구글 아이디", 구글 비밀번호x -> "구글 앱 비밀번호o")
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("gabrieljisu9", "zfhzuqgnksujxwuz");
		
	}
	
//Authenticator 구현 전 반드시 구현해 줘야 하는 메서드
	public PasswordAuthentication getPasswordAuthentication(){
		return passAuth;
	}
}


